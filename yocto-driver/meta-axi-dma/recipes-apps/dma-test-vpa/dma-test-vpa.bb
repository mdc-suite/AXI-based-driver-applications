DESCRIPTION = "DMA test for VPA accelerator"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://dma_test_vpa.c \
           file://input32.txt \
          "

S = "${WORKDIR}"

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} dma_test_vpa.c -o dma_test_vpa
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 dma_test_vpa ${D}${bindir}/dma_test_vpa

    install -d ${D}${datadir}/dma-test-vpa
    install -m 0644 input32.txt ${D}${datadir}/dma-test-vpa/input32.txt
}