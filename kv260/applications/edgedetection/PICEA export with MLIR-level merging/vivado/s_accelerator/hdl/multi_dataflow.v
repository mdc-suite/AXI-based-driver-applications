// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Network module 
// Date: 2026/10/22 09:08:57
//
// ----------------------------------------------------------------------------

module multi_dataflow (
	// Input(s)
	input [5 : 0] in0_data,
	output in0_full_n,
	input in0_write,
	
	// Output(s)
	input [7 : 0] in1_data,
	output in1_full_n,
	input in1_write,
	
	// Output(s)
	output [7 : 0] out0_data,
	input out0_full_n,
	output out0_write,
	
	// Dynamic Parameter(s)
	
	// Monitoring
	
	// Configuration ID
	input [7:0] ID,
	
	
	// System Signal(s)		
	input ap_clk,
	input ap_rst
);	

// internal signals
// ----------------------------------------------------------------------------
// Sboxes Config Wire(s)
wire [5 : 0] sel;
		


// Actors Wire(s)
	
// actor line_buffer_0
wire [5 : 0] mdc_hls_fifo_native_line_buffer_0_arg0_data;
wire mdc_hls_fifo_native_line_buffer_0_arg0_full_n;
wire mdc_hls_fifo_native_line_buffer_0_arg0_write;
wire [5 : 0] line_buffer_0_arg0_data;
wire line_buffer_0_arg0_empty_n;
wire line_buffer_0_arg0_read;
wire [5 : 0] mdc_hls_fifo_native_line_buffer_0_arg1_data;
wire mdc_hls_fifo_native_line_buffer_0_arg1_full_n;
wire mdc_hls_fifo_native_line_buffer_0_arg1_write;
wire [5 : 0] line_buffer_0_arg1_data;
wire line_buffer_0_arg1_empty_n;
wire line_buffer_0_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_line_buffer_0_arg2_data;
wire mdc_hls_fifo_native_line_buffer_0_arg2_full_n;
wire mdc_hls_fifo_native_line_buffer_0_arg2_write;
wire [7 : 0] line_buffer_0_arg2_data;
wire line_buffer_0_arg2_empty_n;
wire line_buffer_0_arg2_read;
wire [7 : 0] line_buffer_0_arg3_data;
wire line_buffer_0_arg3_full_n;
wire line_buffer_0_arg3_write;
	
// actor delay_0
wire [7 : 0] mdc_hls_fifo_native_delay_0_arg0_data;
wire mdc_hls_fifo_native_delay_0_arg0_full_n;
wire mdc_hls_fifo_native_delay_0_arg0_write;
wire [7 : 0] delay_0_arg0_data;
wire delay_0_arg0_empty_n;
wire delay_0_arg0_read;
wire [7 : 0] delay_0_arg1_data;
wire delay_0_arg1_full_n;
wire delay_0_arg1_write;
	
// actor delay_1
wire [7 : 0] mdc_hls_fifo_native_delay_1_arg0_data;
wire mdc_hls_fifo_native_delay_1_arg0_full_n;
wire mdc_hls_fifo_native_delay_1_arg0_write;
wire [7 : 0] delay_1_arg0_data;
wire delay_1_arg0_empty_n;
wire delay_1_arg0_read;
wire [7 : 0] delay_1_arg1_data;
wire delay_1_arg1_full_n;
wire delay_1_arg1_write;
	
// actor roberts_x_0
wire [7 : 0] mdc_hls_fifo_native_roberts_x_0_arg0_data;
wire mdc_hls_fifo_native_roberts_x_0_arg0_full_n;
wire mdc_hls_fifo_native_roberts_x_0_arg0_write;
wire [7 : 0] roberts_x_0_arg0_data;
wire roberts_x_0_arg0_empty_n;
wire roberts_x_0_arg0_read;
wire [7 : 0] mdc_hls_fifo_native_roberts_x_0_arg1_data;
wire mdc_hls_fifo_native_roberts_x_0_arg1_full_n;
wire mdc_hls_fifo_native_roberts_x_0_arg1_write;
wire [7 : 0] roberts_x_0_arg1_data;
wire roberts_x_0_arg1_empty_n;
wire roberts_x_0_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_roberts_x_0_arg2_data;
wire mdc_hls_fifo_native_roberts_x_0_arg2_full_n;
wire mdc_hls_fifo_native_roberts_x_0_arg2_write;
wire [7 : 0] roberts_x_0_arg2_data;
wire roberts_x_0_arg2_empty_n;
wire roberts_x_0_arg2_read;
wire [7 : 0] mdc_hls_fifo_native_roberts_x_0_arg3_data;
wire mdc_hls_fifo_native_roberts_x_0_arg3_full_n;
wire mdc_hls_fifo_native_roberts_x_0_arg3_write;
wire [7 : 0] roberts_x_0_arg3_data;
wire roberts_x_0_arg3_empty_n;
wire roberts_x_0_arg3_read;
wire [13 : 0] roberts_x_0_arg4_data;
wire roberts_x_0_arg4_full_n;
wire roberts_x_0_arg4_write;
	
// actor roberts_y_0
wire [7 : 0] mdc_hls_fifo_native_roberts_y_0_arg0_data;
wire mdc_hls_fifo_native_roberts_y_0_arg0_full_n;
wire mdc_hls_fifo_native_roberts_y_0_arg0_write;
wire [7 : 0] roberts_y_0_arg0_data;
wire roberts_y_0_arg0_empty_n;
wire roberts_y_0_arg0_read;
wire [7 : 0] mdc_hls_fifo_native_roberts_y_0_arg1_data;
wire mdc_hls_fifo_native_roberts_y_0_arg1_full_n;
wire mdc_hls_fifo_native_roberts_y_0_arg1_write;
wire [7 : 0] roberts_y_0_arg1_data;
wire roberts_y_0_arg1_empty_n;
wire roberts_y_0_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_roberts_y_0_arg2_data;
wire mdc_hls_fifo_native_roberts_y_0_arg2_full_n;
wire mdc_hls_fifo_native_roberts_y_0_arg2_write;
wire [7 : 0] roberts_y_0_arg2_data;
wire roberts_y_0_arg2_empty_n;
wire roberts_y_0_arg2_read;
wire [7 : 0] mdc_hls_fifo_native_roberts_y_0_arg3_data;
wire mdc_hls_fifo_native_roberts_y_0_arg3_full_n;
wire mdc_hls_fifo_native_roberts_y_0_arg3_write;
wire [7 : 0] roberts_y_0_arg3_data;
wire roberts_y_0_arg3_empty_n;
wire roberts_y_0_arg3_read;
wire [13 : 0] roberts_y_0_arg4_data;
wire roberts_y_0_arg4_full_n;
wire roberts_y_0_arg4_write;
	
// actor abs_sum_0
wire [13 : 0] mdc_hls_fifo_native_abs_sum_0_arg0_data;
wire mdc_hls_fifo_native_abs_sum_0_arg0_full_n;
wire mdc_hls_fifo_native_abs_sum_0_arg0_write;
wire [13 : 0] abs_sum_0_arg0_data;
wire abs_sum_0_arg0_empty_n;
wire abs_sum_0_arg0_read;
wire [13 : 0] mdc_hls_fifo_native_abs_sum_0_arg1_data;
wire mdc_hls_fifo_native_abs_sum_0_arg1_full_n;
wire mdc_hls_fifo_native_abs_sum_0_arg1_write;
wire [13 : 0] abs_sum_0_arg1_data;
wire abs_sum_0_arg1_empty_n;
wire abs_sum_0_arg1_read;
wire [13 : 0] abs_sum_0_arg2_data;
wire abs_sum_0_arg2_full_n;
wire abs_sum_0_arg2_write;
	
// actor thr_0
wire [13 : 0] mdc_hls_fifo_native_thr_0_arg0_data;
wire mdc_hls_fifo_native_thr_0_arg0_full_n;
wire mdc_hls_fifo_native_thr_0_arg0_write;
wire [13 : 0] thr_0_arg0_data;
wire thr_0_arg0_empty_n;
wire thr_0_arg0_read;
wire [7 : 0] thr_0_arg1_data;
wire thr_0_arg1_full_n;
wire thr_0_arg1_write;
	
// actor remove_2x2_0
wire [5 : 0] mdc_hls_fifo_native_remove_2x2_0_arg0_data;
wire mdc_hls_fifo_native_remove_2x2_0_arg0_full_n;
wire mdc_hls_fifo_native_remove_2x2_0_arg0_write;
wire [5 : 0] remove_2x2_0_arg0_data;
wire remove_2x2_0_arg0_empty_n;
wire remove_2x2_0_arg0_read;
wire [7 : 0] mdc_hls_fifo_native_remove_2x2_0_arg1_data;
wire mdc_hls_fifo_native_remove_2x2_0_arg1_full_n;
wire mdc_hls_fifo_native_remove_2x2_0_arg1_write;
wire [7 : 0] remove_2x2_0_arg1_data;
wire remove_2x2_0_arg1_empty_n;
wire remove_2x2_0_arg1_read;
wire [7 : 0] remove_2x2_0_arg2_data;
wire remove_2x2_0_arg2_full_n;
wire remove_2x2_0_arg2_write;
	
