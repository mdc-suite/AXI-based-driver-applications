Run the HLS-based Platform Generation Flow with the following steps (Vivado ML v2021.2 is assumed to be installed):

1. 	Open a terminal from this folder.

2. 	Open Vivado ML in tcl mode by the following command:
	vivado -mode tcl
	
3. 	Run the Tcl script by the following command:
	source hlsPlatformDesign.tcl

4. 	Open the project in Vivado ML with the following command:
	vivado ./line_detector/line_detector.xpr
	
5. 	In the Tcl Console (Window -> Tcl Console), run the Tcl script by the following command:
	source VivadoDesignFlow.tcl
	
6. 	Wait until the bitstream generation is finished successfully (check Log window associated with synthesis and implementation, Window -> Log), and the message window "Open the Implemented Design".
	
7. 	Then, run the Tcl script by the following command (always in the Tcl Console):
	source XSAGeneration.tcl
