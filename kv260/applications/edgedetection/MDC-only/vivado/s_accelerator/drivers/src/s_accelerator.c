/*****************************************************************************
*  Filename:          s_accelerator.c
*  Description:       Stream Accelerator Driver
*  Date:              2026/09/18 19:41:37 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#include "s_accelerator.h"

int s_accelerator_Roberts(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_size
	int size_in_size, int* data_in_size,
	// port in_pel
	int size_in_pel, int* data_in_pel
	) {
	
	volatile int* config = (int*) XPAR_S_ACCELERATOR_0_CFG_BASEADDR;

	// configure I/O
	*(config + 1) = size_out_pel;
	
	// start execution
	*(config) = 0x1000001;
	
		// send data port in_pel
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x00>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x04>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x18>>2)) = (int) data_in_pel; // src
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x28>>2)) = size_in_pel*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x04>>2))) & 0x2) != 0x2);
		// send data port in_size
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x00>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x04>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x18>>2)) = (int) data_in_size; // src
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x28>>2)) = size_in_size*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x04>>2))) & 0x2) != 0x2);
	
		// receive data port out_pel
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x30>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x34>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x48>>2)) = (int) data_out_pel; // dst
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x58>>2)) = size_out_pel*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x34>>2))) & 0x2) != 0x2);
	
	// stop execution
	//*(config) = 0x0;
	
	return 0;
}

int s_accelerator_Sobel(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_size
	int size_in_size, int* data_in_size,
	// port in_pel
	int size_in_pel, int* data_in_pel
	) {
	
	volatile int* config = (int*) XPAR_S_ACCELERATOR_0_CFG_BASEADDR;

	// configure I/O
	*(config + 1) = size_out_pel;
	
	// start execution
	*(config) = 0x2000001;
	
		// send data port in_pel
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x00>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x04>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x18>>2)) = (int) data_in_pel; // src
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x28>>2)) = size_in_pel*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x04>>2))) & 0x2) != 0x2);
		// send data port in_size
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x00>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x04>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x18>>2)) = (int) data_in_size; // src
		*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x28>>2)) = size_in_size*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_1_BASEADDR + (0x04>>2))) & 0x2) != 0x2);
	
		// receive data port out_pel
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x30>>2)) = 0x00000001; // start
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x34>>2)) = 0x00000000; // reset idle
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x48>>2)) = (int) data_out_pel; // dst
		*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x58>>2)) = size_out_pel*4; // size [B]
		while(((*((volatile int*) XPAR_AXI_DMA_0_BASEADDR + (0x34>>2))) & 0x2) != 0x2);
	
	// stop execution
	//*(config) = 0x0;
	
	return 0;
}
