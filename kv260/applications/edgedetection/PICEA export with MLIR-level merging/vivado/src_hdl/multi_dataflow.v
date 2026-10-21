// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Network module 
// Date: 2026/07/25 15:38:30
//
// ----------------------------------------------------------------------------

module multi_dataflow (
	// Input(s)
	input [7 : 0] in0_data,
	input in0_wr,
	output in0_full,
	
	// Output(s)
	input [5 : 0] in1_data,
	input in1_wr,
	output in1_full,
	
	// Output(s)
	output [7 : 0] out0_data,
	output out0_wr,
	input out0_full,
	
	// Dynamic Parameter(s)
	
	// Monitoring
	
	// Configuration ID
	input [7:0] ID,
	
	
	// System Signal(s)		
	input clock,
	input reset
);	

// internal signals
// ----------------------------------------------------------------------------
// Sboxes Config Wire(s)
wire [5 : 0] sel;
		


// Actors Wire(s)
	
// actor sbox_0
wire [7 : 0] sbox_0_in1_data;
wire sbox_0_in1_wr;
wire sbox_0_in1_full;
wire [7 : 0] sbox_0_in2_data;
wire sbox_0_in2_wr;
wire sbox_0_in2_full;
wire [7 : 0] sbox_0_out1_data;
wire sbox_0_out1_wr;
wire sbox_0_out1_full;
	
// actor sbox_1
wire [7 : 0] sbox_1_in1_data;
wire sbox_1_in1_wr;
wire sbox_1_in1_full;
wire [7 : 0] sbox_1_out1_data;
wire sbox_1_out1_wr;
wire sbox_1_out1_full;
wire [7 : 0] sbox_1_out2_data;
wire sbox_1_out2_wr;
wire sbox_1_out2_full;
	
// actor sbox_2
wire [5 : 0] sbox_2_in1_data;
wire sbox_2_in1_wr;
wire sbox_2_in1_full;
wire [5 : 0] sbox_2_out1_data;
wire sbox_2_out1_wr;
wire sbox_2_out1_full;
wire [5 : 0] sbox_2_out2_data;
wire sbox_2_out2_wr;
wire sbox_2_out2_full;
	
// actor delay_0
wire [7 : 0] fifo_big_delay_0_arg0_data;
wire fifo_big_delay_0_arg0_wr;
wire fifo_big_delay_0_arg0_full;
wire [7 : 0] delay_0_arg0_data;
wire delay_0_arg0_rd;
wire delay_0_arg0_empty;
wire [7 : 0] delay_0_arg1_data;
wire delay_0_arg1_wr;
wire delay_0_arg1_full;
	
// actor delay_1
wire [7 : 0] fifo_big_delay_1_arg0_data;
wire fifo_big_delay_1_arg0_wr;
wire fifo_big_delay_1_arg0_full;
wire [7 : 0] delay_1_arg0_data;
wire delay_1_arg0_rd;
wire delay_1_arg0_empty;
wire [7 : 0] delay_1_arg1_data;
wire delay_1_arg1_wr;
wire delay_1_arg1_full;
	
// actor delay_2
wire [7 : 0] fifo_big_delay_2_arg0_data;
wire fifo_big_delay_2_arg0_wr;
wire fifo_big_delay_2_arg0_full;
wire [7 : 0] delay_2_arg0_data;
wire delay_2_arg0_rd;
wire delay_2_arg0_empty;
wire [7 : 0] delay_2_arg1_data;
wire delay_2_arg1_wr;
wire delay_2_arg1_full;
	
// actor delay_3
wire [7 : 0] fifo_big_delay_3_arg0_data;
wire fifo_big_delay_3_arg0_wr;
wire fifo_big_delay_3_arg0_full;
wire [7 : 0] delay_3_arg0_data;
wire delay_3_arg0_rd;
wire delay_3_arg0_empty;
wire [7 : 0] delay_3_arg1_data;
wire delay_3_arg1_wr;
wire delay_3_arg1_full;
	
// actor delay_4
wire [7 : 0] fifo_big_delay_4_arg0_data;
wire fifo_big_delay_4_arg0_wr;
wire fifo_big_delay_4_arg0_full;
wire [7 : 0] delay_4_arg0_data;
wire delay_4_arg0_rd;
wire delay_4_arg0_empty;
wire [7 : 0] delay_4_arg1_data;
wire delay_4_arg1_wr;
wire delay_4_arg1_full;
	
// actor delay_5
wire [7 : 0] fifo_big_delay_5_arg0_data;
wire fifo_big_delay_5_arg0_wr;
wire fifo_big_delay_5_arg0_full;
wire [7 : 0] delay_5_arg0_data;
wire delay_5_arg0_rd;
wire delay_5_arg0_empty;
wire [7 : 0] delay_5_arg1_data;
wire delay_5_arg1_wr;
wire delay_5_arg1_full;
	
// actor delay_6
wire [7 : 0] fifo_big_delay_6_arg0_data;
wire fifo_big_delay_6_arg0_wr;
wire fifo_big_delay_6_arg0_full;
wire [7 : 0] delay_6_arg0_data;
wire delay_6_arg0_rd;
wire delay_6_arg0_empty;
wire [7 : 0] delay_6_arg1_data;
wire delay_6_arg1_wr;
wire delay_6_arg1_full;
	
// actor delay_7
wire [7 : 0] fifo_big_delay_7_arg0_data;
wire fifo_big_delay_7_arg0_wr;
wire fifo_big_delay_7_arg0_full;
wire [7 : 0] delay_7_arg0_data;
wire delay_7_arg0_rd;
wire delay_7_arg0_empty;
wire [7 : 0] delay_7_arg1_data;
wire delay_7_arg1_wr;
wire delay_7_arg1_full;
	
// actor roberts_x_0
wire [7 : 0] fifo_big_roberts_x_0_arg0_data;
wire fifo_big_roberts_x_0_arg0_wr;
wire fifo_big_roberts_x_0_arg0_full;
wire [7 : 0] roberts_x_0_arg0_data;
wire roberts_x_0_arg0_rd;
wire roberts_x_0_arg0_empty;
wire [7 : 0] fifo_big_roberts_x_0_arg1_data;
wire fifo_big_roberts_x_0_arg1_wr;
wire fifo_big_roberts_x_0_arg1_full;
wire [7 : 0] roberts_x_0_arg1_data;
wire roberts_x_0_arg1_rd;
wire roberts_x_0_arg1_empty;
wire [7 : 0] fifo_big_roberts_x_0_arg2_data;
wire fifo_big_roberts_x_0_arg2_wr;
wire fifo_big_roberts_x_0_arg2_full;
wire [7 : 0] roberts_x_0_arg2_data;
wire roberts_x_0_arg2_rd;
wire roberts_x_0_arg2_empty;
wire [7 : 0] fifo_big_roberts_x_0_arg3_data;
wire fifo_big_roberts_x_0_arg3_wr;
wire fifo_big_roberts_x_0_arg3_full;
wire [7 : 0] roberts_x_0_arg3_data;
wire roberts_x_0_arg3_rd;
wire roberts_x_0_arg3_empty;
wire [13 : 0] roberts_x_0_arg4_data;
wire roberts_x_0_arg4_wr;
wire roberts_x_0_arg4_full;
	
// actor roberts_y_0
wire [7 : 0] fifo_big_roberts_y_0_arg0_data;
wire fifo_big_roberts_y_0_arg0_wr;
wire fifo_big_roberts_y_0_arg0_full;
wire [7 : 0] roberts_y_0_arg0_data;
wire roberts_y_0_arg0_rd;
wire roberts_y_0_arg0_empty;
wire [7 : 0] fifo_big_roberts_y_0_arg1_data;
wire fifo_big_roberts_y_0_arg1_wr;
wire fifo_big_roberts_y_0_arg1_full;
wire [7 : 0] roberts_y_0_arg1_data;
wire roberts_y_0_arg1_rd;
wire roberts_y_0_arg1_empty;
wire [7 : 0] fifo_big_roberts_y_0_arg2_data;
wire fifo_big_roberts_y_0_arg2_wr;
wire fifo_big_roberts_y_0_arg2_full;
wire [7 : 0] roberts_y_0_arg2_data;
wire roberts_y_0_arg2_rd;
wire roberts_y_0_arg2_empty;
wire [7 : 0] fifo_big_roberts_y_0_arg3_data;
wire fifo_big_roberts_y_0_arg3_wr;
wire fifo_big_roberts_y_0_arg3_full;
wire [7 : 0] roberts_y_0_arg3_data;
wire roberts_y_0_arg3_rd;
wire roberts_y_0_arg3_empty;
wire [13 : 0] roberts_y_0_arg4_data;
wire roberts_y_0_arg4_wr;
wire roberts_y_0_arg4_full;
	
