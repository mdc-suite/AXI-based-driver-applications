module aes256_accelerator_1t (
	
	// Ports of Axi Slave Bus Interface S00_AXIS	->	TEXT
	input wire  s00_axis_aclk,
	input wire  s00_axis_aresetn,
	output wire  s00_axis_tready,
	input wire [31 : 0] s00_axis_tdata,
	input wire  s00_axis_tlast,
	input wire  s00_axis_tvalid,
	input wire  [3 : 0] s00_axis_tkeep,
	
	// Ports of Axi Slave Bus Interface S01_AXIS	->	KEY
	input wire  s01_axis_aclk,
	input wire  s01_axis_aresetn,
	output wire  s01_axis_tready,
	input wire [31 : 0] s01_axis_tdata,
	input wire  s01_axis_tlast,
	input wire  s01_axis_tvalid,
	input wire  [3 : 0] s01_axis_tkeep,
	
	// Ports of Axi Master Bus Interface M00_AXIS	->	CHIPED_TEXT
	input wire  m00_axis_aclk,
	input wire  m00_axis_aresetn,
	output wire  m00_axis_tvalid,
	output wire [31 : 0] m00_axis_tdata,
	output wire  [3 : 0] m00_axis_tkeep,
	output wire  m00_axis_tlast,
	input wire  m00_axis_tready
	);


/* Accelerator inst */
wire [31 : 0] text_din;
wire text_write;
wire text_full;
wire [31 : 0] key_din;
wire key_write;
wire key_full;
wire [7 : 0] rc_din;
wire rc_write;
wire rc_full;
wire [31 : 0] chiped_text_din;
wire chiped_text_write;
wire chiped_text_full;

multi_dataflow i_multidataflow(
	.text_din(text_din),
	.text_write(text_write),
	.text_full(text_full),
	
	.key_din(key_din),
	.key_write(key_write),
	.key_full(key_full),
	
	.rc_din(rc_din),
	.rc_write(rc_write),
	.rc_full(rc_full),
	
	.chiped_text_din(chiped_text_din),
	.chiped_text_write(chiped_text_write),
	.chiped_text_full(chiped_text_full),

	.clock(s00_axis_aclk),
	.reset(~s00_axis_aresetn)
);

/* Counters inst */
localparam CNT_S = 10;
wire clr_t0;
wire en_t0;
wire [CNT_S-1 : 0] max_t0;
wire [CNT_S-1 : 0] count_t0;
wire last_t0;

assign max_t0 = 4;
assign en_t0 = chiped_text_write;

counter #(			
	.SIZE(CNT_S) ) 
i_counter_t0 (
	.aclk(s00_axis_aclk),
	.aresetn(s00_axis_aresetn),
	.clr(clr_t0),
	.en(en_t0),
	.max(max_t0),
	.count(count_t0),
	.last(last_t0)
);


/* wire assignments */

// S00
assign s00_axis_tready = ~(|text_full);
assign s01_axis_tready = ~(|key_full);

// M00
assign m00_axis_tdata = chiped_text_din[31 : 0];
assign m00_axis_tlast = last_t0;   //Tanto durano un solo ciclo di clock
assign m00_axis_tvalid = chiped_text_write;
assign m00_axis_tkeep = 4'b1111;


// multidataflow
assign text_din = s00_axis_tdata;
assign text_write = s00_axis_tvalid & s00_axis_tready;
assign key_din = s01_axis_tdata;
assign key_write = s01_axis_tvalid & s01_axis_tready;
assign chiped_text_full = ~m00_axis_tready;


// avoid third DMA for rc
reg [4 : 0] cnt_key_t0;

always @(posedge s01_axis_aclk, negedge s01_axis_aresetn)
	if(!s01_axis_aresetn)
		cnt_key_t0 <= 0;
	else
		if(key_write)
			if((cnt_key_t0 == 7))
				cnt_key_t0 <= 0;
			else
			     cnt_key_t0 <= cnt_key_t0 + 1;
				 

			     
assign rc_din = 8'd1;
assign rc_write = key_write && (cnt_key_t0 == 1);
endmodule