// actor line_buffer_1
wire [5 : 0] mdc_hls_fifo_native_line_buffer_1_arg0_data;
wire mdc_hls_fifo_native_line_buffer_1_arg0_full_n;
wire mdc_hls_fifo_native_line_buffer_1_arg0_write;
wire [5 : 0] line_buffer_1_arg0_data;
wire line_buffer_1_arg0_empty_n;
wire line_buffer_1_arg0_read;
wire [5 : 0] mdc_hls_fifo_native_line_buffer_1_arg1_data;
wire mdc_hls_fifo_native_line_buffer_1_arg1_full_n;
wire mdc_hls_fifo_native_line_buffer_1_arg1_write;
wire [5 : 0] line_buffer_1_arg1_data;
wire line_buffer_1_arg1_empty_n;
wire line_buffer_1_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_line_buffer_1_arg2_data;
wire mdc_hls_fifo_native_line_buffer_1_arg2_full_n;
wire mdc_hls_fifo_native_line_buffer_1_arg2_write;
wire [7 : 0] line_buffer_1_arg2_data;
wire line_buffer_1_arg2_empty_n;
wire line_buffer_1_arg2_read;
wire [7 : 0] line_buffer_1_arg3_data;
wire line_buffer_1_arg3_full_n;
wire line_buffer_1_arg3_write;
	
// actor line_buffer_2
wire [5 : 0] mdc_hls_fifo_native_line_buffer_2_arg0_data;
wire mdc_hls_fifo_native_line_buffer_2_arg0_full_n;
wire mdc_hls_fifo_native_line_buffer_2_arg0_write;
wire [5 : 0] line_buffer_2_arg0_data;
wire line_buffer_2_arg0_empty_n;
wire line_buffer_2_arg0_read;
wire [5 : 0] mdc_hls_fifo_native_line_buffer_2_arg1_data;
wire mdc_hls_fifo_native_line_buffer_2_arg1_full_n;
wire mdc_hls_fifo_native_line_buffer_2_arg1_write;
wire [5 : 0] line_buffer_2_arg1_data;
wire line_buffer_2_arg1_empty_n;
wire line_buffer_2_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_line_buffer_2_arg2_data;
wire mdc_hls_fifo_native_line_buffer_2_arg2_full_n;
wire mdc_hls_fifo_native_line_buffer_2_arg2_write;
wire [7 : 0] line_buffer_2_arg2_data;
wire line_buffer_2_arg2_empty_n;
wire line_buffer_2_arg2_read;
wire [7 : 0] line_buffer_2_arg3_data;
wire line_buffer_2_arg3_full_n;
wire line_buffer_2_arg3_write;
	
// actor delay_2
wire [7 : 0] mdc_hls_fifo_native_delay_2_arg0_data;
wire mdc_hls_fifo_native_delay_2_arg0_full_n;
wire mdc_hls_fifo_native_delay_2_arg0_write;
wire [7 : 0] delay_2_arg0_data;
wire delay_2_arg0_empty_n;
wire delay_2_arg0_read;
wire [7 : 0] delay_2_arg1_data;
wire delay_2_arg1_full_n;
wire delay_2_arg1_write;
	
// actor delay_3
wire [7 : 0] mdc_hls_fifo_native_delay_3_arg0_data;
wire mdc_hls_fifo_native_delay_3_arg0_full_n;
wire mdc_hls_fifo_native_delay_3_arg0_write;
wire [7 : 0] delay_3_arg0_data;
wire delay_3_arg0_empty_n;
wire delay_3_arg0_read;
wire [7 : 0] delay_3_arg1_data;
wire delay_3_arg1_full_n;
wire delay_3_arg1_write;
	
// actor delay_4
wire [7 : 0] mdc_hls_fifo_native_delay_4_arg0_data;
wire mdc_hls_fifo_native_delay_4_arg0_full_n;
wire mdc_hls_fifo_native_delay_4_arg0_write;
wire [7 : 0] delay_4_arg0_data;
wire delay_4_arg0_empty_n;
wire delay_4_arg0_read;
wire [7 : 0] delay_4_arg1_data;
wire delay_4_arg1_full_n;
wire delay_4_arg1_write;
	
// actor delay_5
wire [7 : 0] mdc_hls_fifo_native_delay_5_arg0_data;
wire mdc_hls_fifo_native_delay_5_arg0_full_n;
wire mdc_hls_fifo_native_delay_5_arg0_write;
wire [7 : 0] delay_5_arg0_data;
wire delay_5_arg0_empty_n;
wire delay_5_arg0_read;
wire [7 : 0] delay_5_arg1_data;
wire delay_5_arg1_full_n;
wire delay_5_arg1_write;
	
// actor delay_6
wire [7 : 0] mdc_hls_fifo_native_delay_6_arg0_data;
wire mdc_hls_fifo_native_delay_6_arg0_full_n;
wire mdc_hls_fifo_native_delay_6_arg0_write;
wire [7 : 0] delay_6_arg0_data;
wire delay_6_arg0_empty_n;
wire delay_6_arg0_read;
wire [7 : 0] delay_6_arg1_data;
wire delay_6_arg1_full_n;
wire delay_6_arg1_write;
	
// actor delay_7
wire [7 : 0] mdc_hls_fifo_native_delay_7_arg0_data;
wire mdc_hls_fifo_native_delay_7_arg0_full_n;
wire mdc_hls_fifo_native_delay_7_arg0_write;
wire [7 : 0] delay_7_arg0_data;
wire delay_7_arg0_empty_n;
wire delay_7_arg0_read;
wire [7 : 0] delay_7_arg1_data;
wire delay_7_arg1_full_n;
wire delay_7_arg1_write;
	
// actor sobel_x_0
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg0_data;
wire mdc_hls_fifo_native_sobel_x_0_arg0_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg0_write;
wire [7 : 0] sobel_x_0_arg0_data;
wire sobel_x_0_arg0_empty_n;
wire sobel_x_0_arg0_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg1_data;
wire mdc_hls_fifo_native_sobel_x_0_arg1_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg1_write;
wire [7 : 0] sobel_x_0_arg1_data;
wire sobel_x_0_arg1_empty_n;
wire sobel_x_0_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg2_data;
wire mdc_hls_fifo_native_sobel_x_0_arg2_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg2_write;
wire [7 : 0] sobel_x_0_arg2_data;
wire sobel_x_0_arg2_empty_n;
wire sobel_x_0_arg2_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg3_data;
wire mdc_hls_fifo_native_sobel_x_0_arg3_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg3_write;
wire [7 : 0] sobel_x_0_arg3_data;
wire sobel_x_0_arg3_empty_n;
wire sobel_x_0_arg3_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg4_data;
wire mdc_hls_fifo_native_sobel_x_0_arg4_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg4_write;
wire [7 : 0] sobel_x_0_arg4_data;
wire sobel_x_0_arg4_empty_n;
wire sobel_x_0_arg4_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg5_data;
wire mdc_hls_fifo_native_sobel_x_0_arg5_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg5_write;
wire [7 : 0] sobel_x_0_arg5_data;
wire sobel_x_0_arg5_empty_n;
wire sobel_x_0_arg5_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg6_data;
wire mdc_hls_fifo_native_sobel_x_0_arg6_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg6_write;
wire [7 : 0] sobel_x_0_arg6_data;
wire sobel_x_0_arg6_empty_n;
wire sobel_x_0_arg6_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg7_data;
wire mdc_hls_fifo_native_sobel_x_0_arg7_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg7_write;
wire [7 : 0] sobel_x_0_arg7_data;
wire sobel_x_0_arg7_empty_n;
wire sobel_x_0_arg7_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_x_0_arg8_data;
wire mdc_hls_fifo_native_sobel_x_0_arg8_full_n;
wire mdc_hls_fifo_native_sobel_x_0_arg8_write;
wire [7 : 0] sobel_x_0_arg8_data;
wire sobel_x_0_arg8_empty_n;
wire sobel_x_0_arg8_read;
wire [13 : 0] sobel_x_0_arg9_data;
wire sobel_x_0_arg9_full_n;
wire sobel_x_0_arg9_write;
	
// actor sobel_y_0
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg0_data;
wire mdc_hls_fifo_native_sobel_y_0_arg0_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg0_write;
wire [7 : 0] sobel_y_0_arg0_data;
wire sobel_y_0_arg0_empty_n;
wire sobel_y_0_arg0_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg1_data;
wire mdc_hls_fifo_native_sobel_y_0_arg1_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg1_write;
wire [7 : 0] sobel_y_0_arg1_data;
wire sobel_y_0_arg1_empty_n;
wire sobel_y_0_arg1_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg2_data;
wire mdc_hls_fifo_native_sobel_y_0_arg2_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg2_write;
wire [7 : 0] sobel_y_0_arg2_data;
wire sobel_y_0_arg2_empty_n;
wire sobel_y_0_arg2_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg3_data;
wire mdc_hls_fifo_native_sobel_y_0_arg3_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg3_write;
wire [7 : 0] sobel_y_0_arg3_data;
wire sobel_y_0_arg3_empty_n;
wire sobel_y_0_arg3_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg4_data;
wire mdc_hls_fifo_native_sobel_y_0_arg4_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg4_write;
wire [7 : 0] sobel_y_0_arg4_data;
wire sobel_y_0_arg4_empty_n;
wire sobel_y_0_arg4_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg5_data;
wire mdc_hls_fifo_native_sobel_y_0_arg5_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg5_write;
wire [7 : 0] sobel_y_0_arg5_data;
wire sobel_y_0_arg5_empty_n;
wire sobel_y_0_arg5_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg6_data;
wire mdc_hls_fifo_native_sobel_y_0_arg6_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg6_write;
wire [7 : 0] sobel_y_0_arg6_data;
wire sobel_y_0_arg6_empty_n;
wire sobel_y_0_arg6_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg7_data;
wire mdc_hls_fifo_native_sobel_y_0_arg7_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg7_write;
wire [7 : 0] sobel_y_0_arg7_data;
wire sobel_y_0_arg7_empty_n;
wire sobel_y_0_arg7_read;
wire [7 : 0] mdc_hls_fifo_native_sobel_y_0_arg8_data;
wire mdc_hls_fifo_native_sobel_y_0_arg8_full_n;
wire mdc_hls_fifo_native_sobel_y_0_arg8_write;
wire [7 : 0] sobel_y_0_arg8_data;
wire sobel_y_0_arg8_empty_n;
wire sobel_y_0_arg8_read;
wire [13 : 0] sobel_y_0_arg9_data;
wire sobel_y_0_arg9_full_n;
wire sobel_y_0_arg9_write;
	
