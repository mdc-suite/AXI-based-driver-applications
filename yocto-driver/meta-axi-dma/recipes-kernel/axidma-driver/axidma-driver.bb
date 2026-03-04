DESCRIPTION = "AXI DMA character driver"
SUMMARY = "AXI DMA kernel module axidma.ko da sorgenti locali"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://axidma.c \
           file://Makefile \
          "

S = "${WORKDIR}"

inherit module

RPROVIDES:${PN} += "kernel-module-axidma"

do_compile() {
    oe_runmake -C ${S} KDIR=${STAGING_KERNEL_DIR}
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    install -m 0644 axidma.ko ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/
}

KERNEL_MODULE_AUTOLOAD += "axidma"