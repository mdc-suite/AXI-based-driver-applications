/*****************************************************************************
*  Filename:          s_accelerator.h
*  Description:       Stream Accelerator Driver Header
*  Date:              2026/08/03 11:26:13 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#ifndef S_ACCELERATOR_H
#define S_ACCELERATOR_H

/***************************** Include Files *******************************/		
#include "xparameters.h"

/************************** Constant Definitions ***************************/
/************************* Functions Definitions ***************************/


int s_accelerator_top5(
	// port out0
	int size_out0, int* data_out0,
	// port in1
	int size_in1, int* data_in1,
	// port in0
	int size_in0, int* data_in0
);


#endif /** MM_ACCELERATOR_H */
