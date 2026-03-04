#!/usr/bin/env bash
set -e

git clone https://github.com/GiuseppeSatta/AXI-based-drivers.git
cd AXI-based-drivers

sudo bash install_libs.sh

cd axidma-driver
make
sudo mkdir -p /lib/modules/$(uname -r)/extra
sudo cp axidma.ko /lib/modules/$(uname -r)/extra/
sudo depmod -a
echo axidma | sudo tee /etc/modules-load.d/axidma.conf
sudo modprobe axidma
lsmod | grep axidma
