#include "lineDet.h"

void nMS_Hys(int32_t img_ma0[IMG_WIDTH-4], int32_t img_ma1[IMG_WIDTH-4], int32_t img_ma1_1[IMG_WIDTH-4],
			 int32_t img_ma2[IMG_WIDTH-4],uint8_t img_dir[IMG_WIDTH-4], uint8_t edg_img[IMG_WIDTH-6], int16_t y){

	if(y >= 6){
        wr_buf_loop_jif:
        for (int16_t x = 6; x < IMG_WIDTH; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=2
#pragma HLS PIPELINE rewind
            int16_t x_h=x-5;
            uint8_t direction = img_dir[x_h];
            if (direction == 0) {
            	int32_t currentMagnitude = img_ma1[x_h];
            	if (currentMagnitude >= img_ma1[x_h - 1] && currentMagnitude >= img_ma1_1[x_h + 1] && currentMagnitude >=3600){ //3600 = 60*60 (HIGHT THRESHOLD)
            		//img_axis_out.write(1);
            		edg_img[x-6] = 1;
            	}else{
            		//img_axis_out.write(0);
            		edg_img[x-6] = 0;
                }
            }else if(direction == 90) {
            	int32_t currentMagnitude = img_ma1[x_h];
            	if (currentMagnitude >= img_ma0[x_h] && currentMagnitude >= img_ma2[x_h] && currentMagnitude >=3600){
            		//img_axis_out.write(1);
            		edg_img[x-6] = 1;
               }else{
            	   //img_axis_out.write(0);
            	   edg_img[x-6] = 0;
               }
            }else if(direction == 45) {
            	int32_t currentMagnitude = img_ma1[x_h];
            	if (currentMagnitude >= img_ma0[x_h+1] && currentMagnitude >= img_ma2[x_h-1] && currentMagnitude >=3600){
            		//img_axis_out.write(1);
            		edg_img[x-6] = 1;
               }else{
            	   //img_axis_out.write(0);
            	   edg_img[x-6] = 0;
               }
            }else if(direction == 135) {
            	int32_t currentMagnitude = img_ma1[x_h];
            	if (currentMagnitude >= img_ma0[x_h-1] && currentMagnitude >= img_ma2[x_h+1] && currentMagnitude >=3600){
            		//img_axis_out.write(1);
            		edg_img[x-6] = 1;
               }else{
            	   //img_axis_out.write(0);
            	   edg_img[x-6] = 0;
               }
            }
           else {
        	   //img_axis_out.write(0);
        	   edg_img[x-6] = 0;
           }
        }
    }
}
