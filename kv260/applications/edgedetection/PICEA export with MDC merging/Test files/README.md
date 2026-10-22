# Test Files

This folder contains the Kria KV260 bitstream and test data for the Roberts–Sobel accelerator generated through **PICEA export with MDC merging**.

| File | Description |
| --- | --- |
| `design_1_wrapper.bit` | FPGA bitstream. |
| `in_size_file.mem` | Image-size parameter for `in0`. |
| `in_pel_file.mem` | Input image tokens for `in1`. |
| `out_pel_Roberts_file.mem` | Roberts reference output for `out0`. |
| `out_pel_Sobel_file.mem` | Sobel reference output for `out0`. |

Use the exact mode names **`Robrets`** and **`Sobel`**. See the [main README](../README.md) for deployment and testing commands.