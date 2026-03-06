#include "lineDet.h"

void accumulation_point(uint8_t hough_layer[HOUGH_AREA_SIZE], int8_t peakCoordinates[4]) {

		uint8_t maxVal;
		uint8_t peakIdx = 0; //conta quanti picchi (linee) sono stati trovati
		int8_t jPeak;
		int16_t rhoToRemove;
		int16_t rhoMin;
		int16_t rhoMax;
		int8_t thetaMax;
		int8_t thetaMin;

		maxVal = 0;
		jPeak = 0;
		rhoToRemove = 0;


		// Find the maximum value in hough space
		acc_p_loop1:
		for (int8_t ex = 0; ex < NUMBER_OF_THETA; ex++) {
			for (int16_t k = 0; k < NUMBER_OF_RHO; k++) {
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE
				uint8_t d1 = hough_layer[k * NUMBER_OF_THETA + ex];
				//se il valore trovato è maggiore dell'attuale maxVal lo aggiorno
				if (d1 > maxVal) {
					rhoToRemove = k;
					jPeak = ex;
					maxVal = d1;
				}
			}
		}

		peakIdx++;
		peakCoordinates[peakIdx - 1] = (rhoToRemove - MAX_NEGATIVE_RHO); // + Offset // 0 1
		peakCoordinates[peakIdx + MAX_PEAK_NUMBER - 1] = (jPeak + THETA_MIN); // + Offset // 2 3

		rhoMin = rhoToRemove - PADDING_SIZE_RHO;
		rhoMax = rhoToRemove + PADDING_SIZE_RHO;
		thetaMax = jPeak + PADDING_SIZE_THETA;
		thetaMin = jPeak - PADDING_SIZE_THETA;

		if (rhoMin < 0) {
			rhoMin = 0;
		} else if (rhoMax > NUMBER_OF_RHO - 1) {
			rhoMax = NUMBER_OF_RHO - 1;
		}
		if (thetaMin < 0) {
			thetaMin = 0;
		} else if (thetaMax > NUMBER_OF_THETA - 1) {
			thetaMax = NUMBER_OF_THETA - 1;
		}

		acc_p_loop2:
		for (int8_t ex1 = thetaMin; ex1 <= thetaMax; ex1++) {
			for (int16_t k1 = rhoMin; k1 <= rhoMax; k1++) {
#pragma HLS PIPELINE
				hough_layer[k1 * NUMBER_OF_THETA + ex1] = 0;
			}
		}

		//second loop

		maxVal = 0;
		jPeak = 0;
		rhoToRemove = 0;

		// Find the maximum value in hough space

		acc_p_loop3:
		for (int8_t ex = 0; ex < NUMBER_OF_THETA; ex++) {
			for (int16_t k = 0; k < NUMBER_OF_RHO; k++) {
#pragma HLS UNROLL factor=4
#pragma HLS PIPELINE
				uint8_t d1 = hough_layer[k * NUMBER_OF_THETA + ex];
				//se il valore trovato è maggiore dell'attuale maxVal lo aggiorno
				if (d1 > maxVal) {
					rhoToRemove = k;
					jPeak = ex;
					maxVal = d1;
				}
			}
		}

    	peakIdx++;
    	peakCoordinates[peakIdx - 1] = (rhoToRemove - MAX_NEGATIVE_RHO); // + Offset // 0 1
    	peakCoordinates[peakIdx + MAX_PEAK_NUMBER - 1] = (jPeak + THETA_MIN); // + Offset // 2 3
}


