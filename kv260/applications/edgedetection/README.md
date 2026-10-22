# Applications
This folder contains examples of applications and hardware accelerators that use the **`/dev/uniss_dma`** driver to manage data transfers via AXI4‑Stream interfaces.
Each subfolder represents a specific use case and contains both the hardware logic and the test software needed to verify the correct operation of the driver with the relevant IPs.

## Folder contents
* **`MDC-only/`**: IP made by MDC tool-chain.
* **`PICEA export with MDC merging/`**: IP made by MDC tool-chain from MLIR specifications.
* **`PICEA export with MLIR-level merging/`**: IP made by MDC tool-chain from one MLIR specification merged by DFG-MLIR.
* **`protocols/`**: Communication protocol files.
* **`tutorial/`**: Tutorial file.
---
For specific instructions on how to compile and run individual tests, refer to the README files in each subfolder.
