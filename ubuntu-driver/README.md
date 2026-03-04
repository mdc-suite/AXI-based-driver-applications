## Environment setup
The `set_env.sh` script automate the entire process of downloading, compiling, and installing the AXI DMA driver on your system.

### What the script does:
1.  **Repository Cloning**: Downloads the latest version of the `AXI-based-drivers` repository directly from GitHub.
2.  **Dependency Installation**: Runs `install_libs.sh` to install the necessary system libraries and kernel headers required for compilation.
3.  **Driver Compilation**: Navigates to the `axidma-driver` directory and builds the source code using the `make` command.
4.  **Module Installation**:
    * Creates the required directory in `/lib/modules/` for extra kernel modules.
    * Copies the compiled binary file (`axidma.ko`) to the system module path.
    * Updates the kernel module dependency list using `depmod`.
5.  **Persistence at Boot**: Configures the system to automatically load the `axidma` module during every boot by creating a configuration file in `/etc/modules-load.d/`.
6.  **Loading and Verification**: Immediately loads the driver into the kernel using `modprobe` and displays the status via `lsmod` to confirm a successful installation.
---

## Usage
To set up your environment, run the following commands in your terminal:
```bash
# Make the script executable
chmod +x set_env.sh

# Start the installation
./set_env.sh
