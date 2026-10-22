# Roberts–Sobel Region Merging in PICEA with EmitHLS Actor Generation

This example merges the Roberts and Sobel dataflow regions within PICEA, exports the merged network to MDC, and generates actor-synthesis inputs through EmitHLS. **The actor HDL used by this example is synthesized with Vitis HLS.** MDC composes the hardware from the premerged network and generates the coprocessor and platform-integration files.

RESIN is the command-line entry point of PICEA. The compiler passes perform preparation, region merging, and export.

## Files in this folder

| File | Purpose |
| --- | --- |
| `robertssobel.mlir` | Source containing the actor definitions and separate `@Roberts` and `@Sobel` regions. |
| `mdc.mlir` | Prepared snapshot containing one merged `@top` region, configuration metadata, and S-boxes. |
| `actors.emithls.mlir` | EmitHLS representation of the ten computational actors, used for C++ and HLS Tcl export. |

## Requirements

Use a PICEA build providing `resin`, `picea-opt`, and `picea-translate`, Vitis HLS for actor synthesis, MDC with support for the premerged export, and the matching EmitHLS protocol description. Vivado is required for FPGA implementation.

The commands assume the PICEA executables are on `PATH` and the current directory contains `robertssobel.mlir`. Otherwise, use absolute paths to the executables in your PICEA build directory. The target FPGA is `xck26-sfvc784-2LV-c` on Kria KV260.

## 1. Merge and export with RESIN

Invoke network preparation, PICEA region merging, MDC export, and actor-synthesis input generation:

```bash
resin robertssobel.mlir --mdc --merging --mdc-actors \
  --hls-target-device=xck26-sfvc784-2LV-c \
  -o build-merged
```

**`--merging` enables merging within PICEA.** The resulting network contains shared actors and configuration-dependent switching elements for Roberts and Sobel.

The command writes the merged DFG to `build-merged/mdc.mlir`, the EmitHLS representation to `build-merged/actors.emithls.mlir`, the XDF/CAL project under `build-merged/MDC/src/`, and C++/Tcl synthesis inputs under `build-merged/hw/`.

Synthesize the actor HDL with Vitis HLS:

```bash
cd build-merged/hw
vitis-run --mode hls --tcl run_hls.tcl
cd ../..
```

The generated `build-merged/hw/HDL_components` directory supplies the actor implementations and required FIFO support files for MDC.

## 2. Alternative: prepare, merge, and translate separately

The following sequence exposes the individual compiler and translation stages. Use it as an alternative to the RESIN command.

First, prepare and merge the dataflow regions, then export the merged XDF network and CAL actor interfaces:

```bash
mkdir -p build-manual

picea-opt robertssobel.mlir \
  --prepare-for-mdc --merging \
  -o robertssobel.mdc.mlir

picea-translate robertssobel.mdc.mlir \
  --dfg-to-mdc \
  --mdc-output-dir=build-manual
```

Lower the prepared representation to EmitHLS and export the C++ actor implementations and Vitis HLS synthesis script:

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

These commands generate synthesis inputs. Execute the Tcl script to produce the HDL library:

```bash
cd build-manual
vitis-run --mode hls --tcl run_hls.tcl
cd ..
```

Use the HDL components collected by this script together with the XDF/CAL files from the same preparation and export run.

## 3. Compose the premerged network in MDC

Import the **single merged XDF network** and its CAL actor interfaces into the MDC/Orcc project, preserving the generated `baseline` and `custom` package structure. Select the synthesized actor HDL library and its matching EmitHLS protocol description.

**Do not perform another Roberts–Sobel network merge in MDC.** PICEA has already determined actor sharing and inserted the switching elements. Preserve the exported switching and configuration metadata when generating the coprocessor.

The supplied EmitHLS snapshot lists ten computational actors: `roberts_x`, `roberts_y`, `sobel_x`, `sobel_y`, `abs_sum`, `thr`, `delay`, `line_buffer`, `remove_2x2`, and `remove_3x3`. The merged DFG additionally contains switching infrastructure. Keep the generated actor dependencies and FIFO support files with the HDL library, and ensure the protocol matches the synthesized ports and handshake signals.

MDC generates the hardware composition, AXI coprocessor wrapper, Vivado integration scripts, and Linux deployment sources. Continue with the Vivado and Linux instructions in the parent example directory.

## 4. Build and validate the accelerator

Build the Vivado design and deploy the matching bitstream, overlay, driver, and userspace utilities on Kria KV260. Compare both configurations against their corresponding reference outputs. Check the first execution after loading the FPGA, repeated executions, and switching between configurations.

**Successful synthesis or DMA completion alone does not establish numerical correctness.** Verify the output token counts and reference comparisons for both algorithms.

## Interface and test configuration

The source declares the size input first (`i6`) and the pixel input second (`i8`). The supplied merged snapshot uses `in0` for size, `in1` for pixels, and `out0` for the result. Confirm the exported interface and software metadata before assigning input files.

From the parent example directory, after building the Linux utilities, run:

```bash
./linux/userspace/mdc_test --describe
```

Use the exact mode names, channel mappings, and active ports reported by that build. In particular, account for the `Roberts`/`roberts` difference between the supplied source and snapshot. Consult `linux/TESTING.md` for file formats and test commands.
