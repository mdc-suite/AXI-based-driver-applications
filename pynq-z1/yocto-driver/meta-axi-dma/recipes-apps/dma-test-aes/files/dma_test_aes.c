#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <string.h>
#include <errno.h>

#define DMA_MAGIC 'D'
#define IOCTL_SELECT_CHANNEL     _IOW(DMA_MAGIC, 0, int)
#define IOCTL_DMA_WRITE_BUFFER   _IOW(DMA_MAGIC, 1, unsigned char *)
#define IOCTL_DMA_READ_BUFFER    _IOR(DMA_MAGIC, 2, unsigned char *)
#define IOCTL_DMA_START_TRANSFER _IOW(DMA_MAGIC, 3, size_t)
#define IOCTL_READ_STATUS_REGISTER     _IOR(DMA_MAGIC, 4, unsigned int*)
#define IOCTL_DMA_RESET _IOW(DMA_MAGIC, 5, size_t)
#define IOCTL_DMA_RESET_ALL _IOW(DMA_MAGIC, 6, size_t)

#define DEVICE_FILE "/dev/uniss_dma"
#define DMA_BUF_SIZE 65535

// Definisci qui il numero di iterazioni desiderate
#define N_ITER 1000

void print_mem(void *virtual_address, int byte_count)
{
    char *data_ptr = virtual_address;

    for (int i = 0; i < byte_count; i++)
    {
        printf("%02X", (unsigned char)data_ptr[i]);

        // print a space every 4 bytes (0 indexed)
        if (i % 4 == 3)
        {
            printf(" ");
        }
    }

    printf("\n");
}

