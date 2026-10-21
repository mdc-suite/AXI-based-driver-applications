# Test Files

This folder contains the Kria KV260 bitstream and test data for the Roberts–Sobel accelerator generated through **MDC-only**.

| File | Description |
| --- | --- |
| `design_1_wrapper.bit` | FPGA bitstream. |
| `in_pel_file.mem` | Input image tokens for `in_pel`. |
| `in_size_file.mem` | Image-size parameter for `in_size`. |
| `out_pel_Roberts_file.mem` | Roberts reference output for `out_pel`. |
| `out_pel_Sobel_file.mem` | Sobel reference output for `out_pel`. |

Use the exact mode names **`Robrts`** and **`Sobel`**. See the [main README](../README.md) for deployment and testing commands.