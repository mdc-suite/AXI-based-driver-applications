# AXI-based driver - Test applications

The driver is available into the platform-specific folders, and test-specific applications have been implemented to verify its functionality.

## Requirements for Custom IP

The `/dev/uniss_dma` driver controls an AXI DMA and only supports transfers on AXI4-Stream interfaces. It uses the MM2S channel of the DMA to send data and the S2MM channel to receive data. Consequently, to use this driver, a custom IP must have at least:

* **1 AXIS input port** (e.g., `im_axis_in`) connected to `M_AXIS_MM2S` of the DMA
* **1 AXIS output port** (e.g., `current_pos`) connected to `S_AXIS_S2MM` of the DMA

## Repository Structure

The repository is organized by target hardware boards. Inside each board folder, you will find the operating system drivers and the test applications:

### 1. Target Boards

* **`kv260/`**: Contains the drivers and applications configured for the Xilinx Kria KV260 Vision AI Starter Kit.
* **`zedboard/`**: Contains the drivers and applications configured for the Avnet ZedBoard Zynq-7000 Development Board.

### 2. Inner Directory Structure

Inside each board's directory (`kv260/` and `zedboard/`), the content is structured as follows:

* **`ubuntu-driver/`** *(Available for kv260)*: Contains the specific instructions and source code to compile and install the driver on Ubuntu.
* **`yocto-driver/`**: Contains the specific instructions and source code to compile and install the driver using the Yocto Project build system.
* **`applications/`**: Contains examples of hardware accelerators that implement the AXI4-Stream interface described above, including their test applications to verify correct operation.

## Recent Updates

## Recent Updates

- Extended the Kria KV260 Roberts–Sobel edge-detection example to demonstrate three design flows:
  1. **MDC-only:** CAPH-derived networks and actor HDL, with network merging in MDC.
  2. **PICEA export with MDC merging:** MLIR-to-XDF/CAL export through PICEA, followed by merging in MDC.
  3. **PICEA region merging:** Merging within MLIR, followed by export of the premerged network to MDC for hardware composition and platform integration.
- Added **EmitHLS and Vitis HLS actor-generation support**, alongside the existing CAPH HDL library. RESIN provides the PICEA compiler entry point for preparation, optional region merging, and export.
- Added generated **Vivado scripts** for accelerator IP packaging, Kria system integration, and bitstream generation.
- Added a generated **Linux deployment package** containing the device-tree overlay source, `mdc_dma` driver, configuration headers, and userspace utilities. These examples use **`/dev/mdc_accel0`**, with a separate interface from the existing `/dev/uniss_dma` driver.
- Added **`mdc_probe`, `mdc_run`, and `mdc_test`** for device inspection, binary-stream execution, and named-port testing with reference-output comparison.
- Added bitstreams, input datasets, and reference outputs for Roberts and Sobel, with deployment instructions using `.bit` files directly through `fpgautil`.
- Updated the tutorials and application READMEs with compilation, synthesis, deployment, configuration selection, and numerical-validation instructions.

See the README files in the corresponding board and application directories for flow-specific requirements and commands.