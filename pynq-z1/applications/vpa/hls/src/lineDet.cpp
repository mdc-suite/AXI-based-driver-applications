#include "lineDet.h"

    int8_t img_in0[IMG_WIDTH];
    int8_t img_in1[IMG_WIDTH];
    int8_t img_in2[IMG_WIDTH];
    int32_t img_in1bf[IMG_WIDTH/4];
    int32_t img_in2bf[IMG_WIDTH/4];

    int8_t img_ga[IMG_WIDTH-2];
    int8_t img_ga0[IMG_WIDTH-2];
    int8_t img_ga1[IMG_WIDTH-2];
    int8_t img_ga2[IMG_WIDTH-2];
    int8_t img_ga1bf[IMG_WIDTH-2];
    int8_t img_ga2bf[IMG_WIDTH-2];

    int32_t edgeMagnitudeC[IMG_WIDTH-4];
    int32_t img_ma0[IMG_WIDTH-4];
    int32_t img_ma1[IMG_WIDTH-4];
    int32_t img_ma1_1[IMG_WIDTH-4];
    int32_t img_ma2[IMG_WIDTH-4];
    int32_t img_ma1bf[IMG_WIDTH-4];
    int32_t img_ma2bf[IMG_WIDTH-4];

    uint8_t edgeDirection[IMG_WIDTH-4];
    uint8_t img_dir[IMG_WIDTH-4];
    uint8_t img_dirbf[IMG_WIDTH-4];

    uint8_t edg_img[IMG_WIDTH-6];

    uint8_t hough_space1[NUMBER_OF_RHO];
    uint8_t hough_space2[NUMBER_OF_RHO];
    uint8_t hough_space3[NUMBER_OF_RHO];
    uint8_t hough_space4[NUMBER_OF_RHO];
    uint8_t hough_space5[NUMBER_OF_RHO];
    uint8_t hough_space6[NUMBER_OF_RHO];
    uint8_t hough_space7[NUMBER_OF_RHO];
    uint8_t hough_space1s[NUMBER_OF_RHO];
    uint8_t hough_space2s[NUMBER_OF_RHO];
    uint8_t hough_space3s[NUMBER_OF_RHO];
    uint8_t hough_space4s[NUMBER_OF_RHO];
    uint8_t hough_space5s[NUMBER_OF_RHO];
    uint8_t hough_space6s[NUMBER_OF_RHO];
    uint8_t hough_space7s[NUMBER_OF_RHO];

    uint8_t hough_space_buff1[NUMBER_OF_RHO];
    uint8_t hough_space_buff2[NUMBER_OF_RHO];
    uint8_t hough_space_buff3[NUMBER_OF_RHO];
    uint8_t hough_space_buff4[NUMBER_OF_RHO];
    uint8_t hough_space_buff5[NUMBER_OF_RHO];
    uint8_t hough_space_buff6[NUMBER_OF_RHO];
    uint8_t hough_space_buff7[NUMBER_OF_RHO];
    uint8_t hough_space_buff1s[NUMBER_OF_RHO];
    uint8_t hough_space_buff2s[NUMBER_OF_RHO];
    uint8_t hough_space_buff3s[NUMBER_OF_RHO];
    uint8_t hough_space_buff4s[NUMBER_OF_RHO];
    uint8_t hough_space_buff5s[NUMBER_OF_RHO];
    uint8_t hough_space_buff6s[NUMBER_OF_RHO];
    uint8_t hough_space_buff7s[NUMBER_OF_RHO];

    uint8_t hough_layer[HOUGH_AREA_SIZE];

    int8_t peakCoordinates[4];
    int32_t current_pos_val;

