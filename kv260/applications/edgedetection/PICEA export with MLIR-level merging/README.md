
# Edge Detection Accelerator — AXI4-Stream Hardware Accelerator

This project implements a configurable hardware accelerator for image edge detection using the **Roberts** and **Sobel** operators. The accelerator is integrated into a Xilinx Zynq MPSoC system through **AXI4-Stream** interfaces for image transfer and an **AXI4-Lite** interface for accelerator configuration.

The accelerator is controlled by the custom **`/dev/uniss_dma`** Linux driver, which provides both:

- AXI DMA data transfers
- AXI-Lite register access through ioctl commands

The userspace application demonstrates complete accelerator execution, from image loading to hardware configuration, DMA transfers, and result verification.

---

# Features

- AXI4-Stream image input
- AXI4-Stream configuration input (image width)
- AXI4-Stream processed image output
- AXI4-Lite accelerator control interface
- Runtime selection of:
  - Roberts operator
  - Sobel operator
- Custom Linux DMA driver exposing:
  - DMA buffer management
  - DMA control
  - AXI-Lite register read/write
- Userspace C application demonstrating complete execution flow

---

# Accelerator Interfaces

The accelerator exposes four interfaces:

| Interface | Description |
|-----------|-------------|
| AXIS Input 0 | Input grayscale image |
| AXIS Input 1 | Image width configuration |
| AXIS Output | Edge detection result |
| AXI-Lite | Accelerator configuration and control |

The AXI-Lite interface is used to configure the accelerator before DMA transfers begin.

---

# AXI-Lite Registers

| Offset | Register | Description |
|---------|----------|-------------|
| 0x00 | REG0 | Control register |
| 0x04 | REG1 | Number of output pixels |

REG0 contains:

- bit 0 : Start
- bit 2 : Enable output counter
- bits 31:24 : Kernel selection

Kernel IDs:

| Kernel | Value |
|---------|------|
| Roberts | 1 |
| Sobel | 2 |

Example:

```c
REG1 = output_pixels;
REG0 = (kernel << 24) | 0x4;
REG0 = (kernel << 24) | 0x1;
```

---

# DMA Channel Assignment

The reference Vivado design connects three AXI DMA channels:

| DMA Channel | Direction | Connected Interface |
|-------------|-----------|--------------------|
| Channel 0 | MM2S | Input image stream |
| Channel 1 | MM2S | Image width/configuration stream |
| Channel 2 | S2MM | Edge detection output |

---

# Software Flow

The userspace application performs the following operations.

## 1. Load input image

The application loads an 8-bit grayscale image (PGM format), allocates DMA buffers, and converts each pixel into a 32-bit word.

```
PGM image
      │
      ▼
32-bit DMA input buffer
```

---

### 2. Configure Accelerator (AXI-Lite)

Before any DMA transfer begins, the accelerator is configured through the AXI-Lite interface exposed by the `/dev/uniss_dma` driver.

```c
struct axi_lite_reg_io reg;

/* REG1 = number of output pixels */
reg.offset = ACCEL_REG1;
reg.value  = out_pixels;
ioctl(fd, IOCTL_AXILITE_WRITE_REG, &reg);

/* Enable output counter */
reg.offset = ACCEL_REG0;
reg.value  = ((uint32_t)kernel << 24) | 0x4;
ioctl(fd, IOCTL_AXILITE_WRITE_REG, &reg);

/* Start accelerator */
reg.value  = ((uint32_t)kernel << 24) | 0x1;
ioctl(fd, IOCTL_AXILITE_WRITE_REG, &reg);
```

This configures the selected edge detection operator (Roberts or Sobel), programs the expected number of output pixels, and starts the accelerator.

---

## 3. Reset DMA

```c
ioctl(fd, IOCTL_DMA_RESET_ALL, 0);
```

All DMA channels are reset before starting a new execution.

---

### 4. Prepare Output DMA (S2MM, Channel 2)

The output DMA channel is started first so that the accelerator has a valid destination before producing any output data.

```c
ioctl(fd, IOCTL_SELECT_CHANNEL, 2);
ioctl(fd, IOCTL_DMA_START_TRANSFER, out_pixels * WORD_BYTES);
```

This prepares the S2MM DMA channel to receive the processed image from the accelerator.

---


### 5. Send Image Configuration (MM2S, Channel 1)

The image width is transferred through the second MM2S DMA channel.

