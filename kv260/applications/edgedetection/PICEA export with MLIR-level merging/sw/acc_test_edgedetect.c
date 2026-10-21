#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <string.h>
#include <errno.h>

#define ACCEL_REG0  0x00
#define ACCEL_REG1  0x04

#define ROBERTS_KERNEL_ID 1U
#define SOBEL_KERNEL_ID   2U

typedef enum {
    KERNEL_ROBERTS = ROBERTS_KERNEL_ID,
    KERNEL_SOBEL   = SOBEL_KERNEL_ID
} kernel_t;

struct axi_lite_reg_io {
    uint32_t offset;
    uint32_t value;
};

#define DMA_MAGIC 'D'
#define IOCTL_SELECT_CHANNEL      _IOW(DMA_MAGIC, 0, int)
#define IOCTL_DMA_WRITE_BUFFER    _IOW(DMA_MAGIC, 1, unsigned char *)
#define IOCTL_DMA_READ_BUFFER     _IOR(DMA_MAGIC, 2, unsigned char *)
#define IOCTL_DMA_START_TRANSFER  _IOW(DMA_MAGIC, 3, size_t)
#define IOCTL_READ_STATUS_REGISTER _IOR(DMA_MAGIC, 4, unsigned int*)
#define IOCTL_DMA_RESET           _IOW(DMA_MAGIC, 5, size_t)
#define IOCTL_DMA_RESET_ALL       _IOW(DMA_MAGIC, 6, size_t)
#define IOCTL_DMA_RESET_ALL       _IOW(DMA_MAGIC, 6, size_t)
#define IOCTL_AXILITE_WRITE_REG   _IOW(DMA_MAGIC, 7, struct axi_lite_reg_io)
#define IOCTL_AXILITE_READ_REG    _IOWR(DMA_MAGIC, 8, struct axi_lite_reg_io)

#define DEVICE_FILE "/dev/uniss_dma"

#define WORD_BYTES  4

#define DMA_SR_HALTED       0x00000001U
#define DMA_SR_IDLE         0x00000002U
#define DMA_SR_DMA_INT_ERR  0x00000010U
#define DMA_SR_SLV_ERR      0x00000020U
#define DMA_SR_DEC_ERR      0x00000040U
#define DMA_SR_ERR_IRQ      0x00004000U

static int configure_accelerator(int fd,
                                 kernel_t kernel,
                                 unsigned int output_tokens)
{
    struct axi_lite_reg_io reg;

    /* REG1 = number of output pixels */
    reg.offset = ACCEL_REG1;
    reg.value  = output_tokens;

    if (ioctl(fd, IOCTL_AXILITE_WRITE_REG, &reg) < 0) {
        perror("IOCTL_AXILITE_WRITE_REG(REG1)");
        return -1;
    }

    /* REG0[2] = enable output counter */
    reg.offset = ACCEL_REG0;
    reg.value  = ((uint32_t)kernel << 24) | 0x4U;

    if (ioctl(fd, IOCTL_AXILITE_WRITE_REG, &reg) < 0) {
        perror("IOCTL_AXILITE_WRITE_REG(REG0)");
        return -1;
    }

    /* REG0[0] = start pulse */
    reg.value = ((uint32_t)kernel << 24) | 0x1U;

    if (ioctl(fd, IOCTL_AXILITE_WRITE_REG, &reg) < 0) {
        perror("IOCTL_AXILITE_WRITE_REG(REG0)");
        return -1;
    }

    /* Optional: read registers back for debugging */

    reg.offset = ACCEL_REG0;
    if (ioctl(fd, IOCTL_AXILITE_READ_REG, &reg) < 0) {
        perror("IOCTL_AXILITE_READ_REG(REG0)");
        return -1;
    }
    uint32_t reg0 = reg.value;

    reg.offset = ACCEL_REG1;
    if (ioctl(fd, IOCTL_AXILITE_READ_REG, &reg) < 0) {
        perror("IOCTL_AXILITE_READ_REG(REG1)");
        return -1;
    }
    uint32_t reg1 = reg.value;

    printf("Accelerator configured: REG0=0x%08X, REG1=%u\n",
           reg0, reg1);

    return 0;
}

static int select_channel(int fd, int ch)
{
    return ioctl(fd, IOCTL_SELECT_CHANNEL, ch);
}

