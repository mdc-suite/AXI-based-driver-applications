#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <string.h>
#include <stdint.h>

#define DMA_MAGIC 'D'
#define IOCTL_SELECT_CHANNEL        _IOW(DMA_MAGIC, 0, int)
#define IOCTL_DMA_WRITE_BUFFER      _IOW(DMA_MAGIC, 1, unsigned char *)
#define IOCTL_DMA_READ_BUFFER       _IOR(DMA_MAGIC, 2, unsigned char *)
#define IOCTL_DMA_START_TRANSFER    _IOW(DMA_MAGIC, 3, size_t)
#define IOCTL_READ_STATUS_REGISTER  _IOR(DMA_MAGIC, 4, unsigned int*)
#define IOCTL_DMA_RESET_ALL         _IOW(DMA_MAGIC, 6, size_t)

#define DEVICE_FILE "/dev/uniss_dma"
#define DMA_BUF_SIZE 65535
#define INPUT_FILE "input32.txt"

static void print_mem(unsigned char *data, int byte_count) {
    for (int i = 0; i < byte_count; i++) {
        printf("%02X ", data[i]);
        if ((i + 1) % 16 == 0) printf("\n");
    }
    printf("\n");
}

/* Ricarica input32.txt in img_buf e ritorna img_bytes (multiplo di 4) */
static int load_image_each_iter(FILE *f, unsigned char *img_buf, int max_bytes) {
    rewind(f);  /* torna all'inizio del file */

    int img_bytes = 0;
    unsigned int word;

    while (img_bytes + 4 <= max_bytes && fscanf(f, "%8x", &word) == 1) {
        memcpy(img_buf + img_bytes, &word, 4);
        img_bytes += 4;
    }
    return img_bytes;
}

int main(void) {
    /* Stampe immediate su kubectl logs -f */
    setvbuf(stdout, NULL, _IONBF, 0);  /* no buffering */

    int fd = open(DEVICE_FILE, O_RDWR);
    if (fd < 0) {
        perror("Failed to open /dev/uniss_dma");
        return 1;
    }
    printf("DMA device aperto: %s\n", DEVICE_FILE);

    FILE *f = fopen(INPUT_FILE, "r");
    if (!f) {
        perror("fopen input32.txt");
        close(fd);
        return 1;
    }

    unsigned char *img_buf = (unsigned char*)malloc(DMA_BUF_SIZE);
    unsigned char *out_buf = (unsigned char*)malloc(DMA_BUF_SIZE);
    unsigned int *status = (unsigned int*)malloc(sizeof(unsigned int));

    if (!img_buf || !out_buf || !status) {
        perror("malloc");
        fclose(f);
        close(fd);
        free(img_buf);
        free(out_buf);
        free(status);
        return 1;
    }

    for (int iter = 0; iter < 1200; ++iter) {

        /* (A) STAMPE + RICARICAMENTO FILE AD OGNI ITERAZIONE */
        printf("Caricamento %s...\n", INPUT_FILE);
        int img_bytes = load_image_each_iter(f, img_buf, DMA_BUF_SIZE);

        printf("Caricati %d bytes (%d words) dall'immagine\n", img_bytes, img_bytes / 4);

        printf("Input immagine (primi 64 bytes):\n");
        print_mem(img_buf, 64);

        /* (B) Reset DMA */
        if (ioctl(fd, IOCTL_DMA_RESET_ALL, 0) < 0) {
            perror("DMA reset failed");
            goto cleanup;
        }

        /* (C) MM2S ch0: Scrittura preliminare dei dati nel buffer kernel */
        if (ioctl(fd, IOCTL_SELECT_CHANNEL, 0) < 0) {
            perror("Select channel 0 failed");
            goto cleanup;
        }
        if (ioctl(fd, IOCTL_DMA_WRITE_BUFFER, img_buf) < 0) {
            perror("Write img_buf failed");
            goto cleanup;
        }

        /* (D) S2MM ch1: Prepariamo e armiamo la RICEZIONE prima di trasmettere */
        if (ioctl(fd, IOCTL_SELECT_CHANNEL, 1) < 0) {
            perror("Select channel 1 failed");
            goto cleanup;
        }

        memset(out_buf, 0, DMA_BUF_SIZE);

        if (ioctl(fd, IOCTL_DMA_START_TRANSFER, (size_t)4) < 0) {
            perror("Start S2MM failed");
            goto cleanup;
        }

        /* (E) MM2S ch0: Avviamo ora la TRASMISSIONE */
        if (ioctl(fd, IOCTL_SELECT_CHANNEL, 0) < 0) {
            perror("Select channel 0 failed");
            goto cleanup;
        }
        if (ioctl(fd, IOCTL_DMA_START_TRANSFER, (size_t)img_bytes) < 0) {
            perror("Start MM2S img failed");
            goto cleanup;
        }

        // =======================================================
        // POLLING CON CONTROLLO ERRORI HARDWARE (0x70)
        // =======================================================
        int channels_to_poll[] = {1, 0}; // Controlliamo sia S2MM che MM2S
        for (int i = 0; i < 2; i++) {
            int current_ch = channels_to_poll[i];
            if (ioctl(fd, IOCTL_SELECT_CHANNEL, current_ch) < 0) {
                perror("Select channel for polling failed");
                goto cleanup;
            }

            do {
                if (ioctl(fd, IOCTL_READ_STATUS_REGISTER, status) < 0) {
                    perror("Read status failed");
                    goto cleanup;
                }

                // Se i bit 4, 5 o 6 sono a 1, c'è un errore interno o di bus AXI
                if (*status & 0x70) {
                    printf("\n[!] ERRORE FATALE DMA SUL CANALE %d! Registro: 0x%08X\n", current_ch, *status);
                    goto cleanup;
                }
                usleep(500); // Evita di stressare la CPU al 100%
            } while (!(*status & 0x2)); // Rimani nel loop finché il canale non è IDLE
        }

        /* (F) Lettura finale dell'output dal canale 1 */
        if (ioctl(fd, IOCTL_SELECT_CHANNEL, 1) < 0) {
            perror("Select channel 1 for final read failed");
            goto cleanup;
        }
        if (ioctl(fd, IOCTL_DMA_READ_BUFFER, out_buf) < 0) {
            perror("Read output buffer failed");
            goto cleanup;
        }

        /* (G) STAMPE OUTPUT AD OGNI ITERAZIONE */
        printf("\n\n[iter=%d] Output IP (primi 16 bytes):\n", iter);
        print_mem(out_buf, 16);
        printf("\n[iter=%d] Output (int32): %d\n", iter, *(int32_t*)out_buf);
    }

cleanup:
    free(img_buf);
    free(out_buf);
    free(status);
    fclose(f);
    close(fd);
    printf("Test terminato.\n");
    return 0;
}
