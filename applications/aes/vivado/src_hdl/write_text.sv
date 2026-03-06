`timescale 1ns / 1ps

module write_text(
	input [127 : 0] in_token_dout,
	output reg in_token_read,
	input in_token_empty,
	
	output reg [31 : 0] out_token_din,
	output reg out_token_write,
	input out_token_full,	
	
	input clk,
	input rst
);

	localparam TEXT_SIZE = 128;
	localparam TOKEN_SIZE = 32;
	localparam N_TOKEN = TEXT_SIZE / TOKEN_SIZE;
	localparam COUNTER_SIZE = $clog2(N_TOKEN) + 1;

	reg [COUNTER_SIZE-1 : 0] counterTokens;
	reg [COUNTER_SIZE-1 : 0] next_CounterTokens;
	
	reg [TEXT_SIZE-1 : 0] partial_token;
	reg [TEXT_SIZE-1 : 0] next_partial_token;
	reg en_partial_token;

	always@(posedge clk)
		begin
		if (rst)
			counterTokens <= N_TOKEN;
		else
			counterTokens <= next_CounterTokens;
		end
		
	always@(posedge clk)
		begin
		if(en_partial_token)
			partial_token <= next_partial_token;
		end

always_comb
	if (counterTokens == N_TOKEN && !in_token_empty)
		begin
        in_token_read = 1;
		out_token_din = 'x;
		out_token_write = 0;
		next_CounterTokens = 0;
		en_partial_token = 1;
		next_partial_token = in_token_dout;
		end
	
	else if(counterTokens < N_TOKEN && !out_token_full)
		begin
        in_token_read = 0;
		out_token_din = partial_token[TOKEN_SIZE-1 : 0];
		out_token_write = 1;
		next_CounterTokens = counterTokens + 1;
		en_partial_token = 1;
		next_partial_token = partial_token >> TOKEN_SIZE;		
		end
	
	else
		begin
        in_token_read = 0;
		out_token_din = 'x;
		out_token_write = 0;
		next_CounterTokens = counterTokens;
		en_partial_token = 0;
		next_partial_token = 'x;		
		end	
endmodule