#!/bin/sh

BITDIR=/usr/share/fpga
echo "Reset FPGA..."
fpgautil -R

echo "======================="
echo " FPGA bitstream select "
echo "======================="
echo "1) AES accelerator"
echo "2) VPA accelerator"
echo "q) Quit"
echo
printf "Select option: "
read choice

case "$choice" in
  1)
    echo "Loading AES bitstream..."
    fpgautil -b ${BITDIR}/aes256_dma.bit || exit 1
    echo "Applying AES overlay..."
    fpgautil -o ${BITDIR}/pl_aes.dtbo || exit 1
    sleep 1
    echo "Running AES DMA test..."
    dma_test_aes
    ;;
  2)
    echo "Loading VPA bitstream..."
    fpgautil -b ${BITDIR}/vpa_dma.bit || exit 1
    echo "Applying VPA overlay..."
    fpgautil -o ${BITDIR}/pl_vpa.dtbo || exit 1
    sleep 1
    echo "Running VPA DMA test..."
    dma_test_vpa
    ;;
  q|Q)
    echo "Bye."
    exit 0
    ;;
  *)
    echo "Invalid option."
    exit 1
    ;;
esac

exit 0