# PICEA Region Merging with EmitHLS: Roberts–Sobel Edge-Detection Accelerator on Kria KV260

This directory contains a configurable Roberts–Sobel edge-detection accelerator for the AMD/Xilinx Kria KV260. **PICEA merges the MLIR dataflow regions and exports the merged XDF network and CAL actor interfaces.** MDC uses this premerged network for hardware composition and platform integration.

The actor implementations are generated through **EmitHLS and Vitis HLS**. RESIN is the command-line entry point of PICEA; the compiler passes perform preparation, region merging, and export. The supplied generated HDL can be used to rebuild the Vivado design without repeating HLS synthesis.

The Linux package uses the generated **`mdc_dma` driver**, normally exposing **`/dev/mdc_accel0`**, and the accompanying userspace utilities. 

## Design flow

1. PICEA prepares the Roberts and Sobel regions and merges them, sharing compatible actors and inserting configuration-dependent switching elements.
2. PICEA exports the premerged XDF network, CAL interfaces, and actor-synthesis inputs through EmitHLS.
3. Vitis HLS synthesizes the computational actors and collects the HDL library and required FIFO support files.
4. MDC composes the accelerator from the premerged network, matching HDL library, and EmitHLS protocol description, then generates the AXI wrapper and platform files.
5. The generated Vivado scripts package the IP, construct the Kria system, and generate the bitstream.
6. The matching Linux overlay, driver, and userspace utilities support deployment and numerical testing.

Roberts and Sobel are selectable configurations of the same merged accelerator. Selecting a mode does not require a separate bitstream for each algorithm.

## Requirements

- Vivado with support for the Kria target; the tutorial flow has been tested with Vivado 2024.2.
- Kria KV260 running a compatible Linux image.
- A C compiler, Make, device-tree compiler, and build headers matching the running Kria kernel.
- A supported FPGA/overlay loading mechanism on the board.
- Input tokens and corresponding reference outputs for functional testing.
- MDC to regenerate hardware composition and platform-integration files from the premerged network.
- PICEA to regenerate the merged network, CAL interfaces, and EmitHLS synthesis inputs.
- Vitis HLS to regenerate actor HDL from the generated C++ and Tcl files.

Target identifiers used by the associated flow:

```text
Board part: xilinx.com:kv260_som:part0:1.4
FPGA part:  xck26-sfvc784-2LV-c
```

The board definition must be installed in Vivado. Check the supplied Vivado configuration before rebuilding.

## Repository contents

| Path | Purpose |
| --- | --- |
| [`MLIR/`](MLIR/) | `robertssobel.mlir`, prepared/merged MLIR, EmitHLS actor representation, and export instructions. |
| [`MDC/`](MDC/) | Premerged network and CAL actor interfaces for MDC. |
| [`MDC/baseline/`](MDC/baseline/) | Exported merged XDF network and its `.xdfdiag` visualization file; the supplied merged MLIR region is named `top`. |
| [`MDC/custom/`](MDC/custom/) | CAL interfaces for line buffering, delay, gradient computation, border removal, absolute sum, and thresholding. |
| [`vivado/`](vivado/) | Generated hardware and Vivado automation scripts. |
| [`vivado/accelerator.json`](vivado/accelerator.json) | Generated accelerator description accompanying the hardware build. |
| [`vivado/s_accelerator/hdl/`](vivado/s_accelerator/hdl/) | Actor RTL, merged network, switching logic, control logic, and coprocessor wrapper. |
| [`vivado/s_accelerator/drivers/`](vivado/s_accelerator/drivers/) | Packaged-IP software sources and metadata; distinct from the Linux kernel driver. |
| [`vivado/scripts/`](vivado/scripts/) | IP packaging, system generation, and build scripts. |
| [`linux/`](linux/) | Device-tree source, Linux driver, configuration headers, and userspace programs. |
| [Test files/](<Test files/>) | Supplied bitstream, input tokens, and Roberts/Sobel reference outputs. |

Detailed instructions are available in [`MLIR/Readme.md`](MLIR/Readme.md), [`MDC/README.md`](MDC/README.md), [`vivado/README.md`](vivado/README.md), [`linux/README.md`](linux/README.md), and [`linux/TESTING.md`](linux/TESTING.md).


### MDC inputs

Follow [`MLIR/Readme.md`](MLIR/Readme.md) to regenerate the PICEA exports. From the directory containing `robertssobel.mlir`, with the compiler executable on `PATH`, run:

