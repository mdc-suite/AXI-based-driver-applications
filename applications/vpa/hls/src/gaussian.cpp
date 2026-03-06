#include "lineDet.h"

void gaussian(int8_t img_in0[IMG_WIDTH], int8_t img_in1[IMG_WIDTH], int8_t img_in2[IMG_WIDTH],
			  int8_t img_ga[IMG_WIDTH-2],int16_t y){

	if(y >= 2){

    		for (int16_t x = 0; x < IMG_WIDTH-2; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind

    			// Kernel del filtro gaussiano (3x3)
    					int8_t gaus0 = 1;
    					int8_t gaus1 = 2;
    					int8_t gaus2 = 1;
    					int8_t gaus3 = 2;
    					int8_t gaus4 = 4;
    					int8_t gaus5 = 2;
    					int8_t gaus6 = 1;
    					int8_t gaus7 = 2;
    					int8_t gaus8 = 1;

    			img_ga[x] =
    					(img_in0[x] * gaus0 >> 4) + (img_in0[x+1] * gaus1 >> 4) + (img_in0[x+2] * gaus2 >> 4) +
                        (img_in1[x] * gaus3 >> 4) + (img_in1[x+1] * gaus4 >> 4) + (img_in1[x+2] * gaus5 >> 4) +
                        (img_in2[x] * gaus6 >> 4) + (img_in2[x+1] * gaus7 >> 4) + (img_in2[x+2] * gaus8 >> 4);
    		}
	}
}