// actor line_buffer_0
wire [5 : 0] fifo_big_line_buffer_0_arg0_data;
wire fifo_big_line_buffer_0_arg0_wr;
wire fifo_big_line_buffer_0_arg0_full;
wire [5 : 0] line_buffer_0_arg0_data;
wire line_buffer_0_arg0_rd;
wire line_buffer_0_arg0_empty;
wire [5 : 0] fifo_big_line_buffer_0_arg1_data;
wire fifo_big_line_buffer_0_arg1_wr;
wire fifo_big_line_buffer_0_arg1_full;
wire [5 : 0] line_buffer_0_arg1_data;
wire line_buffer_0_arg1_rd;
wire line_buffer_0_arg1_empty;
wire [7 : 0] fifo_big_line_buffer_0_arg2_data;
wire fifo_big_line_buffer_0_arg2_wr;
wire fifo_big_line_buffer_0_arg2_full;
wire [7 : 0] line_buffer_0_arg2_data;
wire line_buffer_0_arg2_rd;
wire line_buffer_0_arg2_empty;
wire [7 : 0] line_buffer_0_arg3_data;
wire line_buffer_0_arg3_wr;
wire line_buffer_0_arg3_full;
	
// actor line_buffer_1
wire [5 : 0] fifo_big_line_buffer_1_arg0_data;
wire fifo_big_line_buffer_1_arg0_wr;
wire fifo_big_line_buffer_1_arg0_full;
wire [5 : 0] line_buffer_1_arg0_data;
wire line_buffer_1_arg0_rd;
wire line_buffer_1_arg0_empty;
wire [5 : 0] fifo_big_line_buffer_1_arg1_data;
wire fifo_big_line_buffer_1_arg1_wr;
wire fifo_big_line_buffer_1_arg1_full;
wire [5 : 0] line_buffer_1_arg1_data;
wire line_buffer_1_arg1_rd;
wire line_buffer_1_arg1_empty;
wire [7 : 0] fifo_big_line_buffer_1_arg2_data;
wire fifo_big_line_buffer_1_arg2_wr;
wire fifo_big_line_buffer_1_arg2_full;
wire [7 : 0] line_buffer_1_arg2_data;
wire line_buffer_1_arg2_rd;
wire line_buffer_1_arg2_empty;
wire [7 : 0] line_buffer_1_arg3_data;
wire line_buffer_1_arg3_wr;
wire line_buffer_1_arg3_full;
	
// actor line_buffer_2
wire [5 : 0] fifo_big_line_buffer_2_arg0_data;
wire fifo_big_line_buffer_2_arg0_wr;
wire fifo_big_line_buffer_2_arg0_full;
wire [5 : 0] line_buffer_2_arg0_data;
wire line_buffer_2_arg0_rd;
wire line_buffer_2_arg0_empty;
wire [5 : 0] fifo_big_line_buffer_2_arg1_data;
wire fifo_big_line_buffer_2_arg1_wr;
wire fifo_big_line_buffer_2_arg1_full;
wire [5 : 0] line_buffer_2_arg1_data;
wire line_buffer_2_arg1_rd;
wire line_buffer_2_arg1_empty;
wire [7 : 0] fifo_big_line_buffer_2_arg2_data;
wire fifo_big_line_buffer_2_arg2_wr;
wire fifo_big_line_buffer_2_arg2_full;
wire [7 : 0] line_buffer_2_arg2_data;
wire line_buffer_2_arg2_rd;
wire line_buffer_2_arg2_empty;
wire [7 : 0] line_buffer_2_arg3_data;
wire line_buffer_2_arg3_wr;
wire line_buffer_2_arg3_full;
	
// actor sobel_x_0
wire [7 : 0] fifo_big_sobel_x_0_arg0_data;
wire fifo_big_sobel_x_0_arg0_wr;
wire fifo_big_sobel_x_0_arg0_full;
wire [7 : 0] sobel_x_0_arg0_data;
wire sobel_x_0_arg0_rd;
wire sobel_x_0_arg0_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg1_data;
wire fifo_big_sobel_x_0_arg1_wr;
wire fifo_big_sobel_x_0_arg1_full;
wire [7 : 0] sobel_x_0_arg1_data;
wire sobel_x_0_arg1_rd;
wire sobel_x_0_arg1_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg2_data;
wire fifo_big_sobel_x_0_arg2_wr;
wire fifo_big_sobel_x_0_arg2_full;
wire [7 : 0] sobel_x_0_arg2_data;
wire sobel_x_0_arg2_rd;
wire sobel_x_0_arg2_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg3_data;
wire fifo_big_sobel_x_0_arg3_wr;
wire fifo_big_sobel_x_0_arg3_full;
wire [7 : 0] sobel_x_0_arg3_data;
wire sobel_x_0_arg3_rd;
wire sobel_x_0_arg3_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg4_data;
wire fifo_big_sobel_x_0_arg4_wr;
wire fifo_big_sobel_x_0_arg4_full;
wire [7 : 0] sobel_x_0_arg4_data;
wire sobel_x_0_arg4_rd;
wire sobel_x_0_arg4_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg5_data;
wire fifo_big_sobel_x_0_arg5_wr;
wire fifo_big_sobel_x_0_arg5_full;
wire [7 : 0] sobel_x_0_arg5_data;
wire sobel_x_0_arg5_rd;
wire sobel_x_0_arg5_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg6_data;
wire fifo_big_sobel_x_0_arg6_wr;
wire fifo_big_sobel_x_0_arg6_full;
wire [7 : 0] sobel_x_0_arg6_data;
wire sobel_x_0_arg6_rd;
wire sobel_x_0_arg6_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg7_data;
wire fifo_big_sobel_x_0_arg7_wr;
wire fifo_big_sobel_x_0_arg7_full;
wire [7 : 0] sobel_x_0_arg7_data;
wire sobel_x_0_arg7_rd;
wire sobel_x_0_arg7_empty;
wire [7 : 0] fifo_big_sobel_x_0_arg8_data;
wire fifo_big_sobel_x_0_arg8_wr;
wire fifo_big_sobel_x_0_arg8_full;
wire [7 : 0] sobel_x_0_arg8_data;
wire sobel_x_0_arg8_rd;
wire sobel_x_0_arg8_empty;
wire [13 : 0] sobel_x_0_arg9_data;
wire sobel_x_0_arg9_wr;
wire sobel_x_0_arg9_full;
	
// actor sobel_y_0
wire [7 : 0] fifo_big_sobel_y_0_arg0_data;
wire fifo_big_sobel_y_0_arg0_wr;
wire fifo_big_sobel_y_0_arg0_full;
wire [7 : 0] sobel_y_0_arg0_data;
wire sobel_y_0_arg0_rd;
wire sobel_y_0_arg0_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg1_data;
wire fifo_big_sobel_y_0_arg1_wr;
wire fifo_big_sobel_y_0_arg1_full;
wire [7 : 0] sobel_y_0_arg1_data;
wire sobel_y_0_arg1_rd;
wire sobel_y_0_arg1_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg2_data;
wire fifo_big_sobel_y_0_arg2_wr;
wire fifo_big_sobel_y_0_arg2_full;
wire [7 : 0] sobel_y_0_arg2_data;
wire sobel_y_0_arg2_rd;
wire sobel_y_0_arg2_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg3_data;
wire fifo_big_sobel_y_0_arg3_wr;
wire fifo_big_sobel_y_0_arg3_full;
wire [7 : 0] sobel_y_0_arg3_data;
wire sobel_y_0_arg3_rd;
wire sobel_y_0_arg3_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg4_data;
wire fifo_big_sobel_y_0_arg4_wr;
wire fifo_big_sobel_y_0_arg4_full;
wire [7 : 0] sobel_y_0_arg4_data;
wire sobel_y_0_arg4_rd;
wire sobel_y_0_arg4_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg5_data;
wire fifo_big_sobel_y_0_arg5_wr;
wire fifo_big_sobel_y_0_arg5_full;
wire [7 : 0] sobel_y_0_arg5_data;
wire sobel_y_0_arg5_rd;
wire sobel_y_0_arg5_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg6_data;
wire fifo_big_sobel_y_0_arg6_wr;
wire fifo_big_sobel_y_0_arg6_full;
wire [7 : 0] sobel_y_0_arg6_data;
wire sobel_y_0_arg6_rd;
wire sobel_y_0_arg6_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg7_data;
wire fifo_big_sobel_y_0_arg7_wr;
wire fifo_big_sobel_y_0_arg7_full;
wire [7 : 0] sobel_y_0_arg7_data;
wire sobel_y_0_arg7_rd;
wire sobel_y_0_arg7_empty;
wire [7 : 0] fifo_big_sobel_y_0_arg8_data;
wire fifo_big_sobel_y_0_arg8_wr;
wire fifo_big_sobel_y_0_arg8_full;
wire [7 : 0] sobel_y_0_arg8_data;
wire sobel_y_0_arg8_rd;
wire sobel_y_0_arg8_empty;
wire [13 : 0] sobel_y_0_arg9_data;
wire sobel_y_0_arg9_wr;
wire sobel_y_0_arg9_full;
	
