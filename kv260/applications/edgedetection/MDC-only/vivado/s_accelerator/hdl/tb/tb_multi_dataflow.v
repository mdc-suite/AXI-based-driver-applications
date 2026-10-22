`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2018 12:52:54
// Design Name: 
// Module Name: tb_multi_dataflow
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_multi_dataflow;

    reg [5 : 0] in_size_data;
	reg in_size_wr;
	wire in_size_full;
	
	reg [7 : 0] in_pel_data;
	reg in_pel_wr;
	wire in_pel_full;
	
	wire  [7 : 0] out_pel_data;
	wire  out_pel_wr;
	reg  out_pel_full;
	
	reg [7:0] ID;			
	reg clock;
	reg reset;

    multi_dataflow dut(
        .in_size_data(in_size_data),
        .in_size_wr(in_size_wr),
        .in_size_full(in_size_full),
        .in_pel_data(in_pel_data),
        .in_pel_wr(in_pel_wr),
        .in_pel_full(in_pel_full),
        .out_pel_data(out_pel_data),
        .out_pel_wr(out_pel_wr),
        .out_pel_full(out_pel_full),
        .ID(8'd2),  // 2 sobel, 1 roberts
        .clock(clock),
        .reset(reset)
    );	
    
    always #20 clock = ~clock;
    
    parameter SIZE = 6; // 6 sobel, 5 roberts
    integer i,j;
    
    initial
        begin
            clock = 0;
            reset = 1;
            in_size_data = 0;
            in_size_wr = 0;
            in_pel_data = 0;
            in_pel_wr = 0;
            out_pel_full = 0;
            
            #3
            reset = 0;
            
            #120
            reset = 1;
            
            #40
            in_size_data = 6;
            in_size_wr = 1;
            
            #40
            in_size_data = 0;
            in_size_wr = 0;
            
            for(i=0; i<=SIZE; i=i+1)
                for(j=1; j<=SIZE; j=j+1)
                    begin
                        if(in_pel_full) 
                            begin
                                in_pel_data = 0;
                                in_pel_wr = 0;
                                j = j-1;
                            end
                        else
                            begin
                                in_pel_data = i*SIZE+j;
                                in_pel_wr = 1;
                            end
                        #40;
                    end
            #20 in_pel_wr = 0;
                    
            #100
            $stop;
                        
        end
    
endmodule
