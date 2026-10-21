`timescale 1 ns / 1 ps
// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Test Bench module 
// Date: 2026/07/25 15:38:30
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
	
	parameter IN0_TOP1_FILE = "in0_top1_file.mem";
	parameter IN0_TOP1_SIZE = 64;
	parameter IN0_TOP2_FILE = "in0_top2_file.mem";
	parameter IN0_TOP2_SIZE = 64;
	parameter IN1_TOP1_FILE = "in1_top1_file.mem";
	parameter IN1_TOP1_SIZE = 64;
	parameter IN1_TOP2_FILE = "in1_top2_file.mem";
	parameter IN1_TOP2_SIZE = 64;
	
	parameter OUT0_TOP1_FILE = "out0_top1_file.mem";
	parameter OUT0_TOP1_SIZE = 64;
	parameter OUT0_TOP2_FILE = "out0_top2_file.mem";
	parameter OUT0_TOP2_SIZE = 64;
	
	// ----------------------------------------------------------------------------
	
	// multi_dataflow signals
	// ----------------------------------------------------------------------------
	reg start_feeding;
	reg [7 : 0] in0_data;
	reg in0_wr;
	wire in0_full;
	reg [7:0] in0_top1_file_data [IN0_TOP1_SIZE-1:0];
	reg [7:0] in0_top2_file_data [IN0_TOP2_SIZE-1:0];
	integer in0_i = 0;
	reg [5 : 0] in1_data;
	reg in1_wr;
	wire in1_full;
	reg [5:0] in1_top1_file_data [IN1_TOP1_SIZE-1:0];
	reg [5:0] in1_top2_file_data [IN1_TOP2_SIZE-1:0];
	integer in1_i = 0;
	
	wire [7 : 0] out0_data;
	wire out0_wr;
	reg out0_full;
	reg [7:0] out0_top1_file_data [OUT0_TOP1_SIZE-1:0];
	reg [7:0] out0_top2_file_data [OUT0_TOP2_SIZE-1:0];
	integer out0_i = 0;
	
	
	reg [7:0] ID;
	
	reg clock;
	reg reset;
	// ----------------------------------------------------------------------------

	// network input and output files
	// ----------------------------------------------------------------------------
	initial
	 	$readmemh(IN0_TOP1_FILE, in0_top1_file_data);
	initial
	 	$readmemh(IN1_TOP1_FILE, in1_top1_file_data);
	initial
		$readmemh(OUT0_TOP1_FILE, out0_top1_file_data);
	initial
	 	$readmemh(IN0_TOP2_FILE, in0_top2_file_data);
	initial
	 	$readmemh(IN1_TOP2_FILE, in1_top2_file_data);
	initial
		$readmemh(OUT0_TOP2_FILE, out0_top2_file_data);
	// ----------------------------------------------------------------------------

	// dut
	// ----------------------------------------------------------------------------
	multi_dataflow dut (
		.in0_data(in0_data),
		.in0_wr(in0_wr),
		.in0_full(in0_full),
		
		.in1_data(in1_data),
		.in1_wr(in1_wr),
		.in1_full(in1_full),
		
		.out0_data(out0_data),
		.out0_wr(out0_wr),
		.out0_full(out0_full),
		
		
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
				in0_data = 0;
							in0_wr  = 1'b0;
				in1_data = 0;
							in1_wr  = 1'b0;
				out0_full = 1'b0;
	
		// initial reset
				reset = 1;
		#2
				reset = 0;
		#100
				reset = 1;
		#100
	
		// network inputs (output side)
				out0_full = 1'b0;
				
		 		// executing top1
		 		ID = 8'd1;
	start_feeding = 1;
	while(in0_i != IN0_TOP1_SIZE)
		#10;
	while(in1_i != IN1_TOP1_SIZE)
		#10;
	start_feeding = 0;
	in0_data = 0;
	in0_wr  = 1'b0;
	in0_i = 0;
	in1_data = 0;
	in1_wr  = 1'b0;
	in1_i = 0;
	#1000
		 		// executing top2
		 		ID = 8'd2;
	start_feeding = 1;
	while(in0_i != IN0_TOP2_SIZE)
		#10;
	while(in1_i != IN1_TOP2_SIZE)
		#10;
	start_feeding = 0;
	in0_data = 0;
	in0_wr  = 1'b0;
	in0_i = 0;
	in1_data = 0;
	in1_wr  = 1'b0;
	in1_i = 0;
	#1000
	
		$stop;
	end
	// ----------------------------------------------------------------------------

	// input feeding
	// ----------------------------------------------------------------------------
	always@(*)
		if(start_feeding && ID == 1)
	 			begin
			while(in0_i < IN0_TOP1_SIZE)
			begin
				#10
			 			if(in0_full == 0)
			 			begin
							in0_data = in0_top1_file_data[in0_i];
							in0_wr  = 1'b1;
					in0_i = in0_i + 1;
				end
				else
				begin
							in0_data = 0;
							in0_wr  = 1'b0;
				end
			end
			#10
					in0_data = 0;
					in0_wr  = 1'b0;
				end
	always@(*)
		if(start_feeding && ID == 1)
	 			begin
			while(in1_i < IN1_TOP1_SIZE)
			begin
				#10
			 			if(in1_full == 0)
			 			begin
							in1_data = in1_top1_file_data[in1_i];
							in1_wr  = 1'b1;
					in1_i = in1_i + 1;
				end
				else
				begin
							in1_data = 0;
							in1_wr  = 1'b0;
				end
			end
			#10
					in1_data = 0;
					in1_wr  = 1'b0;
				end
	always@(*)
		if(start_feeding && ID == 2)
	 			begin
			while(in0_i < IN0_TOP2_SIZE)
			begin
				#10
			 			if(in0_full == 0)
			 			begin
							in0_data = in0_top2_file_data[in0_i];
							in0_wr  = 1'b1;
					in0_i = in0_i + 1;
				end
				else
				begin
							in0_data = 0;
							in0_wr  = 1'b0;
				end
			end
			#10
					in0_data = 0;
					in0_wr  = 1'b0;
				end
	always@(*)
		if(start_feeding && ID == 2)
	 			begin
			while(in1_i < IN1_TOP2_SIZE)
			begin
				#10
			 			if(in1_full == 0)
			 			begin
							in1_data = in1_top2_file_data[in1_i];
							in1_wr  = 1'b1;
					in1_i = in1_i + 1;
				end
				else
				begin
							in1_data = 0;
							in1_wr  = 1'b0;
				end
			end
			#10
					in1_data = 0;
					in1_wr  = 1'b0;
				end
	// ----------------------------------------------------------------------------

	// output check
	// ----------------------------------------------------------------------------
	always@(posedge clock)
				if(ID == 1)
					begin
					if(out0_wr == 1)
						begin	
						if(out0_data != out0_top1_file_data[out0_i])
							$display("Error for config %d on output %d: obtained %d, expected %d", 1, out0_i, out0_data, out0_top1_file_data[out0_i]);
						out0_i = out0_i + 1;
						end
									if(out0_i == OUT0_TOP1_SIZE)
						out0_i = 0;
					end
	always@(posedge clock)
				if(ID == 2)
					begin
					if(out0_wr == 1)
						begin	
						if(out0_data != out0_top2_file_data[out0_i])
							$display("Error for config %d on output %d: obtained %d, expected %d", 2, out0_i, out0_data, out0_top2_file_data[out0_i]);
						out0_i = out0_i + 1;
						end
									if(out0_i == OUT0_TOP2_SIZE)
						out0_i = 0;
					end
	// ----------------------------------------------------------------------------

endmodule
