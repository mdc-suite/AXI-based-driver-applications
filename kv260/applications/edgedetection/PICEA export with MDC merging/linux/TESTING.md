# Generated file-driven MDC test

This directory contains `userspace/mdc_test`, generated from the same `CoprocessorSpec` as the KV260 wrapper, Linux driver and device-tree overlay. It is the software counterpart of `tb_multi_dataflow.v`: it selects one configuration, reads one token stream per input, arms every output, submits the inputs, waits for every active channel, writes received tokens, and optionally compares them with reference files.

## Build

Run from this generated Linux directory on the target board:

```sh
make userspace
```

The driver, overlay, FPGA image and clock/reset sequence must already be loaded. The application uses the generated `/dev/mdc_accel0` ABI and `mdc_config.h`; it does not use the legacy `/dev/uniss_dma` interface.

## Ports and configurations

| name | index | direction | token bits | descriptor ID |
|---|---:|---|---:|---|
| in0 | 0 | input | 6 | input:0 |
| in1 | 1 | input | 8 | input:1 |
| out0 | 0 | output | 8 | output:0 |

| mode | ID | active ports |
|---|---:|---|
| Roberts | 1 | input:0, input:1, output:0 |
| Sobel | 2 | input:0, input:1, output:0 |

Use `./userspace/mdc_test --describe` to print this information on the board. Port names are intentional: do not substitute numeric channel order by hand.

## Input and output files

The runner accepts any filename extension, including `.mem`, `.data` and `.txt`. Files contain whitespace-separated unsigned tokens. The default `--format hex` matches Verilog `$readmemh`; `--format dec` reads decimal tokens and `--format auto` recognizes hexadecimal letters or a `0x` prefix. Blank lines, `#` comments and `//` comments are accepted. Verilog address directives (`@`), `x`, and `z` values are rejected deliberately. Each token is checked against its declared width and transferred in the low bits of one 32-bit word.

An output count is required because a streaming interface has no end-of-packet marker in this profile. Supplying `--expect name=file` obtains the count from the reference file; otherwise supply `--count name=N`. The received output is written as one uppercase hexadecimal token per line.

## Example equivalent to the generated Verilog testbench

```sh
./userspace/mdc_test --mode Roberts --input in0=in0_Roberts_file.mem --input in1=in1_Roberts_file.mem --output out0=out0_Roberts_actual.mem --expect out0=out0_Roberts_file.mem --format hex --timeout-ms 10000
```

For a test without a golden file, replace each `--expect name=file` with `--count name=N`. Use `--dry-run` before accessing hardware to validate all files and port names:

```sh
./userspace/mdc_test --dry-run --mode Roberts --input in0=in0_Roberts_file.mem --input in1=in1_Roberts_file.mem --output out0=out0_Roberts_actual.mem --expect out0=out0_Roberts_file.mem --format hex
```

The generated DMA capacity is 65536 bytes per channel. The runner refuses longer transfers instead of silently truncating them. A successful transfer and a successful reference comparison are reported separately.
