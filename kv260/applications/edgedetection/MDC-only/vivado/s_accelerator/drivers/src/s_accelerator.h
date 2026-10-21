/*****************************************************************************
*  Filename:          s_accelerator.h
*  Description:       Stream Accelerator Driver Header
*  Date:              2026/09/18 19:41:37 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#ifndef S_ACCELERATOR_H
#define S_ACCELERATOR_H

/***************************** Include Files *******************************/		
#include "xparameters.h"

/************************** Constant Definitions ***************************/
/************************* Functions Definitions ***************************/


int s_accelerator_Roberts(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_size
	int size_in_size, int* data_in_size,
	// port in_pel
	int size_in_pel, int* data_in_pel
);

int s_accelerator_Sobel(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_size
	int size_in_size, int* data_in_size,
	// port in_pel
	int size_in_pel, int* data_in_pel
);


#endif /** MM_ACCELERATOR_H */
