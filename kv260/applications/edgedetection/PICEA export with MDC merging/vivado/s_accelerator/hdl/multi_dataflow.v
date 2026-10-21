// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Network module 
// Date: 2026/09/18 19:41:37
//
// ----------------------------------------------------------------------------

module multi_dataflow (
	// Input(s)
	input [7 : 0] in_pel_data,
	input in_pel_wr,
	output in_pel_full,
	
	// Output(s)
	input [5 : 0] in_size_data,
	input in_size_wr,
	output in_size_full,
	
	// Output(s)
	output [7 : 0] out_pel_data,
	output out_pel_wr,
	input out_pel_full,
	
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
	
// actor remove_2x2_0
wire [5 : 0] fifo_big_remove_2x2_0_in_size_data;
wire fifo_big_remove_2x2_0_in_size_wr;
wire fifo_big_remove_2x2_0_in_size_full;
wire [5 : 0] remove_2x2_0_in_size_data;
wire remove_2x2_0_in_size_rd;
wire remove_2x2_0_in_size_empty;
wire [7 : 0] fifo_big_remove_2x2_0_in_pel_data;
wire fifo_big_remove_2x2_0_in_pel_wr;
wire fifo_big_remove_2x2_0_in_pel_full;
wire [7 : 0] remove_2x2_0_in_pel_data;
wire remove_2x2_0_in_pel_rd;
wire remove_2x2_0_in_pel_empty;
wire [7 : 0] remove_2x2_0_out_pel_data;
wire remove_2x2_0_out_pel_wr;
wire remove_2x2_0_out_pel_full;
	
// actor delay_0
wire [7 : 0] fifo_big_delay_0_in_pel_data;
wire fifo_big_delay_0_in_pel_wr;
wire fifo_big_delay_0_in_pel_full;
wire [7 : 0] delay_0_in_pel_data;
wire delay_0_in_pel_rd;
wire delay_0_in_pel_empty;
wire [7 : 0] delay_0_out_pel_data;
wire delay_0_out_pel_wr;
wire delay_0_out_pel_full;
	
// actor roberts_y_0
wire [7 : 0] fifo_big_roberts_y_0_pel00_data;
wire fifo_big_roberts_y_0_pel00_wr;
wire fifo_big_roberts_y_0_pel00_full;
wire [7 : 0] roberts_y_0_pel00_data;
wire roberts_y_0_pel00_rd;
wire roberts_y_0_pel00_empty;
wire [7 : 0] fifo_big_roberts_y_0_pel01_data;
wire fifo_big_roberts_y_0_pel01_wr;
wire fifo_big_roberts_y_0_pel01_full;
wire [7 : 0] roberts_y_0_pel01_data;
wire roberts_y_0_pel01_rd;
wire roberts_y_0_pel01_empty;
wire [7 : 0] fifo_big_roberts_y_0_pel10_data;
wire fifo_big_roberts_y_0_pel10_wr;
wire fifo_big_roberts_y_0_pel10_full;
wire [7 : 0] roberts_y_0_pel10_data;
wire roberts_y_0_pel10_rd;
wire roberts_y_0_pel10_empty;
wire [7 : 0] fifo_big_roberts_y_0_pel11_data;
wire fifo_big_roberts_y_0_pel11_wr;
wire fifo_big_roberts_y_0_pel11_full;
wire [7 : 0] roberts_y_0_pel11_data;
wire roberts_y_0_pel11_rd;
wire roberts_y_0_pel11_empty;
wire [13 : 0] roberts_y_0_out_pel_data;
wire roberts_y_0_out_pel_wr;
wire roberts_y_0_out_pel_full;
	
// actor line_buffer_0
wire [5 : 0] fifo_big_line_buffer_0_real_size_data;
wire fifo_big_line_buffer_0_real_size_wr;
wire fifo_big_line_buffer_0_real_size_full;
wire [5 : 0] line_buffer_0_real_size_data;
wire line_buffer_0_real_size_rd;
wire line_buffer_0_real_size_empty;
wire [5 : 0] fifo_big_line_buffer_0_ext_size_data;
wire fifo_big_line_buffer_0_ext_size_wr;
wire fifo_big_line_buffer_0_ext_size_full;
wire [5 : 0] line_buffer_0_ext_size_data;
wire line_buffer_0_ext_size_rd;
wire line_buffer_0_ext_size_empty;
wire [7 : 0] fifo_big_line_buffer_0_in_pel_data;
wire fifo_big_line_buffer_0_in_pel_wr;
wire fifo_big_line_buffer_0_in_pel_full;
wire [7 : 0] line_buffer_0_in_pel_data;
wire line_buffer_0_in_pel_rd;
wire line_buffer_0_in_pel_empty;
wire [7 : 0] line_buffer_0_out_pel_data;
wire line_buffer_0_out_pel_wr;
wire line_buffer_0_out_pel_full;
	
// actor roberts_x_0
wire [7 : 0] fifo_big_roberts_x_0_pel00_data;
wire fifo_big_roberts_x_0_pel00_wr;
wire fifo_big_roberts_x_0_pel00_full;
wire [7 : 0] roberts_x_0_pel00_data;
wire roberts_x_0_pel00_rd;
wire roberts_x_0_pel00_empty;
wire [7 : 0] fifo_big_roberts_x_0_pel01_data;
wire fifo_big_roberts_x_0_pel01_wr;
wire fifo_big_roberts_x_0_pel01_full;
wire [7 : 0] roberts_x_0_pel01_data;
wire roberts_x_0_pel01_rd;
wire roberts_x_0_pel01_empty;
wire [7 : 0] fifo_big_roberts_x_0_pel10_data;
wire fifo_big_roberts_x_0_pel10_wr;
wire fifo_big_roberts_x_0_pel10_full;
wire [7 : 0] roberts_x_0_pel10_data;
wire roberts_x_0_pel10_rd;
wire roberts_x_0_pel10_empty;
wire [7 : 0] fifo_big_roberts_x_0_pel11_data;
wire fifo_big_roberts_x_0_pel11_wr;
wire fifo_big_roberts_x_0_pel11_full;
wire [7 : 0] roberts_x_0_pel11_data;
wire roberts_x_0_pel11_rd;
wire roberts_x_0_pel11_empty;
wire [13 : 0] roberts_x_0_out_pel_data;
wire roberts_x_0_out_pel_wr;
wire roberts_x_0_out_pel_full;
	
// actor delay_1
wire [7 : 0] fifo_big_delay_1_in_pel_data;
wire fifo_big_delay_1_in_pel_wr;
wire fifo_big_delay_1_in_pel_full;
wire [7 : 0] delay_1_in_pel_data;
wire delay_1_in_pel_rd;
wire delay_1_in_pel_empty;
wire [7 : 0] delay_1_out_pel_data;
wire delay_1_out_pel_wr;
wire delay_1_out_pel_full;
	
// actor thr_0
wire [13 : 0] fifo_big_thr_0_in_g_data;
wire fifo_big_thr_0_in_g_wr;
wire fifo_big_thr_0_in_g_full;
wire [13 : 0] thr_0_in_g_data;
wire thr_0_in_g_rd;
wire thr_0_in_g_empty;
wire [7 : 0] thr_0_out_pel_data;
wire thr_0_out_pel_wr;
wire thr_0_out_pel_full;
	
// actor abs_sum_0
wire [13 : 0] fifo_big_abs_sum_0_in_gx_data;
wire fifo_big_abs_sum_0_in_gx_wr;
wire fifo_big_abs_sum_0_in_gx_full;
wire [13 : 0] abs_sum_0_in_gx_data;
wire abs_sum_0_in_gx_rd;
wire abs_sum_0_in_gx_empty;
wire [13 : 0] fifo_big_abs_sum_0_in_gy_data;
wire fifo_big_abs_sum_0_in_gy_wr;
wire fifo_big_abs_sum_0_in_gy_full;
wire [13 : 0] abs_sum_0_in_gy_data;
wire abs_sum_0_in_gy_rd;
wire abs_sum_0_in_gy_empty;
wire [13 : 0] abs_sum_0_out_g_data;
wire abs_sum_0_out_g_wr;
wire abs_sum_0_out_g_full;
	
// actor delay_2
wire [7 : 0] fifo_big_delay_2_in_pel_data;
wire fifo_big_delay_2_in_pel_wr;
wire fifo_big_delay_2_in_pel_full;
wire [7 : 0] delay_2_in_pel_data;
wire delay_2_in_pel_rd;
wire delay_2_in_pel_empty;
wire [7 : 0] delay_2_out_pel_data;
wire delay_2_out_pel_wr;
wire delay_2_out_pel_full;
	
// actor sobel_y_0
wire [7 : 0] fifo_big_sobel_y_0_pel00_data;
wire fifo_big_sobel_y_0_pel00_wr;
wire fifo_big_sobel_y_0_pel00_full;
wire [7 : 0] sobel_y_0_pel00_data;
wire sobel_y_0_pel00_rd;
wire sobel_y_0_pel00_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel01_data;
wire fifo_big_sobel_y_0_pel01_wr;
wire fifo_big_sobel_y_0_pel01_full;
wire [7 : 0] sobel_y_0_pel01_data;
wire sobel_y_0_pel01_rd;
wire sobel_y_0_pel01_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel02_data;
wire fifo_big_sobel_y_0_pel02_wr;
wire fifo_big_sobel_y_0_pel02_full;
wire [7 : 0] sobel_y_0_pel02_data;
wire sobel_y_0_pel02_rd;
wire sobel_y_0_pel02_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel10_data;
wire fifo_big_sobel_y_0_pel10_wr;
wire fifo_big_sobel_y_0_pel10_full;
wire [7 : 0] sobel_y_0_pel10_data;
wire sobel_y_0_pel10_rd;
wire sobel_y_0_pel10_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel11_data;
wire fifo_big_sobel_y_0_pel11_wr;
wire fifo_big_sobel_y_0_pel11_full;
wire [7 : 0] sobel_y_0_pel11_data;
wire sobel_y_0_pel11_rd;
wire sobel_y_0_pel11_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel12_data;
wire fifo_big_sobel_y_0_pel12_wr;
wire fifo_big_sobel_y_0_pel12_full;
wire [7 : 0] sobel_y_0_pel12_data;
wire sobel_y_0_pel12_rd;
wire sobel_y_0_pel12_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel20_data;
wire fifo_big_sobel_y_0_pel20_wr;
wire fifo_big_sobel_y_0_pel20_full;
wire [7 : 0] sobel_y_0_pel20_data;
wire sobel_y_0_pel20_rd;
wire sobel_y_0_pel20_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel21_data;
wire fifo_big_sobel_y_0_pel21_wr;
wire fifo_big_sobel_y_0_pel21_full;
wire [7 : 0] sobel_y_0_pel21_data;
wire sobel_y_0_pel21_rd;
wire sobel_y_0_pel21_empty;
wire [7 : 0] fifo_big_sobel_y_0_pel22_data;
wire fifo_big_sobel_y_0_pel22_wr;
wire fifo_big_sobel_y_0_pel22_full;
wire [7 : 0] sobel_y_0_pel22_data;
wire sobel_y_0_pel22_rd;
wire sobel_y_0_pel22_empty;
wire [13 : 0] sobel_y_0_out_pel_data;
wire sobel_y_0_out_pel_wr;
wire sobel_y_0_out_pel_full;
	
// actor delay_3
wire [7 : 0] fifo_big_delay_3_in_pel_data;
wire fifo_big_delay_3_in_pel_wr;
wire fifo_big_delay_3_in_pel_full;
wire [7 : 0] delay_3_in_pel_data;
wire delay_3_in_pel_rd;
wire delay_3_in_pel_empty;
wire [7 : 0] delay_3_out_pel_data;
wire delay_3_out_pel_wr;
wire delay_3_out_pel_full;
	
// actor sobel_x_0
wire [7 : 0] fifo_big_sobel_x_0_pel00_data;
wire fifo_big_sobel_x_0_pel00_wr;
wire fifo_big_sobel_x_0_pel00_full;
wire [7 : 0] sobel_x_0_pel00_data;
wire sobel_x_0_pel00_rd;
wire sobel_x_0_pel00_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel01_data;
wire fifo_big_sobel_x_0_pel01_wr;
wire fifo_big_sobel_x_0_pel01_full;
wire [7 : 0] sobel_x_0_pel01_data;
wire sobel_x_0_pel01_rd;
wire sobel_x_0_pel01_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel02_data;
wire fifo_big_sobel_x_0_pel02_wr;
wire fifo_big_sobel_x_0_pel02_full;
wire [7 : 0] sobel_x_0_pel02_data;
wire sobel_x_0_pel02_rd;
wire sobel_x_0_pel02_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel10_data;
wire fifo_big_sobel_x_0_pel10_wr;
wire fifo_big_sobel_x_0_pel10_full;
wire [7 : 0] sobel_x_0_pel10_data;
wire sobel_x_0_pel10_rd;
wire sobel_x_0_pel10_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel11_data;
wire fifo_big_sobel_x_0_pel11_wr;
wire fifo_big_sobel_x_0_pel11_full;
wire [7 : 0] sobel_x_0_pel11_data;
wire sobel_x_0_pel11_rd;
wire sobel_x_0_pel11_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel12_data;
wire fifo_big_sobel_x_0_pel12_wr;
wire fifo_big_sobel_x_0_pel12_full;
wire [7 : 0] sobel_x_0_pel12_data;
wire sobel_x_0_pel12_rd;
wire sobel_x_0_pel12_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel20_data;
wire fifo_big_sobel_x_0_pel20_wr;
wire fifo_big_sobel_x_0_pel20_full;
wire [7 : 0] sobel_x_0_pel20_data;
wire sobel_x_0_pel20_rd;
wire sobel_x_0_pel20_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel21_data;
wire fifo_big_sobel_x_0_pel21_wr;
wire fifo_big_sobel_x_0_pel21_full;
wire [7 : 0] sobel_x_0_pel21_data;
wire sobel_x_0_pel21_rd;
wire sobel_x_0_pel21_empty;
wire [7 : 0] fifo_big_sobel_x_0_pel22_data;
wire fifo_big_sobel_x_0_pel22_wr;
wire fifo_big_sobel_x_0_pel22_full;
wire [7 : 0] sobel_x_0_pel22_data;
wire sobel_x_0_pel22_rd;
wire sobel_x_0_pel22_empty;
wire [13 : 0] sobel_x_0_out_pel_data;
wire sobel_x_0_out_pel_wr;
wire sobel_x_0_out_pel_full;
	
// actor line_buffer_1
wire [5 : 0] fifo_big_line_buffer_1_real_size_data;
wire fifo_big_line_buffer_1_real_size_wr;
wire fifo_big_line_buffer_1_real_size_full;
wire [5 : 0] line_buffer_1_real_size_data;
wire line_buffer_1_real_size_rd;
wire line_buffer_1_real_size_empty;
wire [5 : 0] fifo_big_line_buffer_1_ext_size_data;
wire fifo_big_line_buffer_1_ext_size_wr;
wire fifo_big_line_buffer_1_ext_size_full;
wire [5 : 0] line_buffer_1_ext_size_data;
wire line_buffer_1_ext_size_rd;
wire line_buffer_1_ext_size_empty;
wire [7 : 0] fifo_big_line_buffer_1_in_pel_data;
wire fifo_big_line_buffer_1_in_pel_wr;
wire fifo_big_line_buffer_1_in_pel_full;
wire [7 : 0] line_buffer_1_in_pel_data;
wire line_buffer_1_in_pel_rd;
wire line_buffer_1_in_pel_empty;
wire [7 : 0] line_buffer_1_out_pel_data;
wire line_buffer_1_out_pel_wr;
wire line_buffer_1_out_pel_full;
	
// actor delay_4
wire [7 : 0] fifo_big_delay_4_in_pel_data;
wire fifo_big_delay_4_in_pel_wr;
wire fifo_big_delay_4_in_pel_full;
wire [7 : 0] delay_4_in_pel_data;
wire delay_4_in_pel_rd;
wire delay_4_in_pel_empty;
wire [7 : 0] delay_4_out_pel_data;
wire delay_4_out_pel_wr;
wire delay_4_out_pel_full;
	
// actor delay_5
wire [7 : 0] fifo_big_delay_5_in_pel_data;
wire fifo_big_delay_5_in_pel_wr;
wire fifo_big_delay_5_in_pel_full;
wire [7 : 0] delay_5_in_pel_data;
wire delay_5_in_pel_rd;
wire delay_5_in_pel_empty;
wire [7 : 0] delay_5_out_pel_data;
wire delay_5_out_pel_wr;
wire delay_5_out_pel_full;
	
// actor remove_3x3_0
wire [5 : 0] fifo_big_remove_3x3_0_in_size_data;
wire fifo_big_remove_3x3_0_in_size_wr;
wire fifo_big_remove_3x3_0_in_size_full;
wire [5 : 0] remove_3x3_0_in_size_data;
wire remove_3x3_0_in_size_rd;
wire remove_3x3_0_in_size_empty;
wire [7 : 0] fifo_big_remove_3x3_0_in_pel_data;
wire fifo_big_remove_3x3_0_in_pel_wr;
wire fifo_big_remove_3x3_0_in_pel_full;
wire [7 : 0] remove_3x3_0_in_pel_data;
wire remove_3x3_0_in_pel_rd;
wire remove_3x3_0_in_pel_empty;
wire [7 : 0] remove_3x3_0_out_pel_data;
wire remove_3x3_0_out_pel_wr;
wire remove_3x3_0_out_pel_full;
	
// actor line_buffer_2
wire [5 : 0] fifo_big_line_buffer_2_real_size_data;
wire fifo_big_line_buffer_2_real_size_wr;
wire fifo_big_line_buffer_2_real_size_full;
wire [5 : 0] line_buffer_2_real_size_data;
wire line_buffer_2_real_size_rd;
wire line_buffer_2_real_size_empty;
wire [5 : 0] fifo_big_line_buffer_2_ext_size_data;
wire fifo_big_line_buffer_2_ext_size_wr;
wire fifo_big_line_buffer_2_ext_size_full;
wire [5 : 0] line_buffer_2_ext_size_data;
wire line_buffer_2_ext_size_rd;
wire line_buffer_2_ext_size_empty;
wire [7 : 0] fifo_big_line_buffer_2_in_pel_data;
wire fifo_big_line_buffer_2_in_pel_wr;
wire fifo_big_line_buffer_2_in_pel_full;
wire [7 : 0] line_buffer_2_in_pel_data;
wire line_buffer_2_in_pel_rd;
wire line_buffer_2_in_pel_empty;
wire [7 : 0] line_buffer_2_out_pel_data;
wire line_buffer_2_out_pel_wr;
wire line_buffer_2_out_pel_full;
	
// actor delay_6
wire [7 : 0] fifo_big_delay_6_in_pel_data;
wire fifo_big_delay_6_in_pel_wr;
wire fifo_big_delay_6_in_pel_full;
wire [7 : 0] delay_6_in_pel_data;
wire delay_6_in_pel_rd;
wire delay_6_in_pel_empty;
wire [7 : 0] delay_6_out_pel_data;
wire delay_6_out_pel_wr;
wire delay_6_out_pel_full;
	
// actor delay_7
wire [7 : 0] fifo_big_delay_7_in_pel_data;
wire fifo_big_delay_7_in_pel_wr;
wire fifo_big_delay_7_in_pel_full;
wire [7 : 0] delay_7_in_pel_data;
wire delay_7_in_pel_rd;
wire delay_7_in_pel_empty;
wire [7 : 0] delay_7_out_pel_data;
wire delay_7_out_pel_wr;
wire delay_7_out_pel_full;
	
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
wire [5 : 0] sbox_1_in1_data;
wire sbox_1_in1_wr;
wire sbox_1_in1_full;
wire [5 : 0] sbox_1_out1_data;
wire sbox_1_out1_wr;
wire sbox_1_out1_full;
wire [5 : 0] sbox_1_out2_data;
wire sbox_1_out2_wr;
wire sbox_1_out2_full;
	
// actor sbox_2
wire [7 : 0] sbox_2_in1_data;
wire sbox_2_in1_wr;
wire sbox_2_in1_full;
wire [7 : 0] sbox_2_out1_data;
wire sbox_2_out1_wr;
wire sbox_2_out1_full;
wire [7 : 0] sbox_2_out2_data;
wire sbox_2_out2_wr;
wire sbox_2_out2_full;
	
// actor sbox_3
wire [7 : 0] sbox_3_in1_data;
wire sbox_3_in1_wr;
wire sbox_3_in1_full;
wire [7 : 0] sbox_3_out1_data;
wire sbox_3_out1_wr;
wire sbox_3_out1_full;
wire [7 : 0] sbox_3_out2_data;
wire sbox_3_out2_wr;
wire sbox_3_out2_full;
	
// actor sbox_4
wire [13 : 0] sbox_4_in1_data;
wire sbox_4_in1_wr;
wire sbox_4_in1_full;
wire [13 : 0] sbox_4_in2_data;
wire sbox_4_in2_wr;
wire sbox_4_in2_full;
wire [13 : 0] sbox_4_out1_data;
wire sbox_4_out1_wr;
wire sbox_4_out1_full;
	
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
// ----------------------------------------------------------------------------

// body
// ----------------------------------------------------------------------------
// Network Configurator
configurator config_0 (
	.sel(sel),
	.ID(ID)
);




// fifo_big_remove_2x2_0_in_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_remove_2x2_0_in_size(
	.datain(fifo_big_remove_2x2_0_in_size_data),
	.dataout(remove_2x2_0_in_size_data),
	.enr(remove_2x2_0_in_size_rd),
	.enw(fifo_big_remove_2x2_0_in_size_wr),
	.empty(remove_2x2_0_in_size_empty),
	.full(fifo_big_remove_2x2_0_in_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_remove_2x2_0_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_remove_2x2_0_in_pel(
	.datain(fifo_big_remove_2x2_0_in_pel_data),
	.dataout(remove_2x2_0_in_pel_data),
	.enr(remove_2x2_0_in_pel_rd),
	.enw(fifo_big_remove_2x2_0_in_pel_wr),
	.empty(remove_2x2_0_in_pel_empty),
	.full(fifo_big_remove_2x2_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor remove_2x2_0
remove_2x2 actor_remove_2x2_0 (
	// Input Signal(s)
	.in_size(remove_2x2_0_in_size_data),
	.in_size_rd(remove_2x2_0_in_size_rd),
	.in_size_empty(remove_2x2_0_in_size_empty),
	.in_pel(remove_2x2_0_in_pel_data),
	.in_pel_rd(remove_2x2_0_in_pel_rd),
	.in_pel_empty(remove_2x2_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(remove_2x2_0_out_pel_data),
	.out_pel_wr(remove_2x2_0_out_pel_wr),
	.out_pel_full(remove_2x2_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_0_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_0_in_pel(
	.datain(fifo_big_delay_0_in_pel_data),
	.dataout(delay_0_in_pel_data),
	.enr(delay_0_in_pel_rd),
	.enw(fifo_big_delay_0_in_pel_wr),
	.empty(delay_0_in_pel_empty),
	.full(fifo_big_delay_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_0
delay actor_delay_0 (
	// Input Signal(s)
	.in_pel(delay_0_in_pel_data),
	.in_pel_rd(delay_0_in_pel_rd),
	.in_pel_empty(delay_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_0_out_pel_data),
	.out_pel_wr(delay_0_out_pel_wr),
	.out_pel_full(delay_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_roberts_y_0_pel00
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_pel00(
	.datain(fifo_big_roberts_y_0_pel00_data),
	.dataout(roberts_y_0_pel00_data),
	.enr(roberts_y_0_pel00_rd),
	.enw(fifo_big_roberts_y_0_pel00_wr),
	.empty(roberts_y_0_pel00_empty),
	.full(fifo_big_roberts_y_0_pel00_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_y_0_pel01
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_pel01(
	.datain(fifo_big_roberts_y_0_pel01_data),
	.dataout(roberts_y_0_pel01_data),
	.enr(roberts_y_0_pel01_rd),
	.enw(fifo_big_roberts_y_0_pel01_wr),
	.empty(roberts_y_0_pel01_empty),
	.full(fifo_big_roberts_y_0_pel01_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_y_0_pel10
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_pel10(
	.datain(fifo_big_roberts_y_0_pel10_data),
	.dataout(roberts_y_0_pel10_data),
	.enr(roberts_y_0_pel10_rd),
	.enw(fifo_big_roberts_y_0_pel10_wr),
	.empty(roberts_y_0_pel10_empty),
	.full(fifo_big_roberts_y_0_pel10_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_y_0_pel11
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_y_0_pel11(
	.datain(fifo_big_roberts_y_0_pel11_data),
	.dataout(roberts_y_0_pel11_data),
	.enr(roberts_y_0_pel11_rd),
	.enw(fifo_big_roberts_y_0_pel11_wr),
	.empty(roberts_y_0_pel11_empty),
	.full(fifo_big_roberts_y_0_pel11_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor roberts_y_0
roberts_y actor_roberts_y_0 (
	// Input Signal(s)
	.pel00(roberts_y_0_pel00_data),
	.pel00_rd(roberts_y_0_pel00_rd),
	.pel00_empty(roberts_y_0_pel00_empty),
	.pel01(roberts_y_0_pel01_data),
	.pel01_rd(roberts_y_0_pel01_rd),
	.pel01_empty(roberts_y_0_pel01_empty),
	.pel10(roberts_y_0_pel10_data),
	.pel10_rd(roberts_y_0_pel10_rd),
	.pel10_empty(roberts_y_0_pel10_empty),
	.pel11(roberts_y_0_pel11_data),
	.pel11_rd(roberts_y_0_pel11_rd),
	.pel11_empty(roberts_y_0_pel11_empty)
	,
	
	// Output Signal(s)
	.out_pel(roberts_y_0_out_pel_data),
	.out_pel_wr(roberts_y_0_out_pel_wr),
	.out_pel_full(roberts_y_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_line_buffer_0_real_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_0_real_size(
	.datain(fifo_big_line_buffer_0_real_size_data),
	.dataout(line_buffer_0_real_size_data),
	.enr(line_buffer_0_real_size_rd),
	.enw(fifo_big_line_buffer_0_real_size_wr),
	.empty(line_buffer_0_real_size_empty),
	.full(fifo_big_line_buffer_0_real_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_0_ext_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_0_ext_size(
	.datain(fifo_big_line_buffer_0_ext_size_data),
	.dataout(line_buffer_0_ext_size_data),
	.enr(line_buffer_0_ext_size_rd),
	.enw(fifo_big_line_buffer_0_ext_size_wr),
	.empty(line_buffer_0_ext_size_empty),
	.full(fifo_big_line_buffer_0_ext_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_0_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_line_buffer_0_in_pel(
	.datain(fifo_big_line_buffer_0_in_pel_data),
	.dataout(line_buffer_0_in_pel_data),
	.enr(line_buffer_0_in_pel_rd),
	.enw(fifo_big_line_buffer_0_in_pel_wr),
	.empty(line_buffer_0_in_pel_empty),
	.full(fifo_big_line_buffer_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_0
line_buffer actor_line_buffer_0 (
	// Input Signal(s)
	.real_size(line_buffer_0_real_size_data),
	.real_size_rd(line_buffer_0_real_size_rd),
	.real_size_empty(line_buffer_0_real_size_empty),
	.ext_size(line_buffer_0_ext_size_data),
	.ext_size_rd(line_buffer_0_ext_size_rd),
	.ext_size_empty(line_buffer_0_ext_size_empty),
	.in_pel(line_buffer_0_in_pel_data),
	.in_pel_rd(line_buffer_0_in_pel_rd),
	.in_pel_empty(line_buffer_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(line_buffer_0_out_pel_data),
	.out_pel_wr(line_buffer_0_out_pel_wr),
	.out_pel_full(line_buffer_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_roberts_x_0_pel00
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_pel00(
	.datain(fifo_big_roberts_x_0_pel00_data),
	.dataout(roberts_x_0_pel00_data),
	.enr(roberts_x_0_pel00_rd),
	.enw(fifo_big_roberts_x_0_pel00_wr),
	.empty(roberts_x_0_pel00_empty),
	.full(fifo_big_roberts_x_0_pel00_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_x_0_pel01
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_pel01(
	.datain(fifo_big_roberts_x_0_pel01_data),
	.dataout(roberts_x_0_pel01_data),
	.enr(roberts_x_0_pel01_rd),
	.enw(fifo_big_roberts_x_0_pel01_wr),
	.empty(roberts_x_0_pel01_empty),
	.full(fifo_big_roberts_x_0_pel01_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_x_0_pel10
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_pel10(
	.datain(fifo_big_roberts_x_0_pel10_data),
	.dataout(roberts_x_0_pel10_data),
	.enr(roberts_x_0_pel10_rd),
	.enw(fifo_big_roberts_x_0_pel10_wr),
	.empty(roberts_x_0_pel10_empty),
	.full(fifo_big_roberts_x_0_pel10_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_roberts_x_0_pel11
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_roberts_x_0_pel11(
	.datain(fifo_big_roberts_x_0_pel11_data),
	.dataout(roberts_x_0_pel11_data),
	.enr(roberts_x_0_pel11_rd),
	.enw(fifo_big_roberts_x_0_pel11_wr),
	.empty(roberts_x_0_pel11_empty),
	.full(fifo_big_roberts_x_0_pel11_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor roberts_x_0
roberts_x actor_roberts_x_0 (
	// Input Signal(s)
	.pel00(roberts_x_0_pel00_data),
	.pel00_rd(roberts_x_0_pel00_rd),
	.pel00_empty(roberts_x_0_pel00_empty),
	.pel01(roberts_x_0_pel01_data),
	.pel01_rd(roberts_x_0_pel01_rd),
	.pel01_empty(roberts_x_0_pel01_empty),
	.pel10(roberts_x_0_pel10_data),
	.pel10_rd(roberts_x_0_pel10_rd),
	.pel10_empty(roberts_x_0_pel10_empty),
	.pel11(roberts_x_0_pel11_data),
	.pel11_rd(roberts_x_0_pel11_rd),
	.pel11_empty(roberts_x_0_pel11_empty)
	,
	
	// Output Signal(s)
	.out_pel(roberts_x_0_out_pel_data),
	.out_pel_wr(roberts_x_0_out_pel_wr),
	.out_pel_full(roberts_x_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_1_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_1_in_pel(
	.datain(fifo_big_delay_1_in_pel_data),
	.dataout(delay_1_in_pel_data),
	.enr(delay_1_in_pel_rd),
	.enw(fifo_big_delay_1_in_pel_wr),
	.empty(delay_1_in_pel_empty),
	.full(fifo_big_delay_1_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_1
delay actor_delay_1 (
	// Input Signal(s)
	.in_pel(delay_1_in_pel_data),
	.in_pel_rd(delay_1_in_pel_rd),
	.in_pel_empty(delay_1_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_1_out_pel_data),
	.out_pel_wr(delay_1_out_pel_wr),
	.out_pel_full(delay_1_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_thr_0_in_g
fifo_big #(
	.depth(64),
	.size(14)
) fifo_big_thr_0_in_g(
	.datain(fifo_big_thr_0_in_g_data),
	.dataout(thr_0_in_g_data),
	.enr(thr_0_in_g_rd),
	.enw(fifo_big_thr_0_in_g_wr),
	.empty(thr_0_in_g_empty),
	.full(fifo_big_thr_0_in_g_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor thr_0
thr actor_thr_0 (
	// Input Signal(s)
	.in_g(thr_0_in_g_data),
	.in_g_rd(thr_0_in_g_rd),
	.in_g_empty(thr_0_in_g_empty)
	,
	
	// Output Signal(s)
	.out_pel(thr_0_out_pel_data),
	.out_pel_wr(thr_0_out_pel_wr),
	.out_pel_full(thr_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_abs_sum_0_in_gx
fifo_big #(
	.depth(64),
	.size(14)
) fifo_big_abs_sum_0_in_gx(
	.datain(fifo_big_abs_sum_0_in_gx_data),
	.dataout(abs_sum_0_in_gx_data),
	.enr(abs_sum_0_in_gx_rd),
	.enw(fifo_big_abs_sum_0_in_gx_wr),
	.empty(abs_sum_0_in_gx_empty),
	.full(fifo_big_abs_sum_0_in_gx_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_abs_sum_0_in_gy
fifo_big #(
	.depth(64),
	.size(14)
) fifo_big_abs_sum_0_in_gy(
	.datain(fifo_big_abs_sum_0_in_gy_data),
	.dataout(abs_sum_0_in_gy_data),
	.enr(abs_sum_0_in_gy_rd),
	.enw(fifo_big_abs_sum_0_in_gy_wr),
	.empty(abs_sum_0_in_gy_empty),
	.full(fifo_big_abs_sum_0_in_gy_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor abs_sum_0
abs_sum actor_abs_sum_0 (
	// Input Signal(s)
	.in_gx(abs_sum_0_in_gx_data),
	.in_gx_rd(abs_sum_0_in_gx_rd),
	.in_gx_empty(abs_sum_0_in_gx_empty),
	.in_gy(abs_sum_0_in_gy_data),
	.in_gy_rd(abs_sum_0_in_gy_rd),
	.in_gy_empty(abs_sum_0_in_gy_empty)
	,
	
	// Output Signal(s)
	.out_g(abs_sum_0_out_g_data),
	.out_g_wr(abs_sum_0_out_g_wr),
	.out_g_full(abs_sum_0_out_g_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_2_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_2_in_pel(
	.datain(fifo_big_delay_2_in_pel_data),
	.dataout(delay_2_in_pel_data),
	.enr(delay_2_in_pel_rd),
	.enw(fifo_big_delay_2_in_pel_wr),
	.empty(delay_2_in_pel_empty),
	.full(fifo_big_delay_2_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_2
delay actor_delay_2 (
	// Input Signal(s)
	.in_pel(delay_2_in_pel_data),
	.in_pel_rd(delay_2_in_pel_rd),
	.in_pel_empty(delay_2_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_2_out_pel_data),
	.out_pel_wr(delay_2_out_pel_wr),
	.out_pel_full(delay_2_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_sobel_y_0_pel00
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel00(
	.datain(fifo_big_sobel_y_0_pel00_data),
	.dataout(sobel_y_0_pel00_data),
	.enr(sobel_y_0_pel00_rd),
	.enw(fifo_big_sobel_y_0_pel00_wr),
	.empty(sobel_y_0_pel00_empty),
	.full(fifo_big_sobel_y_0_pel00_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel01
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel01(
	.datain(fifo_big_sobel_y_0_pel01_data),
	.dataout(sobel_y_0_pel01_data),
	.enr(sobel_y_0_pel01_rd),
	.enw(fifo_big_sobel_y_0_pel01_wr),
	.empty(sobel_y_0_pel01_empty),
	.full(fifo_big_sobel_y_0_pel01_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel02
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel02(
	.datain(fifo_big_sobel_y_0_pel02_data),
	.dataout(sobel_y_0_pel02_data),
	.enr(sobel_y_0_pel02_rd),
	.enw(fifo_big_sobel_y_0_pel02_wr),
	.empty(sobel_y_0_pel02_empty),
	.full(fifo_big_sobel_y_0_pel02_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel10
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel10(
	.datain(fifo_big_sobel_y_0_pel10_data),
	.dataout(sobel_y_0_pel10_data),
	.enr(sobel_y_0_pel10_rd),
	.enw(fifo_big_sobel_y_0_pel10_wr),
	.empty(sobel_y_0_pel10_empty),
	.full(fifo_big_sobel_y_0_pel10_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel11
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel11(
	.datain(fifo_big_sobel_y_0_pel11_data),
	.dataout(sobel_y_0_pel11_data),
	.enr(sobel_y_0_pel11_rd),
	.enw(fifo_big_sobel_y_0_pel11_wr),
	.empty(sobel_y_0_pel11_empty),
	.full(fifo_big_sobel_y_0_pel11_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel12
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel12(
	.datain(fifo_big_sobel_y_0_pel12_data),
	.dataout(sobel_y_0_pel12_data),
	.enr(sobel_y_0_pel12_rd),
	.enw(fifo_big_sobel_y_0_pel12_wr),
	.empty(sobel_y_0_pel12_empty),
	.full(fifo_big_sobel_y_0_pel12_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel20
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel20(
	.datain(fifo_big_sobel_y_0_pel20_data),
	.dataout(sobel_y_0_pel20_data),
	.enr(sobel_y_0_pel20_rd),
	.enw(fifo_big_sobel_y_0_pel20_wr),
	.empty(sobel_y_0_pel20_empty),
	.full(fifo_big_sobel_y_0_pel20_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel21
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel21(
	.datain(fifo_big_sobel_y_0_pel21_data),
	.dataout(sobel_y_0_pel21_data),
	.enr(sobel_y_0_pel21_rd),
	.enw(fifo_big_sobel_y_0_pel21_wr),
	.empty(sobel_y_0_pel21_empty),
	.full(fifo_big_sobel_y_0_pel21_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_y_0_pel22
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_y_0_pel22(
	.datain(fifo_big_sobel_y_0_pel22_data),
	.dataout(sobel_y_0_pel22_data),
	.enr(sobel_y_0_pel22_rd),
	.enw(fifo_big_sobel_y_0_pel22_wr),
	.empty(sobel_y_0_pel22_empty),
	.full(fifo_big_sobel_y_0_pel22_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor sobel_y_0
sobel_y actor_sobel_y_0 (
	// Input Signal(s)
	.pel00(sobel_y_0_pel00_data),
	.pel00_rd(sobel_y_0_pel00_rd),
	.pel00_empty(sobel_y_0_pel00_empty),
	.pel01(sobel_y_0_pel01_data),
	.pel01_rd(sobel_y_0_pel01_rd),
	.pel01_empty(sobel_y_0_pel01_empty),
	.pel02(sobel_y_0_pel02_data),
	.pel02_rd(sobel_y_0_pel02_rd),
	.pel02_empty(sobel_y_0_pel02_empty),
	.pel10(sobel_y_0_pel10_data),
	.pel10_rd(sobel_y_0_pel10_rd),
	.pel10_empty(sobel_y_0_pel10_empty),
	.pel11(sobel_y_0_pel11_data),
	.pel11_rd(sobel_y_0_pel11_rd),
	.pel11_empty(sobel_y_0_pel11_empty),
	.pel12(sobel_y_0_pel12_data),
	.pel12_rd(sobel_y_0_pel12_rd),
	.pel12_empty(sobel_y_0_pel12_empty),
	.pel20(sobel_y_0_pel20_data),
	.pel20_rd(sobel_y_0_pel20_rd),
	.pel20_empty(sobel_y_0_pel20_empty),
	.pel21(sobel_y_0_pel21_data),
	.pel21_rd(sobel_y_0_pel21_rd),
	.pel21_empty(sobel_y_0_pel21_empty),
	.pel22(sobel_y_0_pel22_data),
	.pel22_rd(sobel_y_0_pel22_rd),
	.pel22_empty(sobel_y_0_pel22_empty)
	,
	
	// Output Signal(s)
	.out_pel(sobel_y_0_out_pel_data),
	.out_pel_wr(sobel_y_0_out_pel_wr),
	.out_pel_full(sobel_y_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_3_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_3_in_pel(
	.datain(fifo_big_delay_3_in_pel_data),
	.dataout(delay_3_in_pel_data),
	.enr(delay_3_in_pel_rd),
	.enw(fifo_big_delay_3_in_pel_wr),
	.empty(delay_3_in_pel_empty),
	.full(fifo_big_delay_3_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_3
delay actor_delay_3 (
	// Input Signal(s)
	.in_pel(delay_3_in_pel_data),
	.in_pel_rd(delay_3_in_pel_rd),
	.in_pel_empty(delay_3_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_3_out_pel_data),
	.out_pel_wr(delay_3_out_pel_wr),
	.out_pel_full(delay_3_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_sobel_x_0_pel00
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel00(
	.datain(fifo_big_sobel_x_0_pel00_data),
	.dataout(sobel_x_0_pel00_data),
	.enr(sobel_x_0_pel00_rd),
	.enw(fifo_big_sobel_x_0_pel00_wr),
	.empty(sobel_x_0_pel00_empty),
	.full(fifo_big_sobel_x_0_pel00_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel01
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel01(
	.datain(fifo_big_sobel_x_0_pel01_data),
	.dataout(sobel_x_0_pel01_data),
	.enr(sobel_x_0_pel01_rd),
	.enw(fifo_big_sobel_x_0_pel01_wr),
	.empty(sobel_x_0_pel01_empty),
	.full(fifo_big_sobel_x_0_pel01_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel02
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel02(
	.datain(fifo_big_sobel_x_0_pel02_data),
	.dataout(sobel_x_0_pel02_data),
	.enr(sobel_x_0_pel02_rd),
	.enw(fifo_big_sobel_x_0_pel02_wr),
	.empty(sobel_x_0_pel02_empty),
	.full(fifo_big_sobel_x_0_pel02_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel10
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel10(
	.datain(fifo_big_sobel_x_0_pel10_data),
	.dataout(sobel_x_0_pel10_data),
	.enr(sobel_x_0_pel10_rd),
	.enw(fifo_big_sobel_x_0_pel10_wr),
	.empty(sobel_x_0_pel10_empty),
	.full(fifo_big_sobel_x_0_pel10_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel11
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel11(
	.datain(fifo_big_sobel_x_0_pel11_data),
	.dataout(sobel_x_0_pel11_data),
	.enr(sobel_x_0_pel11_rd),
	.enw(fifo_big_sobel_x_0_pel11_wr),
	.empty(sobel_x_0_pel11_empty),
	.full(fifo_big_sobel_x_0_pel11_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel12
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel12(
	.datain(fifo_big_sobel_x_0_pel12_data),
	.dataout(sobel_x_0_pel12_data),
	.enr(sobel_x_0_pel12_rd),
	.enw(fifo_big_sobel_x_0_pel12_wr),
	.empty(sobel_x_0_pel12_empty),
	.full(fifo_big_sobel_x_0_pel12_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel20
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel20(
	.datain(fifo_big_sobel_x_0_pel20_data),
	.dataout(sobel_x_0_pel20_data),
	.enr(sobel_x_0_pel20_rd),
	.enw(fifo_big_sobel_x_0_pel20_wr),
	.empty(sobel_x_0_pel20_empty),
	.full(fifo_big_sobel_x_0_pel20_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel21
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel21(
	.datain(fifo_big_sobel_x_0_pel21_data),
	.dataout(sobel_x_0_pel21_data),
	.enr(sobel_x_0_pel21_rd),
	.enw(fifo_big_sobel_x_0_pel21_wr),
	.empty(sobel_x_0_pel21_empty),
	.full(fifo_big_sobel_x_0_pel21_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_sobel_x_0_pel22
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_sobel_x_0_pel22(
	.datain(fifo_big_sobel_x_0_pel22_data),
	.dataout(sobel_x_0_pel22_data),
	.enr(sobel_x_0_pel22_rd),
	.enw(fifo_big_sobel_x_0_pel22_wr),
	.empty(sobel_x_0_pel22_empty),
	.full(fifo_big_sobel_x_0_pel22_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor sobel_x_0
sobel_x actor_sobel_x_0 (
	// Input Signal(s)
	.pel00(sobel_x_0_pel00_data),
	.pel00_rd(sobel_x_0_pel00_rd),
	.pel00_empty(sobel_x_0_pel00_empty),
	.pel01(sobel_x_0_pel01_data),
	.pel01_rd(sobel_x_0_pel01_rd),
	.pel01_empty(sobel_x_0_pel01_empty),
	.pel02(sobel_x_0_pel02_data),
	.pel02_rd(sobel_x_0_pel02_rd),
	.pel02_empty(sobel_x_0_pel02_empty),
	.pel10(sobel_x_0_pel10_data),
	.pel10_rd(sobel_x_0_pel10_rd),
	.pel10_empty(sobel_x_0_pel10_empty),
	.pel11(sobel_x_0_pel11_data),
	.pel11_rd(sobel_x_0_pel11_rd),
	.pel11_empty(sobel_x_0_pel11_empty),
	.pel12(sobel_x_0_pel12_data),
	.pel12_rd(sobel_x_0_pel12_rd),
	.pel12_empty(sobel_x_0_pel12_empty),
	.pel20(sobel_x_0_pel20_data),
	.pel20_rd(sobel_x_0_pel20_rd),
	.pel20_empty(sobel_x_0_pel20_empty),
	.pel21(sobel_x_0_pel21_data),
	.pel21_rd(sobel_x_0_pel21_rd),
	.pel21_empty(sobel_x_0_pel21_empty),
	.pel22(sobel_x_0_pel22_data),
	.pel22_rd(sobel_x_0_pel22_rd),
	.pel22_empty(sobel_x_0_pel22_empty)
	,
	
	// Output Signal(s)
	.out_pel(sobel_x_0_out_pel_data),
	.out_pel_wr(sobel_x_0_out_pel_wr),
	.out_pel_full(sobel_x_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_line_buffer_1_real_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_1_real_size(
	.datain(fifo_big_line_buffer_1_real_size_data),
	.dataout(line_buffer_1_real_size_data),
	.enr(line_buffer_1_real_size_rd),
	.enw(fifo_big_line_buffer_1_real_size_wr),
	.empty(line_buffer_1_real_size_empty),
	.full(fifo_big_line_buffer_1_real_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_1_ext_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_1_ext_size(
	.datain(fifo_big_line_buffer_1_ext_size_data),
	.dataout(line_buffer_1_ext_size_data),
	.enr(line_buffer_1_ext_size_rd),
	.enw(fifo_big_line_buffer_1_ext_size_wr),
	.empty(line_buffer_1_ext_size_empty),
	.full(fifo_big_line_buffer_1_ext_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_1_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_line_buffer_1_in_pel(
	.datain(fifo_big_line_buffer_1_in_pel_data),
	.dataout(line_buffer_1_in_pel_data),
	.enr(line_buffer_1_in_pel_rd),
	.enw(fifo_big_line_buffer_1_in_pel_wr),
	.empty(line_buffer_1_in_pel_empty),
	.full(fifo_big_line_buffer_1_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_1
line_buffer actor_line_buffer_1 (
	// Input Signal(s)
	.real_size(line_buffer_1_real_size_data),
	.real_size_rd(line_buffer_1_real_size_rd),
	.real_size_empty(line_buffer_1_real_size_empty),
	.ext_size(line_buffer_1_ext_size_data),
	.ext_size_rd(line_buffer_1_ext_size_rd),
	.ext_size_empty(line_buffer_1_ext_size_empty),
	.in_pel(line_buffer_1_in_pel_data),
	.in_pel_rd(line_buffer_1_in_pel_rd),
	.in_pel_empty(line_buffer_1_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(line_buffer_1_out_pel_data),
	.out_pel_wr(line_buffer_1_out_pel_wr),
	.out_pel_full(line_buffer_1_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_4_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_4_in_pel(
	.datain(fifo_big_delay_4_in_pel_data),
	.dataout(delay_4_in_pel_data),
	.enr(delay_4_in_pel_rd),
	.enw(fifo_big_delay_4_in_pel_wr),
	.empty(delay_4_in_pel_empty),
	.full(fifo_big_delay_4_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_4
delay actor_delay_4 (
	// Input Signal(s)
	.in_pel(delay_4_in_pel_data),
	.in_pel_rd(delay_4_in_pel_rd),
	.in_pel_empty(delay_4_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_4_out_pel_data),
	.out_pel_wr(delay_4_out_pel_wr),
	.out_pel_full(delay_4_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_5_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_5_in_pel(
	.datain(fifo_big_delay_5_in_pel_data),
	.dataout(delay_5_in_pel_data),
	.enr(delay_5_in_pel_rd),
	.enw(fifo_big_delay_5_in_pel_wr),
	.empty(delay_5_in_pel_empty),
	.full(fifo_big_delay_5_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_5
delay actor_delay_5 (
	// Input Signal(s)
	.in_pel(delay_5_in_pel_data),
	.in_pel_rd(delay_5_in_pel_rd),
	.in_pel_empty(delay_5_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_5_out_pel_data),
	.out_pel_wr(delay_5_out_pel_wr),
	.out_pel_full(delay_5_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_remove_3x3_0_in_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_remove_3x3_0_in_size(
	.datain(fifo_big_remove_3x3_0_in_size_data),
	.dataout(remove_3x3_0_in_size_data),
	.enr(remove_3x3_0_in_size_rd),
	.enw(fifo_big_remove_3x3_0_in_size_wr),
	.empty(remove_3x3_0_in_size_empty),
	.full(fifo_big_remove_3x3_0_in_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_remove_3x3_0_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_remove_3x3_0_in_pel(
	.datain(fifo_big_remove_3x3_0_in_pel_data),
	.dataout(remove_3x3_0_in_pel_data),
	.enr(remove_3x3_0_in_pel_rd),
	.enw(fifo_big_remove_3x3_0_in_pel_wr),
	.empty(remove_3x3_0_in_pel_empty),
	.full(fifo_big_remove_3x3_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor remove_3x3_0
remove_3x3 actor_remove_3x3_0 (
	// Input Signal(s)
	.in_size(remove_3x3_0_in_size_data),
	.in_size_rd(remove_3x3_0_in_size_rd),
	.in_size_empty(remove_3x3_0_in_size_empty),
	.in_pel(remove_3x3_0_in_pel_data),
	.in_pel_rd(remove_3x3_0_in_pel_rd),
	.in_pel_empty(remove_3x3_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(remove_3x3_0_out_pel_data),
	.out_pel_wr(remove_3x3_0_out_pel_wr),
	.out_pel_full(remove_3x3_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_line_buffer_2_real_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_2_real_size(
	.datain(fifo_big_line_buffer_2_real_size_data),
	.dataout(line_buffer_2_real_size_data),
	.enr(line_buffer_2_real_size_rd),
	.enw(fifo_big_line_buffer_2_real_size_wr),
	.empty(line_buffer_2_real_size_empty),
	.full(fifo_big_line_buffer_2_real_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_2_ext_size
fifo_big #(
	.depth(64),
	.size(6)
) fifo_big_line_buffer_2_ext_size(
	.datain(fifo_big_line_buffer_2_ext_size_data),
	.dataout(line_buffer_2_ext_size_data),
	.enr(line_buffer_2_ext_size_rd),
	.enw(fifo_big_line_buffer_2_ext_size_wr),
	.empty(line_buffer_2_ext_size_empty),
	.full(fifo_big_line_buffer_2_ext_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_line_buffer_2_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_line_buffer_2_in_pel(
	.datain(fifo_big_line_buffer_2_in_pel_data),
	.dataout(line_buffer_2_in_pel_data),
	.enr(line_buffer_2_in_pel_rd),
	.enw(fifo_big_line_buffer_2_in_pel_wr),
	.empty(line_buffer_2_in_pel_empty),
	.full(fifo_big_line_buffer_2_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_2
line_buffer actor_line_buffer_2 (
	// Input Signal(s)
	.real_size(line_buffer_2_real_size_data),
	.real_size_rd(line_buffer_2_real_size_rd),
	.real_size_empty(line_buffer_2_real_size_empty),
	.ext_size(line_buffer_2_ext_size_data),
	.ext_size_rd(line_buffer_2_ext_size_rd),
	.ext_size_empty(line_buffer_2_ext_size_empty),
	.in_pel(line_buffer_2_in_pel_data),
	.in_pel_rd(line_buffer_2_in_pel_rd),
	.in_pel_empty(line_buffer_2_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(line_buffer_2_out_pel_data),
	.out_pel_wr(line_buffer_2_out_pel_wr),
	.out_pel_full(line_buffer_2_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_6_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_6_in_pel(
	.datain(fifo_big_delay_6_in_pel_data),
	.dataout(delay_6_in_pel_data),
	.enr(delay_6_in_pel_rd),
	.enw(fifo_big_delay_6_in_pel_wr),
	.empty(delay_6_in_pel_empty),
	.full(fifo_big_delay_6_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_6
delay actor_delay_6 (
	// Input Signal(s)
	.in_pel(delay_6_in_pel_data),
	.in_pel_rd(delay_6_in_pel_rd),
	.in_pel_empty(delay_6_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_6_out_pel_data),
	.out_pel_wr(delay_6_out_pel_wr),
	.out_pel_full(delay_6_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// fifo_big_delay_7_in_pel
fifo_big #(
	.depth(64),
	.size(8)
) fifo_big_delay_7_in_pel(
	.datain(fifo_big_delay_7_in_pel_data),
	.dataout(delay_7_in_pel_data),
	.enr(delay_7_in_pel_rd),
	.enw(fifo_big_delay_7_in_pel_wr),
	.empty(delay_7_in_pel_empty),
	.full(fifo_big_delay_7_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_7
delay actor_delay_7 (
	// Input Signal(s)
	.in_pel(delay_7_in_pel_data),
	.in_pel_rd(delay_7_in_pel_rd),
	.in_pel_empty(delay_7_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_7_out_pel_data),
	.out_pel_wr(delay_7_out_pel_wr),
	.out_pel_full(delay_7_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
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
	.SIZE(6)
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
	.SIZE(8)
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


// actor sbox_3
sbox1x2 #(
	.SIZE(8)
)
sbox_3 (
	// Input Signal(s)
	.in1_data(sbox_3_in1_data),
	.in1_wr(sbox_3_in1_wr),
	.in1_full(sbox_3_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_3_out1_data),
	.out1_wr(sbox_3_out1_wr),
	.out1_full(sbox_3_out1_full),
	.out2_data(sbox_3_out2_data),
	.out2_wr(sbox_3_out2_wr),
	.out2_full(sbox_3_out2_full),
	
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
	.in1_wr(sbox_4_in1_wr),
	.in1_full(sbox_4_in1_full),
	.in2_data(sbox_4_in2_data),
	.in2_wr(sbox_4_in2_wr),
	.in2_full(sbox_4_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_4_out1_data),
	.out1_wr(sbox_4_out1_wr),
	.out1_full(sbox_4_out1_full),
	
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

// Module(s) Assignments
assign sbox_0_in1_data = remove_2x2_0_out_pel_data;
assign sbox_0_in1_wr = remove_2x2_0_out_pel_wr;
assign remove_2x2_0_out_pel_full = sbox_0_in1_full;

assign fifo_big_roberts_y_0_pel10_data = delay_0_out_pel_data;
assign fifo_big_roberts_y_0_pel10_wr = delay_0_out_pel_wr;
assign delay_0_out_pel_full =
fifo_big_roberts_y_0_pel10_full || 
fifo_big_roberts_x_0_pel10_full 
;

assign fifo_big_roberts_x_0_pel01_data = line_buffer_0_out_pel_data;
assign fifo_big_roberts_x_0_pel01_wr = line_buffer_0_out_pel_wr;
assign line_buffer_0_out_pel_full =
fifo_big_roberts_x_0_pel01_full || 
fifo_big_roberts_y_0_pel01_full || 
fifo_big_delay_1_in_pel_full 
;

assign fifo_big_roberts_x_0_pel00_data = delay_1_out_pel_data;
assign fifo_big_roberts_x_0_pel00_wr = delay_1_out_pel_wr;
assign delay_1_out_pel_full =
fifo_big_roberts_x_0_pel00_full || 
fifo_big_roberts_y_0_pel00_full 
;

assign fifo_big_remove_2x2_0_in_size_data = sbox_1_out1_data;
assign fifo_big_remove_2x2_0_in_size_wr = sbox_1_out1_wr;
assign sbox_1_out1_full =
fifo_big_line_buffer_0_real_size_full || 
fifo_big_line_buffer_0_ext_size_full || 
fifo_big_remove_2x2_0_in_size_full 
;

assign fifo_big_remove_2x2_0_in_pel_data = sbox_2_out1_data;
assign fifo_big_remove_2x2_0_in_pel_wr = sbox_2_out1_wr;
assign sbox_2_out1_full = fifo_big_remove_2x2_0_in_pel_full;

assign fifo_big_roberts_x_0_pel11_data = sbox_3_out1_data;
assign fifo_big_roberts_x_0_pel11_wr = sbox_3_out1_wr;
assign sbox_3_out1_full =
fifo_big_delay_0_in_pel_full || 
fifo_big_roberts_x_0_pel11_full || 
fifo_big_line_buffer_0_in_pel_full || 
fifo_big_roberts_y_0_pel11_full 
;

assign fifo_big_thr_0_in_g_data = abs_sum_0_out_g_data;
assign fifo_big_thr_0_in_g_wr = abs_sum_0_out_g_wr;
assign abs_sum_0_out_g_full = fifo_big_thr_0_in_g_full;

assign fifo_big_delay_0_in_pel_data = sbox_3_out1_data;
assign fifo_big_delay_0_in_pel_wr = sbox_3_out1_wr;

assign fifo_big_line_buffer_0_ext_size_data = sbox_1_out1_data;
assign fifo_big_line_buffer_0_ext_size_wr = sbox_1_out1_wr;

assign fifo_big_line_buffer_0_in_pel_data = sbox_3_out1_data;
assign fifo_big_line_buffer_0_in_pel_wr = sbox_3_out1_wr;

assign fifo_big_line_buffer_0_real_size_data = sbox_1_out1_data;
assign fifo_big_line_buffer_0_real_size_wr = sbox_1_out1_wr;

assign sbox_4_in1_data = roberts_y_0_out_pel_data;
assign sbox_4_in1_wr = roberts_y_0_out_pel_wr;
assign roberts_y_0_out_pel_full = sbox_4_in1_full;

assign fifo_big_roberts_y_0_pel00_data = delay_1_out_pel_data;
assign fifo_big_roberts_y_0_pel00_wr = delay_1_out_pel_wr;

assign fifo_big_roberts_x_0_pel10_data = delay_0_out_pel_data;
assign fifo_big_roberts_x_0_pel10_wr = delay_0_out_pel_wr;

assign fifo_big_roberts_y_0_pel01_data = line_buffer_0_out_pel_data;
assign fifo_big_roberts_y_0_pel01_wr = line_buffer_0_out_pel_wr;

assign sbox_5_in1_data = roberts_x_0_out_pel_data;
assign sbox_5_in1_wr = roberts_x_0_out_pel_wr;
assign roberts_x_0_out_pel_full = sbox_5_in1_full;

assign fifo_big_delay_1_in_pel_data = line_buffer_0_out_pel_data;
assign fifo_big_delay_1_in_pel_wr = line_buffer_0_out_pel_wr;

assign fifo_big_roberts_y_0_pel11_data = sbox_3_out1_data;
assign fifo_big_roberts_y_0_pel11_wr = sbox_3_out1_wr;

assign fifo_big_sobel_y_0_pel11_data = delay_2_out_pel_data;
assign fifo_big_sobel_y_0_pel11_wr = delay_2_out_pel_wr;
assign delay_2_out_pel_full =
fifo_big_sobel_y_0_pel11_full || 
fifo_big_delay_5_in_pel_full || 
fifo_big_sobel_x_0_pel11_full 
;

assign fifo_big_sobel_x_0_pel20_data = delay_3_out_pel_data;
assign fifo_big_sobel_x_0_pel20_wr = delay_3_out_pel_wr;
assign delay_3_out_pel_full =
fifo_big_sobel_x_0_pel20_full || 
fifo_big_sobel_y_0_pel20_full 
;

assign fifo_big_line_buffer_1_real_size_data = sbox_1_out2_data;
assign fifo_big_line_buffer_1_real_size_wr = sbox_1_out2_wr;
assign sbox_1_out2_full =
fifo_big_remove_3x3_0_in_size_full || 
fifo_big_line_buffer_2_ext_size_full || 
fifo_big_line_buffer_1_real_size_full || 
fifo_big_line_buffer_2_real_size_full || 
fifo_big_line_buffer_1_ext_size_full 
;

assign fifo_big_sobel_y_0_pel21_data = delay_4_out_pel_data;
assign fifo_big_sobel_y_0_pel21_wr = delay_4_out_pel_wr;
assign delay_4_out_pel_full =
fifo_big_sobel_y_0_pel21_full || 
fifo_big_sobel_x_0_pel21_full || 
fifo_big_delay_3_in_pel_full 
;

assign fifo_big_sobel_y_0_pel10_data = delay_5_out_pel_data;
assign fifo_big_sobel_y_0_pel10_wr = delay_5_out_pel_wr;
assign delay_5_out_pel_full =
fifo_big_sobel_y_0_pel10_full || 
fifo_big_sobel_x_0_pel10_full 
;

assign sbox_0_in2_data = remove_3x3_0_out_pel_data;
assign sbox_0_in2_wr = remove_3x3_0_out_pel_wr;
assign remove_3x3_0_out_pel_full = sbox_0_in2_full;

assign fifo_big_delay_6_in_pel_data = line_buffer_2_out_pel_data;
assign fifo_big_delay_6_in_pel_wr = line_buffer_2_out_pel_wr;
assign line_buffer_2_out_pel_full =
fifo_big_delay_6_in_pel_full || 
fifo_big_sobel_y_0_pel02_full || 
fifo_big_sobel_x_0_pel02_full 
;

assign fifo_big_line_buffer_1_in_pel_data = sbox_3_out2_data;
assign fifo_big_line_buffer_1_in_pel_wr = sbox_3_out2_wr;
assign sbox_3_out2_full =
fifo_big_sobel_x_0_pel22_full || 
fifo_big_sobel_y_0_pel22_full || 
fifo_big_line_buffer_1_in_pel_full || 
fifo_big_delay_4_in_pel_full 
;

assign sbox_5_in2_data = sobel_x_0_out_pel_data;
assign sbox_5_in2_wr = sobel_x_0_out_pel_wr;
assign sobel_x_0_out_pel_full = sbox_5_in2_full;

assign fifo_big_sobel_x_0_pel00_data = delay_7_out_pel_data;
assign fifo_big_sobel_x_0_pel00_wr = delay_7_out_pel_wr;
assign delay_7_out_pel_full =
fifo_big_sobel_x_0_pel00_full || 
fifo_big_sobel_y_0_pel00_full 
;

assign fifo_big_sobel_x_0_pel01_data = delay_6_out_pel_data;
assign fifo_big_sobel_x_0_pel01_wr = delay_6_out_pel_wr;
assign delay_6_out_pel_full =
fifo_big_sobel_x_0_pel01_full || 
fifo_big_sobel_y_0_pel01_full || 
fifo_big_delay_7_in_pel_full 
;

assign fifo_big_line_buffer_1_ext_size_data = sbox_1_out2_data;
assign fifo_big_line_buffer_1_ext_size_wr = sbox_1_out2_wr;

assign fifo_big_line_buffer_2_ext_size_data = sbox_1_out2_data;
assign fifo_big_line_buffer_2_ext_size_wr = sbox_1_out2_wr;

assign fifo_big_delay_5_in_pel_data = delay_2_out_pel_data;
assign fifo_big_delay_5_in_pel_wr = delay_2_out_pel_wr;

assign fifo_big_remove_3x3_0_in_pel_data = sbox_2_out2_data;
assign fifo_big_remove_3x3_0_in_pel_wr = sbox_2_out2_wr;
assign sbox_2_out2_full = fifo_big_remove_3x3_0_in_pel_full;

assign fifo_big_sobel_y_0_pel20_data = delay_3_out_pel_data;
assign fifo_big_sobel_y_0_pel20_wr = delay_3_out_pel_wr;

assign fifo_big_sobel_x_0_pel10_data = delay_5_out_pel_data;
assign fifo_big_sobel_x_0_pel10_wr = delay_5_out_pel_wr;

assign fifo_big_sobel_x_0_pel12_data = line_buffer_1_out_pel_data;
assign fifo_big_sobel_x_0_pel12_wr = line_buffer_1_out_pel_wr;
assign line_buffer_1_out_pel_full =
fifo_big_sobel_x_0_pel12_full || 
fifo_big_delay_2_in_pel_full || 
fifo_big_line_buffer_2_in_pel_full || 
fifo_big_sobel_y_0_pel12_full 
;

assign fifo_big_sobel_y_0_pel22_data = sbox_3_out2_data;
assign fifo_big_sobel_y_0_pel22_wr = sbox_3_out2_wr;

assign fifo_big_sobel_x_0_pel11_data = delay_2_out_pel_data;
assign fifo_big_sobel_x_0_pel11_wr = delay_2_out_pel_wr;

assign fifo_big_sobel_y_0_pel02_data = line_buffer_2_out_pel_data;
assign fifo_big_sobel_y_0_pel02_wr = line_buffer_2_out_pel_wr;

assign sbox_4_in2_data = sobel_y_0_out_pel_data;
assign sbox_4_in2_wr = sobel_y_0_out_pel_wr;
assign sobel_y_0_out_pel_full = sbox_4_in2_full;

assign fifo_big_delay_2_in_pel_data = line_buffer_1_out_pel_data;
assign fifo_big_delay_2_in_pel_wr = line_buffer_1_out_pel_wr;

assign fifo_big_delay_4_in_pel_data = sbox_3_out2_data;
assign fifo_big_delay_4_in_pel_wr = sbox_3_out2_wr;

assign fifo_big_remove_3x3_0_in_size_data = sbox_1_out2_data;
assign fifo_big_remove_3x3_0_in_size_wr = sbox_1_out2_wr;

assign fifo_big_sobel_x_0_pel02_data = line_buffer_2_out_pel_data;
assign fifo_big_sobel_x_0_pel02_wr = line_buffer_2_out_pel_wr;

assign fifo_big_line_buffer_2_in_pel_data = line_buffer_1_out_pel_data;
assign fifo_big_line_buffer_2_in_pel_wr = line_buffer_1_out_pel_wr;

assign fifo_big_sobel_x_0_pel21_data = delay_4_out_pel_data;
assign fifo_big_sobel_x_0_pel21_wr = delay_4_out_pel_wr;

assign fifo_big_sobel_y_0_pel01_data = delay_6_out_pel_data;
assign fifo_big_sobel_y_0_pel01_wr = delay_6_out_pel_wr;

assign fifo_big_sobel_y_0_pel00_data = delay_7_out_pel_data;
assign fifo_big_sobel_y_0_pel00_wr = delay_7_out_pel_wr;

assign fifo_big_sobel_y_0_pel12_data = line_buffer_1_out_pel_data;
assign fifo_big_sobel_y_0_pel12_wr = line_buffer_1_out_pel_wr;

assign fifo_big_delay_7_in_pel_data = delay_6_out_pel_data;
assign fifo_big_delay_7_in_pel_wr = delay_6_out_pel_wr;

assign fifo_big_sobel_x_0_pel22_data = sbox_3_out2_data;
assign fifo_big_sobel_x_0_pel22_wr = sbox_3_out2_wr;

assign fifo_big_delay_3_in_pel_data = delay_4_out_pel_data;
assign fifo_big_delay_3_in_pel_wr = delay_4_out_pel_wr;

assign fifo_big_line_buffer_2_real_size_data = sbox_1_out2_data;
assign fifo_big_line_buffer_2_real_size_wr = sbox_1_out2_wr;

assign sbox_3_in1_data = in_pel_data;
assign sbox_3_in1_wr = in_pel_wr;
assign in_pel_full = sbox_3_in1_full;

assign sbox_2_in1_data = thr_0_out_pel_data;
assign sbox_2_in1_wr = thr_0_out_pel_wr;
assign thr_0_out_pel_full = sbox_2_in1_full;

assign sbox_1_in1_data = in_size_data;
assign sbox_1_in1_wr = in_size_wr;
assign in_size_full = sbox_1_in1_full;

assign out_pel_data = sbox_0_out1_data;
assign out_pel_wr = sbox_0_out1_wr;
assign sbox_0_out1_full = out_pel_full;

assign fifo_big_abs_sum_0_in_gy_data = sbox_4_out1_data;
assign fifo_big_abs_sum_0_in_gy_wr = sbox_4_out1_wr;
assign sbox_4_out1_full = fifo_big_abs_sum_0_in_gy_full;

assign fifo_big_abs_sum_0_in_gx_data = sbox_5_out1_data;
assign fifo_big_abs_sum_0_in_gx_wr = sbox_5_out1_wr;
assign sbox_5_out1_full = fifo_big_abs_sum_0_in_gx_full;

endmodule
