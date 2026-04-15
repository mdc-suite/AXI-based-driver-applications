
# AXI DMA Kernel Module (`axidma.c`)

## Overview

This Linux kernel module provides a character device interface for interacting with AXI DMA hardware on a platform such as Xilinx Zynq or ZynqMP. It supports multiple DMA channels, both **MM2S** (memory-to-stream) and **S2MM** (stream-to-memory), probed from the device tree using `dev-handles`.

The module allows user-space applications to:
- Select a DMA channel.
- Transfer data to/from DMA buffers.
- Start transfers.
- Reset individual or all DMA engines.
- Read DMA status registers.

## Features

- Multi-channel DMA support via device tree parsing.
- Coherent memory allocation for each DMA buffer.
- Character device interface with `ioctl` operations.

## Device Tree Requirements

Ensure the platform device includes the `dev-handles` property, which is a list of phandles to DMA controller nodes. Each controller should define child nodes for each channel with at least:
```dts
mm2s = <0|1>;  // 1 for MM2S, 0 for S2MM
xlnx,datawidth = <...>;
xlnx,device-id = <...>;
```

Example:
```dts
dma: dma-controller@... {
    compatible = "xlnx,axi-dma";
    reg = <...>;
    #address-cells = <2>;
    #size-cells = <2>;

    channel@0 {
        mm2s = <1>;
        xlnx,datawidth = <32>;
        xlnx,device-id = <0>;
    };

    channel@1 {
        mm2s = <0>;
        xlnx,datawidth = <32>;
        xlnx,device-id = <1>;
    };
};

dmas {
	compatible = "uniss,dmas";  //The compatible string has to be exactly as this one for the driver to function. 
	status = "okay"; 
	dev-handles = <&dma>;
};
```

Compile with:

```bash
dtc pl.dtsi -o pl.dtbo
```
## Environment setup
The `set_env.sh` script automates the entire process of compiling and installing the AXI DMA driver on your system.

### What the script does:
1.  **Repository Cloning**: Downloads the latest version of the `AXI-based-drivers` repository directly from GitHub.
2.  **Dependency Installation**: Runs `install_libs.sh` to install the necessary system libraries and kernel headers required for compilation.
3.  **Driver Compilation**: Navigates to the `axidma-driver` directory and builds the source code using the `make` command.
4.  **Module Installation**:
    * Creates the required directory in `/lib/modules/` for extra kernel modules.
    * Copies the compiled binary file (`axidma.ko`) to the system module path.
    * Updates the kernel module dependency list using `depmod`.
5.  **Persistence at Boot**: Configures the system to automatically load the `axidma` module during every boot by creating a configuration file in `/etc/modules-load.d/`.
6.  **Loading and Verification**: Immediately loads the driver into the kernel using `modprobe` and displays the status via `lsmod` to confirm a successful installation.
---

## Usage
To set up your environment, run the following commands in your terminal:
```bash
# Make the script executable
chmod +x set_env.sh

# Start the installation
./set_env.sh
```

Alternatively, you can build the module yourself using these steps.

## Building the Module

### Prerequisites

- Kernel headers for your target platform.
- A cross-compiler toolchain (for embedded platforms like Zynq).

### Build

Create a simple Makefile:

```makefile
obj-m += axidma.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
```

Then run:
```bash
make
```

## Installation

```bash
sudo insmod axidma.ko
```

Check `dmesg` for logs confirming successful channel probing and DMA buffer allocation.

To remove:
```bash
sudo rmmod axidma
```

## Device Interface

Once loaded, the module creates a character device:

```
/dev/uniss_dma
```

### `ioctl` Commands

| Command                        | Code                         | Direction | Description                                   |
|-------------------------------|------------------------------|-----------|-----------------------------------------------|
| `IOCTL_SELECT_CHANNEL`        | `_IOW('D', 0, int)`          | write     | Select active channel (by index)              |
| `IOCTL_DMA_WRITE_BUFFER`      | `_IOW('D', 1, unsigned char *)` | write | Write data to MM2S buffer                     |
| `IOCTL_DMA_READ_BUFFER`       | `_IOR('D', 2, unsigned char *)` | read  | Read data from S2MM buffer                    |
| `IOCTL_DMA_START_TRANSFER`    | `_IOW('D', 3, size_t)`       | write     | Start DMA transfer of given length           |
| `IOCTL_READ_STATUS_REGISTER`  | `_IOR('D', 4, unsigned int *)` | read     | Read current DMA status register              |
| `IOCTL_DMA_RESET`             | `_IOW('D', 5, size_t)`       | write     | Reset the selected DMA channel                |
| `IOCTL_DMA_RESET_ALL`         | `_IOW('D', 6, size_t)`       | write     | Reset all DMA channels                        |

*The order of the channel numbers is the same as the one specified in the device-tree.

## Usage Example (in C)

```c
int fd = open("/dev/uniss_dma", O_RDWR);

// Select channel 0
ioctl(fd, IOCTL_SELECT_CHANNEL, 0);

// Write data to MM2S buffer
ioctl(fd, IOCTL_DMA_WRITE_BUFFER, user_buffer);

// Start transfer
ioctl(fd, IOCTL_DMA_START_TRANSFER, length);

//Select channel 1
ioctl(fd, IOCTL_SELECT_CHANNEL, 1);

//Start transfer
ioctl(fd, IOCTL_DMA_START_TRANSFER, length);

// Read data from S2MM buffer
ioctl(fd, IOCTL_DMA_READ_BUFFER, user_buffer_out);

// Read status
unsigned int status;
ioctl(fd, IOCTL_READ_STATUS_REGISTER, &status);
```

*Note that this example isn't functional and is only for demonstration purposes. A functional userspace example is provided in 'dma_test.c' .

## Debugging

This module includes extensive `printk` logging to assist with debugging:
- Use `dmesg` to view messages about device probing, memory allocation, and DMA register access.
- You may observe messages like:
  - `"Starting MM2S DMA transfer..."` or
  - `"DMA buffer allocated for channel..."`

## Known Limitations

- The module assumes `DMA_BIT_MASK(32)` support.
- No interrupt support — relies on polling DMA status.
- Currently no support for VDMA or Multi-channel DMA.

## License

**GPLv2** — See `MODULE_LICENSE("GPL")` in the source.

## Author

**Giuseppe Satta** — Maintainer and original author of this DMA aggregator kernel module.
