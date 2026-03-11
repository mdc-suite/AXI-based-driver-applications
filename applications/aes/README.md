# AES — AXI4-Stream Hardware Accelerator

`AES` is a Vivado HLS–based hardware accelerator designed to be driven by the custom **`/dev/uniss_dma`** AXI DMA driver. It receives plaintext and key data over **AXI4-Stream** input channels and produces the encrypted output on a separate **AXI4-Stream** output channel.

## Features

- AXI4-Stream **plaintext input** (`TEXT`)
- AXI4-Stream **key input** (`KEY`)
- AXI4-Stream **ciphertext output** (`ENCRYPTED`)
- Designed to work with an AXI DMA controlled by `/dev/uniss_dma`
- Test application in C demonstrating end-to-end dataflow:
  - DDR → AXI DMA (MM2S) → AES_IP
  - AES_IP → AXI DMA (S2MM) → DDR

## Top-Level Interface Concept

The AES accelerator is connected to the DMA infrastructure through AXI4-Stream interfaces:

- one AXIS input stream for the plaintext block
- one AXIS input stream for the key block
- one AXIS output stream for the encrypted block

This means that the software must write the plaintext buffer to the first MM2S DMA channel, write the key buffer to the second MM2S DMA channel, and start the S2MM DMA channel to receive the encrypted output.

## Block Design Integration

In the reference Vivado Block Design:

- the plaintext AXIS input is connected to the **MM2S** channel of `axi_dma_0`
- the key AXIS input is connected to the **MM2S** channel of `axi_dma_1`
- the encrypted AXIS output is connected to the **S2MM** channel of `axi_dma_2`

On the software side, the custom driver exposes these as numbered channels.  
In the current setup:

- **Channel 0** → MM2S (plaintext input → `TEXT`)
- **Channel 1** → MM2S (key input → `KEY`)
- **Channel 2** → S2MM (IP output ← `ENCRYPTED`)

## Dataflow with `/dev/uniss_dma`

The userspace C test application performs the following steps:

1. **Prepare input buffers**
   - Allocate a plaintext buffer (`TEXT`)
   - Allocate a key buffer (`KEY`)
   - Allocate an output buffer (`ENCRYPTED`)

2. **Initialize test data**
   - Fill the plaintext buffer with example input data
   - Fill the key buffer with example key data
   - Clear the destination buffer

3. **Reset DMA**
   - Call `IOCTL_DMA_RESET_ALL` on `/dev/uniss_dma` to reset the DMA channels

4. **Send plaintext (MM2S, channel 0)**
   ```c
   ioctl(fd, IOCTL_SELECT_CHANNEL, 0);
   ioctl(fd, IOCTL_DMA_WRITE_BUFFER, virtual_src_TEXT_addr);
   ioctl(fd, IOCTL_DMA_START_TRANSFER, 16);
   ```
   This streams the plaintext block from DDR to the AES IP.

5. **Send key (MM2S, channel 0)**
   ```c
   ioctl(fd, IOCTL_SELECT_CHANNEL, 1);
   ioctl(fd, IOCTL_DMA_WRITE_BUFFER, virtual_src_KEY_addr);
   ioctl(fd, IOCTL_DMA_START_TRANSFER, 32);
   ```
   This streams the key block from DDR to the AES IP.

6. **Receive ciphertext (S2MM, channel 2)**
   ```c
   ioctl(fd, IOCTL_SELECT_CHANNEL, 2);
   ioctl(fd, IOCTL_DMA_START_TRANSFER, 16);
   ioctl(fd, IOCTL_DMA_READ_BUFFER, char_encr);
   ```
   This stores the encrypted output from the AES IP into a userspace buffer.

## Build Example
Suggested Directory Layout
```text
aes/
  ├── hls/                # HLS sources for the AES accelerator
  ├── vivado/             # Vivado project generation files
  ├── sw/
  │   ├── aes256_dma.bit  # Bitstream generated from the Vivado Project
  │   ├── dma_test_aes.c  # Userspace AXI DMA AES test application
  │   ├── pl_aes.dtbo     # Device tree overlay for AES
  │   └── pl_aes.dtsi     # Device tree source include file for AES
  └── README.md           # This file
```

## Run example
From the `aes` folder (or wherever `dma_test_aes.c` lives):
```bash
gcc dma_test_aes.c -o dma_test_aes
sudo ./dma_test_aes
```
Example console output:
```text
Memory map the MM2S source address register blocks:
TEXT
KEY

Memory map the S2MM destination address register block:
ENCRYPTED

Writing text and key data to userspace source buffers...
Clearing the destination register block...

Text memory block data: ...
Key memory block data: ...
Destination memory block data: ...

DMA buffer written successfully.
DMA buffer written successfully.

DMA transfer started.
DMA transfer started.
DMA transfer started.

Encrypted output:
```
