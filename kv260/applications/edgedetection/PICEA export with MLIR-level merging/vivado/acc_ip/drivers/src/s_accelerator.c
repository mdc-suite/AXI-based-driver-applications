/*****************************************************************************
*  Filename:          s_accelerator.c
*  Description:       Stream Accelerator Driver
*  Date:              2026/08/03 11:26:13 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#include "s_accelerator.h"

int s_accelerator_top5(
	// port out0
	int size_out0, int* data_out0,
	// port in1
	int size_in1, int* data_in1,
	// port in0
	int size_in0, int* data_in0
	) {
	
	volatile int* config = (int*) XPAR_S_ACCELERATOR_0_CFG_BASEADDR;

	// configure I/O
	*(config + 1) = size_out0;
	
	// start execution
	*(config) = 0x1000001;
	
		// send data port in0
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x00>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x04>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x18>>2)) = (int) data_in0; // src
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x28>>2)) = size_in0*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x04>>2))) & 0x2) != 0x2);
		// send data port in1
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x00>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x04>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x18>>2)) = (int) data_in1; // src
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x28>>2)) = size_in1*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x04>>2))) & 0x2) != 0x2);
	
		// receive data port out0
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x30>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x34>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x48>>2)) = (int) data_out0; // dst
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x58>>2)) = size_out0*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x34>>2))) & 0x2) != 0x2);
	
	// stop execution
	//*(config) = 0x0;
	
	return 0;
}
