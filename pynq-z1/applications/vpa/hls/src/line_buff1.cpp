#include "lineDet.h"

void line_buff1(hls::stream<axis_t> &im_axis_in,
                int8_t img_in0[IMG_WIDTH], int8_t img_in1[IMG_WIDTH],
                int8_t img_in2[IMG_WIDTH],
                int32_t img_in1bf[IMG_WIDTH/4],
                int32_t img_in2bf[IMG_WIDTH/4],
                int16_t y)
{

	int16_t cnt = 0;

	if(y == 0){
		for (int16_t x = 0; x < IMG_WIDTH; x=x+4) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS PIPELINE rewind
		    axis_t w;
		    im_axis_in.read(w);
		    int32_t val = w.data;
		    int8_t num1 = (val >> 24) & 0xFF;
		    int8_t num2 = (val >> 16) & 0xFF;
		    int8_t num3 = (val >> 8) & 0xFF;
		    int8_t num4 = val & 0xFF;
		    img_in0[x] = num1;
		    img_in0[x+1] = num2;
		    img_in0[x+2] = num3;
		    img_in0[x+3] = num4;
		}
	}else if(y == 1){
		for (int16_t x = 0; x < IMG_WIDTH; x=x+4) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS PIPELINE rewind
		    axis_t w;
		    im_axis_in.read(w);
		    int32_t val = w.data;
		    int8_t num1 = (val >> 24) & 0xFF;
		    int8_t num2 = (val >> 16) & 0xFF;
		    int8_t num3 = (val >> 8) & 0xFF;
		    int8_t num4 = val & 0xFF;
			img_in1bf[cnt] = val;
		    img_in1[x] = num1;
		    img_in1[x+1] = num2;
		    img_in1[x+2] = num3;
		    img_in1[x+3] = num4;
		    cnt++;
		}
	}else if(y == 2){
		for (int16_t x = 0; x < IMG_WIDTH; x=x+4) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS PIPELINE rewind
		    axis_t w;
		    im_axis_in.read(w);
		    int32_t val = w.data;
		    int8_t num1 = (val >> 24) & 0xFF;
		    int8_t num2 = (val >> 16) & 0xFF;
		    int8_t num3 = (val >> 8) & 0xFF;
		    int8_t num4 = val & 0xFF;
			img_in2bf[cnt] = val;
		    img_in2[x] = num1;
		    img_in2[x+1] = num2;
		    img_in2[x+2] = num3;
		    img_in2[x+3] = num4;
		    cnt++;
		}
	}else if(y >= 3){
		for (int16_t x = 0; x < IMG_WIDTH; x=x+4) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS PIPELINE rewind
			int32_t val_1 = img_in1bf[cnt];
		    int8_t num1_1 = (val_1 >> 24) & 0xFF;
		    int8_t num1_2 = (val_1 >> 16) & 0xFF;
		    int8_t num1_3 = (val_1 >> 8) & 0xFF;
		    int8_t num1_4 = val_1 & 0xFF;
			int32_t val_2 = img_in2bf[cnt];
		    int8_t num2_1 = (val_2 >> 24) & 0xFF;
		    int8_t num2_2 = (val_2 >> 16) & 0xFF;
		    int8_t num2_3 = (val_2 >> 8) & 0xFF;
		    int8_t num2_4 = val_2 & 0xFF;
		    axis_t w3;
		    im_axis_in.read(w3);
		    int32_t val_3 = w3.data;
		    int8_t num3_1 = (val_3 >> 24) & 0xFF;
		    int8_t num3_2 = (val_3 >> 16) & 0xFF;
		    int8_t num3_3 = (val_3 >> 8) & 0xFF;
		    int8_t num3_4 = val_3 & 0xFF;

			img_in0[x] = num1_1;
			img_in0[x+1] = num1_2;
			img_in0[x+2] = num1_3;
			img_in0[x+3] = num1_4;

			img_in1[x] = num2_1;
			img_in1[x+1] = num2_2;
			img_in1[x+2] = num2_3;
			img_in1[x+3] = num2_4;

			img_in2[x] = num3_1;
			img_in2[x+1] = num3_2;
			img_in2[x+2] = num3_3;
			img_in2[x+3] = num3_4;

			img_in1bf[cnt] = val_2;
			img_in2bf[cnt] = val_3;

			cnt++;
		}
	}
}

