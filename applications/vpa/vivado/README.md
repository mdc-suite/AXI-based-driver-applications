## Platform Generation Flow

Run the HLS-based platform generation flow with the following steps (Vivado ML v2021.2 is assumed to be installed):

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
