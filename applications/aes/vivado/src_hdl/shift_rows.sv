`timescale 1ns / 1ps

`ifndef ith
`define ith *8 +: 8
`endif


module shift_rows(
	input [127 : 0] in_state_dout,
	output reg in_state_read,
	input in_state_empty,
	
	output reg [127 : 0] out_state_din,
	output reg out_state_write,
	input out_state_full,	
	
	input clk,
	input rst
);


always_comb
	if(!in_state_empty && !out_state_full)
		begin
		in_state_read <= 1;
		out_state_write <= 1;
		// shift rows in parallel
		out_state_din[15`ith] <= in_state_dout[11`ith];		// s'33 = s32
		out_state_din[14`ith] <= in_state_dout[6`ith];		// s'23 = s21
		out_state_din[13`ith] <= in_state_dout[1`ith];		// s'13 = s10
		out_state_din[12`ith] <= in_state_dout[12`ith];		// s'03 = s03
		out_state_din[11`ith] <= in_state_dout[7`ith];		// s'32 = s31
		out_state_din[10`ith] <= in_state_dout[2`ith];		// s'22 = s20
		out_state_din[9`ith] <= in_state_dout[13`ith];		// s'12 = s13
		out_state_din[8`ith] <= in_state_dout[8`ith];		// s'02 = s02
		out_state_din[7`ith] <= in_state_dout[3`ith];		// s'31 = s30
		out_state_din[6`ith] <= in_state_dout[14`ith];		// s'21 = s23
		out_state_din[5`ith] <= in_state_dout[9`ith];		// s'11 = s12
		out_state_din[4`ith] <= in_state_dout[4`ith];		// s'01 = s01
		out_state_din[3`ith] <= in_state_dout[15`ith];		// s'30 = s33
		out_state_din[2`ith] <= in_state_dout[10`ith];		// s'20 = s22
		out_state_din[1`ith] <= in_state_dout[5`ith];		// s'10 = s11
		out_state_din[0`ith] <= in_state_dout[0`ith];		// s'00 = s00		
		end
	else
		begin
		in_state_read <= 0;
		out_state_write <= 0;
		out_state_din <= 'x;
		end

endmodule