void top_module(hls::stream<axis_t> &im_axis_in,
                hls::stream<axis_t> &current_pos) {

#pragma HLS INTERFACE mode=axis register_mode=both port=im_axis_in register
#pragma HLS INTERFACE mode=axis register_mode=both port=current_pos register
#pragma HLS INTERFACE ap_ctrl_none port=return

#pragma HLS STREAM variable=img_in0 type=pipo
#pragma HLS STREAM variable=img_in1 type=pipo
#pragma HLS STREAM variable=img_in2 type=pipo
#pragma HLS STREAM variable=img_in1bf type=pipo
#pragma HLS STREAM variable=img_in2bf type=pipo

#pragma HLS STREAM variable=img_ga type=pipo
#pragma HLS STREAM variable=img_ga0 type=pipo
#pragma HLS STREAM variable=img_ga1 type=pipo
#pragma HLS STREAM variable=img_ga2 type=pipo
#pragma HLS STREAM variable=img_ga1bf type=pipo
#pragma HLS STREAM variable=img_ga2bf type=pipo

#pragma HLS STREAM variable=edgeMagnitudeC type=pipo
#pragma HLS STREAM variable=img_ma0 type=pipo
#pragma HLS STREAM variable=img_ma1 type=pipo
#pragma HLS STREAM variable=img_ma1_1 type=pipo
#pragma HLS STREAM variable=img_ma2 type=pipo
#pragma HLS STREAM variable=img_ma2bf type=pipo
#pragma HLS STREAM variable=img_ma1bf type=pipo

#pragma HLS STREAM variable=edgeDirection type=pipo
#pragma HLS STREAM variable=img_dir type=pipo
#pragma HLS STREAM variable=img_dirbf type=pipo

#pragma HLS STREAM variable=edg_img type=pipo

#pragma HLS STREAM variable=hough_space1 type=pipo
#pragma HLS STREAM variable=hough_space2 type=pipo
#pragma HLS STREAM variable=hough_space3 type=pipo
#pragma HLS STREAM variable=hough_space4 type=pipo
#pragma HLS STREAM variable=hough_space5 type=pipo
#pragma HLS STREAM variable=hough_space6 type=pipo
#pragma HLS STREAM variable=hough_space7 type=pipo
#pragma HLS STREAM variable=hough_space1s type=pipo
#pragma HLS STREAM variable=hough_space2s type=pipo
#pragma HLS STREAM variable=hough_space3s type=pipo
#pragma HLS STREAM variable=hough_space4s type=pipo
#pragma HLS STREAM variable=hough_space5s type=pipo
#pragma HLS STREAM variable=hough_space6s type=pipo
#pragma HLS STREAM variable=hough_space7s type=pipo

#pragma HLS STREAM variable=hough_space_buff1 type=pipo
#pragma HLS STREAM variable=hough_space_buff2 type=pipo
#pragma HLS STREAM variable=hough_space_buff3 type=pipo
#pragma HLS STREAM variable=hough_space_buff4 type=pipo
#pragma HLS STREAM variable=hough_space_buff5 type=pipo
#pragma HLS STREAM variable=hough_space_buff6 type=pipo
#pragma HLS STREAM variable=hough_space_buff7 type=pipo
#pragma HLS STREAM variable=hough_space_buff1s type=pipo
#pragma HLS STREAM variable=hough_space_buff2s type=pipo
#pragma HLS STREAM variable=hough_space_buff3s type=pipo
#pragma HLS STREAM variable=hough_space_buff4s type=pipo
#pragma HLS STREAM variable=hough_space_buff5s type=pipo
#pragma HLS STREAM variable=hough_space_buff6s type=pipo
#pragma HLS STREAM variable=hough_space_buff7s type=pipo

#pragma HLS STREAM variable=hough_layer type=pipo

//#pragma HLS STREAM variable=peakCoordinates type=pipo

#pragma HLS ARRAY_PARTITION variable=img_in0 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_in1 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_in2 type=cyclic factor=4

#pragma HLS ARRAY_PARTITION variable=img_ga type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ga0 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ga1 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ga2 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ga1bf type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ga2bf type=cyclic factor=4

#pragma HLS ARRAY_PARTITION variable=edgeDirection type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_dir type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_dirbf type=cyclic factor=4

#pragma HLS ARRAY_PARTITION variable=edgeMagnitudeC type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ma0 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ma1 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ma1_1 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ma2 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ma1bf type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=img_ma2bf type=cyclic factor=4

#pragma HLS ARRAY_PARTITION variable=edg_img type=cyclic factor=4

#pragma HLS ARRAY_PARTITION variable=hough_space1 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space2 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space3 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space4 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space5 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space6 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space7 type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space1s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space2s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space3s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space4s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space5s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space6s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space7s type=cyclic factor=8
#pragma HLS ARRAY_PARTITION variable=hough_space_buff1 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff2 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff3 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff4 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff5 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff6 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff7 type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff1s type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff2s type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff3s type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff4s type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff5s type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff6s type=cyclic factor=4
#pragma HLS ARRAY_PARTITION variable=hough_space_buff7s type=cyclic factor=4

#pragma HLS ARRAY_PARTITION variable=hough_layer type=cyclic factor=8


    for(int16_t y = 0; y < IMG_HEIGHT; y++){

#pragma HLS DATAFLOW

    line_buff1(im_axis_in,img_in0,img_in1,img_in2,img_in1bf,img_in2bf,y);

    gaussian(img_in0,img_in1,img_in2,img_ga,y);

    line_buff2(img_ga,img_ga0,img_ga1,img_ga2,img_ga1bf,img_ga2bf,y);

    gradient(img_ga0,img_ga1,img_ga2,edgeMagnitudeC,edgeDirection,y);

    line_buff3_magn(edgeMagnitudeC,img_ma0,img_ma1,img_ma1_1,img_ma2,img_ma1bf,img_ma2bf,y);

    line_buff3_dir(edgeDirection,img_dir,img_dirbf,y);

    nMS_Hys(img_ma0,img_ma1,img_ma1_1,img_ma2,img_dir,edg_img,y);

    hough_space_size(edg_img,hough_space1,hough_space2,hough_space3,hough_space4,
    				 hough_space5,hough_space6,hough_space7,hough_space_buff1,
					 hough_space_buff2,hough_space_buff3,hough_space_buff4,
					 hough_space_buff5,hough_space_buff6,hough_space_buff7,
					 hough_space1s,hough_space2s,hough_space3s,hough_space4s,
					 hough_space5s,hough_space6s,hough_space7s,hough_space_buff1s,
					 hough_space_buff2s,hough_space_buff3s,hough_space_buff4s,
					 hough_space_buff5s,hough_space_buff6s,hough_space_buff7s,
					 y);

    }

    hough_space(hough_space1,hough_space2,hough_space3,hough_space4,
			 	 hough_space5,hough_space6,hough_space7,hough_space1s,
				 hough_space2s,hough_space3s,hough_space4s,hough_space5s,
				 hough_space6s,hough_space7s,hough_layer);

    accumulation_point(hough_layer,peakCoordinates);

    current_pos_val = elaboration_data(peakCoordinates);
    axis_t outw;
    outw.data = current_pos_val;
    outw.keep = -1;      // tutti i byte validi
    outw.last = 1;       // 1 sull’ULTIMO valore del frame
    current_pos.write(outw);
}


