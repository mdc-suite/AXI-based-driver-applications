#ifndef SRC_LINE_DET_H
#define SRC_LINE_DET_H

#include "config.h"
#include <hls_stream.h>
#include <hls_math.h>
#include <ap_fixed.h>
#include <ap_axi_sdata.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <string.h>
#include <stddef.h>
#include <stdbool.h>

using namespace hls;

typedef hls::axis<ap_uint<32>,0,0,0> axis_t; 

void top_module(hls::stream<axis_t> &im_axis_in,
                hls::stream<axis_t> &current_pos);

void line_buff1(hls::stream<axis_t> &im_axis_in,
                int8_t img_in0[IMG_WIDTH],
                int8_t img_in1[IMG_WIDTH],
                int8_t img_in2[IMG_WIDTH],
                int32_t img_in1bf[IMG_WIDTH/4],
                int32_t img_in2bf[IMG_WIDTH/4],
                int16_t y);


void gaussian(int8_t img_in0[IMG_WIDTH], int8_t img_in1[IMG_WIDTH], int8_t img_in2[IMG_WIDTH],
			  int8_t img_ga[IMG_WIDTH-2],int16_t y);

void line_buff2(int8_t img_ga[IMG_WIDTH-2],int8_t img_ga0[IMG_WIDTH-2],int8_t img_ga1[IMG_WIDTH-2],int8_t img_ga2[IMG_WIDTH-2],
				int8_t img_ga1bf[IMG_WIDTH-2],int8_t img_ga2bf[IMG_WIDTH-2],int16_t y);

void gradient(int8_t img_ga0[IMG_WIDTH-2],int8_t img_ga1[IMG_WIDTH-2],int8_t img_ga2[IMG_WIDTH-2],
			  int32_t edgeMagnitudeC[IMG_WIDTH-4], uint8_t edgeDirection[IMG_WIDTH-4], int16_t y);

void line_buff3_magn(int32_t edgeMagnitudeC[IMG_WIDTH-4],
		int32_t img_ma0[IMG_WIDTH-4],int32_t img_ma1[IMG_WIDTH-4],int32_t img_ma1_1[IMG_WIDTH-4],
		int32_t img_ma2[IMG_WIDTH-4],int32_t img_ma1bf[IMG_WIDTH-4],int32_t img_ma2bf[IMG_WIDTH-4],int16_t y);

void line_buff3_dir(uint8_t edgeDirection[IMG_WIDTH-4], uint8_t img_dir[IMG_WIDTH-4], uint8_t img_dirbf[IMG_WIDTH-4], int16_t y);

void nMS_Hys(int32_t img_ma0[IMG_WIDTH-4], int32_t img_ma1[IMG_WIDTH-4], int32_t img_ma1_1[IMG_WIDTH-4],
			 int32_t img_ma2[IMG_WIDTH-4],uint8_t img_dir[IMG_WIDTH-4], uint8_t edg_img[IMG_WIDTH-6], int16_t y);

void hough_space_size(uint8_t edg_img[IMG_WIDTH-6],
					  uint8_t hough_space1[NUMBER_OF_RHO], uint8_t hough_space2[NUMBER_OF_RHO], uint8_t hough_space3[NUMBER_OF_RHO], uint8_t hough_space4[NUMBER_OF_RHO],
					  uint8_t hough_space5[NUMBER_OF_RHO], uint8_t hough_space6[NUMBER_OF_RHO], uint8_t hough_space7[NUMBER_OF_RHO], uint8_t houngh_space_buff1[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff2[NUMBER_OF_RHO], uint8_t houngh_space_buff3[NUMBER_OF_RHO], uint8_t houngh_space_buff4[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff5[NUMBER_OF_RHO], uint8_t houngh_space_buff6[NUMBER_OF_RHO], uint8_t houngh_space_buff7[NUMBER_OF_RHO],
					  uint8_t hough_space1s[NUMBER_OF_RHO], uint8_t hough_space2s[NUMBER_OF_RHO], uint8_t hough_space3s[NUMBER_OF_RHO], uint8_t hough_space4s[NUMBER_OF_RHO],
					  uint8_t hough_space5s[NUMBER_OF_RHO], uint8_t hough_space6s[NUMBER_OF_RHO], uint8_t hough_space7s[NUMBER_OF_RHO], uint8_t houngh_space_buff1s[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff2s[NUMBER_OF_RHO], uint8_t houngh_space_buff3s[NUMBER_OF_RHO], uint8_t houngh_space_buff4s[NUMBER_OF_RHO],
					  uint8_t houngh_space_buff5s[NUMBER_OF_RHO], uint8_t houngh_space_buff6s[NUMBER_OF_RHO], uint8_t houngh_space_buff7s[NUMBER_OF_RHO],
					  int16_t y);

void hough_space(uint8_t hough_space1[NUMBER_OF_RHO], uint8_t hough_space2[NUMBER_OF_RHO], uint8_t hough_space3[NUMBER_OF_RHO],
		  	      uint8_t hough_space4[NUMBER_OF_RHO],uint8_t hough_space5[NUMBER_OF_RHO], uint8_t hough_space6[NUMBER_OF_RHO], uint8_t hough_space7[NUMBER_OF_RHO],
				  uint8_t hough_space1s[NUMBER_OF_RHO], uint8_t hough_space2s[NUMBER_OF_RHO], uint8_t hough_space3s[NUMBER_OF_RHO],
				  uint8_t hough_space4s[NUMBER_OF_RHO],uint8_t hough_space5s[NUMBER_OF_RHO], uint8_t hough_space6s[NUMBER_OF_RHO], uint8_t hough_space7s[NUMBER_OF_RHO],
				  uint8_t hough_layer[HOUGH_AREA_SIZE]);

void accumulation_point(uint8_t hough_layer[HOUGH_AREA_SIZE], int8_t peakCoordinates[4]);

int32_t elaboration_data(int8_t peakCoordinates[4]);

#endif //SRC_LINE_DET_H


