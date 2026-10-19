# Layer Structure

The directory tree is organized to follow standard Yocto conventions:

### conf/
Contains the layer configuration.
* **layer.conf**: Defines the layer priority, dependencies (e.g., core), and compatibility (compatible with **Langdale**).

### recipes-kernel/
Contains the AXI DMA driver.
* **axidma-driver/**: Compiles the `axidma.c` source into the `axidma.ko` kernel module. It is configured to autoload at boot time via the `KERNEL_MODULE_AUTOLOAD` variable.

### recipes-apps/
Contains userspace applications to test the hardware.
* **dma-test-aes/**: BitBake recipes for `dma-test-aes`. This compile the C source files and install the binaries into `/usr/bin/` (using `${bindir}`) on the target image.
* **dma-test-vpa/**: BitBake recipes for `dma-test-vpa`. This compile the C source files and install the binaries into `/usr/bin/` (using `${bindir}`) on the target image.

### recipes-core/
Contains the core system logic and the custom image definition.
* **fpga-init/**: Includes bitstreams (`.bit`), device tree overlays (`.dtbo`), and the `fpga-select` script. The recipe uses the `dtc` utility to compile `.dtsi` files into binary overlays.
* **images/**: Contains **axi-dma-image.bb**, a custom image recipe that inherits `core-image` and automatically includes the driver, apps, and FPGA initialization scripts.