int main() {
    int fd = open(DEVICE_FILE, O_RDWR);
    if (fd < 0) {
        perror("Failed to open device");
        return 1;
    }

    // =========================================================================
    // ALLOCAZIONI E INIZIALIZZAZIONI (Eseguite UNA sola volta fuori dal loop)
    // =========================================================================
    printf("Allocating DMA buffers in userspace...\n");
    unsigned int *virtual_src_TEXT_addr = (unsigned int*)malloc(DMA_BUF_SIZE);
    unsigned int *virtual_src_KEY_addr = (unsigned int*)malloc(DMA_BUF_SIZE);
    unsigned int *virtual_dst_ENCRYPTED_addr = (unsigned int*)malloc(DMA_BUF_SIZE);
    
    unsigned int *buffer = (unsigned int*)malloc(sizeof(unsigned int));
    unsigned char *char_encr = (unsigned char*)malloc(DMA_BUF_SIZE);

    if (!virtual_src_TEXT_addr || !virtual_src_KEY_addr || !virtual_dst_ENCRYPTED_addr || !buffer || !char_encr) {
        perror("Failed to allocate buffers");
        free(virtual_src_TEXT_addr);
        free(virtual_src_KEY_addr);
        free(virtual_dst_ENCRYPTED_addr);
        free(buffer);
        free(char_encr);
        close(fd);
        return 1;
    }

    // Inizializzazione KEY (Resta fissa per tutte le iterazioni)
    unsigned int j = 0x00000000;
    for (int i = 0; i < 32; ++i)
    {
        virtual_src_KEY_addr[i] = j;
        j = j + 0x1;
    }

    // Array dei canali da controllare nell'ordine corretto di polling
    int channels_to_poll[] = {2, 0, 1}; 

    printf("Starting loop of %d iterations...\n", N_ITER);

    // =========================================================================
    // LOOP PRINCIPALE DELLE ITERAZIONI
    // =========================================================================
    for (int iter = 0; iter < N_ITER; ++iter) {
        
        // Rigenerazione dei dati TEXT ad ogni iterazione
        j = 0x00000000;
        for (int i = 0; i < 16; ++i)
        {
            virtual_src_TEXT_addr[i] = j;
            j = j + 0x11;
        }

        // Reset del buffer di destinazione locale
        memset(virtual_dst_ENCRYPTED_addr, 0, 16 * 4);

        // Se l'output a terminale rallenta troppo il loop, puoi commentare queste stampe
        printf("\n--- Iteration %d/%d ---\n", iter + 1, N_ITER);
        printf("Text memory block data:      ");
        print_mem(virtual_src_TEXT_addr, 16 * 4);
        printf("Key memory block data:       ");
        print_mem(virtual_src_KEY_addr, 32 * 4);

        // -----------------------------------------------------------------
        // CARICAMENTO BUFFER NEI DRIVER DMA
        // -----------------------------------------------------------------
        int channel = 0;
        if (ioctl(fd, IOCTL_SELECT_CHANNEL, channel) < 0) {
            perror("Failed to select DMA channel 0");
            goto loop_error;
        }
        if (ioctl(fd, IOCTL_DMA_WRITE_BUFFER, virtual_src_TEXT_addr) < 0) {
            perror("Failed to write TEXT buffer to DMA");
            goto loop_error;
        }

        channel = 1;
        if (ioctl(fd, IOCTL_SELECT_CHANNEL, channel) < 0) {
            perror("Failed to select DMA channel 1");
            goto loop_error;
        }
        if (ioctl(fd, IOCTL_DMA_WRITE_BUFFER, virtual_src_KEY_addr) < 0) {
            perror("Failed to write KEY buffer to DMA");
            goto loop_error;
        }

        // Reset logico dell'hardware prima del trasferimento
        channel = 0;
        ioctl(fd, IOCTL_SELECT_CHANNEL, channel);
        if (ioctl(fd, IOCTL_DMA_RESET_ALL, channel) < 0) {
            perror("Failed to reset DMAs");
            goto loop_error;
        }

        // -----------------------------------------------------------------
        // AVVIO TRASFERIMENTI (Sequenza specifica Zedboard)
        // -----------------------------------------------------------------
        
        // 1. Avvia S2MM (Canale 2 - Ricezione)
        channel = 2;
        ioctl(fd, IOCTL_SELECT_CHANNEL, channel);
        if (ioctl(fd, IOCTL_DMA_START_TRANSFER, 16) < 0) {
            perror("Failed to start S2MM DMA transfer");
            goto loop_error;
        }

        // 2. Avvia MM2S (Canale 0 - TEXT)
        channel = 0;
        ioctl(fd, IOCTL_SELECT_CHANNEL, channel);
        if (ioctl(fd, IOCTL_DMA_START_TRANSFER, 16) < 0) {
            perror("Failed to start MM2S TEXT transfer");
            goto loop_error;
        }

        // 3. Avvia MM2S (Canale 1 - KEY)
        channel = 1;
        ioctl(fd, IOCTL_SELECT_CHANNEL, channel);
        if (ioctl(fd, IOCTL_DMA_START_TRANSFER, 32) < 0) {
            perror("Failed to start MM2S KEY transfer");
            goto loop_error;
        }

        // -----------------------------------------------------------------
        // POLLING DI STATO CON SICUREZZA ERRORI
        // -----------------------------------------------------------------
        for (int i = 0; i < 3; i++) {
            channel = channels_to_poll[i];
            ioctl(fd, IOCTL_SELECT_CHANNEL, channel);
            
            do {
                if (ioctl(fd, IOCTL_READ_STATUS_REGISTER, buffer) < 0) {
                    perror("Failed to check status register");
                    goto loop_error;
                }

                if (*buffer & 0x70) {
                    printf("\n[!] ERRORE FATALE DMA SUL CANALE %d! Registro: 0x%08X\n", channel, *buffer);
                    goto loop_error;
                }
                
                usleep(10); // Ridotto a 10us (da 1000us) per rendere i cicli molto più veloci
                
            } while(!(*buffer & (unsigned int)0x2)); 
        }

        // -----------------------------------------------------------------
        // LETTURA DEI DATI CIFRATI
        // -----------------------------------------------------------------
        channel = 2;
        ioctl(fd, IOCTL_SELECT_CHANNEL, channel);
        if (ioctl(fd, IOCTL_DMA_READ_BUFFER, char_encr) < 0) {
            perror("Failed to read destination buffer");
            goto loop_error;
        }

        memcpy(virtual_dst_ENCRYPTED_addr, char_encr, DMA_BUF_SIZE);

        printf("Destination memory block data: ");
        print_mem(virtual_dst_ENCRYPTED_addr, 16 * 4);
    }

    printf("\n[+] Loop completato con successo senza errori hardware!\n");

loop_error:
    // Pulizia finale della memoria
    free(virtual_src_TEXT_addr);
    free(virtual_src_KEY_addr);
    free(virtual_dst_ENCRYPTED_addr);
    free(buffer);
    free(char_encr);
    close(fd);
    return 0;
}
