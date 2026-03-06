`ifndef ith
`define ith *8 +: 8
`endif



module next_round_const(
	input [7 : 0] in_rc_dout,
	output reg in_rc_read,
	input in_rc_empty,
	
	output reg [7 : 0] out_rc_din,
	output reg out_rc_write,
	input out_rc_full,
	
	input clk,
	input rst
);

function automatic [7 : 0] F(input [7 : 0] x);
		F = ((x << 1) ^ (((x >> 7) & 1) * 8'h1b));
endfunction	



always_comb
	if(!in_rc_empty && !out_rc_full)
		begin
		in_rc_read <= 1;
		out_rc_write <= 1;
		out_rc_din <= F(in_rc_dout);
		end
		
	else
		begin
		in_rc_read <= 0;
		out_rc_write <= 0;	
		out_rc_din <= 'x;
		end

endmodule