```c
ioctl(fd, IOCTL_SELECT_CHANNEL, 1);
ioctl(fd, IOCTL_DMA_WRITE_BUFFER, (unsigned char *)cfg);
ioctl(fd, IOCTL_DMA_START_TRANSFER, WORD_BYTES);
```

This streams the image width configuration from DDR memory to the accelerator.

---

### 6. Send Input Image (MM2S, Channel 0)

The grayscale image is transferred through the first MM2S DMA channel.

```c
ioctl(fd, IOCTL_SELECT_CHANNEL, 0);
ioctl(fd, IOCTL_DMA_WRITE_BUFFER, (unsigned char *)img);
ioctl(fd, IOCTL_DMA_START_TRANSFER, in_pixels * WORD_BYTES);
```

This streams the input image from DDR memory to the edge detection accelerator.

---

### 7. Wait for DMA Completion

The application waits until all DMA channels report the **Idle** state.

```c
wait_done(fd, 0, "DMA0", 50000);
wait_done(fd, 1, "DMA1", 50000);
wait_done(fd, 2, "DMA2", 50000);
```

During polling, the application also checks for DMA error conditions such as:

- DMA Internal Error
- Slave Error
- Decode Error

---

### 8. Receive Processed Image (S2MM, Channel 2)

After all DMA transfers complete, the processed image is copied back into userspace.

```c
ioctl(fd, IOCTL_SELECT_CHANNEL, 2);
ioctl(fd, IOCTL_DMA_READ_BUFFER, (unsigned char *)out);
```

This stores the edge detection result from the accelerator into the userspace output buffer.

---

### 9. Display Output

Finally, the application prints the processed image to the console.

```c
for (size_t i = 0; i < out_pixels; ++i) {
    if (i % out_width == 0)
        printf("\n");
    printf("%02X ", out[i] & 0xFF);
}
```

# Dataflow

```
                 AXI-Lite
                     │
                     ▼
             Configure Accelerator
                     │
                     ▼

        Channel 0 (MM2S)
Input Image ----------------------->

        Channel 1 (MM2S)
Image Width ----------------------->

                         Edge Detection
                             IP
                               │
                               ▼

        Channel 2 (S2MM)

Processed Image <-------------------
```

---

# Extended AXI DMA Driver

The custom `/dev/uniss_dma` driver provides both DMA management and AXI-Lite register access.

## DMA IOCTLs

| IOCTL | Function |
|--------|----------|
| IOCTL_SELECT_CHANNEL | Select active DMA channel |
| IOCTL_DMA_WRITE_BUFFER | Copy userspace data into DMA buffer |
| IOCTL_DMA_READ_BUFFER | Copy DMA buffer to userspace |
| IOCTL_DMA_START_TRANSFER | Start DMA transaction |
| IOCTL_READ_STATUS_REGISTER | Read DMA status |
| IOCTL_DMA_RESET | Reset current DMA |
| IOCTL_DMA_RESET_ALL | Reset all DMA channels |

## AXI-Lite IOCTLs

| IOCTL | Function |
|--------|----------|
| IOCTL_AXILITE_WRITE_REG | Write accelerator register |
| IOCTL_AXILITE_READ_REG | Read accelerator register |

The driver maps the AXI-Lite register space during probe using the Device Tree property:

```dts
axi_lite-handle = <&s_accelerator_0>;
```

This eliminates the need for `/dev/mem` access from userspace.

---

# Directory Layout

```text
edge_detector/
├── sw/
│   ├── acc_test_edgedetect.c
│   ├── input.pgm
│   ├── pl_s.dtbo
│   └── pl_s.dtsi
├── vivado/
└── README.md
```

---

# Build

```bash
gcc acc_test_edgedetect.c -o acc_test_edgedetect
```

---

# Run

Roberts operator

```bash
sudo ./acc_test_edgedetect roberts input.pgm
```

Sobel operator

```bash
sudo ./acc_test_edgedetect sobel input.pgm
```

If no arguments are supplied, the application executes the Roberts operator using `input.pgm`.

---

# Example Execution

```text
Input image (16x16)

Accelerator configured:
REG0 = 0x02000001
REG1 = 196

DMA transfers started.

DMA0 status = DONE
DMA1 status = DONE
DMA2 status = DONE

Sobel output (196 words)

...
```

The output image consists of one 32-bit word per output pixel, with the processed grayscale value stored in the least significant byte.