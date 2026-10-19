#include "lineDet.h"

void hough_space(uint8_t hough_space1[NUMBER_OF_RHO], uint8_t hough_space2[NUMBER_OF_RHO], uint8_t hough_space3[NUMBER_OF_RHO],
		  	      uint8_t hough_space4[NUMBER_OF_RHO],uint8_t hough_space5[NUMBER_OF_RHO], uint8_t hough_space6[NUMBER_OF_RHO], uint8_t hough_space7[NUMBER_OF_RHO],
				  uint8_t hough_space1s[NUMBER_OF_RHO], uint8_t hough_space2s[NUMBER_OF_RHO], uint8_t hough_space3s[NUMBER_OF_RHO],
				  uint8_t hough_space4s[NUMBER_OF_RHO],uint8_t hough_space5s[NUMBER_OF_RHO], uint8_t hough_space6s[NUMBER_OF_RHO], uint8_t hough_space7s[NUMBER_OF_RHO],
				  uint8_t hough_layer[HOUGH_AREA_SIZE]){
		
		for (int16_t yh = 0; yh < NUMBER_OF_RHO; yh++) {
			for(int16_t x = 0; x < NUMBER_OF_THETA; x++){
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=12
#pragma HLS PIPELINE rewind
				if(x == 0){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space1[yh]+hough_space1s[yh];
				}else if(x == 1){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space2[yh]+hough_space2s[yh];
				}else if(x == 2){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space3[yh]+hough_space3s[yh];
				}else if(x == 3){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space4[yh]+hough_space4s[yh];
				}else if(x == 4){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space5[yh]+hough_space5s[yh];
				}else if(x == 5){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space6[yh]+hough_space6s[yh];
				}else if(x == 6){
					hough_layer[x + yh * NUMBER_OF_THETA] = hough_space7[yh]+hough_space7s[yh];
			}
		}
	}
}
