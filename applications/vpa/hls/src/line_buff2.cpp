#include "lineDet.h"

void line_buff2(int8_t img_ga[IMG_WIDTH-2],int8_t img_ga0[IMG_WIDTH-2],int8_t img_ga1[IMG_WIDTH-2],int8_t img_ga2[IMG_WIDTH-2],
				int8_t img_ga1bf[IMG_WIDTH-2],int8_t img_ga2bf[IMG_WIDTH-2],int16_t y){

	if(y == 2){
		for (int16_t x = 0; x < IMG_WIDTH-2; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			img_ga0[x] = img_ga[x];
		}
	}else if(y == 3){
		for (int16_t x = 0; x < IMG_WIDTH-2; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			int8_t val_1 = img_ga[x];
			img_ga1[x] = val_1;
			img_ga1bf[x] = val_1;
		}
	}else if(y == 4){
		for (int16_t x = 0; x < IMG_WIDTH-2; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			int8_t val_1 = img_ga[x];
			img_ga2[x] = val_1;
			img_ga2bf[x] = val_1;
		}
	}else if(y >= 5){
		for (int16_t x = 0; x < IMG_WIDTH-2; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind
			int8_t val_1 = img_ga1bf[x];
			int8_t val_2 = img_ga2bf[x];
			int8_t val_3 = img_ga[x];
			img_ga0[x] = val_1;
			img_ga1[x] = val_2;
			img_ga2[x] = val_3;
			img_ga1bf[x] = val_2;
			img_ga2bf[x] = val_3;
		}
	}
}
