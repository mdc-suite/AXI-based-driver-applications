DESCRIPTION = "DMA test for AES accelerator"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"


SRC_URI = "file://dma_test_aes.c"

S = "${WORKDIR}"

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} dma_test_aes.c -o dma_test_aes
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 dma_test_aes ${D}${bindir}/dma_test_aes
}