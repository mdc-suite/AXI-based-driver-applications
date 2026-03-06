`ifndef ith
`define ith *8 +: 8
`endif

/* Extracts the 128-bit key for the forst and second round from the initial 256-bit key */

module round_key_256(
	input [255 : 0] in_key_dout,
	output reg in_key_read,
	input in_key_empty,

	output reg [127 : 0] out_key0_din,
	output reg out_key0_write,
	input out_key0_full,

	output reg [127 : 0] out_key1_din,
	output reg out_key1_write,
	input out_key1_full,
	
	input clk,
	input rst
);

always_comb
    if(!in_key_empty && !out_key0_full && !out_key1_full)
        begin
        in_key_read <= 1;
        out_key0_din <= in_key_dout[127 : 0];
        out_key0_write <= 1;
        out_key1_din <= in_key_dout[255 : 128];
        out_key1_write <= 1;
        end
     else
        begin
        in_key_read <= 0;
        out_key0_din <= 'x;
        out_key0_write <= 0;
        out_key1_din <= 'x;
        out_key1_write <= 0;
        end

endmodule





// OLD VERSION

//parameter [2 : 0] READ = 1, WRITE1 = 2, WRITE2 = 4;

//reg [255 : 0] round_key, round_key_nxt;
//reg round_key_en;

//reg [2 : 0] state, state_nxt;
//reg state_en;


// data
//always @(posedge clk)
//	if(round_key_en) 
//		round_key <= round_key_nxt;


// control
//always @(posedge clk)
//	if(rst)
//		state <= READ;
//	else if(state_en)
//		state <= state_nxt;


//always_comb
//	if(state == READ && !in_key_empty)
//		begin
//		in_key_read <= 1;
//		out_key_din <= 'x;
//		out_key_write <= 0;
		
//		round_key_en <= 1;
//		round_key_nxt <= in_key_dout;
		
//		state_en <= 1;
//		state_nxt <= WRITE1;		
//		end
//	else if(state == WRITE1 && !out_key_full)
//		begin
//		in_key_read <= 0;
//		out_key_din <= round_key[127 : 0];
//		out_key_write <= 0;
		
//		round_key_en <= 0;
//		round_key_nxt <= 'x;
		
//		state_en <= 1;
//		state_nxt <= WRITE2;		
//		end		
//	else if(state == WRITE2 && !out_key_full)
//		begin
//		in_key_read <= 0;
//		out_key_din <= round_key[255 : 128];
//		out_key_write <= 0;
		
//		round_key_en <= 0;
//		round_key_nxt <= 'x;
		
//		state_en <= 1;
//		state_nxt <= READ;		
//		end			
//	else
//		begin
//		in_key_read <= 0;
//		out_key_din <= 'x;
//		out_key_write <= 0;
		
//		round_key_en <= 0;
//		round_key_nxt <= 'x;
		
//		state_en <= 0;
//		state_nxt <= 'x;		
//		end				

// endmodule