// actor remove_3x3_0
wire [5 : 0] mdc_hls_fifo_native_remove_3x3_0_arg0_data;
wire mdc_hls_fifo_native_remove_3x3_0_arg0_full_n;
wire mdc_hls_fifo_native_remove_3x3_0_arg0_write;
wire [5 : 0] remove_3x3_0_arg0_data;
wire remove_3x3_0_arg0_empty_n;
wire remove_3x3_0_arg0_read;
wire [7 : 0] mdc_hls_fifo_native_remove_3x3_0_arg1_data;
wire mdc_hls_fifo_native_remove_3x3_0_arg1_full_n;
wire mdc_hls_fifo_native_remove_3x3_0_arg1_write;
wire [7 : 0] remove_3x3_0_arg1_data;
wire remove_3x3_0_arg1_empty_n;
wire remove_3x3_0_arg1_read;
wire [7 : 0] remove_3x3_0_arg2_data;
wire remove_3x3_0_arg2_full_n;
wire remove_3x3_0_arg2_write;
	
// actor sbox_0
wire [5 : 0] sbox_0_in1_data;
wire sbox_0_in1_full_n;
wire sbox_0_in1_write;
wire [5 : 0] sbox_0_out1_data;
wire sbox_0_out1_full_n;
wire sbox_0_out1_write;
wire [5 : 0] sbox_0_out2_data;
wire sbox_0_out2_full_n;
wire sbox_0_out2_write;
	
// actor sbox_1
wire [7 : 0] sbox_1_in1_data;
wire sbox_1_in1_full_n;
wire sbox_1_in1_write;
wire [7 : 0] sbox_1_out1_data;
wire sbox_1_out1_full_n;
wire sbox_1_out1_write;
wire [7 : 0] sbox_1_out2_data;
wire sbox_1_out2_full_n;
wire sbox_1_out2_write;
	
// actor sbox_2
wire [7 : 0] sbox_2_in1_data;
wire sbox_2_in1_full_n;
wire sbox_2_in1_write;
wire [7 : 0] sbox_2_out1_data;
wire sbox_2_out1_full_n;
wire sbox_2_out1_write;
wire [7 : 0] sbox_2_out2_data;
wire sbox_2_out2_full_n;
wire sbox_2_out2_write;
	
// actor sbox_3
wire [7 : 0] sbox_3_in1_data;
wire sbox_3_in1_full_n;
wire sbox_3_in1_write;
wire [7 : 0] sbox_3_in2_data;
wire sbox_3_in2_full_n;
wire sbox_3_in2_write;
wire [7 : 0] sbox_3_out1_data;
wire sbox_3_out1_full_n;
wire sbox_3_out1_write;
	
// actor sbox_4
wire [13 : 0] sbox_4_in1_data;
wire sbox_4_in1_full_n;
wire sbox_4_in1_write;
wire [13 : 0] sbox_4_in2_data;
wire sbox_4_in2_full_n;
wire sbox_4_in2_write;
wire [13 : 0] sbox_4_out1_data;
wire sbox_4_out1_full_n;
wire sbox_4_out1_write;
	
// actor sbox_5
wire [13 : 0] sbox_5_in1_data;
wire sbox_5_in1_full_n;
wire sbox_5_in1_write;
wire [13 : 0] sbox_5_in2_data;
wire sbox_5_in2_full_n;
wire sbox_5_in2_write;
wire [13 : 0] sbox_5_out1_data;
wire sbox_5_out1_full_n;
wire sbox_5_out1_write;
// ----------------------------------------------------------------------------

// body
// ----------------------------------------------------------------------------
// Network Configurator
configurator config_0 (
	.sel(sel),
	.ID(ID)
);




