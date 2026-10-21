`timescale 1 ns / 1 ps
// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Test Bench module 
// Date: 2026/09/18 19:41:37
//
// Please note that the testbench manages only common signals to dataflows
// - clock system signals
// - reset system signals
// - dataflow communication signals
//
// ----------------------------------------------------------------------------

module tb_multi_dataflow;

	// test bench parameters
	// ----------------------------------------------------------------------------
	parameter CLOCK_PERIOD = 10;
	
	parameter IN_PEL_ROBERTS_FILE = "in_pel_Roberts_file.mem";
	parameter IN_PEL_ROBERTS_SIZE = 64;
	parameter IN_PEL_SOBEL_FILE = "in_pel_Sobel_file.mem";
	parameter IN_PEL_SOBEL_SIZE = 64;
	parameter IN_SIZE_ROBERTS_FILE = "in_size_Roberts_file.mem";
	parameter IN_SIZE_ROBERTS_SIZE = 64;
	parameter IN_SIZE_SOBEL_FILE = "in_size_Sobel_file.mem";
	parameter IN_SIZE_SOBEL_SIZE = 64;
	
	parameter OUT_PEL_ROBERTS_FILE = "out_pel_Roberts_file.mem";
	parameter OUT_PEL_ROBERTS_SIZE = 64;
	parameter OUT_PEL_SOBEL_FILE = "out_pel_Sobel_file.mem";
	parameter OUT_PEL_SOBEL_SIZE = 64;
	
	// ----------------------------------------------------------------------------
	
	// multi_dataflow signals
	// ----------------------------------------------------------------------------
	reg start_feeding;
	reg [7 : 0] in_pel_data;
	reg in_pel_wr;
	wire in_pel_full;
	reg [7:0] in_pel_Roberts_file_data [IN_PEL_ROBERTS_SIZE-1:0];
	reg [7:0] in_pel_Sobel_file_data [IN_PEL_SOBEL_SIZE-1:0];
	integer in_pel_i = 0;
	reg [5 : 0] in_size_data;
	reg in_size_wr;
	wire in_size_full;
	reg [5:0] in_size_Roberts_file_data [IN_SIZE_ROBERTS_SIZE-1:0];
	reg [5:0] in_size_Sobel_file_data [IN_SIZE_SOBEL_SIZE-1:0];
	integer in_size_i = 0;
	
	wire [7 : 0] out_pel_data;
	wire out_pel_wr;
	reg out_pel_full;
	reg [7:0] out_pel_Roberts_file_data [OUT_PEL_ROBERTS_SIZE-1:0];
	reg [7:0] out_pel_Sobel_file_data [OUT_PEL_SOBEL_SIZE-1:0];
	integer out_pel_i = 0;
	
	
	reg [7:0] ID;
	
	reg clock;
	reg reset;
	// ----------------------------------------------------------------------------

	// network input and output files
	// ----------------------------------------------------------------------------
	initial
	 	$readmemh(IN_PEL_ROBERTS_FILE, in_pel_Roberts_file_data);
	initial
	 	$readmemh(IN_SIZE_ROBERTS_FILE, in_size_Roberts_file_data);
	initial
		$readmemh(OUT_PEL_ROBERTS_FILE, out_pel_Roberts_file_data);
	initial
	 	$readmemh(IN_PEL_SOBEL_FILE, in_pel_Sobel_file_data);
	initial
	 	$readmemh(IN_SIZE_SOBEL_FILE, in_size_Sobel_file_data);
	initial
		$readmemh(OUT_PEL_SOBEL_FILE, out_pel_Sobel_file_data);
	// ----------------------------------------------------------------------------

	// dut
	// ----------------------------------------------------------------------------
	multi_dataflow dut (
		.in_pel_data(in_pel_data),
		.in_pel_wr(in_pel_wr),
		.in_pel_full(in_pel_full),
		
		.in_size_data(in_size_data),
		.in_size_wr(in_size_wr),
		.in_size_full(in_size_full),
		
		.out_pel_data(out_pel_data),
		.out_pel_wr(out_pel_wr),
		.out_pel_full(out_pel_full),
		
		
		.ID(ID),
				
		.clock(clock),
		.reset(reset)
	);	
	// ----------------------------------------------------------------------------

	// clocks
	// ----------------------------------------------------------------------------
	always #(CLOCK_PERIOD/2)
		clock = ~clock;
	// ----------------------------------------------------------------------------

	// signals evolution
	// ----------------------------------------------------------------------------
	initial
	begin
		// feeding flag initialization
		start_feeding = 0;
		
		// network configuration
		ID = 8'd0;
		
	
		// clocks initialization
			clock = 0;
	
		// network signals initialization
				in_pel_data = 0;
							in_pel_wr  = 1'b0;
				in_size_data = 0;
							in_size_wr  = 1'b0;
				out_pel_full = 1'b0;
	
		// initial reset
				reset = 1;
		#2
				reset = 0;
		#100
				reset = 1;
		#100
	
		// network inputs (output side)
				out_pel_full = 1'b0;
				
		 		// executing Roberts
		 		ID = 8'd1;
	start_feeding = 1;
	while(in_pel_i != IN_PEL_ROBERTS_SIZE)
		#10;
	while(in_size_i != IN_SIZE_ROBERTS_SIZE)
		#10;
	start_feeding = 0;
	in_pel_data = 0;
	in_pel_wr  = 1'b0;
	in_pel_i = 0;
	in_size_data = 0;
	in_size_wr  = 1'b0;
	in_size_i = 0;
	#1000
		 		// executing Sobel
		 		ID = 8'd2;
	start_feeding = 1;
	while(in_pel_i != IN_PEL_SOBEL_SIZE)
		#10;
	while(in_size_i != IN_SIZE_SOBEL_SIZE)
		#10;
	start_feeding = 0;
	in_pel_data = 0;
	in_pel_wr  = 1'b0;
	in_pel_i = 0;
	in_size_data = 0;
	in_size_wr  = 1'b0;
	in_size_i = 0;
	#1000
	
		$stop;
	end
	// ----------------------------------------------------------------------------

	// input feeding
	// ----------------------------------------------------------------------------
	always@(*)
		if(start_feeding && ID == 1)
	 			begin
			while(in_pel_i < IN_PEL_ROBERTS_SIZE)
			begin
				#10
			 			if(in_pel_full == 0)
			 			begin
							in_pel_data = in_pel_Roberts_file_data[in_pel_i];
							in_pel_wr  = 1'b1;
					in_pel_i = in_pel_i + 1;
				end
				else
				begin
							in_pel_data = 0;
							in_pel_wr  = 1'b0;
				end
			end
			#10
					in_pel_data = 0;
					in_pel_wr  = 1'b0;
				end
	always@(*)
		if(start_feeding && ID == 1)
	 			begin
			while(in_size_i < IN_SIZE_ROBERTS_SIZE)
			begin
				#10
			 			if(in_size_full == 0)
			 			begin
							in_size_data = in_size_Roberts_file_data[in_size_i];
							in_size_wr  = 1'b1;
					in_size_i = in_size_i + 1;
				end
				else
				begin
							in_size_data = 0;
							in_size_wr  = 1'b0;
				end
			end
			#10
					in_size_data = 0;
					in_size_wr  = 1'b0;
				end
	always@(*)
		if(start_feeding && ID == 2)
	 			begin
			while(in_pel_i < IN_PEL_SOBEL_SIZE)
			begin
				#10
			 			if(in_pel_full == 0)
			 			begin
							in_pel_data = in_pel_Sobel_file_data[in_pel_i];
							in_pel_wr  = 1'b1;
					in_pel_i = in_pel_i + 1;
				end
				else
				begin
							in_pel_data = 0;
							in_pel_wr  = 1'b0;
				end
			end
			#10
					in_pel_data = 0;
					in_pel_wr  = 1'b0;
				end
	always@(*)
		if(start_feeding && ID == 2)
	 			begin
			while(in_size_i < IN_SIZE_SOBEL_SIZE)
			begin
				#10
			 			if(in_size_full == 0)
			 			begin
							in_size_data = in_size_Sobel_file_data[in_size_i];
							in_size_wr  = 1'b1;
					in_size_i = in_size_i + 1;
				end
				else
				begin
							in_size_data = 0;
							in_size_wr  = 1'b0;
				end
			end
			#10
					in_size_data = 0;
					in_size_wr  = 1'b0;
				end
	// ----------------------------------------------------------------------------

	// output check
	// ----------------------------------------------------------------------------
	always@(posedge clock)
				if(ID == 1)
					begin
					if(out_pel_wr == 1)
						begin	
						if(out_pel_data != out_pel_Roberts_file_data[out_pel_i])
							$display("Error for config %d on output %d: obtained %d, expected %d", 1, out_pel_i, out_pel_data, out_pel_Roberts_file_data[out_pel_i]);
						out_pel_i = out_pel_i + 1;
						end
									if(out_pel_i == OUT_PEL_ROBERTS_SIZE)
						out_pel_i = 0;
					end
	always@(posedge clock)
				if(ID == 2)
					begin
					if(out_pel_wr == 1)
						begin	
						if(out_pel_data != out_pel_Sobel_file_data[out_pel_i])
							$display("Error for config %d on output %d: obtained %d, expected %d", 2, out_pel_i, out_pel_data, out_pel_Sobel_file_data[out_pel_i]);
						out_pel_i = out_pel_i + 1;
						end
									if(out_pel_i == OUT_PEL_SOBEL_SIZE)
						out_pel_i = 0;
					end
	// ----------------------------------------------------------------------------

endmodule
