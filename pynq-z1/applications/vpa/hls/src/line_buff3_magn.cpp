#include "lineDet.h"

void line_buff3_magn(int32_t edgeMagnitudeC[IMG_WIDTH-4],
		int32_t img_ma0[IMG_WIDTH-4],int32_t img_ma1[IMG_WIDTH-4],int32_t img_ma1_1[IMG_WIDTH-4],
		int32_t img_ma2[IMG_WIDTH-4],int32_t img_ma1bf[IMG_WIDTH-4],int32_t img_ma2bf[IMG_WIDTH-4],int16_t y){

	if(y == 4){
		for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			img_ma0[x] = edgeMagnitudeC[x];
		}
	}else if(y == 5){
		for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			int32_t valma_1 = edgeMagnitudeC[x];
			img_ma1[x] = valma_1;
			img_ma1_1[x] = valma_1;
			img_ma1bf[x] = valma_1;
		}
	}else if(y == 6){
		for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			int32_t valma_1 = edgeMagnitudeC[x];
			img_ma2[x] = valma_1;
			img_ma2bf[x] = valma_1;
		}
	}else if(y >= 7){
		for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			int32_t valma_1 = img_ma1bf[x];
			int32_t valma_2 = img_ma2bf[x];
			int32_t valma_3 = edgeMagnitudeC[x];
			img_ma0[x] = valma_1;
			img_ma1[x] = valma_2;
			img_ma1_1[x] = valma_2;
			img_ma2[x] = valma_3;
			img_ma1bf[x] = valma_2;
			img_ma2bf[x] = valma_3;

		}
	}
}
