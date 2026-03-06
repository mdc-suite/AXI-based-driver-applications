`timescale 1ns / 1ps

`ifndef ith
`define ith *8 +: 8
`endif

/* implements the mix column operators
 * functions are used for convenience as the new value of a bytes depends on the bytes of its column elaborated by a function. 
 * The function to be applied depeneds on the row of the bytes. */

module mix_cols(
	input [127 : 0] in_state_dout,
	output reg in_state_read,
	input in_state_empty,
	
	output reg [127 : 0] out_state_din,
	output reg out_state_write,
	input out_state_full,	
	
	input clk,
	input rst
);


function automatic [7 : 0] xtime(input [7 : 0] x);
		xtime = (x & 8'h80) ? ((x << 1) ^ 8'h1b) : (x << 1);
endfunction		


function automatic [7 : 0] row0(
		input [7 : 0] s0c,	// 1st byte of the column 
		input [7 : 0] s1c,	// 2nd byte of the column 
		input [7 : 0] s2c,	// 3rd byte of the column 
		input [7 : 0] s3c	// 4th byte of the column 
		);
		
		reg [7 : 0] e = s0c ^ s1c ^ s2c ^ s3c;
		row0 = s0c ^ e ^ xtime(s0c ^ s1c);
		
endfunction


function automatic [7 : 0] row1(
		input [7 : 0] s0c,	// 1st byte of the column 
		input [7 : 0] s1c,	// 2nd byte of the column 
		input [7 : 0] s2c,	// 3rd byte of the column 
		input [7 : 0] s3c	// 4th byte of the column 
		);
		
		reg [7 : 0] e = s0c ^ s1c ^ s2c ^ s3c;
		row1 = s1c ^ e ^ xtime(s1c ^ s2c);
		
endfunction


function automatic [7 : 0] row2(
		input [7 : 0] s0c,	// 1st byte of the column 
		input [7 : 0] s1c,	// 2nd byte of the column 
		input [7 : 0] s2c,	// 3rd byte of the column 
		input [7 : 0] s3c	// 4th byte of the column 
		);
		
		reg [7 : 0] e = s0c ^ s1c ^ s2c ^ s3c;
		row2 = s2c ^ e ^ xtime(s2c ^ s3c);
		
endfunction


function automatic [7 : 0] row3(
		input [7 : 0] s0c,	// 1st byte of the column 
		input [7 : 0] s1c,	// 2nd byte of the column 
		input [7 : 0] s2c,	// 3rd byte of the column 
		input [7 : 0] s3c	// 4th byte of the column 
		);
		
		reg [7 : 0] e = s0c ^ s1c ^ s2c ^ s3c;
		row3 = s3c ^ e ^ xtime(s3c ^ s0c);
		
endfunction


always_comb
	if(!in_state_empty && !out_state_full)
		begin
		in_state_read <= 1;
		out_state_write <= 1;
		// mix cols in parallel
		out_state_din[15`ith] <= row3(in_state_dout[12`ith], in_state_dout[13`ith], in_state_dout[14`ith], in_state_dout[15`ith]);		// s'33
		out_state_din[14`ith] <= row2(in_state_dout[12`ith], in_state_dout[13`ith], in_state_dout[14`ith], in_state_dout[15`ith]);		// s'23 
		out_state_din[13`ith] <= row1(in_state_dout[12`ith], in_state_dout[13`ith], in_state_dout[14`ith], in_state_dout[15`ith]);		// s'13
		out_state_din[12`ith] <= row0(in_state_dout[12`ith], in_state_dout[13`ith], in_state_dout[14`ith], in_state_dout[15`ith]); 		// s'03 
		out_state_din[11`ith] <= row3(in_state_dout[8`ith], in_state_dout[9`ith], in_state_dout[10`ith], in_state_dout[11`ith]);		// s'32 
		out_state_din[10`ith] <= row2(in_state_dout[8`ith], in_state_dout[9`ith], in_state_dout[10`ith], in_state_dout[11`ith]);		// s'22 
		out_state_din[9`ith] <= row1(in_state_dout[8`ith], in_state_dout[9`ith], in_state_dout[10`ith], in_state_dout[11`ith]);			// s'12 
		out_state_din[8`ith] <= row0(in_state_dout[8`ith], in_state_dout[9`ith], in_state_dout[10`ith], in_state_dout[11`ith]);			// s'02
		out_state_din[7`ith] <= row3(in_state_dout[4`ith], in_state_dout[5`ith], in_state_dout[6`ith], in_state_dout[7`ith]);			// s'31 
		out_state_din[6`ith] <= row2(in_state_dout[4`ith], in_state_dout[5`ith], in_state_dout[6`ith], in_state_dout[7`ith]);			// s'21 
		out_state_din[5`ith] <= row1(in_state_dout[4`ith], in_state_dout[5`ith], in_state_dout[6`ith], in_state_dout[7`ith]);			// s'11
		out_state_din[4`ith] <= row0(in_state_dout[4`ith], in_state_dout[5`ith], in_state_dout[6`ith], in_state_dout[7`ith]);			// s'01
		out_state_din[3`ith] <= row3(in_state_dout[0`ith], in_state_dout[1`ith], in_state_dout[2`ith], in_state_dout[3`ith]);			// s'30 
		out_state_din[2`ith] <= row2(in_state_dout[0`ith], in_state_dout[1`ith], in_state_dout[2`ith], in_state_dout[3`ith]);			// s'20 
		out_state_din[1`ith] <= row1(in_state_dout[0`ith], in_state_dout[1`ith], in_state_dout[2`ith], in_state_dout[3`ith]); 			// s'10 
		out_state_din[0`ith] <= row0(in_state_dout[0`ith], in_state_dout[1`ith], in_state_dout[2`ith], in_state_dout[3`ith]);			// s'00 		
		end
	else
		begin
		in_state_read <= 0;
		out_state_write <= 0;
		out_state_din <= 'x;
		end

endmodule