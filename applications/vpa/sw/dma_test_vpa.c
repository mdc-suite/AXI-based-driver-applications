#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <string.h>
#include <stdint.h>

#define DMA_MAGIC 'D'
#define IOCTL_SELECT_CHANNEL _IOW(DMA_MAGIC, 0, int)
#define IOCTL_DMA_WRITE_BUFFER _IOW(DMA_MAGIC, 1, unsigned char *)
#define IOCTL_DMA_READ_BUFFER _IOR(DMA_MAGIC, 2, unsigned char *)
#define IOCTL_DMA_START_TRANSFER _IOW(DMA_MAGIC, 3, size_t)
#define IOCTL_READ_STATUS_REGISTER _IOR(DMA_MAGIC, 4, unsigned int*)
#define IOCTL_DMA_RESET _IOW(DMA_MAGIC, 5, size_t)
#define IOCTL_DMA_RESET_ALL _IOW(DMA_MAGIC, 6, size_t)

#define DEVICE_FILE "/dev/uniss_dma"
#define DMA_BUF_SIZE 65535
#define INPUT_FILE "input32.txt"

void print_mem(unsigned char *data, int byte_count) {
    for (int i = 0; i < byte_count; i++) {
        printf("%02X ", data[i]);
        if ((i + 1) % 16 == 0) printf("\n");
    }
    printf("\n");
}

int main() {
    int fd = open(DEVICE_FILE, O_RDWR);
    if (fd < 0) {
        perror("Failed to open /dev/uniss_dma");
        return 1;
    }
    printf("DMA device opened: %s\n", DEVICE_FILE);

    // 1) Read input image from file
    printf("Loading %s...\n", INPUT_FILE);
    FILE *f = fopen(INPUT_FILE, "r");
    if (!f) {
        perror("fopen input32.txt");
        close(fd);
        return 1;
    }

    unsigned char *img_buf = malloc(DMA_BUF_SIZE);
    unsigned char *out_buf = malloc(DMA_BUF_SIZE);
    unsigned int *status = malloc(sizeof(unsigned int));

    if (!img_buf || !out_buf || !status) {
        perror("malloc");
        fclose(f);
        close(fd);
        return 1;
    }

    int img_bytes = 0;
    unsigned int word;
    while (img_bytes < DMA_BUF_SIZE && fscanf(f, "%8x", &word) == 1) {
        memcpy(img_buf + img_bytes, &word, 4);
        img_bytes += 4;
    }
    fclose(f);

    printf("Loaded %d bytes (%d words) from the image\n", img_bytes, img_bytes / 4);

    printf("Input image (first 64 bytes):\n");
    print_mem(img_buf, 64);

    // 2) Reset DMA
    if (ioctl(fd, IOCTL_DMA_RESET_ALL, 0) < 0) {
        perror("DMA reset failed");
        goto cleanup;
    }
    printf("DMA reset done\n");

    // 3) MM2S Channel 0: send image to the IP (im_axis_in)
    printf("\n=== MM2S im_axis_in (Channel 0) ===\n");
    if (ioctl(fd, IOCTL_SELECT_CHANNEL, 0) < 0) {
        perror("Select channel 0 failed");
        goto cleanup;
    }
    if (ioctl(fd, IOCTL_DMA_WRITE_BUFFER, img_buf) < 0) {
        perror("Write img_buf failed");
        goto cleanup;
    }
    if (ioctl(fd, IOCTL_DMA_START_TRANSFER, (size_t)img_bytes) < 0) {
        perror("Start MM2S img failed");
        goto cleanup;
    }
    printf("MM2S image transfer started (%d bytes)\n", img_bytes);

    do {
        if (ioctl(fd, IOCTL_READ_STATUS_REGISTER, status) < 0) {
            perror("Read status failed (MM2S)");
            goto cleanup;
        }
    } while (!(*status & 0x2));
    printf("MM2S transfer completed\n");

    // 4) S2MM Channel 1: receive only 4 bytes (1 word) from the IP output (current_pos)
    printf("\n=== S2MM output (Channel 1, 4 bytes) ===\n");
    if (ioctl(fd, IOCTL_SELECT_CHANNEL, 1) < 0) {
        perror("Select channel 1 failed");
        goto cleanup;
    }

    memset(out_buf, 0, DMA_BUF_SIZE);

    if (ioctl(fd, IOCTL_DMA_START_TRANSFER, (size_t)4) < 0) {
        perror("Start S2MM failed");
        goto cleanup;
    }
    printf("S2MM output transfer started (4 bytes)\n");

    do {
        if (ioctl(fd, IOCTL_READ_STATUS_REGISTER, status) < 0) {
            perror("Read status failed (S2MM)");
            goto cleanup;
        }
    } while (!(*status & 0x2));

    if (ioctl(fd, IOCTL_DMA_READ_BUFFER, out_buf) < 0) {
        perror("Read output buffer failed");
        goto cleanup;
    }
    printf("S2MM transfer completed\n");

    // 5) Print output
    printf("\nIP output (first 16 bytes):\n");
    print_mem(out_buf, 16);
    printf("Output (int32): %d\n", *(int32_t*)out_buf);

cleanup:
    free(img_buf);
    free(out_buf);
    free(status);
    close(fd);
    printf("Test finished.\n");
    return 0;
}
