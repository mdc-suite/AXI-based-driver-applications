# Test Files

This folder contains the Kria KV260 bitstream and test data for the Roberts–Sobel accelerator generated through **PICEA export with MDC merging**.

| File | Description |
| --- | --- |
| `design_1_wrapper.bit` | FPGA bitstream. |
| `in0_file.mem` | Input image tokens for `in0`. |
| `in1_file.mem` | Image-size parameter for `in1`. |
| `out0_Roberts_file.mem` | Roberts reference output for `out0`. |
| `out0_Sobel_file.mem` | Sobel reference output for `out0`. |

Use the exact mode names **`Robrts`** and **`Sobel`**. See the [main README](../README.md) for deployment and testing commands.