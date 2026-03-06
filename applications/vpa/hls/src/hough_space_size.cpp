#include "lineDet.h"

#if defined(THETA_neg_3_pos_3)
const ap_fixed<22,2,AP_RND> cost[NUMBER_OF_THETA] = {0.998630, 0.999391, 0.999848, 1.000000, 0.999848, 0.999391, 0.998630};
const ap_fixed<22,2,AP_RND> sint[NUMBER_OF_THETA] = {-0.052336, -0.034899, -0.017452, 0.000000, 0.017452, 0.034899, 0.052336};
const ap_fixed<22,2,AP_RND> inc = 0.5;
#endif

void hough_space_size(uint8_t edg_img[IMG_WIDTH-6],
					  uint8_t hough_space1[NUMBER_OF_RHO], uint8_t hough_space2[NUMBER_OF_RHO], uint8_t hough_space3[NUMBER_OF_RHO], uint8_t hough_space4[NUMBER_OF_RHO],
					  uint8_t hough_space5[NUMBER_OF_RHO], uint8_t hough_space6[NUMBER_OF_RHO], uint8_t hough_space7[NUMBER_OF_RHO], uint8_t houngh_space_buff1[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff2[NUMBER_OF_RHO], uint8_t houngh_space_buff3[NUMBER_OF_RHO], uint8_t houngh_space_buff4[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff5[NUMBER_OF_RHO], uint8_t houngh_space_buff6[NUMBER_OF_RHO], uint8_t houngh_space_buff7[NUMBER_OF_RHO],
					  uint8_t hough_space1s[NUMBER_OF_RHO], uint8_t hough_space2s[NUMBER_OF_RHO], uint8_t hough_space3s[NUMBER_OF_RHO], uint8_t hough_space4s[NUMBER_OF_RHO],
					  uint8_t hough_space5s[NUMBER_OF_RHO], uint8_t hough_space6s[NUMBER_OF_RHO], uint8_t hough_space7s[NUMBER_OF_RHO], uint8_t houngh_space_buff1s[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff2s[NUMBER_OF_RHO], uint8_t houngh_space_buff3s[NUMBER_OF_RHO], uint8_t houngh_space_buff4s[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff5s[NUMBER_OF_RHO], uint8_t houngh_space_buff6s[NUMBER_OF_RHO], uint8_t houngh_space_buff7s[NUMBER_OF_RHO],
					  int16_t y) {
						  
	if(y>=6){

#pragma HLS DEPENDENCE variable=hough_space1 type=inter false
#pragma HLS DEPENDENCE variable=hough_space2 type=inter false
#pragma HLS DEPENDENCE variable=hough_space3 type=inter false
#pragma HLS DEPENDENCE variable=hough_space4 type=inter false
#pragma HLS DEPENDENCE variable=hough_space5 type=inter false
#pragma HLS DEPENDENCE variable=hough_space6 type=inter false
#pragma HLS DEPENDENCE variable=hough_space7 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff1 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff2 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff3 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff4 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff5 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff6 type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff7 type=inter false
#pragma HLS DEPENDENCE variable=hough_space1s type=inter false
#pragma HLS DEPENDENCE variable=hough_space2s type=inter false
#pragma HLS DEPENDENCE variable=hough_space3s type=inter false
#pragma HLS DEPENDENCE variable=hough_space4s type=inter false
#pragma HLS DEPENDENCE variable=hough_space5s type=inter false
#pragma HLS DEPENDENCE variable=hough_space6s type=inter false
#pragma HLS DEPENDENCE variable=hough_space7s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff1s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff2s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff3s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff4s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff5s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff6s type=inter false
#pragma HLS DEPENDENCE variable=houngh_space_buff7s type=inter false

		for (int16_t x = 0; x < IMG_WIDTH-6; x=x+2) {
#pragma HLS LOOP_FLATTEN off
#pragma HLS PIPELINE rewind
			if (edg_img[x] == 1) {

            	uint8_t rho1 = ((x * cost[0]) + ((y-6) * sint[0]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho2 = ((x * cost[1]) + ((y-6) * sint[1]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho3 = ((x * cost[2]) + ((y-6) * sint[2]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho4 = ((x * cost[3]) + ((y-6) * sint[3]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho5 = ((x * cost[4]) + ((y-6) * sint[4]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho6 = ((x * cost[5]) + ((y-6) * sint[5]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho7 = ((x * cost[6]) + ((y-6) * sint[6]) + MAX_NEGATIVE_RHO + inc);

            	uint8_t val1 = houngh_space_buff1[rho1];
            	uint8_t val2 = houngh_space_buff2[rho2];
            	uint8_t val3 = houngh_space_buff3[rho3];
				uint8_t val4 = houngh_space_buff4[rho4];
				uint8_t val5 = houngh_space_buff5[rho5];
				uint8_t val6 = houngh_space_buff6[rho6];
				uint8_t val7 = houngh_space_buff7[rho7];

                hough_space1[rho1] = val1+1;
                hough_space2[rho2] = val2+1;
                hough_space3[rho3] = val3+1;
                hough_space4[rho4] = val4+1;
                hough_space5[rho5] = val5+1;
                hough_space6[rho6] = val6+1;
                hough_space7[rho7] = val7+1;

            	houngh_space_buff1[rho1] = val1+1;
            	houngh_space_buff2[rho2] = val2+1;
            	houngh_space_buff3[rho3] = val3+1;
				houngh_space_buff4[rho4] = val4+1;
				houngh_space_buff5[rho5] = val5+1;
				houngh_space_buff6[rho6] = val6+1;
				houngh_space_buff7[rho7] = val7+1;
            }
			if(edg_img[(x + 1)] == 1){

            	uint8_t rho1s = (((x + 1) * cost[0]) + ((y-6) * sint[0]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho2s = (((x + 1) * cost[1]) + ((y-6) * sint[1]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho3s = (((x + 1) * cost[2]) + ((y-6) * sint[2]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho4s = (((x + 1) * cost[3]) + ((y-6) * sint[3]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho5s = (((x + 1) * cost[4]) + ((y-6) * sint[4]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho6s = (((x + 1) * cost[5]) + ((y-6) * sint[5]) + MAX_NEGATIVE_RHO + inc);
            	uint8_t rho7s = (((x + 1) * cost[6]) + ((y-6) * sint[6]) + MAX_NEGATIVE_RHO + inc);

            	uint8_t val1s = houngh_space_buff1s[rho1s];
            	uint8_t val2s = houngh_space_buff2s[rho2s];
            	uint8_t val3s = houngh_space_buff3s[rho3s];
				uint8_t val4s = houngh_space_buff4s[rho4s];
				uint8_t val5s = houngh_space_buff5s[rho5s];
				uint8_t val6s = houngh_space_buff6s[rho6s];
				uint8_t val7s = houngh_space_buff7s[rho7s];

                hough_space1s[rho1s] = val1s+1;
                hough_space2s[rho2s] = val2s+1;
                hough_space3s[rho3s] = val3s+1;
                hough_space4s[rho4s] = val4s+1;
                hough_space5s[rho5s] = val5s+1;
                hough_space6s[rho6s] = val6s+1;
                hough_space7s[rho7s] = val7s+1;

            	houngh_space_buff1s[rho1s] = val1s+1;
            	houngh_space_buff2s[rho2s] = val2s+1;
            	houngh_space_buff3s[rho3s] = val3s+1;
				houngh_space_buff4s[rho4s] = val4s+1;
				houngh_space_buff5s[rho5s] = val5s+1;
				houngh_space_buff6s[rho6s] = val6s+1;
				houngh_space_buff7s[rho7s] = val7s+1;
			}
        }
    }
}



