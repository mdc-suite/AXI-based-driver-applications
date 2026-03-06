`timescale 1ns / 1ps

`ifndef ith
`define ith *8 +: 8
`endif



module add_round_key(
	input [127 : 0] in_state_dout,
	output reg in_state_read,
	input in_state_empty,
	
	input [127 : 0] round_key_dout,
	output reg round_key_read,
	input round_key_empty,
	
	output reg [127 : 0] out_state_din,
	output reg out_state_write,
	input out_state_full,	
	
	input clk,
	input rst
);


always_comb
	if(!in_state_empty && !round_key_empty && !out_state_full)
		begin
		in_state_read <= 1;
		round_key_read <= 1;
		out_state_write <= 1;
		out_state_din <= in_state_dout ^ round_key_dout;
		end
	else
		begin
		in_state_read <= 0;
		round_key_read <= 0;
		out_state_write <= 0;
		out_state_din <= 'x;
		end		

endmodule