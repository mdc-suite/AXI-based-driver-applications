DESCRIPTION = "FPGA bitstreams and overlays (AES + VPA) + selection script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://fpga-select.sh \
           file://aes256_dma.bit \
           file://pl_aes.dtsi \
           file://vpa_dma.bit \
           file://pl_vpa.dtsi \
          "

DEPENDS += "dtc-native"

S = "${WORKDIR}"

do_compile() {
    ${STAGING_BINDIR_NATIVE}/dtc -I dts -O dtb -o pl_aes.dtbo -@ pl_aes.dtsi
    ${STAGING_BINDIR_NATIVE}/dtc -I dts -O dtb -o pl_vpa.dtbo -@ pl_vpa.dtsi
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 fpga-select.sh ${D}${bindir}/fpga-select

    install -d ${D}/usr/share/fpga
    install -m 0644 aes256_dma.bit ${D}/usr/share/fpga/aes256_dma.bit
    install -m 0644 vpa_dma.bit    ${D}/usr/share/fpga/vpa_dma.bit
    install -m 0644 pl_aes.dtbo    ${D}/usr/share/fpga/pl_aes.dtbo
    install -m 0644 pl_vpa.dtbo    ${D}/usr/share/fpga/pl_vpa.dtbo
}

FILES:${PN} += " \
    ${bindir}/fpga-select \
    /usr/share/fpga/aes256_dma.bit \
    /usr/share/fpga/vpa_dma.bit \
    /usr/share/fpga/pl_aes.dtbo \
    /usr/share/fpga/pl_vpa.dtbo \
"