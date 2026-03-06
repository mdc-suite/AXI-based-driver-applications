#include "lineDet.h"

#if defined(THETA_neg_3_pos_3)
const ap_fixed<24,4,AP_RND> val_cos[11] = {0.998630,0.000000, 0.999391,0.000000, 0.999848, 1.000000, 0.999848,0.000000, 0.999391,0.000000,0.998630};
//const float val_cos[11] = {0.99863, 0, 0.99939, 0, 0.999848, 1, 0.999848, 0, 0.99939, 0, 0.99863};
const ap_fixed<24,4,AP_RND> val_div[11] = {-3.721949, 0.000000, -2.479412, 0.000000, -1.239067, 0.00000, 1.239067, 0.000000, 2.479412, 0.000000, 3.721949};
//const ap_fixed<24,4,AP_RND> val_sin[11] = {-0.052336,0.000000, -0.034899,0.000000, -0.017452, 0.000000, 0.017452,0.000000, 0.034899, 0.000000,0.052336};
//float val_sin[11] = {-0.05235, 0, -0.0349, 0, -0.017449, 0, 0.017449, 0, 0.0349, 0, 0.05235};
#endif
int32_t elaboration_data(int8_t peakCoordinates[4]) {


		int16_t outData[MAX_PEAK_NUMBER];
		int16_t dataPeaks[MAX_PEAK_NUMBER] = {0};
		ap_fixed<24,4,AP_RND> theta;
		ap_fixed<36,16,AP_RND>  peak;

		for (int8_t x = 0; x < MAX_PEAK_NUMBER; x++) {
#pragma HLS UNROLL factor=2
#pragma HLS PIPELINE
			theta = peakCoordinates[x + MAX_PEAK_NUMBER] * 0.01745;
			int8_t the_int = (theta * 100);
			int8_t ind = the_int + 5;

			//float theta   = (float)peakCoordinates[x+MAX_PEAK_NUMBER]*PI/180.0;
			peak = peakCoordinates[x];
			int16_t distance = peak - val_div[ind];

        	if (distance < 0)
        		distance = 0;
        	if (distance > (IMG_WIDTH - 1))
        		distance = (IMG_WIDTH - 1);
        	//Assign the distance to data peak array
        	dataPeaks[x] = distance;
    	}

    	for (int8_t a = 0; a < (MAX_PEAK_NUMBER - 1); a++) {
        	for (int8_t b = a + 1; b < (MAX_PEAK_NUMBER); b++) {
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE
            	if (dataPeaks[b] > dataPeaks[a]) {
                	int8_t swap_rho = dataPeaks[a];
                	// Swap a and b
                	dataPeaks[a] = dataPeaks[b];
                	dataPeaks[b] = swap_rho;

            	}
        	}
    	}
    	// Assign output data
    	for (int8_t y = 0; y < MAX_PEAK_NUMBER; y++) {
#pragma HLS UNROLL factor=2
#pragma HLS PIPELINE
    		outData[y] = dataPeaks[y];
    	}


    	int16_t right_edge = outData[0];
    	int16_t left_edge = outData[1];
        int32_t current_pos_val = ((int32_t)left_edge + (int32_t)right_edge) / 2 + 3;

    	
    	return current_pos_val;

}