// actor sbox_3
wire [13 : 0] sbox_3_in1_data;
wire sbox_3_in1_wr;
wire sbox_3_in1_full;
wire [13 : 0] sbox_3_in2_data;
wire sbox_3_in2_wr;
wire sbox_3_in2_full;
wire [13 : 0] sbox_3_out1_data;
wire sbox_3_out1_wr;
wire sbox_3_out1_full;
	
// actor sbox_4
wire [7 : 0] sbox_4_in1_data;
wire sbox_4_in1_wr;
wire sbox_4_in1_full;
wire [7 : 0] sbox_4_out1_data;
wire sbox_4_out1_wr;
wire sbox_4_out1_full;
wire [7 : 0] sbox_4_out2_data;
wire sbox_4_out2_wr;
wire sbox_4_out2_full;
	
// actor sbox_5
wire [13 : 0] sbox_5_in1_data;
wire sbox_5_in1_wr;
wire sbox_5_in1_full;
wire [13 : 0] sbox_5_in2_data;
wire sbox_5_in2_wr;
wire sbox_5_in2_full;
wire [13 : 0] sbox_5_out1_data;
wire sbox_5_out1_wr;
wire sbox_5_out1_full;
	
// actor abs_sum_0
wire [13 : 0] fifo_big_abs_sum_0_arg0_data;
wire fifo_big_abs_sum_0_arg0_wr;
wire fifo_big_abs_sum_0_arg0_full;
wire [13 : 0] abs_sum_0_arg0_data;
wire abs_sum_0_arg0_rd;
wire abs_sum_0_arg0_empty;
wire [13 : 0] fifo_big_abs_sum_0_arg1_data;
wire fifo_big_abs_sum_0_arg1_wr;
wire fifo_big_abs_sum_0_arg1_full;
wire [13 : 0] abs_sum_0_arg1_data;
wire abs_sum_0_arg1_rd;
wire abs_sum_0_arg1_empty;
wire [13 : 0] abs_sum_0_arg2_data;
wire abs_sum_0_arg2_wr;
wire abs_sum_0_arg2_full;
	
// actor thr_0
wire [13 : 0] fifo_big_thr_0_arg0_data;
wire fifo_big_thr_0_arg0_wr;
wire fifo_big_thr_0_arg0_full;
wire [13 : 0] thr_0_arg0_data;
wire thr_0_arg0_rd;
wire thr_0_arg0_empty;
wire [7 : 0] thr_0_arg1_data;
wire thr_0_arg1_wr;
wire thr_0_arg1_full;
	
// actor remove_2x2_0
wire [5 : 0] fifo_big_remove_2x2_0_arg0_data;
wire fifo_big_remove_2x2_0_arg0_wr;
wire fifo_big_remove_2x2_0_arg0_full;
wire [5 : 0] remove_2x2_0_arg0_data;
wire remove_2x2_0_arg0_rd;
wire remove_2x2_0_arg0_empty;
wire [7 : 0] fifo_big_remove_2x2_0_arg1_data;
wire fifo_big_remove_2x2_0_arg1_wr;
wire fifo_big_remove_2x2_0_arg1_full;
wire [7 : 0] remove_2x2_0_arg1_data;
wire remove_2x2_0_arg1_rd;
wire remove_2x2_0_arg1_empty;
wire [7 : 0] remove_2x2_0_arg2_data;
wire remove_2x2_0_arg2_wr;
wire remove_2x2_0_arg2_full;
	
// actor remove_3x3_0
wire [5 : 0] fifo_big_remove_3x3_0_arg0_data;
wire fifo_big_remove_3x3_0_arg0_wr;
wire fifo_big_remove_3x3_0_arg0_full;
wire [5 : 0] remove_3x3_0_arg0_data;
wire remove_3x3_0_arg0_rd;
wire remove_3x3_0_arg0_empty;
wire [7 : 0] fifo_big_remove_3x3_0_arg1_data;
wire fifo_big_remove_3x3_0_arg1_wr;
wire fifo_big_remove_3x3_0_arg1_full;
wire [7 : 0] remove_3x3_0_arg1_data;
wire remove_3x3_0_arg1_rd;
wire remove_3x3_0_arg1_empty;
wire [7 : 0] remove_3x3_0_arg2_data;
wire remove_3x3_0_arg2_wr;
wire remove_3x3_0_arg2_full;
// ----------------------------------------------------------------------------

// body
// ----------------------------------------------------------------------------
// Network Configurator
configurator config_0 (
	.sel(sel),
	.ID(ID)
);




// actor sbox_0
sbox2x1 #(
	.SIZE(8)
)
sbox_0 (
	// Input Signal(s)
	.in1_data(sbox_0_in1_data),
	.in1_wr(sbox_0_in1_wr),
	.in1_full(sbox_0_in1_full),
	.in2_data(sbox_0_in2_data),
	.in2_wr(sbox_0_in2_wr),
	.in2_full(sbox_0_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_0_out1_data),
	.out1_wr(sbox_0_out1_wr),
	.out1_full(sbox_0_out1_full),
	
	// Selector
	.sel(sel[0])	
);


// actor sbox_1
sbox1x2 #(
	.SIZE(8)
)
sbox_1 (
	// Input Signal(s)
	.in1_data(sbox_1_in1_data),
	.in1_wr(sbox_1_in1_wr),
	.in1_full(sbox_1_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_1_out1_data),
	.out1_wr(sbox_1_out1_wr),
	.out1_full(sbox_1_out1_full),
	.out2_data(sbox_1_out2_data),
	.out2_wr(sbox_1_out2_wr),
	.out2_full(sbox_1_out2_full),
	
	// Selector
	.sel(sel[1])	
);


// actor sbox_2
sbox1x2 #(
	.SIZE(6)
)
sbox_2 (
	// Input Signal(s)
	.in1_data(sbox_2_in1_data),
	.in1_wr(sbox_2_in1_wr),
	.in1_full(sbox_2_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_2_out1_data),
	.out1_wr(sbox_2_out1_wr),
	.out1_full(sbox_2_out1_full),
	.out2_data(sbox_2_out2_data),
	.out2_wr(sbox_2_out2_wr),
	.out2_full(sbox_2_out2_full),
	
	// Selector
	.sel(sel[2])	
);


