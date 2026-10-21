// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Sbox 1x2 module 
// Date: 2026/08/03 11:26:13
//
// ----------------------------------------------------------------------------

module sbox1x2 #(
	parameter SIZE = 32
)(
	output [SIZE-1 : 0] out1_data,
	output [SIZE-1 : 0] out2_data,
	output out1_wr,
	output out2_wr,
	input out1_full,
	input out2_full,
	input [SIZE-1 : 0] in1_data,
	input in1_wr,
	output in1_full,
	input sel
);


assign out1_data = sel ? {SIZE{1'b0}} : in1_data;
assign out2_data = sel ? in1_data : {SIZE{1'b0}};
assign out1_wr = sel ? {1{1'b0}} : in1_wr;
assign out2_wr = sel ? in1_wr : {1{1'b0}};
assign in1_full = sel ? out2_full : out1_full;

endmodule
