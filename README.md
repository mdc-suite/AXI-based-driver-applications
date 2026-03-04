# AXI-based driver - Test applications
The driver contained in this repository is taken from this [link](https://github.com/GiuseppeSatta/AXI-based-drivers), from which specific test applications have been implemented to verify its functionality.

## Requirements for Custom IP
The `/dev/uniss_dma` driver controls an AXI DMA and only supports transfers on AXI4‑Stream interfaces. It uses the MM2S channel of the DMA to send data and the S2MM channel to receive data.
Consequently, to use this driver, a custom IP must have at least:
* **1 AXIS input port** (e.g., `im_axis_in`) connected to `M_AXIS_MM2S` of the DMA
* **1 AXIS output port** (e.g., `current_pos`) connected to `S_AXIS_S2MM` of the DMA

## Repository Structure
This repository is organized as follows:
* **`ubuntu-driver/`** and **`yocto-driver/`**: Contain the specific instructions and source code to compile and install the driver on the respective operating systems.
* **`aes/`** and **`vpa/`**: Contain examples of hardware accelerators that implement the AXI4-Stream interface described above, including their test applications to verify correct operation.