// fifo_big_delay_0_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_0_arg0(
	.datain(fifo_big_delay_0_arg0_data),
	.dataout(delay_0_arg0_data),
	.enr(delay_0_arg0_rd),
	.enw(fifo_big_delay_0_arg0_wr),
	.empty(delay_0_arg0_empty),
	.full(fifo_big_delay_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_0
delay actor_delay_0 (
	// Input Signal(s)
	.arg0(delay_0_arg0_data),
	.arg0_rd(delay_0_arg0_rd),
	.arg0_empty(delay_0_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_0_arg1_data),
	.arg1_wr(delay_0_arg1_wr),
	.arg1_full(delay_0_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_1_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_1_arg0(
	.datain(fifo_big_delay_1_arg0_data),
	.dataout(delay_1_arg0_data),
	.enr(delay_1_arg0_rd),
	.enw(fifo_big_delay_1_arg0_wr),
	.empty(delay_1_arg0_empty),
	.full(fifo_big_delay_1_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_1
delay actor_delay_1 (
	// Input Signal(s)
	.arg0(delay_1_arg0_data),
	.arg0_rd(delay_1_arg0_rd),
	.arg0_empty(delay_1_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_1_arg1_data),
	.arg1_wr(delay_1_arg1_wr),
	.arg1_full(delay_1_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_2_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_2_arg0(
	.datain(fifo_big_delay_2_arg0_data),
	.dataout(delay_2_arg0_data),
	.enr(delay_2_arg0_rd),
	.enw(fifo_big_delay_2_arg0_wr),
	.empty(delay_2_arg0_empty),
	.full(fifo_big_delay_2_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_2
delay actor_delay_2 (
	// Input Signal(s)
	.arg0(delay_2_arg0_data),
	.arg0_rd(delay_2_arg0_rd),
	.arg0_empty(delay_2_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_2_arg1_data),
	.arg1_wr(delay_2_arg1_wr),
	.arg1_full(delay_2_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_3_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_3_arg0(
	.datain(fifo_big_delay_3_arg0_data),
	.dataout(delay_3_arg0_data),
	.enr(delay_3_arg0_rd),
	.enw(fifo_big_delay_3_arg0_wr),
	.empty(delay_3_arg0_empty),
	.full(fifo_big_delay_3_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_3
delay actor_delay_3 (
	// Input Signal(s)
	.arg0(delay_3_arg0_data),
	.arg0_rd(delay_3_arg0_rd),
	.arg0_empty(delay_3_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_3_arg1_data),
	.arg1_wr(delay_3_arg1_wr),
	.arg1_full(delay_3_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_4_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_4_arg0(
	.datain(fifo_big_delay_4_arg0_data),
	.dataout(delay_4_arg0_data),
	.enr(delay_4_arg0_rd),
	.enw(fifo_big_delay_4_arg0_wr),
	.empty(delay_4_arg0_empty),
	.full(fifo_big_delay_4_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_4
delay actor_delay_4 (
	// Input Signal(s)
	.arg0(delay_4_arg0_data),
	.arg0_rd(delay_4_arg0_rd),
	.arg0_empty(delay_4_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_4_arg1_data),
	.arg1_wr(delay_4_arg1_wr),
	.arg1_full(delay_4_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_5_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_5_arg0(
	.datain(fifo_big_delay_5_arg0_data),
	.dataout(delay_5_arg0_data),
	.enr(delay_5_arg0_rd),
	.enw(fifo_big_delay_5_arg0_wr),
	.empty(delay_5_arg0_empty),
	.full(fifo_big_delay_5_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_5
delay actor_delay_5 (
	// Input Signal(s)
	.arg0(delay_5_arg0_data),
	.arg0_rd(delay_5_arg0_rd),
	.arg0_empty(delay_5_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_5_arg1_data),
	.arg1_wr(delay_5_arg1_wr),
	.arg1_full(delay_5_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_6_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_6_arg0(
	.datain(fifo_big_delay_6_arg0_data),
	.dataout(delay_6_arg0_data),
	.enr(delay_6_arg0_rd),
	.enw(fifo_big_delay_6_arg0_wr),
	.empty(delay_6_arg0_empty),
	.full(fifo_big_delay_6_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_6
delay actor_delay_6 (
	// Input Signal(s)
	.arg0(delay_6_arg0_data),
	.arg0_rd(delay_6_arg0_rd),
	.arg0_empty(delay_6_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_6_arg1_data),
	.arg1_wr(delay_6_arg1_wr),
	.arg1_full(delay_6_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_7_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_7_arg0(
	.datain(fifo_big_delay_7_arg0_data),
	.dataout(delay_7_arg0_data),
	.enr(delay_7_arg0_rd),
	.enw(fifo_big_delay_7_arg0_wr),
	.empty(delay_7_arg0_empty),
	.full(fifo_big_delay_7_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_7
delay actor_delay_7 (
	// Input Signal(s)
	.arg0(delay_7_arg0_data),
	.arg0_rd(delay_7_arg0_rd),
	.arg0_empty(delay_7_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(delay_7_arg1_data),
	.arg1_wr(delay_7_arg1_wr),
	.arg1_full(delay_7_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_roberts_x_0_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_arg0(
	.datain(fifo_big_roberts_x_0_arg0_data),
	.dataout(roberts_x_0_arg0_data),
	.enr(roberts_x_0_arg0_rd),
	.enw(fifo_big_roberts_x_0_arg0_wr),
	.empty(roberts_x_0_arg0_empty),
	.full(fifo_big_roberts_x_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_x_0_arg1
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_arg1(
	.datain(fifo_big_roberts_x_0_arg1_data),
	.dataout(roberts_x_0_arg1_data),
	.enr(roberts_x_0_arg1_rd),
	.enw(fifo_big_roberts_x_0_arg1_wr),
	.empty(roberts_x_0_arg1_empty),
	.full(fifo_big_roberts_x_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_x_0_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_arg2(
	.datain(fifo_big_roberts_x_0_arg2_data),
	.dataout(roberts_x_0_arg2_data),
	.enr(roberts_x_0_arg2_rd),
	.enw(fifo_big_roberts_x_0_arg2_wr),
	.empty(roberts_x_0_arg2_empty),
	.full(fifo_big_roberts_x_0_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_x_0_arg3
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_arg3(
	.datain(fifo_big_roberts_x_0_arg3_data),
	.dataout(roberts_x_0_arg3_data),
	.enr(roberts_x_0_arg3_rd),
	.enw(fifo_big_roberts_x_0_arg3_wr),
	.empty(roberts_x_0_arg3_empty),
	.full(fifo_big_roberts_x_0_arg3_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor roberts_x_0
roberts_x actor_roberts_x_0 (
	// Input Signal(s)
	.arg0(roberts_x_0_arg0_data),
	.arg0_rd(roberts_x_0_arg0_rd),
	.arg0_empty(roberts_x_0_arg0_empty),
	.arg1(roberts_x_0_arg1_data),
	.arg1_rd(roberts_x_0_arg1_rd),
	.arg1_empty(roberts_x_0_arg1_empty),
	.arg2(roberts_x_0_arg2_data),
	.arg2_rd(roberts_x_0_arg2_rd),
	.arg2_empty(roberts_x_0_arg2_empty),
	.arg3(roberts_x_0_arg3_data),
	.arg3_rd(roberts_x_0_arg3_rd),
	.arg3_empty(roberts_x_0_arg3_empty)
	,
	
	// Output Signal(s)
	.arg4(roberts_x_0_arg4_data),
	.arg4_wr(roberts_x_0_arg4_wr),
	.arg4_full(roberts_x_0_arg4_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_roberts_y_0_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_arg0(
	.datain(fifo_big_roberts_y_0_arg0_data),
	.dataout(roberts_y_0_arg0_data),
	.enr(roberts_y_0_arg0_rd),
	.enw(fifo_big_roberts_y_0_arg0_wr),
	.empty(roberts_y_0_arg0_empty),
	.full(fifo_big_roberts_y_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_y_0_arg1
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_arg1(
	.datain(fifo_big_roberts_y_0_arg1_data),
	.dataout(roberts_y_0_arg1_data),
	.enr(roberts_y_0_arg1_rd),
	.enw(fifo_big_roberts_y_0_arg1_wr),
	.empty(roberts_y_0_arg1_empty),
	.full(fifo_big_roberts_y_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_y_0_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_arg2(
	.datain(fifo_big_roberts_y_0_arg2_data),
	.dataout(roberts_y_0_arg2_data),
	.enr(roberts_y_0_arg2_rd),
	.enw(fifo_big_roberts_y_0_arg2_wr),
	.empty(roberts_y_0_arg2_empty),
	.full(fifo_big_roberts_y_0_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_y_0_arg3
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_arg3(
	.datain(fifo_big_roberts_y_0_arg3_data),
	.dataout(roberts_y_0_arg3_data),
	.enr(roberts_y_0_arg3_rd),
	.enw(fifo_big_roberts_y_0_arg3_wr),
	.empty(roberts_y_0_arg3_empty),
	.full(fifo_big_roberts_y_0_arg3_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor roberts_y_0
roberts_y actor_roberts_y_0 (
	// Input Signal(s)
	.arg0(roberts_y_0_arg0_data),
	.arg0_rd(roberts_y_0_arg0_rd),
	.arg0_empty(roberts_y_0_arg0_empty),
	.arg1(roberts_y_0_arg1_data),
	.arg1_rd(roberts_y_0_arg1_rd),
	.arg1_empty(roberts_y_0_arg1_empty),
	.arg2(roberts_y_0_arg2_data),
	.arg2_rd(roberts_y_0_arg2_rd),
	.arg2_empty(roberts_y_0_arg2_empty),
	.arg3(roberts_y_0_arg3_data),
	.arg3_rd(roberts_y_0_arg3_rd),
	.arg3_empty(roberts_y_0_arg3_empty)
	,
	
	// Output Signal(s)
	.arg4(roberts_y_0_arg4_data),
	.arg4_wr(roberts_y_0_arg4_wr),
	.arg4_full(roberts_y_0_arg4_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_line_buffer_0_arg0
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_0_arg0(
	.datain(fifo_big_line_buffer_0_arg0_data),
	.dataout(line_buffer_0_arg0_data),
	.enr(line_buffer_0_arg0_rd),
	.enw(fifo_big_line_buffer_0_arg0_wr),
	.empty(line_buffer_0_arg0_empty),
	.full(fifo_big_line_buffer_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_0_arg1
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_0_arg1(
	.datain(fifo_big_line_buffer_0_arg1_data),
	.dataout(line_buffer_0_arg1_data),
	.enr(line_buffer_0_arg1_rd),
	.enw(fifo_big_line_buffer_0_arg1_wr),
	.empty(line_buffer_0_arg1_empty),
	.full(fifo_big_line_buffer_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_0_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_line_buffer_0_arg2(
	.datain(fifo_big_line_buffer_0_arg2_data),
	.dataout(line_buffer_0_arg2_data),
	.enr(line_buffer_0_arg2_rd),
	.enw(fifo_big_line_buffer_0_arg2_wr),
	.empty(line_buffer_0_arg2_empty),
	.full(fifo_big_line_buffer_0_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_0
line_buffer actor_line_buffer_0 (
	// Input Signal(s)
	.arg0(line_buffer_0_arg0_data),
	.arg0_rd(line_buffer_0_arg0_rd),
	.arg0_empty(line_buffer_0_arg0_empty),
	.arg1(line_buffer_0_arg1_data),
	.arg1_rd(line_buffer_0_arg1_rd),
	.arg1_empty(line_buffer_0_arg1_empty),
	.arg2(line_buffer_0_arg2_data),
	.arg2_rd(line_buffer_0_arg2_rd),
	.arg2_empty(line_buffer_0_arg2_empty)
	,
	
	// Output Signal(s)
	.arg3(line_buffer_0_arg3_data),
	.arg3_wr(line_buffer_0_arg3_wr),
	.arg3_full(line_buffer_0_arg3_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_line_buffer_1_arg0
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_1_arg0(
	.datain(fifo_big_line_buffer_1_arg0_data),
	.dataout(line_buffer_1_arg0_data),
	.enr(line_buffer_1_arg0_rd),
	.enw(fifo_big_line_buffer_1_arg0_wr),
	.empty(line_buffer_1_arg0_empty),
	.full(fifo_big_line_buffer_1_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_1_arg1
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_1_arg1(
	.datain(fifo_big_line_buffer_1_arg1_data),
	.dataout(line_buffer_1_arg1_data),
	.enr(line_buffer_1_arg1_rd),
	.enw(fifo_big_line_buffer_1_arg1_wr),
	.empty(line_buffer_1_arg1_empty),
	.full(fifo_big_line_buffer_1_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_1_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_line_buffer_1_arg2(
	.datain(fifo_big_line_buffer_1_arg2_data),
	.dataout(line_buffer_1_arg2_data),
	.enr(line_buffer_1_arg2_rd),
	.enw(fifo_big_line_buffer_1_arg2_wr),
	.empty(line_buffer_1_arg2_empty),
	.full(fifo_big_line_buffer_1_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_1
line_buffer actor_line_buffer_1 (
	// Input Signal(s)
	.arg0(line_buffer_1_arg0_data),
	.arg0_rd(line_buffer_1_arg0_rd),
	.arg0_empty(line_buffer_1_arg0_empty),
	.arg1(line_buffer_1_arg1_data),
	.arg1_rd(line_buffer_1_arg1_rd),
	.arg1_empty(line_buffer_1_arg1_empty),
	.arg2(line_buffer_1_arg2_data),
	.arg2_rd(line_buffer_1_arg2_rd),
	.arg2_empty(line_buffer_1_arg2_empty)
	,
	
	// Output Signal(s)
	.arg3(line_buffer_1_arg3_data),
	.arg3_wr(line_buffer_1_arg3_wr),
	.arg3_full(line_buffer_1_arg3_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_line_buffer_2_arg0
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_2_arg0(
	.datain(fifo_big_line_buffer_2_arg0_data),
	.dataout(line_buffer_2_arg0_data),
	.enr(line_buffer_2_arg0_rd),
	.enw(fifo_big_line_buffer_2_arg0_wr),
	.empty(line_buffer_2_arg0_empty),
	.full(fifo_big_line_buffer_2_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_2_arg1
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_2_arg1(
	.datain(fifo_big_line_buffer_2_arg1_data),
	.dataout(line_buffer_2_arg1_data),
	.enr(line_buffer_2_arg1_rd),
	.enw(fifo_big_line_buffer_2_arg1_wr),
	.empty(line_buffer_2_arg1_empty),
	.full(fifo_big_line_buffer_2_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_2_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_line_buffer_2_arg2(
	.datain(fifo_big_line_buffer_2_arg2_data),
	.dataout(line_buffer_2_arg2_data),
	.enr(line_buffer_2_arg2_rd),
	.enw(fifo_big_line_buffer_2_arg2_wr),
	.empty(line_buffer_2_arg2_empty),
	.full(fifo_big_line_buffer_2_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_2
line_buffer actor_line_buffer_2 (
	// Input Signal(s)
	.arg0(line_buffer_2_arg0_data),
	.arg0_rd(line_buffer_2_arg0_rd),
	.arg0_empty(line_buffer_2_arg0_empty),
	.arg1(line_buffer_2_arg1_data),
	.arg1_rd(line_buffer_2_arg1_rd),
	.arg1_empty(line_buffer_2_arg1_empty),
	.arg2(line_buffer_2_arg2_data),
	.arg2_rd(line_buffer_2_arg2_rd),
	.arg2_empty(line_buffer_2_arg2_empty)
	,
	
	// Output Signal(s)
	.arg3(line_buffer_2_arg3_data),
	.arg3_wr(line_buffer_2_arg3_wr),
	.arg3_full(line_buffer_2_arg3_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_sobel_x_0_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg0(
	.datain(fifo_big_sobel_x_0_arg0_data),
	.dataout(sobel_x_0_arg0_data),
	.enr(sobel_x_0_arg0_rd),
	.enw(fifo_big_sobel_x_0_arg0_wr),
	.empty(sobel_x_0_arg0_empty),
	.full(fifo_big_sobel_x_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg1
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg1(
	.datain(fifo_big_sobel_x_0_arg1_data),
	.dataout(sobel_x_0_arg1_data),
	.enr(sobel_x_0_arg1_rd),
	.enw(fifo_big_sobel_x_0_arg1_wr),
	.empty(sobel_x_0_arg1_empty),
	.full(fifo_big_sobel_x_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg2(
	.datain(fifo_big_sobel_x_0_arg2_data),
	.dataout(sobel_x_0_arg2_data),
	.enr(sobel_x_0_arg2_rd),
	.enw(fifo_big_sobel_x_0_arg2_wr),
	.empty(sobel_x_0_arg2_empty),
	.full(fifo_big_sobel_x_0_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg3
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg3(
	.datain(fifo_big_sobel_x_0_arg3_data),
	.dataout(sobel_x_0_arg3_data),
	.enr(sobel_x_0_arg3_rd),
	.enw(fifo_big_sobel_x_0_arg3_wr),
	.empty(sobel_x_0_arg3_empty),
	.full(fifo_big_sobel_x_0_arg3_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg4
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg4(
	.datain(fifo_big_sobel_x_0_arg4_data),
	.dataout(sobel_x_0_arg4_data),
	.enr(sobel_x_0_arg4_rd),
	.enw(fifo_big_sobel_x_0_arg4_wr),
	.empty(sobel_x_0_arg4_empty),
	.full(fifo_big_sobel_x_0_arg4_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg5
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg5(
	.datain(fifo_big_sobel_x_0_arg5_data),
	.dataout(sobel_x_0_arg5_data),
	.enr(sobel_x_0_arg5_rd),
	.enw(fifo_big_sobel_x_0_arg5_wr),
	.empty(sobel_x_0_arg5_empty),
	.full(fifo_big_sobel_x_0_arg5_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg6
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg6(
	.datain(fifo_big_sobel_x_0_arg6_data),
	.dataout(sobel_x_0_arg6_data),
	.enr(sobel_x_0_arg6_rd),
	.enw(fifo_big_sobel_x_0_arg6_wr),
	.empty(sobel_x_0_arg6_empty),
	.full(fifo_big_sobel_x_0_arg6_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg7
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg7(
	.datain(fifo_big_sobel_x_0_arg7_data),
	.dataout(sobel_x_0_arg7_data),
	.enr(sobel_x_0_arg7_rd),
	.enw(fifo_big_sobel_x_0_arg7_wr),
	.empty(sobel_x_0_arg7_empty),
	.full(fifo_big_sobel_x_0_arg7_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_arg8
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_arg8(
	.datain(fifo_big_sobel_x_0_arg8_data),
	.dataout(sobel_x_0_arg8_data),
	.enr(sobel_x_0_arg8_rd),
	.enw(fifo_big_sobel_x_0_arg8_wr),
	.empty(sobel_x_0_arg8_empty),
	.full(fifo_big_sobel_x_0_arg8_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor sobel_x_0
sobel_x actor_sobel_x_0 (
	// Input Signal(s)
	.arg0(sobel_x_0_arg0_data),
	.arg0_rd(sobel_x_0_arg0_rd),
	.arg0_empty(sobel_x_0_arg0_empty),
	.arg1(sobel_x_0_arg1_data),
	.arg1_rd(sobel_x_0_arg1_rd),
	.arg1_empty(sobel_x_0_arg1_empty),
	.arg2(sobel_x_0_arg2_data),
	.arg2_rd(sobel_x_0_arg2_rd),
	.arg2_empty(sobel_x_0_arg2_empty),
	.arg3(sobel_x_0_arg3_data),
	.arg3_rd(sobel_x_0_arg3_rd),
	.arg3_empty(sobel_x_0_arg3_empty),
	.arg4(sobel_x_0_arg4_data),
	.arg4_rd(sobel_x_0_arg4_rd),
	.arg4_empty(sobel_x_0_arg4_empty),
	.arg5(sobel_x_0_arg5_data),
	.arg5_rd(sobel_x_0_arg5_rd),
	.arg5_empty(sobel_x_0_arg5_empty),
	.arg6(sobel_x_0_arg6_data),
	.arg6_rd(sobel_x_0_arg6_rd),
	.arg6_empty(sobel_x_0_arg6_empty),
	.arg7(sobel_x_0_arg7_data),
	.arg7_rd(sobel_x_0_arg7_rd),
	.arg7_empty(sobel_x_0_arg7_empty),
	.arg8(sobel_x_0_arg8_data),
	.arg8_rd(sobel_x_0_arg8_rd),
	.arg8_empty(sobel_x_0_arg8_empty)
	,
	
	// Output Signal(s)
	.arg9(sobel_x_0_arg9_data),
	.arg9_wr(sobel_x_0_arg9_wr),
	.arg9_full(sobel_x_0_arg9_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_sobel_y_0_arg0
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg0(
	.datain(fifo_big_sobel_y_0_arg0_data),
	.dataout(sobel_y_0_arg0_data),
	.enr(sobel_y_0_arg0_rd),
	.enw(fifo_big_sobel_y_0_arg0_wr),
	.empty(sobel_y_0_arg0_empty),
	.full(fifo_big_sobel_y_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg1
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg1(
	.datain(fifo_big_sobel_y_0_arg1_data),
	.dataout(sobel_y_0_arg1_data),
	.enr(sobel_y_0_arg1_rd),
	.enw(fifo_big_sobel_y_0_arg1_wr),
	.empty(sobel_y_0_arg1_empty),
	.full(fifo_big_sobel_y_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg2
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg2(
	.datain(fifo_big_sobel_y_0_arg2_data),
	.dataout(sobel_y_0_arg2_data),
	.enr(sobel_y_0_arg2_rd),
	.enw(fifo_big_sobel_y_0_arg2_wr),
	.empty(sobel_y_0_arg2_empty),
	.full(fifo_big_sobel_y_0_arg2_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg3
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg3(
	.datain(fifo_big_sobel_y_0_arg3_data),
	.dataout(sobel_y_0_arg3_data),
	.enr(sobel_y_0_arg3_rd),
	.enw(fifo_big_sobel_y_0_arg3_wr),
	.empty(sobel_y_0_arg3_empty),
	.full(fifo_big_sobel_y_0_arg3_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg4
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg4(
	.datain(fifo_big_sobel_y_0_arg4_data),
	.dataout(sobel_y_0_arg4_data),
	.enr(sobel_y_0_arg4_rd),
	.enw(fifo_big_sobel_y_0_arg4_wr),
	.empty(sobel_y_0_arg4_empty),
	.full(fifo_big_sobel_y_0_arg4_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg5
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg5(
	.datain(fifo_big_sobel_y_0_arg5_data),
	.dataout(sobel_y_0_arg5_data),
	.enr(sobel_y_0_arg5_rd),
	.enw(fifo_big_sobel_y_0_arg5_wr),
	.empty(sobel_y_0_arg5_empty),
	.full(fifo_big_sobel_y_0_arg5_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg6
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg6(
	.datain(fifo_big_sobel_y_0_arg6_data),
	.dataout(sobel_y_0_arg6_data),
	.enr(sobel_y_0_arg6_rd),
	.enw(fifo_big_sobel_y_0_arg6_wr),
	.empty(sobel_y_0_arg6_empty),
	.full(fifo_big_sobel_y_0_arg6_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg7
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg7(
	.datain(fifo_big_sobel_y_0_arg7_data),
	.dataout(sobel_y_0_arg7_data),
	.enr(sobel_y_0_arg7_rd),
	.enw(fifo_big_sobel_y_0_arg7_wr),
	.empty(sobel_y_0_arg7_empty),
	.full(fifo_big_sobel_y_0_arg7_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_arg8
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_arg8(
	.datain(fifo_big_sobel_y_0_arg8_data),
	.dataout(sobel_y_0_arg8_data),
	.enr(sobel_y_0_arg8_rd),
	.enw(fifo_big_sobel_y_0_arg8_wr),
	.empty(sobel_y_0_arg8_empty),
	.full(fifo_big_sobel_y_0_arg8_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor sobel_y_0
sobel_y actor_sobel_y_0 (
	// Input Signal(s)
	.arg0(sobel_y_0_arg0_data),
	.arg0_rd(sobel_y_0_arg0_rd),
	.arg0_empty(sobel_y_0_arg0_empty),
	.arg1(sobel_y_0_arg1_data),
	.arg1_rd(sobel_y_0_arg1_rd),
	.arg1_empty(sobel_y_0_arg1_empty),
	.arg2(sobel_y_0_arg2_data),
	.arg2_rd(sobel_y_0_arg2_rd),
	.arg2_empty(sobel_y_0_arg2_empty),
	.arg3(sobel_y_0_arg3_data),
	.arg3_rd(sobel_y_0_arg3_rd),
	.arg3_empty(sobel_y_0_arg3_empty),
	.arg4(sobel_y_0_arg4_data),
	.arg4_rd(sobel_y_0_arg4_rd),
	.arg4_empty(sobel_y_0_arg4_empty),
	.arg5(sobel_y_0_arg5_data),
	.arg5_rd(sobel_y_0_arg5_rd),
	.arg5_empty(sobel_y_0_arg5_empty),
	.arg6(sobel_y_0_arg6_data),
	.arg6_rd(sobel_y_0_arg6_rd),
	.arg6_empty(sobel_y_0_arg6_empty),
	.arg7(sobel_y_0_arg7_data),
	.arg7_rd(sobel_y_0_arg7_rd),
	.arg7_empty(sobel_y_0_arg7_empty),
	.arg8(sobel_y_0_arg8_data),
	.arg8_rd(sobel_y_0_arg8_rd),
	.arg8_empty(sobel_y_0_arg8_empty)
	,
	
	// Output Signal(s)
	.arg9(sobel_y_0_arg9_data),
	.arg9_wr(sobel_y_0_arg9_wr),
	.arg9_full(sobel_y_0_arg9_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// actor sbox_3
sbox2x1 #(
	.SIZE(14)
)
sbox_3 (
	// Input Signal(s)
	.in1_data(sbox_3_in1_data),
	.in1_wr(sbox_3_in1_wr),
	.in1_full(sbox_3_in1_full),
	.in2_data(sbox_3_in2_data),
	.in2_wr(sbox_3_in2_wr),
	.in2_full(sbox_3_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_3_out1_data),
	.out1_wr(sbox_3_out1_wr),
	.out1_full(sbox_3_out1_full),
	
	// Selector
	.sel(sel[3])	
);


// actor sbox_4
sbox1x2 #(
	.SIZE(8)
)
sbox_4 (
	// Input Signal(s)
	.in1_data(sbox_4_in1_data),
	.in1_wr(sbox_4_in1_wr),
	.in1_full(sbox_4_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_4_out1_data),
	.out1_wr(sbox_4_out1_wr),
	.out1_full(sbox_4_out1_full),
	.out2_data(sbox_4_out2_data),
	.out2_wr(sbox_4_out2_wr),
	.out2_full(sbox_4_out2_full),
	
	// Selector
	.sel(sel[4])	
);


// actor sbox_5
sbox2x1 #(
	.SIZE(14)
)
sbox_5 (
	// Input Signal(s)
	.in1_data(sbox_5_in1_data),
	.in1_wr(sbox_5_in1_wr),
	.in1_full(sbox_5_in1_full),
	.in2_data(sbox_5_in2_data),
	.in2_wr(sbox_5_in2_wr),
	.in2_full(sbox_5_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_5_out1_data),
	.out1_wr(sbox_5_out1_wr),
	.out1_full(sbox_5_out1_full),
	
	// Selector
	.sel(sel[5])	
);


// fifo_big_abs_sum_0_arg0
fifo_big #(
	.depth(64),
	.size(14)
) fifo_big_abs_sum_0_arg0(
	.datain(fifo_big_abs_sum_0_arg0_data),
	.dataout(abs_sum_0_arg0_data),
	.enr(abs_sum_0_arg0_rd),
	.enw(fifo_big_abs_sum_0_arg0_wr),
	.empty(abs_sum_0_arg0_empty),
	.full(fifo_big_abs_sum_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_abs_sum_0_arg1
fifo_big #(
	.depth(64),
	.size(14)
) fifo_big_abs_sum_0_arg1(
	.datain(fifo_big_abs_sum_0_arg1_data),
	.dataout(abs_sum_0_arg1_data),
	.enr(abs_sum_0_arg1_rd),
	.enw(fifo_big_abs_sum_0_arg1_wr),
	.empty(abs_sum_0_arg1_empty),
	.full(fifo_big_abs_sum_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor abs_sum_0
abs_sum actor_abs_sum_0 (
	// Input Signal(s)
	.arg0(abs_sum_0_arg0_data),
	.arg0_rd(abs_sum_0_arg0_rd),
	.arg0_empty(abs_sum_0_arg0_empty),
	.arg1(abs_sum_0_arg1_data),
	.arg1_rd(abs_sum_0_arg1_rd),
	.arg1_empty(abs_sum_0_arg1_empty)
	,
	
	// Output Signal(s)
	.arg2(abs_sum_0_arg2_data),
	.arg2_wr(abs_sum_0_arg2_wr),
	.arg2_full(abs_sum_0_arg2_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_thr_0_arg0
fifo_big #(
	.depth(64),
	.size(14)
) fifo_big_thr_0_arg0(
	.datain(fifo_big_thr_0_arg0_data),
	.dataout(thr_0_arg0_data),
	.enr(thr_0_arg0_rd),
	.enw(fifo_big_thr_0_arg0_wr),
	.empty(thr_0_arg0_empty),
	.full(fifo_big_thr_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor thr_0
thr actor_thr_0 (
	// Input Signal(s)
	.arg0(thr_0_arg0_data),
	.arg0_rd(thr_0_arg0_rd),
	.arg0_empty(thr_0_arg0_empty)
	,
	
	// Output Signal(s)
	.arg1(thr_0_arg1_data),
	.arg1_wr(thr_0_arg1_wr),
	.arg1_full(thr_0_arg1_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_remove_2x2_0_arg0
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_remove_2x2_0_arg0(
	.datain(fifo_big_remove_2x2_0_arg0_data),
	.dataout(remove_2x2_0_arg0_data),
	.enr(remove_2x2_0_arg0_rd),
	.enw(fifo_big_remove_2x2_0_arg0_wr),
	.empty(remove_2x2_0_arg0_empty),
	.full(fifo_big_remove_2x2_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_remove_2x2_0_arg1
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_remove_2x2_0_arg1(
	.datain(fifo_big_remove_2x2_0_arg1_data),
	.dataout(remove_2x2_0_arg1_data),
	.enr(remove_2x2_0_arg1_rd),
	.enw(fifo_big_remove_2x2_0_arg1_wr),
	.empty(remove_2x2_0_arg1_empty),
	.full(fifo_big_remove_2x2_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor remove_2x2_0
remove_2x2 actor_remove_2x2_0 (
	// Input Signal(s)
	.arg0(remove_2x2_0_arg0_data),
	.arg0_rd(remove_2x2_0_arg0_rd),
	.arg0_empty(remove_2x2_0_arg0_empty),
	.arg1(remove_2x2_0_arg1_data),
	.arg1_rd(remove_2x2_0_arg1_rd),
	.arg1_empty(remove_2x2_0_arg1_empty)
	,
	
	// Output Signal(s)
	.arg2(remove_2x2_0_arg2_data),
	.arg2_wr(remove_2x2_0_arg2_wr),
	.arg2_full(remove_2x2_0_arg2_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_remove_3x3_0_arg0
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_remove_3x3_0_arg0(
	.datain(fifo_big_remove_3x3_0_arg0_data),
	.dataout(remove_3x3_0_arg0_data),
	.enr(remove_3x3_0_arg0_rd),
	.enw(fifo_big_remove_3x3_0_arg0_wr),
	.empty(remove_3x3_0_arg0_empty),
	.full(fifo_big_remove_3x3_0_arg0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_remove_3x3_0_arg1
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_remove_3x3_0_arg1(
	.datain(fifo_big_remove_3x3_0_arg1_data),
	.dataout(remove_3x3_0_arg1_data),
	.enr(remove_3x3_0_arg1_rd),
	.enw(fifo_big_remove_3x3_0_arg1_wr),
	.empty(remove_3x3_0_arg1_empty),
	.full(fifo_big_remove_3x3_0_arg1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor remove_3x3_0
remove_3x3 actor_remove_3x3_0 (
	// Input Signal(s)
	.arg0(remove_3x3_0_arg0_data),
	.arg0_rd(remove_3x3_0_arg0_rd),
	.arg0_empty(remove_3x3_0_arg0_empty),
	.arg1(remove_3x3_0_arg1_data),
	.arg1_rd(remove_3x3_0_arg1_rd),
	.arg1_empty(remove_3x3_0_arg1_empty)
	,
	
	// Output Signal(s)
	.arg2(remove_3x3_0_arg2_data),
	.arg2_wr(remove_3x3_0_arg2_wr),
	.arg2_full(remove_3x3_0_arg2_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// Module(s) Assignments
assign sbox_1_in1_data = in0_data;
assign sbox_1_in1_wr = in0_wr;
assign in0_full = sbox_1_in1_full;

assign sbox_2_in1_data = in1_data;
assign sbox_2_in1_wr = in1_wr;
assign in1_full = sbox_2_in1_full;

assign fifo_big_delay_0_arg0_data = sbox_1_out2_data;
assign fifo_big_delay_0_arg0_wr = sbox_1_out2_wr;
assign sbox_1_out2_full =
fifo_big_delay_0_arg0_full || 
fifo_big_roberts_x_0_arg3_full || 
fifo_big_roberts_y_0_arg3_full || 
fifo_big_line_buffer_0_arg2_full 
;

assign fifo_big_delay_5_arg0_data = sbox_1_out1_data;
assign fifo_big_delay_5_arg0_wr = sbox_1_out1_wr;
assign sbox_1_out1_full =
fifo_big_delay_5_arg0_full || 
fifo_big_line_buffer_1_arg2_full || 
fifo_big_sobel_x_0_arg8_full || 
fifo_big_sobel_y_0_arg8_full 
;

assign fifo_big_roberts_x_0_arg0_data = delay_1_arg1_data;
assign fifo_big_roberts_x_0_arg0_wr = delay_1_arg1_wr;
assign delay_1_arg1_full =
fifo_big_roberts_x_0_arg0_full || 
fifo_big_roberts_y_0_arg0_full 
;

assign fifo_big_roberts_x_0_arg1_data = line_buffer_0_arg3_data;
assign fifo_big_roberts_x_0_arg1_wr = line_buffer_0_arg3_wr;
assign line_buffer_0_arg3_full =
fifo_big_roberts_x_0_arg1_full || 
fifo_big_roberts_y_0_arg1_full || 
fifo_big_delay_1_arg0_full 
;

assign fifo_big_roberts_x_0_arg2_data = delay_0_arg1_data;
assign fifo_big_roberts_x_0_arg2_wr = delay_0_arg1_wr;
assign delay_0_arg1_full =
fifo_big_roberts_x_0_arg2_full || 
fifo_big_roberts_y_0_arg2_full 
;

assign fifo_big_roberts_x_0_arg3_data = sbox_1_out2_data;
assign fifo_big_roberts_x_0_arg3_wr = sbox_1_out2_wr;

assign fifo_big_roberts_y_0_arg0_data = delay_1_arg1_data;
assign fifo_big_roberts_y_0_arg0_wr = delay_1_arg1_wr;

assign fifo_big_roberts_y_0_arg1_data = line_buffer_0_arg3_data;
assign fifo_big_roberts_y_0_arg1_wr = line_buffer_0_arg3_wr;

assign fifo_big_roberts_y_0_arg2_data = delay_0_arg1_data;
assign fifo_big_roberts_y_0_arg2_wr = delay_0_arg1_wr;

assign fifo_big_roberts_y_0_arg3_data = sbox_1_out2_data;
assign fifo_big_roberts_y_0_arg3_wr = sbox_1_out2_wr;

assign fifo_big_line_buffer_0_arg0_data = sbox_2_out2_data;
assign fifo_big_line_buffer_0_arg0_wr = sbox_2_out2_wr;
assign sbox_2_out2_full =
fifo_big_line_buffer_0_arg0_full || 
fifo_big_line_buffer_0_arg1_full || 
fifo_big_remove_2x2_0_arg0_full 
;

assign fifo_big_line_buffer_0_arg1_data = sbox_2_out2_data;
assign fifo_big_line_buffer_0_arg1_wr = sbox_2_out2_wr;

assign fifo_big_line_buffer_0_arg2_data = sbox_1_out2_data;
assign fifo_big_line_buffer_0_arg2_wr = sbox_1_out2_wr;

assign fifo_big_line_buffer_1_arg0_data = sbox_2_out1_data;
assign fifo_big_line_buffer_1_arg0_wr = sbox_2_out1_wr;
assign sbox_2_out1_full =
fifo_big_line_buffer_1_arg0_full || 
fifo_big_line_buffer_1_arg1_full || 
fifo_big_line_buffer_2_arg0_full || 
fifo_big_line_buffer_2_arg1_full || 
fifo_big_remove_3x3_0_arg0_full 
;

assign fifo_big_line_buffer_1_arg1_data = sbox_2_out1_data;
assign fifo_big_line_buffer_1_arg1_wr = sbox_2_out1_wr;

assign fifo_big_line_buffer_1_arg2_data = sbox_1_out1_data;
assign fifo_big_line_buffer_1_arg2_wr = sbox_1_out1_wr;

assign fifo_big_sobel_x_0_arg0_data = delay_7_arg1_data;
assign fifo_big_sobel_x_0_arg0_wr = delay_7_arg1_wr;
assign delay_7_arg1_full =
fifo_big_sobel_x_0_arg0_full || 
fifo_big_sobel_y_0_arg0_full 
;

assign fifo_big_sobel_x_0_arg1_data = delay_3_arg1_data;
assign fifo_big_sobel_x_0_arg1_wr = delay_3_arg1_wr;
assign delay_3_arg1_full =
fifo_big_sobel_x_0_arg1_full || 
fifo_big_sobel_y_0_arg1_full || 
fifo_big_delay_7_arg0_full 
;

assign fifo_big_sobel_x_0_arg2_data = line_buffer_2_arg3_data;
assign fifo_big_sobel_x_0_arg2_wr = line_buffer_2_arg3_wr;
assign line_buffer_2_arg3_full =
fifo_big_sobel_x_0_arg2_full || 
fifo_big_sobel_y_0_arg2_full || 
fifo_big_delay_3_arg0_full 
;

assign fifo_big_sobel_x_0_arg3_data = delay_6_arg1_data;
assign fifo_big_sobel_x_0_arg3_wr = delay_6_arg1_wr;
assign delay_6_arg1_full =
fifo_big_sobel_x_0_arg3_full || 
fifo_big_sobel_y_0_arg3_full 
;

assign fifo_big_sobel_x_0_arg4_data = delay_2_arg1_data;
assign fifo_big_sobel_x_0_arg4_wr = delay_2_arg1_wr;
assign delay_2_arg1_full =
fifo_big_sobel_x_0_arg4_full || 
fifo_big_sobel_y_0_arg4_full || 
fifo_big_delay_6_arg0_full 
;

assign fifo_big_sobel_x_0_arg5_data = line_buffer_1_arg3_data;
assign fifo_big_sobel_x_0_arg5_wr = line_buffer_1_arg3_wr;
assign line_buffer_1_arg3_full =
fifo_big_sobel_x_0_arg5_full || 
fifo_big_sobel_y_0_arg5_full || 
fifo_big_line_buffer_2_arg2_full || 
fifo_big_delay_2_arg0_full 
;

assign fifo_big_sobel_x_0_arg6_data = delay_4_arg1_data;
assign fifo_big_sobel_x_0_arg6_wr = delay_4_arg1_wr;
assign delay_4_arg1_full =
fifo_big_sobel_x_0_arg6_full || 
fifo_big_sobel_y_0_arg6_full 
;

assign fifo_big_sobel_x_0_arg7_data = delay_5_arg1_data;
assign fifo_big_sobel_x_0_arg7_wr = delay_5_arg1_wr;
assign delay_5_arg1_full =
fifo_big_sobel_x_0_arg7_full || 
fifo_big_sobel_y_0_arg7_full || 
fifo_big_delay_4_arg0_full 
;

assign fifo_big_sobel_x_0_arg8_data = sbox_1_out1_data;
assign fifo_big_sobel_x_0_arg8_wr = sbox_1_out1_wr;

assign fifo_big_sobel_y_0_arg0_data = delay_7_arg1_data;
assign fifo_big_sobel_y_0_arg0_wr = delay_7_arg1_wr;

assign fifo_big_sobel_y_0_arg1_data = delay_3_arg1_data;
assign fifo_big_sobel_y_0_arg1_wr = delay_3_arg1_wr;

assign fifo_big_sobel_y_0_arg2_data = line_buffer_2_arg3_data;
assign fifo_big_sobel_y_0_arg2_wr = line_buffer_2_arg3_wr;

assign fifo_big_sobel_y_0_arg3_data = delay_6_arg1_data;
assign fifo_big_sobel_y_0_arg3_wr = delay_6_arg1_wr;

assign fifo_big_sobel_y_0_arg4_data = delay_2_arg1_data;
assign fifo_big_sobel_y_0_arg4_wr = delay_2_arg1_wr;

assign fifo_big_sobel_y_0_arg5_data = line_buffer_1_arg3_data;
assign fifo_big_sobel_y_0_arg5_wr = line_buffer_1_arg3_wr;

assign fifo_big_sobel_y_0_arg6_data = delay_4_arg1_data;
assign fifo_big_sobel_y_0_arg6_wr = delay_4_arg1_wr;

assign fifo_big_sobel_y_0_arg7_data = delay_5_arg1_data;
assign fifo_big_sobel_y_0_arg7_wr = delay_5_arg1_wr;

assign fifo_big_sobel_y_0_arg8_data = sbox_1_out1_data;
assign fifo_big_sobel_y_0_arg8_wr = sbox_1_out1_wr;

assign fifo_big_line_buffer_2_arg0_data = sbox_2_out1_data;
assign fifo_big_line_buffer_2_arg0_wr = sbox_2_out1_wr;

assign fifo_big_line_buffer_2_arg1_data = sbox_2_out1_data;
assign fifo_big_line_buffer_2_arg1_wr = sbox_2_out1_wr;

assign fifo_big_line_buffer_2_arg2_data = line_buffer_1_arg3_data;
assign fifo_big_line_buffer_2_arg2_wr = line_buffer_1_arg3_wr;

assign fifo_big_remove_2x2_0_arg0_data = sbox_2_out2_data;
assign fifo_big_remove_2x2_0_arg0_wr = sbox_2_out2_wr;

assign fifo_big_remove_2x2_0_arg1_data = sbox_4_out2_data;
assign fifo_big_remove_2x2_0_arg1_wr = sbox_4_out2_wr;
assign sbox_4_out2_full = fifo_big_remove_2x2_0_arg1_full;

assign fifo_big_remove_3x3_0_arg0_data = sbox_2_out1_data;
assign fifo_big_remove_3x3_0_arg0_wr = sbox_2_out1_wr;

assign fifo_big_remove_3x3_0_arg1_data = sbox_4_out1_data;
assign fifo_big_remove_3x3_0_arg1_wr = sbox_4_out1_wr;
assign sbox_4_out1_full = fifo_big_remove_3x3_0_arg1_full;

assign fifo_big_delay_4_arg0_data = delay_5_arg1_data;
assign fifo_big_delay_4_arg0_wr = delay_5_arg1_wr;

assign sbox_5_in1_data = sobel_x_0_arg9_data;
assign sbox_5_in1_wr = sobel_x_0_arg9_wr;
assign sobel_x_0_arg9_full = sbox_5_in1_full;

assign sbox_5_in2_data = roberts_x_0_arg4_data;
assign sbox_5_in2_wr = roberts_x_0_arg4_wr;
assign roberts_x_0_arg4_full = sbox_5_in2_full;

assign sbox_3_in1_data = sobel_y_0_arg9_data;
assign sbox_3_in1_wr = sobel_y_0_arg9_wr;
assign sobel_y_0_arg9_full = sbox_3_in1_full;

assign sbox_3_in2_data = roberts_y_0_arg4_data;
assign sbox_3_in2_wr = roberts_y_0_arg4_wr;
assign roberts_y_0_arg4_full = sbox_3_in2_full;

assign fifo_big_delay_1_arg0_data = line_buffer_0_arg3_data;
assign fifo_big_delay_1_arg0_wr = line_buffer_0_arg3_wr;

assign fifo_big_delay_2_arg0_data = line_buffer_1_arg3_data;
assign fifo_big_delay_2_arg0_wr = line_buffer_1_arg3_wr;

assign fifo_big_delay_3_arg0_data = line_buffer_2_arg3_data;
assign fifo_big_delay_3_arg0_wr = line_buffer_2_arg3_wr;

assign sbox_0_in1_data = remove_3x3_0_arg2_data;
assign sbox_0_in1_wr = remove_3x3_0_arg2_wr;
assign remove_3x3_0_arg2_full = sbox_0_in1_full;

assign sbox_0_in2_data = remove_2x2_0_arg2_data;
assign sbox_0_in2_wr = remove_2x2_0_arg2_wr;
assign remove_2x2_0_arg2_full = sbox_0_in2_full;

assign fifo_big_abs_sum_0_arg0_data = sbox_5_out1_data;
assign fifo_big_abs_sum_0_arg0_wr = sbox_5_out1_wr;
assign sbox_5_out1_full = fifo_big_abs_sum_0_arg0_full;

assign fifo_big_abs_sum_0_arg1_data = sbox_3_out1_data;
assign fifo_big_abs_sum_0_arg1_wr = sbox_3_out1_wr;
assign sbox_3_out1_full = fifo_big_abs_sum_0_arg1_full;

assign fifo_big_delay_6_arg0_data = delay_2_arg1_data;
assign fifo_big_delay_6_arg0_wr = delay_2_arg1_wr;

assign fifo_big_delay_7_arg0_data = delay_3_arg1_data;
assign fifo_big_delay_7_arg0_wr = delay_3_arg1_wr;

assign out0_data = sbox_0_out1_data;
assign out0_wr = sbox_0_out1_wr;
assign sbox_0_out1_full = out0_full;

assign fifo_big_thr_0_arg0_data = abs_sum_0_arg2_data;
assign fifo_big_thr_0_arg0_wr = abs_sum_0_arg2_wr;
assign abs_sum_0_arg2_full = fifo_big_thr_0_arg0_full;

assign sbox_4_in1_data = thr_0_arg1_data;
assign sbox_4_in1_wr = thr_0_arg1_wr;
assign thr_0_arg1_full = sbox_4_in1_full;

endmodule