static int wait_done(int fd, int ch, const char *name, int timeout_ms)
{
    uint32_t status = 0;

    if (select_channel(fd, ch) < 0) {
        perror("select_channel");
        return -1;
    }

    while (timeout_ms-- > 0) {
        if (ioctl(fd, IOCTL_READ_STATUS_REGISTER, &status) < 0) {
            perror("IOCTL_READ_STATUS_REGISTER");
            return -1;
        }

        if (status & (DMA_SR_DMA_INT_ERR |
                      DMA_SR_SLV_ERR |
                      DMA_SR_DEC_ERR |
                      DMA_SR_ERR_IRQ)) {
            fprintf(stderr,
                    "%s ERROR: status=0x%08X "
                    "(halted=%u, dma_int=%u, slv=%u, dec=%u)\n",
                    name, status,
                    !!(status & DMA_SR_HALTED),
                    !!(status & DMA_SR_DMA_INT_ERR),
                    !!(status & DMA_SR_SLV_ERR),
                    !!(status & DMA_SR_DEC_ERR));
            return -1;
        }

        if (status & DMA_SR_IDLE) {
            printf("%s status = 0x%08X -> DONE\n", name, status);
            return 0;
        }

        usleep(1000);
    }

    fprintf(stderr, "Timeout waiting for %s: 0x%08X\n",
            name, status);
    return -1;
}

static void skip_comments(FILE *fp)
{
    int c;

    while ((c = fgetc(fp)) == '#') {
        while ((c = fgetc(fp)) != '\n' && c != EOF)
            ;
    }

    if (c != EOF)
        ungetc(c, fp);
}

