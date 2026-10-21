// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Sbox 2x1 module 
// Date: 2026/07/25 15:38:30
//
// ----------------------------------------------------------------------------

module sbox2x1 #(
	parameter SIZE = 32
)(
	output [SIZE-1 : 0] out1_data,
	output out1_wr,
	input out1_full,
	input [SIZE-1 : 0] in1_data,
	input [SIZE-1 : 0] in2_data,
	input in1_wr,
	input in2_wr,
	output in1_full,
	output in2_full,
	input sel
);


assign out1_data = sel ? in2_data : in1_data;
assign out1_wr = sel ? in2_wr : in1_wr;
assign in1_full = sel ? {1{1'b0}} : out1_full;
assign in2_full = sel ? out1_full : {1{1'b0}};

endmodule
