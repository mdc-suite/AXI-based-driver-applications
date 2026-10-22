SUMMARY = "Image with AXI DMA Kernel driver and k3s support"

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit core-image

IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "", d)}"

# Installazione pacchetti di base ed emulazione runtime per K3s
IMAGE_INSTALL:append = " \
    fpga-manager-script \
    axidma-driver \
    python3-core \
    python3-statistics \
    curl \
    ca-certificates \
    iproute2 \
    iptables \
    kmod \
    kernel-modules \
    systemd \
    systemd-analyze \
    python3-psutil \
"

EXTRA_IMAGE_FEATURES:append = " ssh-server-openssh"

# =========================================================================
# SOLUZIONE CONTRO I CONFLITTI DI TRANSAZIONE DNF
# =========================================================================
PACKAGE_EXCLUDE = "sysvinit sysvinit-pidof sysvinit-inittab initscripts"
PACKAGE_EXCLUDE:remove = "systemd"

BAD_RECOMMENDATIONS += "sysvinit sysvinit-pidof sysvinit-inittab initscripts"
BAD_RECOMMENDATIONS:remove = "systemd"

# =========================================================================
# INTERCETTAZIONE DIRETTA E PATCH HARDWARE PRIMA DI FORMATTARE IL FILE WIC
# =========================================================================

do_image_wic[depends] += "device-tree:do_deploy"

IMAGE_CMD:wic:prepend() {
    DTB_FILE="${DEPLOY_DIR_IMAGE}/system.dtb"
    TMP_DTS="${WORKDIR}/k3s_final_system.dts"
    
    if [ -f "$DTB_FILE" ]; then
        bbnote "Forzatura hardware del Device Tree nel blocco di deploy prima del WIC..."
        
        # 1. Decompiliamo il DTB di deploy corrente in un formato DTS testuale
        dtc -I dtb -O dts -o "$TMP_DTS" "$DTB_FILE"
        
        # 2. Manipolazione atomica e pulita delle linee
        
        # Modifica RAM a 512MB
        sed -i 's/reg = <0x00 0x40000000>;/reg = <0x00 0x20000000>;/g' "$TMP_DTS"
        
        # Spostamento PHY Ethernet da @7 a @0
        sed -i 's/ethernet-phy@7 {/ethernet-phy@0 {/g' "$TMP_DTS"
        
        # Patching dell'indirizzo PHY
        sed -i '/ethernet-phy@0 {/,/};/s/reg = <0x07>;/reg = <0x0>;/g' "$TMP_DTS"
        sed -i 's/ethernet_phy = "\/axi\/ethernet@e000b000\/ethernet-phy@7";/ethernet_phy = "\/axi\/ethernet@e000b000\/ethernet-phy@0";/g' "$TMP_DTS"
        
        # Rimozione protezione da scrittura SD Card (mmc0)
        sed -i '/xlnx,has-wp = <0x01>;/d' "$TMP_DTS"
        sed -i '/disable-wp/d' "$TMP_DTS"
        sed -i 's/xlnx,has-power = <0x00>;/xlnx,has-power = <0x00>;\n\t\t\tdisable-wp;/g' "$TMP_DTS"
        
        # -----------------------------------------------------------------
        # MODIFICA RIGIDA E SICURA DEI BOOTARGS (Risolve il Kernel Panic)
        # -----------------------------------------------------------------
        bbnote "Piallatura e riscrittura pulita dei bootargs nel nodo chosen..."
        
        # Cancelliamo preventivamente qualsiasi riga bootargs esistente per evitare loop/duplicazioni
        sed -i '/bootargs =/d' "$TMP_DTS"
        
        # Iniettiamo la riga perfetta e definitiva che contiene SIA il mount di root SIA i parametri per i cgroups v2
        sed -i 's/chosen {/chosen {\n\t\tbootargs = "earlyprintk console=ttyPS0,115200 root=\/dev\/mmcblk0p2 rw rootwait cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1";/g' "$TMP_DTS"
        # -----------------------------------------------------------------
        
        # 3. Ricompiliamo sovrascrivendo direttamente il file binario system.dtb
        dtc -I dts -O dtb -o "$DTB_FILE" "$TMP_DTS"
        
        # 4. SOVRASCRITTURA DI SICUREZZA PER LE COPIE STAGING DI WIC
        cp "$DTB_FILE" "${DEPLOY_DIR_IMAGE}/devicetree.dtb"
        
        # Sovrascriviamo il file DTB eventualmente copiato dentro la cartella /boot del rootfs
        if [ -d "${IMAGE_ROOTFS}/boot" ]; then
            bbnote "Patching dei file DTB dentro la cartella /boot del rootfs..."
            cp "$DTB_FILE" "${IMAGE_ROOTFS}/boot/system.dtb"
            cp "$DTB_FILE" "${IMAGE_ROOTFS}/boot/devicetree.dtb"
        fi
        
        rm -f "$TMP_DTS"
        bbnote "Tutte le istanze del Device Tree (compresi i Cgroups v2) sono state allineate!"
    else
        bbfatal "Errore: Impossibile trovare $DTB_FILE per applicare le modifiche hardware di K3s."
    fi
}

# =========================================================================
# ATTIVAZIONE AUTOMATICA CONTROLLER CGROUPS V2 NEL ROOTFS AL BOOT
# =========================================================================
init_enable_cgroups_v2() {
    mkdir -p ${IMAGE_ROOTFS}/usr/bin
    cat << 'EOF' > ${IMAGE_ROOTFS}/usr/bin/cgroups-v2-fix.sh
#!/bin/sh
if [ -e /sys/fs/cgroup/cgroup.subtree_control ]; then
    for controller in cpu cpuset memory pids; do
        echo "+${controller}" > /sys/fs/cgroup/cgroup.subtree_control 2>/dev/null || true
    done
fi
EOF
    chmod +x ${IMAGE_ROOTFS}/usr/bin/cgroups-v2-fix.sh

    mkdir -p ${IMAGE_ROOTFS}/etc/systemd/system
    cat << 'EOF' > ${IMAGE_ROOTFS}/etc/systemd/system/cgroups-v2-fix.service
[Unit]
Description=Forza Attivazione Controller Cgroups v2 per K3s
DefaultDependencies=no
Before=k3s-agent.service
After=sys-fs-cgroup.mount

[Service]
Type=oneshot
ExecStart=/usr/bin/cgroups-v2-fix.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    mkdir -p ${IMAGE_ROOTFS}/etc/systemd/system/multi-user.target.wants
    ln -sf ../cgroups-v2-fix.service ${IMAGE_ROOTFS}/etc/systemd/system/multi-user.target.wants/cgroups-v2-fix.service
}

ROOTFS_POSTPROCESS_COMMAND += "init_enable_cgroups_v2; "
