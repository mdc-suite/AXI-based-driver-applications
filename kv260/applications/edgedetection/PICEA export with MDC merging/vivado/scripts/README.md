## Notes

Tcl scripts used to recreate the project

When using another Vivado version, check the availability of the required board definitions and IP versions. Regenerate the project using the supplied Tcl scripts and resolve any compatibility issues before generating the bitstream.

## Folder Contents

- `accelerator_config.tcl` — Accelerator and target-platform settings.
- `mdc_common.tcl` — Common procedures used by the Vivado scripts.
- `generate_ip.tcl` — Script for packaging the accelerator IP.
- `generate_top.tcl` — Script for generating the top-level Vivado system.
- `build_all.tcl` — Combined build entry point.
- `packaged_ip.path` — Location of the packaged accelerator IP; check this path when moving the project.
