#include "lineDet.h"

void gradient(int8_t img_ga0[IMG_WIDTH-2],int8_t img_ga1[IMG_WIDTH-2],int8_t img_ga2[IMG_WIDTH-2],
			  int32_t edgeMagnitudeC[IMG_WIDTH-4], uint8_t edgeDirection[IMG_WIDTH-4], int16_t y) {

	if(y >= 4){

    	for (int16_t x = 0; x < IMG_WIDTH-4; x++) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE rewind

    		int16_t t_int;
    		int16_t pix_grad;

        	int8_t sobx0 = -1;
        	int8_t sobx1 = 0;
        	int8_t sobx2 = 1;
        	int8_t sobx3 = -2;
        	int8_t sobx4 = 0;
        	int8_t sobx5 = 2;
        	int8_t sobx6 = -1;
        	int8_t sobx7 = 0;
        	int8_t sobx8 = 1;

        	int8_t soby0 = 1;
        	int8_t soby1 = 2;
        	int8_t soby2 = 1;
        	int8_t soby3 = 0;
        	int8_t soby4 = 0;
        	int8_t soby5 = 0;
        	int8_t soby6 = -1;
        	int8_t soby7 = -2;
        	int8_t soby8 = -1;

    		uint8_t gaus_0s = img_ga0[x];
    		uint8_t gaus_0c = img_ga0[x+1];
    		uint8_t gaus_0d = img_ga0[x+2];
    		uint8_t gaus_1s = img_ga1[x];
    		uint8_t gaus_1c = img_ga1[x+1];
    		uint8_t gaus_1d = img_ga1[x+2];
    		uint8_t gaus_2s = img_ga2[x];
        	uint8_t gaus_2c = img_ga2[x+1];
        	uint8_t gaus_2d = img_ga2[x+2];

        	int16_t valx =
        	(gaus_0s * sobx0) + (gaus_0c * sobx1) + (gaus_0d * sobx2) +
            (gaus_1s * sobx3) + (gaus_1c * sobx4) + (gaus_1d * sobx5) +
			(gaus_2s * sobx6) + (gaus_2c * sobx7) + (gaus_2d * sobx8);
        	int16_t valy =
       		(gaus_0s * soby0) + (gaus_0c * soby1) + (gaus_0d * soby2) +
            (gaus_1s * soby3) + (gaus_1c * soby4) + (gaus_1d * soby5) +
			(gaus_2s * soby6) + (gaus_2c * soby7) + (gaus_2d * soby8);


        	edgeMagnitudeC[x] = valx * valx + valy * valy;

        	if((65025) < (valx * valx + valy * valy)){ //65025 = 255*255
        		pix_grad = 255;
        	}
        	if(valx != 0){
        		t_int = valy*255/valx;
        	}else{
        		t_int = 0xFFFF;
        	}
        	// 112.5° ~ 157.5° (tan 112.5° ~= -2.4142, tan 157.5° ~= -0.4142)
        	if(-618 < t_int && t_int <= -106) {
        	    edgeDirection[x] = 135;
        	}
        	// -22.5° ~ 22.5° (tan -22.5° ~= -0.4142, tan 22.5° = 0.4142)
        	else if(-106 < t_int && t_int <= 106) {
        		edgeDirection[x] = 0;
        	}
        	// 22.5° ~ 67.5° (tan 22.5° ~= 0.4142, tan 67.5° = 2.4142)
        	else if(106 < t_int && t_int < 618) {
        	    edgeDirection[x] = 45;
        	}
        	// 67.5° ~ 112.5° (to inf)
        	else{
        	edgeDirection[x] = 90;
        	}
        }
    }
}


