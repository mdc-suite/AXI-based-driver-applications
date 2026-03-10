## Platform Generation Flow

Run the HLS-based Platform Generation Flow with the following steps (Vivado ML v2021.2 is assumed to be installed):

1. 	Open a terminal from this folder.

2. 	Open Vivado ML in tcl mode by the following command:
	vivado -mode tcl
	
3. 	Run the Tcl script by the following command:
	source hlsPlatformDesign.tcl

4. 	Open the project in Vivado ML with the following command:
	vivado ./line_detector/line_detector.xpr