int load_pgm(const char *filename,
             uint8_t **img,
             int *width,
             int *height)
{
    FILE *fp;
    char magic[3];
    int maxval;

    fp = fopen(filename, "rb");
    if (!fp) {
        perror(filename);
        return -1;
    }

    /* Magic number */
    if (fscanf(fp, "%2s", magic) != 1) {
        fclose(fp);
        return -1;
    }

    if (strcmp(magic, "P5") != 0) {
        fprintf(stderr, "Only binary PGM (P5) is supported.\n");
        fclose(fp);
        return -1;
    }

    skip_comments(fp);
    if (fscanf(fp, "%d", width) != 1) {
        fclose(fp);
        return -1;
    }

    skip_comments(fp);
    if (fscanf(fp, "%d", height) != 1) {
        fclose(fp);
        return -1;
    }

    skip_comments(fp);
    if (fscanf(fp, "%d", &maxval) != 1) {
        fclose(fp);
        return -1;
    }

    if (maxval > 255) {
        fprintf(stderr, "Only 8-bit PGM images are supported.\n");
        fclose(fp);
        return -1;
    }

    /* consume one whitespace after maxval */
    fgetc(fp);

    *img = malloc((*width) * (*height));
    if (*img == NULL) {
        fclose(fp);
        return -1;
    }

    if (fread(*img, 1, (*width) * (*height), fp) !=
        (size_t)((*width) * (*height))) {
        free(*img);
        fclose(fp);
        return -1;
    }

    fclose(fp);
    return 0;
}
int main(int argc, char **argv)
{
    int width;
    int height;
    uint8_t *gray;
    kernel_t kernel = KERNEL_ROBERTS;
    const char *image_name ="input.pgm";

    if (argc > 1) {
        if (!strcmp(argv[1], "sobel") || !strcmp(argv[1], "2"))
            kernel = KERNEL_SOBEL;
        else if (!strcmp(argv[1], "roberts") || !strcmp(argv[1], "1"))
            kernel = KERNEL_ROBERTS;
    }
    if (argc > 2) {
        image_name= argv[2];
    }
    /* Load image from .pgm file */
    if (load_pgm(image_name, &gray, &width, &height) != 0) {
        fprintf(stderr, "Failed to load image\n");
        return 1;
    }

    if (width > 63 || height > 63) {
        printf( "over size image, please load lwss that 63 width and height\n");
        return 1;
    }
    int out_width  = (kernel == KERNEL_SOBEL) ? width  - 2 : width  - 1;
    int out_height = (kernel == KERNEL_SOBEL) ? height - 2 : height - 1;

    size_t in_pixels = (size_t)width * height;
    size_t out_pixels = (size_t)out_width * out_height;

    int fd = open(DEVICE_FILE, O_RDWR);
    if (fd < 0) {
        perror("open");
        return 1;
    }

    /* Input image: grayscale, one pixel stored in low byte of each 32-bit word */
    uint32_t *img = calloc(in_pixels, sizeof(uint32_t));
    uint32_t *cfg = calloc(1, sizeof(uint32_t));
    uint32_t *out = calloc(out_pixels, sizeof(uint32_t));

    if (!img || !cfg || !out) {
        perror("calloc");
        close(fd);
        free(img);
        free(cfg);
        free(out);
        return 1;
    }

    for(int i=0;i<in_pixels;i++)
        img[i]=gray[i]&0xff;
  

    /* removed gradient */
    cfg[0] = (uint32_t)width;   /* simple size word */

    printf("Input image (%dx%d):\n", width, height);
    for (int i = 0; i < in_pixels; ++i) {
        if (i % width == 0) printf("\n");
        printf("%02X ", (unsigned)(img[i] & 0xFF));
    }
    printf("\n\n");

    /* Reset all DMA channels */
    if (ioctl(fd, IOCTL_DMA_RESET_ALL, 0) < 0) {
        perror("IOCTL_DMA_RESET_ALL");
        free(img);
        free(cfg);
        free(out);
        close(fd);
        return 1;
    }
    if (configure_accelerator(fd, kernel, out_pixels) < 0)
    goto fail;

    /* Channel 2: output */
    if (select_channel(fd, 2) < 0) {
        perror("select channel 2");
        goto fail;
    }
    if (ioctl(fd, IOCTL_DMA_START_TRANSFER, out_pixels * WORD_BYTES) < 0) {
        perror("start transfer ch2");
        goto fail;
    }

    /* Channel 1: size/config */
    if (select_channel(fd, 1) < 0) {
        perror("select channel 1");
        goto fail;
    }
    if (ioctl(fd, IOCTL_DMA_WRITE_BUFFER, (unsigned char *)cfg) < 0) {
        perror("write cfg buffer");
        goto fail;
    }
    if (ioctl(fd, IOCTL_DMA_START_TRANSFER, WORD_BYTES) < 0) {
        perror("start transfer ch1");
        goto fail;
    }

    /* Channel 0: image */
    if (select_channel(fd, 0) < 0) {
        perror("select channel 0");
        goto fail;
    }
    if (ioctl(fd, IOCTL_DMA_WRITE_BUFFER, (unsigned char *)img) < 0) {
        perror("write image buffer");
        goto fail;
    }
    if (ioctl(fd, IOCTL_DMA_START_TRANSFER, in_pixels * WORD_BYTES) < 0) {
        perror("start transfer ch0");
        goto fail;
    }

    printf("DMA transfers started.\n");

    if (wait_done(fd, 0, "DMA0", 50000) < 0) goto fail;
    if (wait_done(fd, 1, "DMA1", 50000) < 0) goto fail;
    if (wait_done(fd, 2, "DMA2", 50000) < 0) goto fail;

    if (select_channel(fd, 2) < 0) {
        perror("select channel 2 for read");
        goto fail;
    }

    printf("out_pixels = %zu\n", out_pixels);
    printf("out bytes  = %zu\n", out_pixels * sizeof(uint32_t));
    printf("out ptr    = %p\n", out);

    if (ioctl(fd, IOCTL_DMA_READ_BUFFER, (unsigned char *)out) < 0) {
        perror("read output buffer");
        goto fail;
    }
    printf("read completed\n");
     if(kernel == KERNEL_SOBEL) 
        printf("\nSobel output (%zu words):\n", out_pixels);
    else
        printf("\nRoberts output (%zu words):\n", out_pixels);

    for (size_t i = 0; i < out_pixels; ++i) {
        if (i % out_width == 0) printf("\n");
        printf("%02X ", out[i]& 0xFF);
    }
    printf("\n");


    free(img);
    free(cfg);
    printf("free(out)\n");
    free(out);
    close(fd);
    return 0;

fail:
    free(img);
    free(cfg);
    free(out);
    close(fd);
    return 1;
}