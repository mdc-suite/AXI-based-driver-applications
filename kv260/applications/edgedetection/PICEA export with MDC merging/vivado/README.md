## Notes

The Vivado flow targets **Vivado 2024.2** and the **Kria KV260**, using FPGA part **`xck26-sfvc784-2LV-c`**.

When using another Vivado version, check the availability of the required board definitions and IP versions. Regenerate the project using the supplied Tcl scripts and resolve any compatibility issues before generating the bitstream.

## Folder Contents

- `accelerator.json` — Generated accelerator description accompanying the hardware build.
- `s_accelerator` — Verilog source files for the AES IP
- `scripts` — Tcl scripts used to recreate the project

The supplied bitstream is located at `../Test files/design_1_wrapper.bit`. Deployment and functional testing are described in the example's main README and the documentation under `../linux/`.