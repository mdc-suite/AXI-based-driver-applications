# meta-axi-dma: Yocto Layer for AXI DMA
This Yocto layer, **`meta-axi-dma`**, provides the necessary recipes to integrate the AXI DMA kernel driver, userspace test applications, and FPGA initialization scripts into a custom Linux distribution.
---

## How to Import the Layer
To include this layer in your Yocto Project build environment, follow these steps:
### 1. Copy the Layer
Place the `meta-axi-dma` directory into your Yocto `sources` folder:
```bash
cp -r /path/to/meta-axi-dma <yocto-project-root>/sources/
```
### 2. Add the Layer to your Build
You can add the layer using the BitBake utility:
```bash
cd <yocto-project-root>/build
bitbake-layers add-layer ../sources/meta-axi-dma
```
Alternatively, manually edit your conf/bblayers.conf file to include the path:
```bash
BBLAYERS ?= " \
  ...
  ${TOPDIR}/../sources/meta-axi-dma \
"
```


