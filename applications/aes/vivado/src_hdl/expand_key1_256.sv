`ifndef ith
`define ith *8 +: 8
`endif



module expand_key1_256(
	input [255 : 0] in_key_dout,
	output reg in_key_read,
	input in_key_empty,
	
	output reg [255 : 0] out_key_din,
	output reg out_key_write,
	input out_key_full,
	
	input clk,
	input rst
);


parameter reg [7 : 0] look_up_table [0 : 255] = 
	{
	8'h63, 8'h7c, 8'h77, 8'h7b, 8'hf2, 8'h6b, 8'h6f, 8'hc5,
    8'h30, 8'h01, 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76,
    8'hca, 8'h82, 8'hc9, 8'h7d, 8'hfa, 8'h59, 8'h47, 8'hf0,
    8'had, 8'hd4, 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0,
    8'hb7, 8'hfd, 8'h93, 8'h26, 8'h36, 8'h3f, 8'hf7, 8'hcc,
    8'h34, 8'ha5, 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15,
    8'h04, 8'hc7, 8'h23, 8'hc3, 8'h18, 8'h96, 8'h05, 8'h9a,
    8'h07, 8'h12, 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75,
    8'h09, 8'h83, 8'h2c, 8'h1a, 8'h1b, 8'h6e, 8'h5a, 8'ha0,
    8'h52, 8'h3b, 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84,
    8'h53, 8'hd1, 8'h00, 8'hed, 8'h20, 8'hfc, 8'hb1, 8'h5b,
    8'h6a, 8'hcb, 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf,
    8'hd0, 8'hef, 8'haa, 8'hfb, 8'h43, 8'h4d, 8'h33, 8'h85,
    8'h45, 8'hf9, 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8,
    8'h51, 8'ha3, 8'h40, 8'h8f, 8'h92, 8'h9d, 8'h38, 8'hf5,
    8'hbc, 8'hb6, 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2,
    8'hcd, 8'h0c, 8'h13, 8'hec, 8'h5f, 8'h97, 8'h44, 8'h17,
    8'hc4, 8'ha7, 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73,
    8'h60, 8'h81, 8'h4f, 8'hdc, 8'h22, 8'h2a, 8'h90, 8'h88,
    8'h46, 8'hee, 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb,
    8'he0, 8'h32, 8'h3a, 8'h0a, 8'h49, 8'h06, 8'h24, 8'h5c,
    8'hc2, 8'hd3, 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79,
    8'he7, 8'hc8, 8'h37, 8'h6d, 8'h8d, 8'hd5, 8'h4e, 8'ha9,
    8'h6c, 8'h56, 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08,
    8'hba, 8'h78, 8'h25, 8'h2e, 8'h1c, 8'ha6, 8'hb4, 8'hc6,
    8'he8, 8'hdd, 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a,
    8'h70, 8'h3e, 8'hb5, 8'h66, 8'h48, 8'h03, 8'hf6, 8'h0e,
    8'h61, 8'h35, 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e,
    8'he1, 8'hf8, 8'h98, 8'h11, 8'h69, 8'hd9, 8'h8e, 8'h94,
    8'h9b, 8'h1e, 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf,
    8'h8c, 8'ha1, 8'h89, 8'h0d, 8'hbf, 8'he6, 8'h42, 8'h68,
    8'h41, 8'h99, 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16
	};

function [7 : 0] sub_byte(input [7 : 0] in_byte);
		sub_byte = look_up_table[in_byte];
endfunction



always_comb
	if(!in_key_empty && !out_key_full)
		begin
		in_key_read <= 1;
		out_key_write <= 1;		
		
		out_key_din[0`ith] <= in_key_dout[0`ith];
		out_key_din[1`ith] <= in_key_dout[1`ith];	
		out_key_din[2`ith] <= in_key_dout[2`ith];		
		out_key_din[3`ith] <= in_key_dout[3`ith];

		out_key_din[(4)`ith] <= in_key_dout[(4)`ith] ^ in_key_dout[(4-4)`ith];
		out_key_din[(4+1)`ith] <= in_key_dout[(4+1)`ith] ^ in_key_dout[(4-3)`ith];
		out_key_din[(4+2)`ith] <= in_key_dout[(4+2)`ith] ^ in_key_dout[(4-2)`ith];
		out_key_din[(4+3)`ith] <= in_key_dout[(4+3)`ith] ^ in_key_dout[(4-1)`ith];	
		
		out_key_din[8`ith] <= in_key_dout[8`ith];
		out_key_din[9`ith] <= in_key_dout[9`ith];
		out_key_din[10`ith] <= in_key_dout[10`ith];
		out_key_din[11`ith] <= in_key_dout[11`ith];
		out_key_din[12`ith] <= in_key_dout[12`ith];
		out_key_din[13`ith] <= in_key_dout[13`ith];
		out_key_din[14`ith] <= in_key_dout[14`ith];
		out_key_din[15`ith] <= in_key_dout[15`ith];
		out_key_din[16`ith] <= in_key_dout[16`ith];
		out_key_din[17`ith] <= in_key_dout[17`ith];
		out_key_din[18`ith] <= in_key_dout[18`ith];
		out_key_din[19`ith] <= in_key_dout[19`ith];
		out_key_din[20`ith] <= in_key_dout[20`ith];
		out_key_din[21`ith] <= in_key_dout[21`ith];
		out_key_din[22`ith] <= in_key_dout[22`ith];
		out_key_din[23`ith] <= in_key_dout[23`ith];
		out_key_din[24`ith] <= in_key_dout[24`ith];
		out_key_din[25`ith] <= in_key_dout[25`ith];
		out_key_din[26`ith] <= in_key_dout[26`ith];
		out_key_din[27`ith] <= in_key_dout[27`ith];
		out_key_din[28`ith] <= in_key_dout[28`ith];
		out_key_din[29`ith] <= in_key_dout[29`ith];		
		out_key_din[30`ith] <= in_key_dout[30`ith];
		out_key_din[31`ith] <= in_key_dout[31`ith];				
		end
		
	else
		begin
		in_key_read <= 0;
		out_key_write <= 0;	
		out_key_din <= 'x;
		end

endmodule