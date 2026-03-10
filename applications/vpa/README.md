# VPA — AXI4‑Stream Hardware Accelerator
`VPA` is a Vivado HLS–based hardware accelerator designed to be driven by the custom **`/dev/uniss_dma`** AXI DMA driver.  It receives an input image over **AXI4‑Stream** and produces a 32‑bit result (`current_pos`) on a separate AXI4‑Stream output.

## Features
- AXI4‑Stream **image input** (`im_axis_in`)
- AXI4‑Stream **result output** (`current_pos`)
- Designed to work with an AXI DMA controlled by `/dev/uniss_dma`
- Test application in C demonstrating end‑to‑end dataflow:
  - DDR → AXI DMA (MM2S) → VPA_IP
  - VPA_IP → AXI DMA (S2MM) → DDR

## Top‑Level HLS Interface
The HLS top function exposes two AXI4‑Stream ports:
```cpp
void top_module(hls::stream<axis_t> &im_axis_in,
                hls::stream<axis_t> &current_pos);
```
- `im_axis_in`  
  AXIS input stream carrying the image pixels.
- `current_pos`  
  AXIS output stream carrying the computed 32‑bit result (`current_pos_val`).
The result is written in HLS as:
```cpp
outw.data = current_pos_val;
current_pos.write(outw);
```
## Block Design Integration
In the reference Vivado Block Design:
- `im_axis_in` is connected to the **MM2S** channel of an AXI DMA.
- `current_pos` is connected to the **S2MM** channel of an AXI DMA.

On the software side, the custom driver exposes these as numbered channels.  
In the current setup:

- **Channel 0** → MM2S (image input → `im_axis_in`)
- **Channel 1** → S2MM (IP output ← `current_pos`)

## Dataflow with `/dev/uniss_dma`
The userspace C test application performs the following steps:
1. **Load input image**
   - Read `input32.txt` (hex 32‑bit words) into a byte buffer `img_buf`.
   - `img_bytes` is the total number of bytes to send.
2. **Reset DMA**
   - Call `IOCTL_DMA_RESET_ALL` on `/dev/uniss_dma` to reset the DMA channels.
3. **Send image (MM2S, channel 0)**
   ```c
   ioctl(fd, IOCTL_SELECT_CHANNEL, 0);          // MM2S
   ioctl(fd, IOCTL_DMA_WRITE_BUFFER, img_buf);  // point DMA to img_buf
   ioctl(fd, IOCTL_DMA_START_TRANSFER, img_bytes);
   // poll IOCTL_READ_STATUS_REGISTER until DONE bit is set
   ```
   This streams the image from DDR to `im_axis_in` on VPA_IP.
4. **Receive result (S2MM, channel 1, 4 bytes)**
   ```c
   ioctl(fd, IOCTL_SELECT_CHANNEL, 1);       // S2MM
   ioctl(fd, IOCTL_DMA_START_TRANSFER, 4);   // 4 bytes = 1 word
   // poll IOCTL_READ_STATUS_REGISTER until DONE bit is set
   ioctl(fd, IOCTL_DMA_READ_BUFFER, out_buf);
   ```
   Only **4 bytes** are requested, because the IP logically produces a single 32‑bit result.
5. **Interpret result**
   ```c
   int32_t current_pos = *(int32_t *)out_buf;
   printf("Output (int32) = %d\n", current_pos);
   ```

## Build Example
Suggested Directory Layout
```text
vpa/
  ├── hls/            # HLS sources (top_module, lineDet.cpp, etc.)
  ├── vivado/             # Bitstream, XSA, device-tree overlay for VPA_IP + DMA
  ├── sw/
  │   ├── test.c      # Userspace AXI DMA test application for VPA_IP
  │   └── input32.txt # Example image input in hex format
  └── README.md       # This file
```

## Run example
From the `vpa` folder (or wherever `test.c` lives):
```bash
gcc test.c -o test
sudo ./test
```
Example console output (clean/reset IP):
```text
DMA device opened: /dev/uniss_dma
Loading input32.txt...
Loaded 12496 bytes (3124 words) from the image
Input image (first 64 bytes):
...

DMA reset done

=== MM2S im_axis_in (Channel 0) ===
MM2S image transfer started (12496 bytes)
MM2S transfer completed

=== S2MM output (Channel 1, 4 bytes) ===
S2MM output transfer started (4 bytes)
S2MM transfer completed

IP output (first 16 bytes):
28 00 00 00 00 00 00 00 ...
Output (int32): 40
```

---
