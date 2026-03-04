# Applications
This folder contains examples of applications and hardware accelerators that use the **`/dev/uniss_dma`** driver to manage data transfers via AXI4‑Stream interfaces.
Each subfolder represents a specific use case and contains both the hardware logic and the test software needed to verify the correct operation of the driver with the relevant IPs.

## Folder contents
* **`aes/`**: Example application for data encryption/decryption using an AES accelerator.
* **`vpa/`**: Example accelerator for image processing (Video Processing Accelerator).

---
For specific instructions on how to compile and run individual tests, refer to the README files in each subfolder.
...