```bash
resin robertssobel.mlir --mdc --merging --mdc-actors \
  --hls-target-device=xck26-sfvc784-2LV-c \
  -o build

cd build/hw
vitis-run --mode hls --tcl run_hls.tcl
cd ../..
```

The PICEA pipeline writes the merged representation to `build/mdc.mlir`, the XDF/CAL project under `build/MDC/src/`, and actor-synthesis inputs under `build/hw/`. Vitis HLS produces the actor library under `build/hw/HDL_components`.

Import the **single premerged network** and its CAL interfaces into MDC, preserving package references. Use the synthesized actor library, including its FIFO support files, and the matching EmitHLS protocol description. **Do not perform a second Roberts–Sobel merge in MDC.** Preserve the exported configuration metadata so that the two functionalities remain selectable.

The CAL files describe actor interfaces; the synthesized HDL supplies their implementations. Use files from the same export and synthesis run so actor names, ports, widths, and handshake conventions remain consistent.

### Accelerator hardware

| File or group | Role |
| --- | --- |
| `multi_dataflow.v` | Composed Roberts–Sobel dataflow network. |
| `s_accelerator.v` | Accelerator wrapper for system integration. |
| `sbox1x2.v`, `sbox2x1.v` | Switching elements used by the merged network. |
| `configurator.v`, `config_regs.v` | Configuration selection and register logic. |
| `counter.v` | Counter support for the generated wrapper. |
| Synthesized actor HDL | Actor implementations generated through EmitHLS and Vitis HLS, including their synthesis dependencies. |
| FIFO support HDL | Support components collected with the generated actor library. |
| `tb/`, `tb_multi_dataflow.v`, `tb_s_accelerator.v` | Simulation testbench sources. |

Use the simulation testbench files present in the generated build. Testbench sources are not accelerator synthesis sources.

[`configNetID.txt`](vivado/s_accelerator/configNetID.txt) records the generated mapping between network configurations and mode IDs. [`report.txt`](vivado/s_accelerator/report.txt) describes MDC generation; consult the PICEA merged representation for compiler-level sharing decisions and use Vivado reports for implemented resource usage and timing.

### Vivado scripts

| Script or file | Role |
| --- | --- |
| `accelerator_config.tcl` | Generated configuration consumed by the scripts. |
| `mdc_common.tcl` | Shared Tcl support procedures. |
| `generate_ip.tcl` | Accelerator IP generation/packaging entry point. |
| `generate_top.tcl` | Top-level system generation entry point. |
| `build_all.tcl` | Combined build entry point. |
| `packaged_ip.path` | Records the packaged-IP location used by the flow. |

Follow [`vivado/README.md`](vivado/README.md) for the required working directory, script arguments, and build invocation. The combined script can be launched with Vivado's batch interface:

```bash
vivado -mode batch -source "/absolute/path/to/PICEA region merging with EmitHLS/vivado/scripts/build_all.tcl"
```

Use the working directory and any additional arguments required by that README. Check `packaged_ip.path` after moving the project: a path from another machine may need regeneration. Keep the hardware sources and scripts together.

## Linux package

| Path | Purpose |
| --- | --- |
| `accelerator.json`, `software.json` | Generated descriptions accompanying the hardware/software configuration. |
| `device-tree/pl_mdc.dts` | Device-tree overlay source for the generated hardware. |
| `driver/mdc_dma.c` | Linux accelerator/DMA driver implementation. |
| `driver/Makefile` | Kernel-module build rules. |
| `include/mdc_config.h` | Application-specific driver configuration. |
| `include/mdc_test_config.h` | Generated mode and port information for testing. |
| `include/mdc_uapi.h` | Interface shared between kernel and userspace. |
| `include/mdc_user.h` | Userspace support declarations/helpers. |
| `userspace/mdc_probe.c` | Device inspection utility. |
| `userspace/mdc_run.c` | Accelerator execution utility; see the Linux documentation for usage. |
| `userspace/mdc_test.c` | Named-port execution and reference-comparison utility. |
| `Makefile` | Build targets for userspace, overlay, and kernel module. |

**Use the generated configuration and UAPI headers as the authority for channel mappings, register definitions, and ioctl operations.** The previous README's hard-coded DMA channel order and legacy ioctl examples do not describe this generated package.

### Build on Kria

From the `PICEA region merging with EmitHLS` directory on the board:

```bash
cd linux
uname -r
ls /lib/modules/$(uname -r)/build
make userspace overlay
make module KDIR=/lib/modules/$(uname -r)/build
```

The module is built as `driver/mdc_dma.ko`. Use the overlay output path reported by the Makefile. If the kernel build directory is missing, install or prepare matching kernel headers before building the module.

