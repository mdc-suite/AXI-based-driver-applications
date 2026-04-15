#!/bin/bash
set -e

echo "Updating package list..."
sudo apt update

echo "Installing required packages for building kernel modules and OpenGL ES 2.0..."
sudo apt install -y \
    build-essential \
    dkms \
    linux-headers-$(uname -r) \
    gcc \
    make \
    perl \
    git \
    device-tree-compiler \
    bc \
    bison \
    flex \
    libelf-dev \
    libssl-dev \
    libncurses-dev \
    wget \
        curl \
    vim \
    libfdt-dev \
    fpga-manager-xlnx \
    libncurses5-dev \
    libtinfo5 \
    xterm \
    autoconf \
    libtool \
    texinfo \
    libgles2-mesa-dev \
    libegl1-mesa-dev \
    imagemagick
                                        
echo "All necessary packages have been installed."
