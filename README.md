# axidma-driver

The `/dev/uniss_dma` [driver](https://github.com/GiuseppeSatta/AXI-based-drivers) controls an AXI DMA and only supports transfers on AXI4‑Stream interfaces. It uses the MM2S channel of the DMA to send data and the S2MM channel to receive data.
Consequently, to use this driver, a custom IP must have at least:
* **1 AXIS input port** (e.g., `im_axis_in`) connected to `M_AXIS_MM2S` of the DMA
* **1 AXIS output port** (e.g., `current_pos`) connected to `S_AXIS_S2MM` of the DMA