### Load and inspect

Follow [`linux/README.md`](linux/README.md) to load the matching bitstream and apply the overlay using the mechanism supported by the board's Linux image. Stop accelerator clients and release any previous accelerator configuration before replacing it.

After successful hardware and overlay loading, from `linux/`:

```bash
sudo insmod driver/mdc_dma.ko
ls -l /dev/mdc_accel0
sudo ./userspace/mdc_probe
```

If the module is already loaded, follow the documented unload/reload procedure rather than inserting it again. A successful `insmod` alone does not establish device binding. If the device node is absent, inspect the kernel log:

```bash
sudo dmesg | tail -n 100
```

Keep the **bitstream, overlay, module, and userspace configuration from the same build** together. The reusable driver source is compiled with application-specific configuration and must also match the running kernel.

## Supplied test files

The `Test files/` directory contains:

| File | Purpose |
| --- | --- |
| `design_1_wrapper.bit` | Supplied Vivado bitstream for the accelerator. |
| `in_pel_file.mem` | Input image tokens shared by both tests. |
| `in_size_file.mem` | Input image-size parameter. |
| `out_pel_Roberts_file.mem` | Expected Roberts output. |
| `out_pel_Sobel_file.mem` | Expected Sobel output. |

Use the supplied bitstream with its matching overlay and generated software configuration. This deployment loads `design_1_wrapper.bit` directly with `fpgautil`.

## Functional testing

See [`linux/TESTING.md`](linux/TESTING.md) for the exact data format and commands for this package. The bitstream, input data, and reference outputs are supplied in `Test files/`.

Inspect the generated configuration before testing:

```bash
./linux/userspace/mdc_test --describe
```

The supplied merged MLIR declares **`in0` as the 6-bit size input**, **`in1` as the 8-bit pixel input**, and **`out0` as the 8-bit result**. Its configuration metadata names the networks `roberts` and `Sobel`.

For a generated package retaining these names, run the following from the example root. These commands use the test filenames listed above:

```bash
sudo ./linux/userspace/mdc_test \
  --mode roberts \
  --input "in0=in_size_file.mem" \
  --input "in1=in_pel_file.mem" \
  --output out0=out_pel_Roberts_actual.mem \
  --expect "out0=out_pel_Roberts_file.mem"

sudo ./linux/userspace/mdc_test \
  --mode Sobel \
  --input "in0=in_size_file.mem" \
  --input "in1=in_pel_file.mem" \
  --output out0=out_pel_Sobel_actual.mem \
  --expect "out0=out_pel_Sobel_file.mem"
```

Arguments containing `.mem` files are in root. Actual outputs are written separately to preserve the references. Obtain numeric mode IDs, channel indices, buffer capacity, and active ports from `--describe` and `linux/include/mdc_test_config.h`; these values depend on the generated build.

The `.mem` files contain tokens in the format supported by the test utility; they are not PGM, PNG, or JPEG images. Both modes can use the same source image, but each requires its own reference output.

For the previously validated 16 × 16 test with valid border handling and four-byte transport words:

| Transfer | Tokens | Bytes |
| --- | ---: | ---: |
| Size parameter | 1 | 4 |
| Input image | 256 | 1024 |
| Roberts output | 225 | 900 |
| Sobel output | 196 | 784 |

Successful comparison is reported as `out0: reference verified (225 tokens)` for Roberts or `out0: reference verified (196 tokens)` for Sobel. These counts apply to that test configuration, not every supported image or network.

DMA completion confirms transport progress; **numerical correctness requires a successful reference comparison**. Repeat both modes and alternate between them to check repeated execution and configuration switching. Preserve test inputs, reference outputs, actual outputs, and logs with the build revision.

## Troubleshooting

| Symptom | Check |
| --- | --- |
| Missing `/dev/mdc_accel0` | Overlay application, driver binding, register resources, and kernel log. |
| Kernel module rejected | Running kernel version, matching headers, module build, and kernel log. |
| Vivado cannot locate HDL/IP | HLS actor and FIFO dependencies, source paths, script working directory, and `packaged_ip.path`. |
| Unknown mode or port | Generated `mdc_test_config.h` and `configNetID.txt`. |
| DMA timeout or incorrect output count | Mode, input counts, output length, interface mapping, and consistency of the deployed build. |
| Numerical mismatch | Input ordering, reference algorithm, arithmetic widths, border handling, and retained state. |

The supplied generated sources support rebuilding and deployment. The supplied `Test files/` directory provides the bitstream and input/reference dataset for testing with the matching generated hardware and software configuration.
