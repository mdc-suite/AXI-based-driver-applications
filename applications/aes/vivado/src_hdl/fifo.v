`timescale 1ns / 1ps


//-------------------------------------------------
// NB: la fifo deve avere 2^n locazioni 
//-------------------------------------------------

module fifo #(
    width = 0,
    depth = 0
) (
    output  full,
    input  [width-1:0] din,
    input write,
    output  empty,
    output  reg [width-1:0] dout,
    input read,
    input clk,
    input rst 
);
       
reg read_c, write_c;
reg empty_c;
reg [$clog2(depth):0] read_addr, write_addr;
reg [width-1:0] inputD, outputD, inputR;
wire [width-1:0] outputR;
        
	ram #(
		.depth(depth),
		.size(width)
	) mem (
		.clock(clk),
		.data(inputR),
		.write_address(write_addr[$clog2(depth)-1:0]),
		.read_address(read_addr[$clog2(depth)-1:0]),
		.we(write),
		.q(outputR)
	);
        
	always@(posedge clk)
		begin
			write_c <= write;
			read_c <= read;
			empty_c <= empty;
			outputD <= inputD;
		end
		
	always@(*)
		if( (empty_c) && (read_c==1'b1) && (write_c==1'b1) )
			begin
				inputD = din;
				inputR = {width{1'bx}};
				dout = outputD;
			end
		else
			begin
				inputD = {width{1'bx}};
				inputR = din;
				dout = outputR;
			end  

//------------------------------------------
// gestione dell indirizzo di lettura
    
   always@(posedge clk)
            if (rst)
                read_addr <= 0;
            else if(read && !empty)
                   read_addr <= read_addr+1; 

//---------------------------------------------                     
// gestione indirizzo di scrittura
       always@(posedge clk)
      if (rst)
          write_addr <= 0;
      else if(write && !full)
           write_addr = write_addr+1; 

//---------------------------------------------
// generazione empty


assign empty = (read_addr == write_addr) ? 1 : 0;
            
//----------------------------------------------
// generazione full


assign full = ((read_addr[$clog2(depth)-1:0] == write_addr[$clog2(depth)-1:0])
               && (read_addr[$clog2(depth)] != write_addr[$clog2(depth)]))    ? 1 : 0;

         
//----------------------------------------------

endmodule


 
module ram #(
    depth = 10,
    size = 10
) (
    input clock,
    input [size-1:0] data,
    input [$clog2(depth)-1:0] write_address,
    input [$clog2(depth)-1:0] read_address,
    input we,
    output [size-1:0] q
);
    reg [size-1:0] ram_block [0:depth-1];
    always@(posedge clock)
        if(we)
            ram_block[write_address] <= data;
            
    assign q = ram_block[read_address];

endmodule

