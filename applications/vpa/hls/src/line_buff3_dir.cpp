#include "lineDet.h"

void line_buff3_dir(uint8_t edgeDirection[IMG_WIDTH-4], uint8_t img_dir[IMG_WIDTH-4], uint8_t img_dirbf[IMG_WIDTH-4], int16_t y){

	 if(y == 5){
		for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			uint8_t valma_1 = edgeDirection[x];
			img_dirbf[x] = valma_1;
		}
	}else if(y >= 6){
		for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			uint8_t valma_1 = edgeDirection[x];
			uint8_t valma_2 = img_dirbf[x];
			img_dir[x] = valma_2;
			img_dirbf[x] = valma_1;
		}
	}
}
