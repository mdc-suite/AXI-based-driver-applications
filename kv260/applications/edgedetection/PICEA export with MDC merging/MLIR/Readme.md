# Roberts–Sobel Export from PICEA for Merging in MDC

This example exports separate Roberts and Sobel dataflow networks from MLIR using PICEA. **MDC performs the network merging.** The default implementation uses the existing CAPH actor HDL library. Actor HDL generated through EmitHLS and Vitis HLS can optionally be evaluated with the same example.

RESIN is the command-line entry point of the PICEA compiler. The PICEA passes perform preparation and export.

## Files in this folder

| File | Purpose |
| --- | --- |
| `robertssobel.mlir` | Source containing the actor definitions and separate `@Roberts` and `@Sobel` regions. Use this file to regenerate the MDC inputs. |
| `mdc.mlir` | Supplied prepared snapshot containing a single merged `@top` region, configuration metadata, and S-boxes. It belongs to the PICEA-merging path and must not be used as the separate-network input for this flow. |
| `actors.emithls.mlir` | Supplied EmitHLS actor representation for inspecting the optional actor-generation path. Regenerate actor-synthesis inputs from the source when testing a new build. |

**Do not enable `--merging` in the commands below.** Regenerate into a separate output directory to avoid confusing the new unmerged representation with the supplied merged `mdc.mlir` snapshot.

## Requirements

Use a PICEA build providing `resin`, `picea-opt`, and `picea-translate`, together with MDC and the matching CAPH actor library and protocol description. Vivado is required for FPGA implementation. Vitis HLS is required only for the optional EmitHLS actor-synthesis path.

The commands below assume the PICEA executables are available on `PATH` and that the current directory contains `robertssobel.mlir`. Otherwise, use the absolute paths to the executables in your PICEA build directory.

## 1. Export with RESIN

For the default CAPH-based implementation:

```bash
resin robertssobel.mlir --mdc --mdc-actors --mdc --hls-target-device=xck26-sfvc784-2LV-c -o build-mdc
```
This invokes PICEA network preparation and MDC export. The generated project is placed under `build-mdc/MDC/`, with network descriptions under `src/baseline/` and CAL actor interfaces under `src/custom/`. The prepared DFG is written to `build-mdc/mdc.mlir`.

## 2. Alternative: prepare and translate separately

The following commands invoke the preparation and export stages individually. **Merging remains in MDC**, since `--merging` is omitted.

First, prepare the DFG and export the XDF networks and CAL actor interfaces:

```bash
mkdir -p build-manual

picea-opt robertssobel.mlir \
  --prepare-for-mdc \
  -o robertssobel.mdc.mlir

picea-translate robertssobel.mdc.mlir \
  --dfg-to-mdc \
  --mdc-output-dir=build-manual
```

**For the CAPH-based implementation, these commands are sufficient.** Supply the exported networks and interfaces to MDC together with the matching CAPH HDL library and protocol description.

To optionally generate HLS actor implementations, lower the prepared DFG to EmitHLS and export the C++ source and Vitis HLS synthesis script:

```bash
picea-opt robertssobel.mdc.mlir \
  --convert-to-emithls --for-mdc \
  -o robertssobel.emithls.mdc.mlir

picea-translate robertssobel.emithls.mdc.mlir \
  --emithls-to-cpp \
  -o build-manual/main.cpp

picea-translate robertssobel.emithls.mdc.mlir \
  --emithls-to-hls-tcl \
  --hls-actor-library \
  --hls-source-file=main.cpp \
  --hls-target-device=xck26-sfvc784-2LV-c \
  -o build-manual/run_hls.tcl
```

These additional commands generate **synthesis inputs**, rather than HDL directly. Execute the generated script with Vitis HLS to synthesize the actor library:

```bash
cd build-manual
vitis-run --mode hls --tcl run_hls.tcl
cd ..
```

Use the resulting HDL library with its matching protocol description in MDC, then rebuild and validate the accelerator.

## 3. Merge in MDC using CAPH HDL

Import both exported XDF networks and their CAL interfaces into the MDC/Orcc project, preserving the generated `baseline` and `custom` package structure. Select the CAPH actor library and its matching protocol description, then enable network merging in MDC.

Ensure the actor port names, widths, and handshake signals match the selected HDL components. Use the CAPH library adapted to the exported interfaces; changing a library path alone does not reconcile incompatible port names or protocols.

MDC merges the two networks, inserts configuration-dependent switching logic, and generates the coprocessor and platform-integration files. Continue with the Vivado and Linux instructions in the parent example directory.

**The optional HLS implementation requires its own hardware build and numerical validation.** Regenerate the accelerator, bitstream, and matching software configuration. Compare Roberts and Sobel outputs against their reference data, including the first execution after loading the FPGA and repeated configuration switching.

## Interface and test configuration

The source regions declare the size input first (`i6`) and the pixel input second (`i8`). The supplied merged snapshot likewise uses `in0` for size and `in1` for pixels. 

After building the generated Linux utilities, run:

```bash
./linux/userspace/mdc_test --describe
```

Use the exact mode names and port mappings from that build, and associate each input file with the correct semantic input. Consult the generated `linux/TESTING.md` for test options and file formats.