// mdc_hls_fifo_native_line_buffer_0_arg0
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_0_arg0(
	.din(mdc_hls_fifo_native_line_buffer_0_arg0_data),
	.empty_n(line_buffer_0_arg0_empty_n),
	.read(line_buffer_0_arg0_read),
	.dout(line_buffer_0_arg0_data),
	.full_n(mdc_hls_fifo_native_line_buffer_0_arg0_full_n),
	.write(mdc_hls_fifo_native_line_buffer_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_line_buffer_0_arg1
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_0_arg1(
	.din(mdc_hls_fifo_native_line_buffer_0_arg1_data),
	.empty_n(line_buffer_0_arg1_empty_n),
	.read(line_buffer_0_arg1_read),
	.dout(line_buffer_0_arg1_data),
	.full_n(mdc_hls_fifo_native_line_buffer_0_arg1_full_n),
	.write(mdc_hls_fifo_native_line_buffer_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_line_buffer_0_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_0_arg2(
	.din(mdc_hls_fifo_native_line_buffer_0_arg2_data),
	.empty_n(line_buffer_0_arg2_empty_n),
	.read(line_buffer_0_arg2_read),
	.dout(line_buffer_0_arg2_data),
	.full_n(mdc_hls_fifo_native_line_buffer_0_arg2_full_n),
	.write(mdc_hls_fifo_native_line_buffer_0_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor line_buffer_0
line_buffer actor_line_buffer_0 (
	// Input Signal(s)
	.arg0_dout(line_buffer_0_arg0_data),
	.arg0_empty_n(line_buffer_0_arg0_empty_n),
	.arg0_read(line_buffer_0_arg0_read),
	.arg1_dout(line_buffer_0_arg1_data),
	.arg1_empty_n(line_buffer_0_arg1_empty_n),
	.arg1_read(line_buffer_0_arg1_read),
	.arg2_dout(line_buffer_0_arg2_data),
	.arg2_empty_n(line_buffer_0_arg2_empty_n),
	.arg2_read(line_buffer_0_arg2_read)
	,
	
	// Output Signal(s)
	.arg3_din(line_buffer_0_arg3_data),
	.arg3_full_n(line_buffer_0_arg3_full_n),
	.arg3_write(line_buffer_0_arg3_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_0_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_0_arg0(
	.din(mdc_hls_fifo_native_delay_0_arg0_data),
	.empty_n(delay_0_arg0_empty_n),
	.read(delay_0_arg0_read),
	.dout(delay_0_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_0_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_0
delay actor_delay_0 (
	// Input Signal(s)
	.arg0_dout(delay_0_arg0_data),
	.arg0_empty_n(delay_0_arg0_empty_n),
	.arg0_read(delay_0_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_0_arg1_data),
	.arg1_full_n(delay_0_arg1_full_n),
	.arg1_write(delay_0_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_1_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_1_arg0(
	.din(mdc_hls_fifo_native_delay_1_arg0_data),
	.empty_n(delay_1_arg0_empty_n),
	.read(delay_1_arg0_read),
	.dout(delay_1_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_1_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_1_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_1
delay actor_delay_1 (
	// Input Signal(s)
	.arg0_dout(delay_1_arg0_data),
	.arg0_empty_n(delay_1_arg0_empty_n),
	.arg0_read(delay_1_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_1_arg1_data),
	.arg1_full_n(delay_1_arg1_full_n),
	.arg1_write(delay_1_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_roberts_x_0_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_x_0_arg0(
	.din(mdc_hls_fifo_native_roberts_x_0_arg0_data),
	.empty_n(roberts_x_0_arg0_empty_n),
	.read(roberts_x_0_arg0_read),
	.dout(roberts_x_0_arg0_data),
	.full_n(mdc_hls_fifo_native_roberts_x_0_arg0_full_n),
	.write(mdc_hls_fifo_native_roberts_x_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_roberts_x_0_arg1
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_x_0_arg1(
	.din(mdc_hls_fifo_native_roberts_x_0_arg1_data),
	.empty_n(roberts_x_0_arg1_empty_n),
	.read(roberts_x_0_arg1_read),
	.dout(roberts_x_0_arg1_data),
	.full_n(mdc_hls_fifo_native_roberts_x_0_arg1_full_n),
	.write(mdc_hls_fifo_native_roberts_x_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_roberts_x_0_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_x_0_arg2(
	.din(mdc_hls_fifo_native_roberts_x_0_arg2_data),
	.empty_n(roberts_x_0_arg2_empty_n),
	.read(roberts_x_0_arg2_read),
	.dout(roberts_x_0_arg2_data),
	.full_n(mdc_hls_fifo_native_roberts_x_0_arg2_full_n),
	.write(mdc_hls_fifo_native_roberts_x_0_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_roberts_x_0_arg3
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_x_0_arg3(
	.din(mdc_hls_fifo_native_roberts_x_0_arg3_data),
	.empty_n(roberts_x_0_arg3_empty_n),
	.read(roberts_x_0_arg3_read),
	.dout(roberts_x_0_arg3_data),
	.full_n(mdc_hls_fifo_native_roberts_x_0_arg3_full_n),
	.write(mdc_hls_fifo_native_roberts_x_0_arg3_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor roberts_x_0
roberts_x actor_roberts_x_0 (
	// Input Signal(s)
	.arg0_dout(roberts_x_0_arg0_data),
	.arg0_empty_n(roberts_x_0_arg0_empty_n),
	.arg0_read(roberts_x_0_arg0_read),
	.arg1_dout(roberts_x_0_arg1_data),
	.arg1_empty_n(roberts_x_0_arg1_empty_n),
	.arg1_read(roberts_x_0_arg1_read),
	.arg2_dout(roberts_x_0_arg2_data),
	.arg2_empty_n(roberts_x_0_arg2_empty_n),
	.arg2_read(roberts_x_0_arg2_read),
	.arg3_dout(roberts_x_0_arg3_data),
	.arg3_empty_n(roberts_x_0_arg3_empty_n),
	.arg3_read(roberts_x_0_arg3_read)
	,
	
	// Output Signal(s)
	.arg4_din(roberts_x_0_arg4_data),
	.arg4_full_n(roberts_x_0_arg4_full_n),
	.arg4_write(roberts_x_0_arg4_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_roberts_y_0_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_y_0_arg0(
	.din(mdc_hls_fifo_native_roberts_y_0_arg0_data),
	.empty_n(roberts_y_0_arg0_empty_n),
	.read(roberts_y_0_arg0_read),
	.dout(roberts_y_0_arg0_data),
	.full_n(mdc_hls_fifo_native_roberts_y_0_arg0_full_n),
	.write(mdc_hls_fifo_native_roberts_y_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_roberts_y_0_arg1
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_y_0_arg1(
	.din(mdc_hls_fifo_native_roberts_y_0_arg1_data),
	.empty_n(roberts_y_0_arg1_empty_n),
	.read(roberts_y_0_arg1_read),
	.dout(roberts_y_0_arg1_data),
	.full_n(mdc_hls_fifo_native_roberts_y_0_arg1_full_n),
	.write(mdc_hls_fifo_native_roberts_y_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_roberts_y_0_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_y_0_arg2(
	.din(mdc_hls_fifo_native_roberts_y_0_arg2_data),
	.empty_n(roberts_y_0_arg2_empty_n),
	.read(roberts_y_0_arg2_read),
	.dout(roberts_y_0_arg2_data),
	.full_n(mdc_hls_fifo_native_roberts_y_0_arg2_full_n),
	.write(mdc_hls_fifo_native_roberts_y_0_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_roberts_y_0_arg3
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_roberts_y_0_arg3(
	.din(mdc_hls_fifo_native_roberts_y_0_arg3_data),
	.empty_n(roberts_y_0_arg3_empty_n),
	.read(roberts_y_0_arg3_read),
	.dout(roberts_y_0_arg3_data),
	.full_n(mdc_hls_fifo_native_roberts_y_0_arg3_full_n),
	.write(mdc_hls_fifo_native_roberts_y_0_arg3_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor roberts_y_0
roberts_y actor_roberts_y_0 (
	// Input Signal(s)
	.arg0_dout(roberts_y_0_arg0_data),
	.arg0_empty_n(roberts_y_0_arg0_empty_n),
	.arg0_read(roberts_y_0_arg0_read),
	.arg1_dout(roberts_y_0_arg1_data),
	.arg1_empty_n(roberts_y_0_arg1_empty_n),
	.arg1_read(roberts_y_0_arg1_read),
	.arg2_dout(roberts_y_0_arg2_data),
	.arg2_empty_n(roberts_y_0_arg2_empty_n),
	.arg2_read(roberts_y_0_arg2_read),
	.arg3_dout(roberts_y_0_arg3_data),
	.arg3_empty_n(roberts_y_0_arg3_empty_n),
	.arg3_read(roberts_y_0_arg3_read)
	,
	
	// Output Signal(s)
	.arg4_din(roberts_y_0_arg4_data),
	.arg4_full_n(roberts_y_0_arg4_full_n),
	.arg4_write(roberts_y_0_arg4_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_abs_sum_0_arg0
mdc_hls_fifo_native #(
	.width(14),
	.depth(64)
) mdc_hls_fifo_native_abs_sum_0_arg0(
	.din(mdc_hls_fifo_native_abs_sum_0_arg0_data),
	.empty_n(abs_sum_0_arg0_empty_n),
	.read(abs_sum_0_arg0_read),
	.dout(abs_sum_0_arg0_data),
	.full_n(mdc_hls_fifo_native_abs_sum_0_arg0_full_n),
	.write(mdc_hls_fifo_native_abs_sum_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_abs_sum_0_arg1
mdc_hls_fifo_native #(
	.width(14),
	.depth(64)
) mdc_hls_fifo_native_abs_sum_0_arg1(
	.din(mdc_hls_fifo_native_abs_sum_0_arg1_data),
	.empty_n(abs_sum_0_arg1_empty_n),
	.read(abs_sum_0_arg1_read),
	.dout(abs_sum_0_arg1_data),
	.full_n(mdc_hls_fifo_native_abs_sum_0_arg1_full_n),
	.write(mdc_hls_fifo_native_abs_sum_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor abs_sum_0
abs_sum actor_abs_sum_0 (
	// Input Signal(s)
	.arg0_dout(abs_sum_0_arg0_data),
	.arg0_empty_n(abs_sum_0_arg0_empty_n),
	.arg0_read(abs_sum_0_arg0_read),
	.arg1_dout(abs_sum_0_arg1_data),
	.arg1_empty_n(abs_sum_0_arg1_empty_n),
	.arg1_read(abs_sum_0_arg1_read)
	,
	
	// Output Signal(s)
	.arg2_din(abs_sum_0_arg2_data),
	.arg2_full_n(abs_sum_0_arg2_full_n),
	.arg2_write(abs_sum_0_arg2_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_thr_0_arg0
mdc_hls_fifo_native #(
	.width(14),
	.depth(64)
) mdc_hls_fifo_native_thr_0_arg0(
	.din(mdc_hls_fifo_native_thr_0_arg0_data),
	.empty_n(thr_0_arg0_empty_n),
	.read(thr_0_arg0_read),
	.dout(thr_0_arg0_data),
	.full_n(mdc_hls_fifo_native_thr_0_arg0_full_n),
	.write(mdc_hls_fifo_native_thr_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor thr_0
thr actor_thr_0 (
	// Input Signal(s)
	.arg0_dout(thr_0_arg0_data),
	.arg0_empty_n(thr_0_arg0_empty_n),
	.arg0_read(thr_0_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(thr_0_arg1_data),
	.arg1_full_n(thr_0_arg1_full_n),
	.arg1_write(thr_0_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_remove_2x2_0_arg0
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_remove_2x2_0_arg0(
	.din(mdc_hls_fifo_native_remove_2x2_0_arg0_data),
	.empty_n(remove_2x2_0_arg0_empty_n),
	.read(remove_2x2_0_arg0_read),
	.dout(remove_2x2_0_arg0_data),
	.full_n(mdc_hls_fifo_native_remove_2x2_0_arg0_full_n),
	.write(mdc_hls_fifo_native_remove_2x2_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_remove_2x2_0_arg1
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_remove_2x2_0_arg1(
	.din(mdc_hls_fifo_native_remove_2x2_0_arg1_data),
	.empty_n(remove_2x2_0_arg1_empty_n),
	.read(remove_2x2_0_arg1_read),
	.dout(remove_2x2_0_arg1_data),
	.full_n(mdc_hls_fifo_native_remove_2x2_0_arg1_full_n),
	.write(mdc_hls_fifo_native_remove_2x2_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor remove_2x2_0
remove_2x2 actor_remove_2x2_0 (
	// Input Signal(s)
	.arg0_dout(remove_2x2_0_arg0_data),
	.arg0_empty_n(remove_2x2_0_arg0_empty_n),
	.arg0_read(remove_2x2_0_arg0_read),
	.arg1_dout(remove_2x2_0_arg1_data),
	.arg1_empty_n(remove_2x2_0_arg1_empty_n),
	.arg1_read(remove_2x2_0_arg1_read)
	,
	
	// Output Signal(s)
	.arg2_din(remove_2x2_0_arg2_data),
	.arg2_full_n(remove_2x2_0_arg2_full_n),
	.arg2_write(remove_2x2_0_arg2_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_line_buffer_1_arg0
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_1_arg0(
	.din(mdc_hls_fifo_native_line_buffer_1_arg0_data),
	.empty_n(line_buffer_1_arg0_empty_n),
	.read(line_buffer_1_arg0_read),
	.dout(line_buffer_1_arg0_data),
	.full_n(mdc_hls_fifo_native_line_buffer_1_arg0_full_n),
	.write(mdc_hls_fifo_native_line_buffer_1_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_line_buffer_1_arg1
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_1_arg1(
	.din(mdc_hls_fifo_native_line_buffer_1_arg1_data),
	.empty_n(line_buffer_1_arg1_empty_n),
	.read(line_buffer_1_arg1_read),
	.dout(line_buffer_1_arg1_data),
	.full_n(mdc_hls_fifo_native_line_buffer_1_arg1_full_n),
	.write(mdc_hls_fifo_native_line_buffer_1_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_line_buffer_1_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_1_arg2(
	.din(mdc_hls_fifo_native_line_buffer_1_arg2_data),
	.empty_n(line_buffer_1_arg2_empty_n),
	.read(line_buffer_1_arg2_read),
	.dout(line_buffer_1_arg2_data),
	.full_n(mdc_hls_fifo_native_line_buffer_1_arg2_full_n),
	.write(mdc_hls_fifo_native_line_buffer_1_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor line_buffer_1
line_buffer actor_line_buffer_1 (
	// Input Signal(s)
	.arg0_dout(line_buffer_1_arg0_data),
	.arg0_empty_n(line_buffer_1_arg0_empty_n),
	.arg0_read(line_buffer_1_arg0_read),
	.arg1_dout(line_buffer_1_arg1_data),
	.arg1_empty_n(line_buffer_1_arg1_empty_n),
	.arg1_read(line_buffer_1_arg1_read),
	.arg2_dout(line_buffer_1_arg2_data),
	.arg2_empty_n(line_buffer_1_arg2_empty_n),
	.arg2_read(line_buffer_1_arg2_read)
	,
	
	// Output Signal(s)
	.arg3_din(line_buffer_1_arg3_data),
	.arg3_full_n(line_buffer_1_arg3_full_n),
	.arg3_write(line_buffer_1_arg3_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_line_buffer_2_arg0
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_2_arg0(
	.din(mdc_hls_fifo_native_line_buffer_2_arg0_data),
	.empty_n(line_buffer_2_arg0_empty_n),
	.read(line_buffer_2_arg0_read),
	.dout(line_buffer_2_arg0_data),
	.full_n(mdc_hls_fifo_native_line_buffer_2_arg0_full_n),
	.write(mdc_hls_fifo_native_line_buffer_2_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_line_buffer_2_arg1
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_2_arg1(
	.din(mdc_hls_fifo_native_line_buffer_2_arg1_data),
	.empty_n(line_buffer_2_arg1_empty_n),
	.read(line_buffer_2_arg1_read),
	.dout(line_buffer_2_arg1_data),
	.full_n(mdc_hls_fifo_native_line_buffer_2_arg1_full_n),
	.write(mdc_hls_fifo_native_line_buffer_2_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_line_buffer_2_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_line_buffer_2_arg2(
	.din(mdc_hls_fifo_native_line_buffer_2_arg2_data),
	.empty_n(line_buffer_2_arg2_empty_n),
	.read(line_buffer_2_arg2_read),
	.dout(line_buffer_2_arg2_data),
	.full_n(mdc_hls_fifo_native_line_buffer_2_arg2_full_n),
	.write(mdc_hls_fifo_native_line_buffer_2_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor line_buffer_2
line_buffer actor_line_buffer_2 (
	// Input Signal(s)
	.arg0_dout(line_buffer_2_arg0_data),
	.arg0_empty_n(line_buffer_2_arg0_empty_n),
	.arg0_read(line_buffer_2_arg0_read),
	.arg1_dout(line_buffer_2_arg1_data),
	.arg1_empty_n(line_buffer_2_arg1_empty_n),
	.arg1_read(line_buffer_2_arg1_read),
	.arg2_dout(line_buffer_2_arg2_data),
	.arg2_empty_n(line_buffer_2_arg2_empty_n),
	.arg2_read(line_buffer_2_arg2_read)
	,
	
	// Output Signal(s)
	.arg3_din(line_buffer_2_arg3_data),
	.arg3_full_n(line_buffer_2_arg3_full_n),
	.arg3_write(line_buffer_2_arg3_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_2_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_2_arg0(
	.din(mdc_hls_fifo_native_delay_2_arg0_data),
	.empty_n(delay_2_arg0_empty_n),
	.read(delay_2_arg0_read),
	.dout(delay_2_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_2_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_2_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_2
delay actor_delay_2 (
	// Input Signal(s)
	.arg0_dout(delay_2_arg0_data),
	.arg0_empty_n(delay_2_arg0_empty_n),
	.arg0_read(delay_2_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_2_arg1_data),
	.arg1_full_n(delay_2_arg1_full_n),
	.arg1_write(delay_2_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_3_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_3_arg0(
	.din(mdc_hls_fifo_native_delay_3_arg0_data),
	.empty_n(delay_3_arg0_empty_n),
	.read(delay_3_arg0_read),
	.dout(delay_3_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_3_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_3_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_3
delay actor_delay_3 (
	// Input Signal(s)
	.arg0_dout(delay_3_arg0_data),
	.arg0_empty_n(delay_3_arg0_empty_n),
	.arg0_read(delay_3_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_3_arg1_data),
	.arg1_full_n(delay_3_arg1_full_n),
	.arg1_write(delay_3_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_4_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_4_arg0(
	.din(mdc_hls_fifo_native_delay_4_arg0_data),
	.empty_n(delay_4_arg0_empty_n),
	.read(delay_4_arg0_read),
	.dout(delay_4_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_4_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_4_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_4
delay actor_delay_4 (
	// Input Signal(s)
	.arg0_dout(delay_4_arg0_data),
	.arg0_empty_n(delay_4_arg0_empty_n),
	.arg0_read(delay_4_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_4_arg1_data),
	.arg1_full_n(delay_4_arg1_full_n),
	.arg1_write(delay_4_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_5_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_5_arg0(
	.din(mdc_hls_fifo_native_delay_5_arg0_data),
	.empty_n(delay_5_arg0_empty_n),
	.read(delay_5_arg0_read),
	.dout(delay_5_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_5_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_5_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_5
delay actor_delay_5 (
	// Input Signal(s)
	.arg0_dout(delay_5_arg0_data),
	.arg0_empty_n(delay_5_arg0_empty_n),
	.arg0_read(delay_5_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_5_arg1_data),
	.arg1_full_n(delay_5_arg1_full_n),
	.arg1_write(delay_5_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_6_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_6_arg0(
	.din(mdc_hls_fifo_native_delay_6_arg0_data),
	.empty_n(delay_6_arg0_empty_n),
	.read(delay_6_arg0_read),
	.dout(delay_6_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_6_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_6_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_6
delay actor_delay_6 (
	// Input Signal(s)
	.arg0_dout(delay_6_arg0_data),
	.arg0_empty_n(delay_6_arg0_empty_n),
	.arg0_read(delay_6_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_6_arg1_data),
	.arg1_full_n(delay_6_arg1_full_n),
	.arg1_write(delay_6_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_delay_7_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_delay_7_arg0(
	.din(mdc_hls_fifo_native_delay_7_arg0_data),
	.empty_n(delay_7_arg0_empty_n),
	.read(delay_7_arg0_read),
	.dout(delay_7_arg0_data),
	.full_n(mdc_hls_fifo_native_delay_7_arg0_full_n),
	.write(mdc_hls_fifo_native_delay_7_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor delay_7
delay actor_delay_7 (
	// Input Signal(s)
	.arg0_dout(delay_7_arg0_data),
	.arg0_empty_n(delay_7_arg0_empty_n),
	.arg0_read(delay_7_arg0_read)
	,
	
	// Output Signal(s)
	.arg1_din(delay_7_arg1_data),
	.arg1_full_n(delay_7_arg1_full_n),
	.arg1_write(delay_7_arg1_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_sobel_x_0_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg0(
	.din(mdc_hls_fifo_native_sobel_x_0_arg0_data),
	.empty_n(sobel_x_0_arg0_empty_n),
	.read(sobel_x_0_arg0_read),
	.dout(sobel_x_0_arg0_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg0_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg1
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg1(
	.din(mdc_hls_fifo_native_sobel_x_0_arg1_data),
	.empty_n(sobel_x_0_arg1_empty_n),
	.read(sobel_x_0_arg1_read),
	.dout(sobel_x_0_arg1_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg1_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg2(
	.din(mdc_hls_fifo_native_sobel_x_0_arg2_data),
	.empty_n(sobel_x_0_arg2_empty_n),
	.read(sobel_x_0_arg2_read),
	.dout(sobel_x_0_arg2_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg2_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg3
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg3(
	.din(mdc_hls_fifo_native_sobel_x_0_arg3_data),
	.empty_n(sobel_x_0_arg3_empty_n),
	.read(sobel_x_0_arg3_read),
	.dout(sobel_x_0_arg3_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg3_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg3_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg4
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg4(
	.din(mdc_hls_fifo_native_sobel_x_0_arg4_data),
	.empty_n(sobel_x_0_arg4_empty_n),
	.read(sobel_x_0_arg4_read),
	.dout(sobel_x_0_arg4_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg4_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg4_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg5
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg5(
	.din(mdc_hls_fifo_native_sobel_x_0_arg5_data),
	.empty_n(sobel_x_0_arg5_empty_n),
	.read(sobel_x_0_arg5_read),
	.dout(sobel_x_0_arg5_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg5_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg5_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg6
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg6(
	.din(mdc_hls_fifo_native_sobel_x_0_arg6_data),
	.empty_n(sobel_x_0_arg6_empty_n),
	.read(sobel_x_0_arg6_read),
	.dout(sobel_x_0_arg6_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg6_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg6_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg7
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg7(
	.din(mdc_hls_fifo_native_sobel_x_0_arg7_data),
	.empty_n(sobel_x_0_arg7_empty_n),
	.read(sobel_x_0_arg7_read),
	.dout(sobel_x_0_arg7_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg7_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg7_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_x_0_arg8
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_x_0_arg8(
	.din(mdc_hls_fifo_native_sobel_x_0_arg8_data),
	.empty_n(sobel_x_0_arg8_empty_n),
	.read(sobel_x_0_arg8_read),
	.dout(sobel_x_0_arg8_data),
	.full_n(mdc_hls_fifo_native_sobel_x_0_arg8_full_n),
	.write(mdc_hls_fifo_native_sobel_x_0_arg8_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor sobel_x_0
sobel_x actor_sobel_x_0 (
	// Input Signal(s)
	.arg0_dout(sobel_x_0_arg0_data),
	.arg0_empty_n(sobel_x_0_arg0_empty_n),
	.arg0_read(sobel_x_0_arg0_read),
	.arg1_dout(sobel_x_0_arg1_data),
	.arg1_empty_n(sobel_x_0_arg1_empty_n),
	.arg1_read(sobel_x_0_arg1_read),
	.arg2_dout(sobel_x_0_arg2_data),
	.arg2_empty_n(sobel_x_0_arg2_empty_n),
	.arg2_read(sobel_x_0_arg2_read),
	.arg3_dout(sobel_x_0_arg3_data),
	.arg3_empty_n(sobel_x_0_arg3_empty_n),
	.arg3_read(sobel_x_0_arg3_read),
	.arg4_dout(sobel_x_0_arg4_data),
	.arg4_empty_n(sobel_x_0_arg4_empty_n),
	.arg4_read(sobel_x_0_arg4_read),
	.arg5_dout(sobel_x_0_arg5_data),
	.arg5_empty_n(sobel_x_0_arg5_empty_n),
	.arg5_read(sobel_x_0_arg5_read),
	.arg6_dout(sobel_x_0_arg6_data),
	.arg6_empty_n(sobel_x_0_arg6_empty_n),
	.arg6_read(sobel_x_0_arg6_read),
	.arg7_dout(sobel_x_0_arg7_data),
	.arg7_empty_n(sobel_x_0_arg7_empty_n),
	.arg7_read(sobel_x_0_arg7_read),
	.arg8_dout(sobel_x_0_arg8_data),
	.arg8_empty_n(sobel_x_0_arg8_empty_n),
	.arg8_read(sobel_x_0_arg8_read)
	,
	
	// Output Signal(s)
	.arg9_din(sobel_x_0_arg9_data),
	.arg9_full_n(sobel_x_0_arg9_full_n),
	.arg9_write(sobel_x_0_arg9_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_sobel_y_0_arg0
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg0(
	.din(mdc_hls_fifo_native_sobel_y_0_arg0_data),
	.empty_n(sobel_y_0_arg0_empty_n),
	.read(sobel_y_0_arg0_read),
	.dout(sobel_y_0_arg0_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg0_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg1
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg1(
	.din(mdc_hls_fifo_native_sobel_y_0_arg1_data),
	.empty_n(sobel_y_0_arg1_empty_n),
	.read(sobel_y_0_arg1_read),
	.dout(sobel_y_0_arg1_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg1_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg2
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg2(
	.din(mdc_hls_fifo_native_sobel_y_0_arg2_data),
	.empty_n(sobel_y_0_arg2_empty_n),
	.read(sobel_y_0_arg2_read),
	.dout(sobel_y_0_arg2_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg2_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg2_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg3
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg3(
	.din(mdc_hls_fifo_native_sobel_y_0_arg3_data),
	.empty_n(sobel_y_0_arg3_empty_n),
	.read(sobel_y_0_arg3_read),
	.dout(sobel_y_0_arg3_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg3_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg3_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg4
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg4(
	.din(mdc_hls_fifo_native_sobel_y_0_arg4_data),
	.empty_n(sobel_y_0_arg4_empty_n),
	.read(sobel_y_0_arg4_read),
	.dout(sobel_y_0_arg4_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg4_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg4_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg5
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg5(
	.din(mdc_hls_fifo_native_sobel_y_0_arg5_data),
	.empty_n(sobel_y_0_arg5_empty_n),
	.read(sobel_y_0_arg5_read),
	.dout(sobel_y_0_arg5_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg5_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg5_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg6
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg6(
	.din(mdc_hls_fifo_native_sobel_y_0_arg6_data),
	.empty_n(sobel_y_0_arg6_empty_n),
	.read(sobel_y_0_arg6_read),
	.dout(sobel_y_0_arg6_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg6_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg6_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg7
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg7(
	.din(mdc_hls_fifo_native_sobel_y_0_arg7_data),
	.empty_n(sobel_y_0_arg7_empty_n),
	.read(sobel_y_0_arg7_read),
	.dout(sobel_y_0_arg7_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg7_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg7_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_sobel_y_0_arg8
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_sobel_y_0_arg8(
	.din(mdc_hls_fifo_native_sobel_y_0_arg8_data),
	.empty_n(sobel_y_0_arg8_empty_n),
	.read(sobel_y_0_arg8_read),
	.dout(sobel_y_0_arg8_data),
	.full_n(mdc_hls_fifo_native_sobel_y_0_arg8_full_n),
	.write(mdc_hls_fifo_native_sobel_y_0_arg8_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor sobel_y_0
sobel_y actor_sobel_y_0 (
	// Input Signal(s)
	.arg0_dout(sobel_y_0_arg0_data),
	.arg0_empty_n(sobel_y_0_arg0_empty_n),
	.arg0_read(sobel_y_0_arg0_read),
	.arg1_dout(sobel_y_0_arg1_data),
	.arg1_empty_n(sobel_y_0_arg1_empty_n),
	.arg1_read(sobel_y_0_arg1_read),
	.arg2_dout(sobel_y_0_arg2_data),
	.arg2_empty_n(sobel_y_0_arg2_empty_n),
	.arg2_read(sobel_y_0_arg2_read),
	.arg3_dout(sobel_y_0_arg3_data),
	.arg3_empty_n(sobel_y_0_arg3_empty_n),
	.arg3_read(sobel_y_0_arg3_read),
	.arg4_dout(sobel_y_0_arg4_data),
	.arg4_empty_n(sobel_y_0_arg4_empty_n),
	.arg4_read(sobel_y_0_arg4_read),
	.arg5_dout(sobel_y_0_arg5_data),
	.arg5_empty_n(sobel_y_0_arg5_empty_n),
	.arg5_read(sobel_y_0_arg5_read),
	.arg6_dout(sobel_y_0_arg6_data),
	.arg6_empty_n(sobel_y_0_arg6_empty_n),
	.arg6_read(sobel_y_0_arg6_read),
	.arg7_dout(sobel_y_0_arg7_data),
	.arg7_empty_n(sobel_y_0_arg7_empty_n),
	.arg7_read(sobel_y_0_arg7_read),
	.arg8_dout(sobel_y_0_arg8_data),
	.arg8_empty_n(sobel_y_0_arg8_empty_n),
	.arg8_read(sobel_y_0_arg8_read)
	,
	
	// Output Signal(s)
	.arg9_din(sobel_y_0_arg9_data),
	.arg9_full_n(sobel_y_0_arg9_full_n),
	.arg9_write(sobel_y_0_arg9_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// mdc_hls_fifo_native_remove_3x3_0_arg0
mdc_hls_fifo_native #(
	.width(6),
	.depth(64)
) mdc_hls_fifo_native_remove_3x3_0_arg0(
	.din(mdc_hls_fifo_native_remove_3x3_0_arg0_data),
	.empty_n(remove_3x3_0_arg0_empty_n),
	.read(remove_3x3_0_arg0_read),
	.dout(remove_3x3_0_arg0_data),
	.full_n(mdc_hls_fifo_native_remove_3x3_0_arg0_full_n),
	.write(mdc_hls_fifo_native_remove_3x3_0_arg0_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);
// mdc_hls_fifo_native_remove_3x3_0_arg1
mdc_hls_fifo_native #(
	.width(8),
	.depth(64)
) mdc_hls_fifo_native_remove_3x3_0_arg1(
	.din(mdc_hls_fifo_native_remove_3x3_0_arg1_data),
	.empty_n(remove_3x3_0_arg1_empty_n),
	.read(remove_3x3_0_arg1_read),
	.dout(remove_3x3_0_arg1_data),
	.full_n(mdc_hls_fifo_native_remove_3x3_0_arg1_full_n),
	.write(mdc_hls_fifo_native_remove_3x3_0_arg1_write),
	
	// System Signal(s)
	.clk(ap_clk),
	.ap_rst(ap_rst)
);

// actor remove_3x3_0
remove_3x3 actor_remove_3x3_0 (
	// Input Signal(s)
	.arg0_dout(remove_3x3_0_arg0_data),
	.arg0_empty_n(remove_3x3_0_arg0_empty_n),
	.arg0_read(remove_3x3_0_arg0_read),
	.arg1_dout(remove_3x3_0_arg1_data),
	.arg1_empty_n(remove_3x3_0_arg1_empty_n),
	.arg1_read(remove_3x3_0_arg1_read)
	,
	
	// Output Signal(s)
	.arg2_din(remove_3x3_0_arg2_data),
	.arg2_full_n(remove_3x3_0_arg2_full_n),
	.arg2_write(remove_3x3_0_arg2_write)
		,
	
	// System Signal(s)
	.ap_clk(ap_clk),
	.ap_rst(ap_rst)
);



// actor sbox_0
sbox1x2 #(
	.SIZE(6)
)
sbox_0 (
	// Input Signal(s)
	.in1_data(sbox_0_in1_data),
	.in1_full_n(sbox_0_in1_full_n),
	.in1_write(sbox_0_in1_write),
	
	// Output Signal(s)
	.out1_data(sbox_0_out1_data),
	.out1_full_n(sbox_0_out1_full_n),
	.out1_write(sbox_0_out1_write),
	.out2_data(sbox_0_out2_data),
	.out2_full_n(sbox_0_out2_full_n),
	.out2_write(sbox_0_out2_write),
	
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
	.in1_full_n(sbox_1_in1_full_n),
	.in1_write(sbox_1_in1_write),
	
	// Output Signal(s)
	.out1_data(sbox_1_out1_data),
	.out1_full_n(sbox_1_out1_full_n),
	.out1_write(sbox_1_out1_write),
	.out2_data(sbox_1_out2_data),
	.out2_full_n(sbox_1_out2_full_n),
	.out2_write(sbox_1_out2_write),
	
	// Selector
	.sel(sel[1])	
);


// actor sbox_2
sbox1x2 #(
	.SIZE(8)
)
sbox_2 (
	// Input Signal(s)
	.in1_data(sbox_2_in1_data),
	.in1_full_n(sbox_2_in1_full_n),
	.in1_write(sbox_2_in1_write),
	
	// Output Signal(s)
	.out1_data(sbox_2_out1_data),
	.out1_full_n(sbox_2_out1_full_n),
	.out1_write(sbox_2_out1_write),
	.out2_data(sbox_2_out2_data),
	.out2_full_n(sbox_2_out2_full_n),
	.out2_write(sbox_2_out2_write),
	
	// Selector
	.sel(sel[2])	
);


// actor sbox_3
sbox2x1 #(
	.SIZE(8)
)
sbox_3 (
	// Input Signal(s)
	.in1_data(sbox_3_in1_data),
	.in1_full_n(sbox_3_in1_full_n),
	.in1_write(sbox_3_in1_write),
	.in2_data(sbox_3_in2_data),
	.in2_full_n(sbox_3_in2_full_n),
	.in2_write(sbox_3_in2_write),
	
	// Output Signal(s)
	.out1_data(sbox_3_out1_data),
	.out1_full_n(sbox_3_out1_full_n),
	.out1_write(sbox_3_out1_write),
	
	// Selector
	.sel(sel[3])	
);


// actor sbox_4
sbox2x1 #(
	.SIZE(14)
)
sbox_4 (
	// Input Signal(s)
	.in1_data(sbox_4_in1_data),
	.in1_full_n(sbox_4_in1_full_n),
	.in1_write(sbox_4_in1_write),
	.in2_data(sbox_4_in2_data),
	.in2_full_n(sbox_4_in2_full_n),
	.in2_write(sbox_4_in2_write),
	
	// Output Signal(s)
	.out1_data(sbox_4_out1_data),
	.out1_full_n(sbox_4_out1_full_n),
	.out1_write(sbox_4_out1_write),
	
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
	.in1_full_n(sbox_5_in1_full_n),
	.in1_write(sbox_5_in1_write),
	.in2_data(sbox_5_in2_data),
	.in2_full_n(sbox_5_in2_full_n),
	.in2_write(sbox_5_in2_write),
	
	// Output Signal(s)
	.out1_data(sbox_5_out1_data),
	.out1_full_n(sbox_5_out1_full_n),
	.out1_write(sbox_5_out1_write),
	
	// Selector
	.sel(sel[5])	
);

// Module(s) Assignments
assign sbox_0_in1_data = in0_data;
assign in0_full_n = sbox_0_in1_full_n;
assign sbox_0_in1_write = in0_write;

assign sbox_1_in1_data = in1_data;
assign in1_full_n = sbox_1_in1_full_n;
assign sbox_1_in1_write = in1_write;

assign mdc_hls_fifo_native_line_buffer_0_arg0_data = sbox_0_out1_data;
assign sbox_0_out1_full_n =
mdc_hls_fifo_native_line_buffer_0_arg0_full_n && 
mdc_hls_fifo_native_line_buffer_0_arg1_full_n && 
mdc_hls_fifo_native_remove_2x2_0_arg0_full_n 
;
assign mdc_hls_fifo_native_line_buffer_0_arg0_write = sbox_0_out1_write;

assign mdc_hls_fifo_native_line_buffer_0_arg1_data = sbox_0_out1_data;
assign mdc_hls_fifo_native_line_buffer_0_arg1_write = sbox_0_out1_write;

assign mdc_hls_fifo_native_line_buffer_0_arg2_data = sbox_1_out1_data;
assign sbox_1_out1_full_n =
mdc_hls_fifo_native_line_buffer_0_arg2_full_n && 
mdc_hls_fifo_native_delay_1_arg0_full_n && 
mdc_hls_fifo_native_roberts_x_0_arg3_full_n && 
mdc_hls_fifo_native_roberts_y_0_arg3_full_n 
;
assign mdc_hls_fifo_native_line_buffer_0_arg2_write = sbox_1_out1_write;

assign mdc_hls_fifo_native_remove_2x2_0_arg0_data = sbox_0_out1_data;
assign mdc_hls_fifo_native_remove_2x2_0_arg0_write = sbox_0_out1_write;

assign mdc_hls_fifo_native_remove_2x2_0_arg1_data = sbox_2_out1_data;
assign sbox_2_out1_full_n = mdc_hls_fifo_native_remove_2x2_0_arg1_full_n;
assign mdc_hls_fifo_native_remove_2x2_0_arg1_write = sbox_2_out1_write;

assign mdc_hls_fifo_native_line_buffer_1_arg0_data = sbox_0_out2_data;
assign sbox_0_out2_full_n =
mdc_hls_fifo_native_line_buffer_1_arg0_full_n && 
mdc_hls_fifo_native_line_buffer_1_arg1_full_n && 
mdc_hls_fifo_native_line_buffer_2_arg0_full_n && 
mdc_hls_fifo_native_line_buffer_2_arg1_full_n && 
mdc_hls_fifo_native_remove_3x3_0_arg0_full_n 
;
assign mdc_hls_fifo_native_line_buffer_1_arg0_write = sbox_0_out2_write;

assign mdc_hls_fifo_native_line_buffer_1_arg1_data = sbox_0_out2_data;
assign mdc_hls_fifo_native_line_buffer_1_arg1_write = sbox_0_out2_write;

assign mdc_hls_fifo_native_line_buffer_1_arg2_data = sbox_1_out2_data;
assign sbox_1_out2_full_n =
mdc_hls_fifo_native_line_buffer_1_arg2_full_n && 
mdc_hls_fifo_native_delay_6_arg0_full_n && 
mdc_hls_fifo_native_sobel_x_0_arg8_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg8_full_n 
;
assign mdc_hls_fifo_native_line_buffer_1_arg2_write = sbox_1_out2_write;

assign mdc_hls_fifo_native_line_buffer_2_arg0_data = sbox_0_out2_data;
assign mdc_hls_fifo_native_line_buffer_2_arg0_write = sbox_0_out2_write;

assign mdc_hls_fifo_native_line_buffer_2_arg1_data = sbox_0_out2_data;
assign mdc_hls_fifo_native_line_buffer_2_arg1_write = sbox_0_out2_write;

assign mdc_hls_fifo_native_line_buffer_2_arg2_data = line_buffer_1_arg3_data;
assign line_buffer_1_arg3_full_n =
mdc_hls_fifo_native_line_buffer_2_arg2_full_n && 
mdc_hls_fifo_native_sobel_x_0_arg5_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg5_full_n && 
mdc_hls_fifo_native_delay_4_arg0_full_n 
;
assign mdc_hls_fifo_native_line_buffer_2_arg2_write = line_buffer_1_arg3_write;

assign mdc_hls_fifo_native_remove_3x3_0_arg0_data = sbox_0_out2_data;
assign mdc_hls_fifo_native_remove_3x3_0_arg0_write = sbox_0_out2_write;

assign mdc_hls_fifo_native_remove_3x3_0_arg1_data = sbox_2_out2_data;
assign sbox_2_out2_full_n = mdc_hls_fifo_native_remove_3x3_0_arg1_full_n;
assign mdc_hls_fifo_native_remove_3x3_0_arg1_write = sbox_2_out2_write;

assign mdc_hls_fifo_native_delay_1_arg0_data = sbox_1_out1_data;
assign mdc_hls_fifo_native_delay_1_arg0_write = sbox_1_out1_write;

assign mdc_hls_fifo_native_roberts_x_0_arg0_data = delay_0_arg1_data;
assign delay_0_arg1_full_n =
mdc_hls_fifo_native_roberts_x_0_arg0_full_n && 
mdc_hls_fifo_native_roberts_y_0_arg0_full_n 
;
assign mdc_hls_fifo_native_roberts_x_0_arg0_write = delay_0_arg1_write;

assign mdc_hls_fifo_native_roberts_x_0_arg1_data = line_buffer_0_arg3_data;
assign line_buffer_0_arg3_full_n =
mdc_hls_fifo_native_roberts_x_0_arg1_full_n && 
mdc_hls_fifo_native_roberts_y_0_arg1_full_n && 
mdc_hls_fifo_native_delay_0_arg0_full_n 
;
assign mdc_hls_fifo_native_roberts_x_0_arg1_write = line_buffer_0_arg3_write;

assign mdc_hls_fifo_native_roberts_x_0_arg2_data = delay_1_arg1_data;
assign delay_1_arg1_full_n =
mdc_hls_fifo_native_roberts_x_0_arg2_full_n && 
mdc_hls_fifo_native_roberts_y_0_arg2_full_n 
;
assign mdc_hls_fifo_native_roberts_x_0_arg2_write = delay_1_arg1_write;

assign mdc_hls_fifo_native_roberts_x_0_arg3_data = sbox_1_out1_data;
assign mdc_hls_fifo_native_roberts_x_0_arg3_write = sbox_1_out1_write;

assign mdc_hls_fifo_native_roberts_y_0_arg0_data = delay_0_arg1_data;
assign mdc_hls_fifo_native_roberts_y_0_arg0_write = delay_0_arg1_write;

assign mdc_hls_fifo_native_roberts_y_0_arg1_data = line_buffer_0_arg3_data;
assign mdc_hls_fifo_native_roberts_y_0_arg1_write = line_buffer_0_arg3_write;

assign mdc_hls_fifo_native_roberts_y_0_arg2_data = delay_1_arg1_data;
assign mdc_hls_fifo_native_roberts_y_0_arg2_write = delay_1_arg1_write;

assign mdc_hls_fifo_native_roberts_y_0_arg3_data = sbox_1_out1_data;
assign mdc_hls_fifo_native_roberts_y_0_arg3_write = sbox_1_out1_write;

assign mdc_hls_fifo_native_delay_6_arg0_data = sbox_1_out2_data;
assign mdc_hls_fifo_native_delay_6_arg0_write = sbox_1_out2_write;

assign mdc_hls_fifo_native_sobel_x_0_arg0_data = delay_3_arg1_data;
assign delay_3_arg1_full_n =
mdc_hls_fifo_native_sobel_x_0_arg0_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg0_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg0_write = delay_3_arg1_write;

assign mdc_hls_fifo_native_sobel_x_0_arg1_data = delay_2_arg1_data;
assign delay_2_arg1_full_n =
mdc_hls_fifo_native_sobel_x_0_arg1_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg1_full_n && 
mdc_hls_fifo_native_delay_3_arg0_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg1_write = delay_2_arg1_write;

assign mdc_hls_fifo_native_sobel_x_0_arg2_data = line_buffer_2_arg3_data;
assign line_buffer_2_arg3_full_n =
mdc_hls_fifo_native_sobel_x_0_arg2_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg2_full_n && 
mdc_hls_fifo_native_delay_2_arg0_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg2_write = line_buffer_2_arg3_write;

assign mdc_hls_fifo_native_sobel_x_0_arg3_data = delay_5_arg1_data;
assign delay_5_arg1_full_n =
mdc_hls_fifo_native_sobel_x_0_arg3_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg3_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg3_write = delay_5_arg1_write;

assign mdc_hls_fifo_native_sobel_x_0_arg4_data = delay_4_arg1_data;
assign delay_4_arg1_full_n =
mdc_hls_fifo_native_sobel_x_0_arg4_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg4_full_n && 
mdc_hls_fifo_native_delay_5_arg0_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg4_write = delay_4_arg1_write;

assign mdc_hls_fifo_native_sobel_x_0_arg5_data = line_buffer_1_arg3_data;
assign mdc_hls_fifo_native_sobel_x_0_arg5_write = line_buffer_1_arg3_write;

assign mdc_hls_fifo_native_sobel_x_0_arg6_data = delay_7_arg1_data;
assign delay_7_arg1_full_n =
mdc_hls_fifo_native_sobel_x_0_arg6_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg6_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg6_write = delay_7_arg1_write;

assign mdc_hls_fifo_native_sobel_x_0_arg7_data = delay_6_arg1_data;
assign delay_6_arg1_full_n =
mdc_hls_fifo_native_sobel_x_0_arg7_full_n && 
mdc_hls_fifo_native_sobel_y_0_arg7_full_n && 
mdc_hls_fifo_native_delay_7_arg0_full_n 
;
assign mdc_hls_fifo_native_sobel_x_0_arg7_write = delay_6_arg1_write;

assign mdc_hls_fifo_native_sobel_x_0_arg8_data = sbox_1_out2_data;
assign mdc_hls_fifo_native_sobel_x_0_arg8_write = sbox_1_out2_write;

assign mdc_hls_fifo_native_sobel_y_0_arg0_data = delay_3_arg1_data;
assign mdc_hls_fifo_native_sobel_y_0_arg0_write = delay_3_arg1_write;

assign mdc_hls_fifo_native_sobel_y_0_arg1_data = delay_2_arg1_data;
assign mdc_hls_fifo_native_sobel_y_0_arg1_write = delay_2_arg1_write;

assign mdc_hls_fifo_native_sobel_y_0_arg2_data = line_buffer_2_arg3_data;
assign mdc_hls_fifo_native_sobel_y_0_arg2_write = line_buffer_2_arg3_write;

assign mdc_hls_fifo_native_sobel_y_0_arg3_data = delay_5_arg1_data;
assign mdc_hls_fifo_native_sobel_y_0_arg3_write = delay_5_arg1_write;

assign mdc_hls_fifo_native_sobel_y_0_arg4_data = delay_4_arg1_data;
assign mdc_hls_fifo_native_sobel_y_0_arg4_write = delay_4_arg1_write;

assign mdc_hls_fifo_native_sobel_y_0_arg5_data = line_buffer_1_arg3_data;
assign mdc_hls_fifo_native_sobel_y_0_arg5_write = line_buffer_1_arg3_write;

assign mdc_hls_fifo_native_sobel_y_0_arg6_data = delay_7_arg1_data;
assign mdc_hls_fifo_native_sobel_y_0_arg6_write = delay_7_arg1_write;

assign mdc_hls_fifo_native_sobel_y_0_arg7_data = delay_6_arg1_data;
assign mdc_hls_fifo_native_sobel_y_0_arg7_write = delay_6_arg1_write;

assign mdc_hls_fifo_native_sobel_y_0_arg8_data = sbox_1_out2_data;
assign mdc_hls_fifo_native_sobel_y_0_arg8_write = sbox_1_out2_write;

assign mdc_hls_fifo_native_delay_0_arg0_data = line_buffer_0_arg3_data;
assign mdc_hls_fifo_native_delay_0_arg0_write = line_buffer_0_arg3_write;

assign sbox_3_in1_data = remove_2x2_0_arg2_data;
assign remove_2x2_0_arg2_full_n = sbox_3_in1_full_n;
assign sbox_3_in1_write = remove_2x2_0_arg2_write;

assign sbox_3_in2_data = remove_3x3_0_arg2_data;
assign remove_3x3_0_arg2_full_n = sbox_3_in2_full_n;
assign sbox_3_in2_write = remove_3x3_0_arg2_write;

assign mdc_hls_fifo_native_delay_4_arg0_data = line_buffer_1_arg3_data;
assign mdc_hls_fifo_native_delay_4_arg0_write = line_buffer_1_arg3_write;

assign mdc_hls_fifo_native_delay_2_arg0_data = line_buffer_2_arg3_data;
assign mdc_hls_fifo_native_delay_2_arg0_write = line_buffer_2_arg3_write;

assign sbox_4_in1_data = roberts_x_0_arg4_data;
assign roberts_x_0_arg4_full_n = sbox_4_in1_full_n;
assign sbox_4_in1_write = roberts_x_0_arg4_write;

assign sbox_4_in2_data = sobel_x_0_arg9_data;
assign sobel_x_0_arg9_full_n = sbox_4_in2_full_n;
assign sbox_4_in2_write = sobel_x_0_arg9_write;

assign sbox_5_in1_data = roberts_y_0_arg4_data;
assign roberts_y_0_arg4_full_n = sbox_5_in1_full_n;
assign sbox_5_in1_write = roberts_y_0_arg4_write;

assign sbox_5_in2_data = sobel_y_0_arg9_data;
assign sobel_y_0_arg9_full_n = sbox_5_in2_full_n;
assign sbox_5_in2_write = sobel_y_0_arg9_write;

assign mdc_hls_fifo_native_delay_7_arg0_data = delay_6_arg1_data;
assign mdc_hls_fifo_native_delay_7_arg0_write = delay_6_arg1_write;

assign out0_data = sbox_3_out1_data;
assign sbox_3_out1_full_n = out0_full_n;
assign out0_write = sbox_3_out1_write;

assign mdc_hls_fifo_native_delay_5_arg0_data = delay_4_arg1_data;
assign mdc_hls_fifo_native_delay_5_arg0_write = delay_4_arg1_write;

assign mdc_hls_fifo_native_delay_3_arg0_data = delay_2_arg1_data;
assign mdc_hls_fifo_native_delay_3_arg0_write = delay_2_arg1_write;

assign mdc_hls_fifo_native_abs_sum_0_arg0_data = sbox_4_out1_data;
assign sbox_4_out1_full_n = mdc_hls_fifo_native_abs_sum_0_arg0_full_n;
assign mdc_hls_fifo_native_abs_sum_0_arg0_write = sbox_4_out1_write;

assign mdc_hls_fifo_native_abs_sum_0_arg1_data = sbox_5_out1_data;
assign sbox_5_out1_full_n = mdc_hls_fifo_native_abs_sum_0_arg1_full_n;
assign mdc_hls_fifo_native_abs_sum_0_arg1_write = sbox_5_out1_write;

assign mdc_hls_fifo_native_thr_0_arg0_data = abs_sum_0_arg2_data;
assign abs_sum_0_arg2_full_n = mdc_hls_fifo_native_thr_0_arg0_full_n;
assign mdc_hls_fifo_native_thr_0_arg0_write = abs_sum_0_arg2_write;

assign sbox_2_in1_data = thr_0_arg1_data;
assign thr_0_arg1_full_n = sbox_2_in1_full_n;
assign sbox_2_in1_write = thr_0_arg1_write;

endmodule
