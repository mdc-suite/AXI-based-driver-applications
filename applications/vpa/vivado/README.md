## Platform Generation Flow
All projects were created with Vivado 2021 and for the KV260.
Run the HLS-based platform generation flow with the following steps:

1. Open a terminal in this folder.

2. Open Vivado ML in Tcl mode:

   ```bash
   vivado -mode tcl
   ```

3. Run the Tcl script:

   ```tcl
   source hlsPlatformDesign.tcl
   ```

4. Open the generated Vivado project:

   ```bash
   vivado ./line_detector/line_detector.xpr
   ```

5. Check the project in Vivado and generate the bitstream.
