`timescale 1ns / 1ps

`define ZYNQ_VIP_0 tb.zynq_sys.line_detector_bd_i.zynq_ultra_ps_e_0.inst

`define DMA_M_AXIS_MM2S_TLAST tb.zynq_sys.line_detector_bd_i.axi_dma_0.M_AXIS_MM2S.TLAST

`define VPA_IP_0_START 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.ap_start
`define VPA_IP_0_LB1	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.line_buff1_U0.ap_start
`define VPA_IP_0_GA 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.gaussian_U0.ap_start
`define VPA_IP_0_LB2	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.line_buff2_U0.ap_start
`define VPA_IP_0_GR 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.gradient_U0.ap_start
`define VPA_IP_0_LB3m	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.line_buff3_magn_U0.ap_start
`define VPA_IP_0_LB3d	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.line_buff3_dir_U0.ap_start
`define VPA_IP_0_nMSH 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.nMS_Hys_U0.ap_start
`define VPA_IP_0_HSS 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_dataflow_parent_loop_proc_fu_2562.dataflow_in_loop_VITIS_LOOP_189_1_1_U0.hough_space_size_U0.ap_start
`define VPA_IP_0_AP 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_accumulation_point_fu_3066.ap_start
`define VPA_IP_0_ED 	tb.zynq_sys.line_detector_bd_i.VPA_IP_0.inst.grp_elaboration_data_fu_3088.ap_start

/* Zynq UltraScale+ VIP APIs used in this testbench

Reset the PL:
`ZYNQ_VIP_0.por_srstb_reset(por_reset_ctrl);
`ZYNQ_VIP_0.fpga_soft_reset([3:0] reset_ctrl);

Debug:
`ZYNQ_VIP_0.set_debug_level_info(LEVEL);
`ZYNQ_VIP_0.set_verbosity(VERBOSITY); // 32'd0 None, 32'd400 Full
`ZYNQ_VIP_0.set_stop_on_error(LEVEL);

Single Reads/Writes:
`ZYNQ_VIP_0.write_data([31:0] addr, [7:0] wr_size, [1023:0] wr_data, RESPONSE);
`ZYNQ_VIP_0.read_data([31:0] addr, [7:0] rd_size, DATA, RESPONSE);

Burst Reads/Writes: 
`ZYNQ_VIP_0.write_burst(ADDR, LEN, SIZE, BURST, LOCK, CACHE, PROT, DATA, DATASIZE, RESPONSE);
`ZYNQ_VIP_0.write_burst_concurrent(ADDR, LEN, SIZE, BURST, LOCK, CACHE, PROT, DATA, DATASIZE, RESPONSE);
`ZYNQ_VIP_0.read_burst(ADDR, LEN, SIZE, BURST, LOCK, CACHE, PROT, DATA, RESPONSE);

Memory Functions:
`ZYNQ_VIP_0.pre_load_mem_from_file([2047:0] file_name, [31:0] start_addr, Num lines);
`ZYNQ_VIP_0.read_mem([31:0] start_addr, no_of_bytes, [1023:0] data);

Interrupt:
`ZYNQ_VIP_0.wait_interrupt([3:0] irq, [15:0] irq_status);


RESPONSE: The slave write response from the following: [OKAY, EXOKAY, SLVERR, DECERR]

*/


module tb;

	integer b,i,j,k,x,y;
	
	parameter integer INPUT_DATA_WIDTH = 8;
	parameter integer IMAGE_DATA_WIDTH = 32;
	parameter integer BUS_ADDR_SIZE = 32;
	parameter integer BUS_DATA_SIZE = 32;
	parameter integer BURST_WIDTH = 256;
	parameter integer BURST_SIZE = BUS_DATA_SIZE*BURST_WIDTH;
	parameter integer IMAGE_WIDTH = 88;
	parameter integer IMAGE_HEIGHT = 142;
	parameter integer IMAGE_SIZE = IMAGE_HEIGHT*IMAGE_WIDTH;
	parameter integer IMAGE_DATA_SIZE = IMAGE_SIZE*(BUS_DATA_SIZE/IMAGE_DATA_WIDTH);
	parameter integer IB_RATIO = IMAGE_SIZE/(BURST_WIDTH*(BUS_DATA_SIZE/INPUT_DATA_WIDTH));
	parameter integer IB_REMAINDER = IMAGE_SIZE-(IB_RATIO*BURST_WIDTH);
	
	parameter INFO=0, DEBUG=1, WARN=2, ERROR=3;
	
	parameter IDLE=0, FIFO=1, DMA=2;
	
	parameter CHECK=0, START=1, END=3;
	
	parameter CLK_PERIOD=4.348;
	
	parameter [BUS_ADDR_SIZE-1:0] ACC_BASE_ADDR = 32'hB0000000;
	parameter [BUS_ADDR_SIZE-1:0] ACC_CTRL_REG_ADDR = ACC_BASE_ADDR;
	parameter [BUS_ADDR_SIZE-1:0] ACC_GIE_REG_ADDR = ACC_BASE_ADDR + 32'h04; //Global Interrupt Enable Register
	parameter [BUS_ADDR_SIZE-1:0] ACC_IER_REG_ADDR = ACC_BASE_ADDR + 32'h08; //IP Interrupt Enable Register
	parameter [BUS_ADDR_SIZE-1:0] ACC_OUT_DATA_REG_ADDR = ACC_BASE_ADDR + 32'h10;
	parameter [BUS_ADDR_SIZE-1:0] ACC_OUT_CTRL_REG_ADDR = ACC_BASE_ADDR + 32'h14;
	
	parameter [BUS_ADDR_SIZE-1:0] DMA_AXILITE_ADDR = 32'hA0000000;
	parameter [BUS_ADDR_SIZE-1:0] DMA_CTRL_REG_ADDR = DMA_AXILITE_ADDR;
	parameter [BUS_ADDR_SIZE-1:0] DMA_STATUS_REG_ADDR = DMA_AXILITE_ADDR + 32'h4;
	parameter [BUS_ADDR_SIZE-1:0] DMA_SRC_REG_ADDR = DMA_AXILITE_ADDR + 32'h18;
	parameter [BUS_ADDR_SIZE-1:0] DMA_DST_REG_ADDR = DMA_AXILITE_ADDR + 32'h48;
	parameter [BUS_ADDR_SIZE-1:0] DMA_LEN_REG_ADDR = DMA_AXILITE_ADDR + 32'h28;
	
	parameter [BUS_ADDR_SIZE-1:0] FIFO_AXILITE_ADDR = 32'hA0010000;
	parameter [BUS_ADDR_SIZE-1:0] FIFO_AXIFULL_ADDR = 32'hA0012000;
	
	parameter [BUS_ADDR_SIZE-1:0] HP0_DDR_LOW_ADDR = 32'h00000000;
	
	reg irq_test, ddr_test, resp;
	reg [1:0] tb_mode = INFO;
	reg [1:0] tb_task = IDLE;
	reg [BUS_DATA_SIZE-1:0] input_data;
    reg [BURST_SIZE-1:0] burst;
	reg [INPUT_DATA_WIDTH-1:0] input_image [0:IMAGE_SIZE-1];
	reg [15:0]  irq_status;
	reg [BUS_DATA_SIZE-1:0] ctrl_reg = 32'h00000000;
	reg [BUS_DATA_SIZE-1:0] out_ctrl_reg = 32'h00000000;
	reg [BUS_DATA_SIZE-1:0] out_data_reg = 32'h00000000;
	reg [BUS_DATA_SIZE-1:0] dma_status_reg = 32'h00000000;
	reg [BUS_DATA_SIZE-1:0] dma_ctrl_reg = 32'h00000000;
	reg [BUS_DATA_SIZE-1:0] ddr_data_reg = 32'h00000000;
	
	reg [BUS_ADDR_SIZE-1:0] inc_addr_reg = 32'h00000000;
	
	reg [1:0] vpa_lb1_exec_time_check = CHECK;
	reg [1:0] vpa_ga_exec_time_check = CHECK;
	reg [1:0] vpa_lb2_exec_time_check = CHECK;
	reg [1:0] vpa_gr_exec_time_check = CHECK;
	reg [1:0] vpa_lb3m_exec_time_check = CHECK;
	reg [1:0] vpa_lb3d_exec_time_check = CHECK;
	reg [1:0] vpa_nmsh_exec_time_check = CHECK;
	reg [1:0] vpa_hss_exec_time_check = CHECK;
	reg [1:0] vpa_hs_exec_time_check = CHECK;
	reg [1:0] vpa_ap_exec_time_check = CHECK;
	reg [1:0] vpa_ed_exec_time_check = CHECK;
	
	realtime fifo_exec_start_time;
	realtime fifo_exec_end_time;
	realtime fifo_exec_time;
	realtime fifo_com_start_time;
	realtime fifo_com_end_time;
	realtime fifo_com_time;
	realtime fifo_proc_start_time;
	realtime fifo_proc_end_time;
	realtime fifo_proc_time;
	realtime dma_exec_start_time;
	realtime dma_exec_end_time;
	realtime dma_exec_time;
	realtime dma_com_start_time;
	realtime dma_com_end_time;
	realtime dma_com_time;
	realtime dma_proc_start_time;
	realtime dma_proc_end_time;
	realtime dma_proc_time;
	realtime vpa_exec_start_time;
	realtime vpa_lb1_exec_start_time;
	realtime vpa_lb1_exec_end_time;
	realtime fifo_vpa_lb1_exec_time = 0;
	realtime dma_vpa_lb1_exec_time = 0;
	realtime vpa_ga_exec_start_time;
	realtime vpa_ga_exec_end_time;
	realtime fifo_vpa_ga_exec_time = 0;
	realtime dma_vpa_ga_exec_time = 0;
	realtime vpa_lb2_exec_start_time;
	realtime vpa_lb2_exec_end_time;
	realtime fifo_vpa_lb2_exec_time = 0;
	realtime dma_vpa_lb2_exec_time = 0;
	realtime vpa_gr_exec_start_time;
	realtime vpa_gr_exec_end_time;
	realtime fifo_vpa_gr_exec_time = 0;
	realtime dma_vpa_gr_exec_time = 0;
	realtime vpa_lb3m_exec_start_time;
	realtime vpa_lb3m_exec_end_time;
	realtime fifo_vpa_lb3m_exec_time = 0;
	realtime dma_vpa_lb3m_exec_time = 0;
	realtime vpa_lb3d_exec_start_time;
	realtime vpa_lb3d_exec_end_time;
	realtime fifo_vpa_lb3d_exec_time = 0;
	realtime dma_vpa_lb3d_exec_time = 0;
	realtime vpa_nmsh_exec_start_time;
	realtime vpa_nmsh_exec_end_time;
	realtime fifo_vpa_nmsh_exec_time = 0;
	realtime dma_vpa_nmsh_exec_time = 0;
	realtime vpa_hss_exec_start_time;
	realtime vpa_hss_exec_end_time;
	realtime fifo_vpa_hss_exec_time = 0;
	realtime dma_vpa_hss_exec_time = 0;
	realtime vpa_ap_exec_start_time;
	realtime vpa_ap_exec_end_time;
	realtime fifo_vpa_ap_exec_time = 0;
	realtime dma_vpa_ap_exec_time = 0;
	realtime vpa_ed_exec_start_time;
	realtime vpa_ed_exec_end_time;
	realtime fifo_vpa_ed_exec_time = 0;
	realtime dma_vpa_ed_exec_time = 0;

    
    	// Getting Execution Times for LB1 task of VPA IP	
	always@(`VPA_IP_0_LB1)
		begin
			if(`VPA_IP_0_LB1 == 1 && tb_task != IDLE)
				begin
					vpa_lb1_exec_start_time = $time;
					$display("%t: -- LB1 start time is equal to %t", $time, vpa_lb1_exec_start_time);
					vpa_lb1_exec_time_check = START;
				end
			else if(`VPA_IP_0_LB1 == 0 && tb_task != IDLE && vpa_lb1_exec_time_check == START)
				begin
					vpa_lb1_exec_end_time = $time;
					$display("%t: -- LB1 end time is equal to %t", $time, vpa_lb1_exec_end_time);
					vpa_lb1_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_lb1_exec_time = fifo_vpa_lb1_exec_time + (vpa_lb1_exec_end_time - vpa_lb1_exec_start_time);
							$display("%t: -- LB1 execution time for FIFO test is equal to %t", $time, fifo_vpa_lb1_exec_time);
						end
					else
						begin
							dma_vpa_lb1_exec_time = dma_vpa_lb1_exec_time + (vpa_lb1_exec_end_time - vpa_lb1_exec_start_time);
							$display("%t: -- LB1 execution time for DMA test is equal to %t", $time, dma_vpa_lb1_exec_time);
						end
				end
		end
		
	// Getting Execution Times for GA task of VPA IP	
	always@(`VPA_IP_0_GA)
		begin
			if(`VPA_IP_0_GA == 1 && tb_task != IDLE)
				begin
					vpa_ga_exec_start_time = $time;
					$display("%t: -- GA start time is equal to %t", $time, vpa_ga_exec_start_time);
					vpa_ga_exec_time_check = START;
				end
			else if(`VPA_IP_0_GA == 0 && tb_task != IDLE && vpa_ga_exec_time_check == START)
				begin
					vpa_ga_exec_end_time = $time;
					$display("%t: -- GA end time is equal to %t", $time, vpa_ga_exec_end_time);
					vpa_ga_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_ga_exec_time = fifo_vpa_ga_exec_time + (vpa_ga_exec_end_time - vpa_ga_exec_start_time);
							$display("%t: -- GA execution time for FIFO test is equal to %t", $time, fifo_vpa_ga_exec_time);
						end
					else
						begin
							dma_vpa_ga_exec_time = dma_vpa_ga_exec_time + (vpa_ga_exec_end_time - vpa_ga_exec_start_time);
							$display("%t: -- GA execution time for DMA test is equal to %t", $time, dma_vpa_ga_exec_time);
						end
				end
		end
	
	// Getting Execution Times for LB2 task of VPA IP	
	always@(`VPA_IP_0_LB2)
		begin
			if(`VPA_IP_0_LB2 == 1 && tb_task != IDLE)
				begin
					vpa_lb2_exec_start_time = $time;
					$display("%t: -- LB2 start time is equal to %t", $time, vpa_lb2_exec_start_time);
					vpa_lb2_exec_time_check = START;
				end
			else if(`VPA_IP_0_LB2 == 0 && tb_task != IDLE && vpa_lb2_exec_time_check == START)
				begin
					vpa_lb2_exec_end_time = $time;
					$display("%t: -- LB2 end time is equal to %t", $time, vpa_lb2_exec_end_time);
					vpa_lb2_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_lb2_exec_time = fifo_vpa_lb2_exec_time + (vpa_lb2_exec_end_time - vpa_lb2_exec_start_time);
							$display("%t: -- LB2 execution time for FIFO test is equal to %t", $time, fifo_vpa_lb2_exec_time);
						end
					else
						begin
							dma_vpa_lb2_exec_time = dma_vpa_lb2_exec_time + (vpa_lb2_exec_end_time - vpa_lb2_exec_start_time);
							$display("%t: -- LB2 execution time for DMA test is equal to %t", $time, dma_vpa_lb2_exec_time);
						end
				end
		end
	
	// Getting Execution Times for GR task of VPA IP	
	always@(`VPA_IP_0_GR)
		begin
			if(`VPA_IP_0_GR == 1 && tb_task != IDLE)
				begin
					vpa_gr_exec_start_time = $time;
					$display("%t: -- GR start time is equal to %t", $time, vpa_gr_exec_start_time);
					vpa_gr_exec_time_check = START;
				end
			else if(`VPA_IP_0_GR == 0 && tb_task != IDLE && vpa_gr_exec_time_check == START)
				begin
					vpa_gr_exec_end_time = $time;
					$display("%t: -- GR end time is equal to %t", $time, vpa_gr_exec_end_time);
					vpa_gr_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_gr_exec_time = fifo_vpa_gr_exec_time + (vpa_gr_exec_end_time - vpa_gr_exec_start_time);
							$display("%t: -- GR execution time for FIFO test is equal to %t", $time, fifo_vpa_gr_exec_time);
						end
					else
						begin
							dma_vpa_gr_exec_time = dma_vpa_gr_exec_time + (vpa_gr_exec_end_time - vpa_gr_exec_start_time);
							$display("%t: -- GR execution time for DMA test is equal to %t", $time, dma_vpa_gr_exec_time);
						end
				end
		end
	
	// Getting Execution Times for LB3m task of VPA IP	
	always@(`VPA_IP_0_LB3m)
		begin
			if(`VPA_IP_0_LB3m == 1 && tb_task != IDLE)
				begin
					vpa_lb3m_exec_start_time = $time;
					$display("%t: -- LB3m start time is equal to %t", $time, vpa_lb3m_exec_start_time);
					vpa_lb3m_exec_time_check = START;
				end
			else if(`VPA_IP_0_LB3m == 0 && tb_task != IDLE && vpa_lb3m_exec_time_check == START)
				begin
					vpa_lb3m_exec_end_time = $time;
					$display("%t: -- LB3m end time is equal to %t", $time, vpa_lb3m_exec_end_time);
					vpa_lb3m_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_lb3m_exec_time = fifo_vpa_lb3m_exec_time + (vpa_lb3m_exec_end_time - vpa_lb3m_exec_start_time);
							$display("%t: -- LB3m execution time for FIFO test is equal to %t", $time, fifo_vpa_lb3m_exec_time);
						end
					else
						begin
							dma_vpa_lb3m_exec_time = dma_vpa_lb3m_exec_time + (vpa_lb3m_exec_end_time - vpa_lb3m_exec_start_time);
							$display("%t: -- LB3m execution time for DMA test is equal to %t", $time, dma_vpa_lb3m_exec_time);
						end
				end
		end
	
	// Getting Execution Times for LB3d task of VPA IP	
	always@(`VPA_IP_0_LB3d)
		begin
			if(`VPA_IP_0_LB3d == 1 && tb_task != IDLE)
				begin
					vpa_lb3d_exec_start_time = $time;
					$display("%t: -- LB3d start time is equal to %t", $time, vpa_lb3d_exec_start_time);
					vpa_lb3d_exec_time_check = START;
				end
			else if(`VPA_IP_0_LB3d == 0 && tb_task != IDLE && vpa_lb3d_exec_time_check == START)
				begin
					vpa_lb3d_exec_end_time = $time;
					$display("%t: -- LB3d end time is equal to %t", $time, vpa_lb3d_exec_end_time);
					vpa_lb3d_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_lb3d_exec_time = fifo_vpa_lb3d_exec_time + (vpa_lb3d_exec_end_time - vpa_lb3d_exec_start_time);
							$display("%t: -- LB3d execution time for FIFO test is equal to %t", $time, fifo_vpa_lb3d_exec_time);
						end
					else
						begin
							dma_vpa_lb3d_exec_time = dma_vpa_lb3d_exec_time + (vpa_lb3d_exec_end_time - vpa_lb3d_exec_start_time);
							$display("%t: -- LB3d execution time for DMA test is equal to %t", $time, dma_vpa_lb3d_exec_time);
						end
				end
		end
	
	// Getting Execution Times for nMSH task of VPA IP	
	always@(`VPA_IP_0_nMSH)
		begin
			if(`VPA_IP_0_nMSH == 1 && tb_task != IDLE)
				begin
					vpa_nmsh_exec_start_time = $time;
					$display("%t: -- nMSH start time is equal to %t", $time, vpa_nmsh_exec_start_time);
					vpa_nmsh_exec_time_check = START;
				end
			else if(`VPA_IP_0_nMSH == 0 && tb_task != IDLE && vpa_nmsh_exec_time_check == START)
				begin
					vpa_nmsh_exec_end_time = $time;
					$display("%t: -- nMSH end time is equal to %t", $time, vpa_nmsh_exec_end_time);
					vpa_nmsh_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_nmsh_exec_time = fifo_vpa_nmsh_exec_time + (vpa_nmsh_exec_end_time - vpa_nmsh_exec_start_time);
							$display("%t: -- nMSH execution time for FIFO test is equal to %t", $time, fifo_vpa_nmsh_exec_time);
						end
					else
						begin
							dma_vpa_nmsh_exec_time = dma_vpa_nmsh_exec_time + (vpa_nmsh_exec_end_time - vpa_nmsh_exec_start_time);
							$display("%t: -- nMSH execution time for DMA test is equal to %t", $time, dma_vpa_nmsh_exec_time);
						end
				end
		end
		
	// Getting Execution Times for HSS task of VPA IP
	always@(`VPA_IP_0_HSS)
		begin
			if(`VPA_IP_0_HSS == 1 && tb_task != IDLE)
				begin
					vpa_hss_exec_start_time = $time;
					$display("%t: -- HSS start time is equal to %t", $time, vpa_hss_exec_start_time);
					vpa_hss_exec_time_check = START;
				end
			else if(`VPA_IP_0_HSS == 0 && tb_task != IDLE && vpa_hss_exec_time_check == START)
				begin
					vpa_hss_exec_end_time = $time;
					$display("%t: -- HSS end time is equal to %t", $time, vpa_hss_exec_end_time);
					vpa_hss_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_hss_exec_time = fifo_vpa_hss_exec_time + (vpa_hss_exec_end_time - vpa_hss_exec_start_time);
							$display("%t: -- HSS execution time for FIFO test is equal to %t", $time, fifo_vpa_hss_exec_time);
						end
					else
						begin
							dma_vpa_hss_exec_time = dma_vpa_hss_exec_time + (vpa_hss_exec_end_time - vpa_hss_exec_start_time);
							$display("%t: -- HSS execution time for DMA test is equal to %t", $time, dma_vpa_hss_exec_time);
						end
				end
		end
		
	// Getting Execution Times for AP task of VPA IP
	/*always@(`VPA_IP_0_HSS or `VPA_IP_0_ED)
		begin
			if(`VPA_IP_0_HSS == 0 && tb_task != IDLE)
				begin
					vpa_ap_exec_start_time = $time;
					$display("%t: -- AP start time is equal to %t", $time, vpa_ap_exec_start_time);
					vpa_ap_exec_time_check = START;
				end
			else if(`VPA_IP_0_ED == 1 && tb_task != IDLE && vpa_ap_exec_time_check == START)
				begin
					vpa_ap_exec_end_time = $time;
					$display("%t: -- AP end time is equal to %t", $time, vpa_ap_exec_end_time);
					vpa_ap_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_ap_exec_time = fifo_vpa_ap_exec_time + (vpa_ap_exec_end_time - vpa_ap_exec_start_time);
							$display("%t: -- AP execution time for FIFO test is equal to %t", $time, fifo_vpa_ap_exec_time);
						end
					else
						begin
							dma_vpa_ap_exec_time = dma_vpa_ap_exec_time + (vpa_ap_exec_end_time - vpa_ap_exec_start_time);
							$display("%t: -- AP execution time for DMA test is equal to %t", $time, dma_vpa_ap_exec_time);
						end
				end
		end*/
		
	// Getting Execution Times for AP task of VPA IP
	always@(`VPA_IP_0_AP)
		begin
			if(`VPA_IP_0_AP == 1 && tb_task != IDLE)
				begin
					vpa_ap_exec_start_time = $time;
					$display("%t: -- AP start time is equal to %t", $time, vpa_ap_exec_start_time);
					vpa_ap_exec_time_check = START;
				end
			else if(`VPA_IP_0_AP == 0 && tb_task != IDLE && vpa_ap_exec_time_check == START)
				begin
					vpa_ap_exec_end_time = $time;
					$display("%t: -- AP end time is equal to %t", $time, vpa_ap_exec_end_time);
					vpa_ap_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_ap_exec_time = fifo_vpa_ap_exec_time + (vpa_ap_exec_end_time - vpa_ap_exec_start_time);
							$display("%t: -- AP execution time for FIFO test is equal to %t", $time, fifo_vpa_ap_exec_time);
						end
					else
						begin
							dma_vpa_ap_exec_time = dma_vpa_ap_exec_time + (vpa_ap_exec_end_time - vpa_ap_exec_start_time);
							$display("%t: -- AP execution time for DMA test is equal to %t", $time, dma_vpa_ap_exec_time);
						end
				end
		end
		
	// Getting Execution Times for ED task of VPA IP
	always@(`VPA_IP_0_ED)
		begin
			if(`VPA_IP_0_ED == 1 && tb_task != IDLE)
				begin
					vpa_ed_exec_start_time = $time;
					$display("%t: -- ED start time is equal to %t", $time, vpa_ed_exec_start_time);
					vpa_ed_exec_time_check = START;
				end
			else if(`VPA_IP_0_ED == 0 && tb_task != IDLE && vpa_ed_exec_time_check == START)
				begin
					vpa_ed_exec_end_time = $time;
					$display("%t: -- ED end time is equal to %t", $time, vpa_ed_exec_end_time);
					vpa_ed_exec_time_check = END;
					if(tb_task == FIFO)
						begin
							fifo_vpa_ed_exec_time = fifo_vpa_ed_exec_time + (vpa_ed_exec_end_time - vpa_ed_exec_start_time);
							$display("%t: -- ED execution time for FIFO test is equal to %t", $time, fifo_vpa_ed_exec_time);
						end
					else
						begin
							dma_vpa_ed_exec_time = dma_vpa_ed_exec_time + (vpa_ed_exec_end_time - vpa_ed_exec_start_time);
							$display("%t: -- ED execution time for DMA test is equal to %t", $time, dma_vpa_ed_exec_time);
						end
				end
		end
	
	
    initial
		begin
			
			$display("%t: ==========================================================================", $time);
			$display("%t: SIMULATION STARTED -------------------------------------------------------", $time);
			$display("%t: ==========================================================================", $time);
			
			$display("%t: -- BURST_SIZE = %0d", $time, BURST_SIZE);
			$display("%t: -- IMAGE_SIZE = %0d", $time, IMAGE_SIZE);
			$display("%t: -- IMAGE_DATA_SIZE = %0d", $time, IMAGE_DATA_SIZE);
			$display("%t: -- IB_RATIO = %0d", $time, IB_RATIO);
			$display("%t: -- IB_REMAINDER = %0d", $time, IB_REMAINDER);
			$display("%t: -- CLK_PERIOD = %0d ns", $time, CLK_PERIOD);
			
			
			/************************************************************************************************/
			/********************************	   VPA IP TEST (via DMA)	 ********************************/
			/************************************************************************************************/
			$display("%t: --------------------------------------------------------------------------", $time);
			$display("%t: -- VPA IP TEST (via DMA) -------------------------------------------------", $time);
			$display("%t: --------------------------------------------------------------------------", $time);
			
			/*** Reset of the Zynq VIP and FPGA***/
			// Reset VIP
			$display("%t: -- Applying Zynq VIP reset", $time);
			`ZYNQ_VIP_0.por_srstb_reset(1'b0);
			// Reset the PL
			$display("%t: -- Applying FPGA reset", $time);
			`ZYNQ_VIP_0.fpga_soft_reset(4'h1);  
			$display("%t: -- FPGA has been reset", $time);
			#(CLK_PERIOD*16);  // This delay depends on your clock frequency. It should be at least 16 clock cycles.
			$display("%t: -- Restarting Zynq VIP", $time);	
			`ZYNQ_VIP_0.por_srstb_reset(1'b1);
			$display("%t: -- Zynq VIP has been restarted", $time);
			$display("%t: -- Restarting FPGA", $time);	
			`ZYNQ_VIP_0.fpga_soft_reset(4'h0);
			$display("%t: -- FPGA has been restarted", $time);
			//#CLK_PERIOD;
			$display("%t: -- Zynq VIP is ready to start processing", $time);
			$display("%t: -- FPGA is ready to start processing", $time);
			
			/*** Configuration of Debug Information***/
			// Set debug level info to off. For more info, set to 1.
			$display("%t: -- Setting debug level information", $time);
			`ZYNQ_VIP_0.set_debug_level_info(0);
			// Set stop in case of simulation error.
			$display("%t: -- Setting stop on error", $time);
			`ZYNQ_VIP_0.set_stop_on_error(1);
			// Set minimum port verbosity.
			$display("%t: -- Setting verbosity", $time);
			`ZYNQ_VIP_0.M_AXI_HPM0_FPD.set_verbosity(32'd0);
			`ZYNQ_VIP_0.M_AXI_HPM1_FPD.set_verbosity(32'd0);
			`ZYNQ_VIP_0.S_AXI_HP0_FPD.set_verbosity(32'd0);
			
			/*** Configuring Accelerator ***/
			// Write a 4-byte single data into the control register of the accelerator at the ap_start (bit[0]). 
			$display("%t: -- Setting start register", $time);
			`ZYNQ_VIP_0.write_data(ACC_CTRL_REG_ADDR,4, 32'h00000001, resp);
			// Read a 4-byte single data from the control register of the accelerator at the ap_ready (bit[3]).  
			$display("%t: -- Reading ap_ready bit of the control register", $time);
            `ZYNQ_VIP_0.read_data(ACC_CTRL_REG_ADDR,4,ctrl_reg,resp);
            $display("%t: -- ap_ready bit has been set to %0d", $time, ctrl_reg[3]);
			// Write a 4-byte single data into the global interrupt enable (GIE) register of the accelerator (bit[0]). 
			$display("%t: -- Setting GIE register", $time);
			`ZYNQ_VIP_0.write_data(ACC_GIE_REG_ADDR,4, 32'h00000001, resp);
			// Write a 4-byte single data into the IP interrupt enable (IER) register of the accelerator (bit[1:0]). 
			$display("%t: -- Setting IER register", $time);
			`ZYNQ_VIP_0.write_data(ACC_IER_REG_ADDR,4, 32'h00000003, resp);
			
			/*** Initializing Memory***/
			// Fill the source data area with the input data
			$display("%t: -- Loading input data from file", $time);
			`ZYNQ_VIP_0.pre_load_mem_from_file("input32.txt", HP0_DDR_LOW_ADDR, IMAGE_SIZE);
			$display("%t: -- Input data have been loaded", $time);
			// Checking input data loading
			if(tb_mode == DEBUG)
				begin
					inc_addr_reg = HP0_DDR_LOW_ADDR;
					ddr_test = 1;
					for(x=0;x<IMAGE_SIZE;x=x+1)
						begin
							`ZYNQ_VIP_0.read_mem(inc_addr_reg, 4, ddr_data_reg);
							if(ddr_data_reg == input_image[x][7:0])
								begin
									$display("%t: -- Check n.%0d PASSED: Data loaded/read into/from DDR are equal", $time, x);
								end
							else
								begin
									$display("%t: -- Check n.%0d FAILED: Data loaded/read into/from DDR are not equal", $time, x);
									ddr_test = 0;
								end
							$display("%t: -- Data loaded 32h%x, data read 32h%x (at address 32h%x)", $time, input_image[x][7:0], ddr_data_reg, inc_addr_reg);
							inc_addr_reg = inc_addr_reg+32'h4;
						end
					if(ddr_test == 1)
						begin
							$display("%t: -- DDR Loading PASSED!", $time);
						end
					else
						begin
							$display("%t: -- DDR Loading FAILED!", $time);
							$stop;
						end				
				end
				
			/*** Configuring DMA ***/
			// Read status
			$display("%t: -- Reading DMA status register", $time);
			`ZYNQ_VIP_0.read_data(DMA_STATUS_REG_ADDR, 4, dma_status_reg, resp);
			$display("%t: -- DMA status register is equal to 32h%x", $time, dma_status_reg);
			// Read the control register
			$display("%t: -- Reading DMA control register", $time);
			`ZYNQ_VIP_0.read_data(DMA_CTRL_REG_ADDR, 4, dma_ctrl_reg, resp);
			$display("%t: -- DMA control register is equal to 32h%x", $time, dma_ctrl_reg);
			// Set the control register in order to have MM2S_DMACR.RS = 1
			$display("%t: -- Setting DMA control register", $time);
			`ZYNQ_VIP_0.write_data(DMA_CTRL_REG_ADDR, 4, {dma_ctrl_reg[31:1],1'b1}, resp);
			// Read status in order to check DMASR.Halted (deasserted when the MM2S channel is running)
			$display("%t: -- Reading DMA status register", $time);
			`ZYNQ_VIP_0.read_data(DMA_STATUS_REG_ADDR, 4, dma_status_reg, resp);
			$display("%t: -- DMA status register is equal to 32h%x", $time, dma_status_reg);
			// Read the control register
			$display("%t: -- Reading DMA control register", $time);
			`ZYNQ_VIP_0.read_data(DMA_CTRL_REG_ADDR, 4, dma_ctrl_reg, resp);
			$display("%t: -- DMA control register is equal to 32h%x", $time, dma_ctrl_reg);
			// Set the control register in order to enable interrupts (MM2S_DMACR.IOC_IrqEn = 1 and MM2S_DMACR.Err_IrqEn = 1)
			$display("%t: -- Setting DMA control register", $time);
			`ZYNQ_VIP_0.write_data(DMA_CTRL_REG_ADDR, 4, {dma_ctrl_reg[31:15],1'b1,dma_ctrl_reg[13],1'b1,dma_ctrl_reg[11:0]}, resp);
			// Read status in order to check DMASR.Halted (deasserted when the MM2S channel is running)
			$display("%t: -- Reading DMA status register", $time);
			`ZYNQ_VIP_0.read_data(DMA_STATUS_REG_ADDR, 4, dma_status_reg, resp);
			$display("%t: -- DMA status register is equal to 32h%x", $time, dma_status_reg);
			
			/*** Sending Input Data to the Accelerator via DMA***/
			// Set the source address
			$display("%t: -- Setting DMA source address register to 32h%x", $time, HP0_DDR_LOW_ADDR);
			`ZYNQ_VIP_0.write_data(DMA_SRC_REG_ADDR, 4, HP0_DDR_LOW_ADDR, resp);
			tb_task = DMA;
			dma_exec_start_time = $realtime;
			dma_com_start_time = $realtime;
			dma_proc_start_time = $realtime;
			// Set the transfer length register
			$display("%t: -- Setting DMA length address register to %0d", $time, IMAGE_DATA_SIZE);
			`ZYNQ_VIP_0.write_data(DMA_LEN_REG_ADDR, 4, IMAGE_DATA_SIZE, resp);
			$display("%t: -- All input data have been sent to the accelerator via DMA", $time);
			// Wait for interrupt from the DMA
			$display("%t: -- Waiting for interrupt from the DMA...", $time);
			`ZYNQ_VIP_0.wait_interrupt(4'h2,irq_status);
			$display("%t: -- Interrupt has been sent by the DMA", $time);
			// Wait for last data sent from DMA to the accelerator
			//while(`DMA_M_AXIS_MM2S_TLAST == 0)
			//	begin
			//		#CLK_PERIOD;
			//	end
			dma_com_end_time = $realtime;
			
			/*** Checking Interrupt Received by the Accelerator***/
			// Wait for interrupt from the accelerator
			$display("%t: -- Waiting for interrupt from the accelerator...", $time);
			`ZYNQ_VIP_0.wait_interrupt(4'h1,irq_status);
			$display("%t: -- Interrupt has been sent by the accelerator", $time);
			dma_proc_end_time = $realtime;
			// Checking interrupt status
            if(irq_status & 16'h0002) begin
                $display("%t: -- Interrupt status register is equal to 16'h%x", $time, irq_status);
				$display("%t: -- Interrupt comes from the accelerator", $time);
				irq_test = 1;
			end
			else begin
				$display("%t: -- Interrupt has not been received from the accelerator", $time);
				irq_test = 0;
			end 
		
			/*** Checking Output Data from the Accelerator by its Registers***/
			$display("%t: -- Checking output data from the accelerator by its registers", $time);
			if(irq_test == 1)
			    begin
			        // Read a 4-byte single data from the output control register of the accelerator. 
					$display("%t: -- Reading control register of the accelerator", $time);
                    `ZYNQ_VIP_0.read_data(ACC_OUT_CTRL_REG_ADDR, 4, out_ctrl_reg, resp);
                    $display("%t: -- Accelerator control register is equal to 32h%x", $time, out_ctrl_reg);
					
					// Read a 4-byte single data from the output data register of the accelerator. 
					$display("%t: -- Reading data register of the accelerator", $time);
					`ZYNQ_VIP_0.read_data(ACC_OUT_DATA_REG_ADDR, 4, out_data_reg, resp);
					$display("%t: -- Accelerator data register is equal to 32h%x", $time, out_data_reg);
					if(out_data_reg == 32'h00000028) 
						begin
							$display("%t: --------------------------------------------------------------------------", $time);
							$display("%t: -- VPA IP TEST (via DMA): PASSED -----------------------------------------", $time);
							$display("%t: --------------------------------------------------------------------------", $time);
						end
					else 
						begin
							$display("%t: --------------------------------------------------------------------------", $time);
							$display("%t: -- VPA IP TEST (via DMA): FAILED -----------------------------------------", $time);
							$display("%t: --------------------------------------------------------------------------", $time);
							//$stop;
						end
					irq_test = 0;
                end
			dma_exec_end_time = $realtime;
			tb_task = IDLE;
			vpa_lb1_exec_time_check = CHECK;
			vpa_ga_exec_time_check = CHECK;
			vpa_lb2_exec_time_check = CHECK;
			vpa_gr_exec_time_check = CHECK;
			vpa_lb3m_exec_time_check = CHECK;
			vpa_lb3d_exec_time_check = CHECK;
			vpa_nmsh_exec_time_check = CHECK;
			vpa_hss_exec_time_check = CHECK;
			vpa_ap_exec_time_check = CHECK;
			vpa_ed_exec_time_check = CHECK;
			dma_exec_time = dma_exec_end_time - dma_exec_start_time;
			dma_com_time = dma_com_end_time - dma_com_start_time;
			dma_proc_time = (dma_proc_end_time - dma_proc_start_time) - dma_com_time;
			$display("%t: -- Simulation of the accelerator using DMA is finished", $time);
			$display("%t: -- Execution time is equal to %t", $time, dma_exec_time);
			$display("%t: -- Communication time is equal to %t", $time, dma_com_time);
			$display("%t: -- Processing time is equal to %t", $time, dma_proc_time);
			$display("%t: -- VPA task execution times:", $time);
			$display("%t: -- LB1 execution time is equal to %t", $time, dma_vpa_lb1_exec_time);
			$display("%t: -- GA execution time is equal to %t", $time, dma_vpa_ga_exec_time);
			$display("%t: -- LB2 execution time is equal to %t", $time, dma_vpa_lb2_exec_time);
			$display("%t: -- GR execution time is equal to %t", $time, dma_vpa_gr_exec_time);
			$display("%t: -- LB3m execution time is equal to %t", $time, dma_vpa_lb3m_exec_time);
			$display("%t: -- LB3d execution time is equal to %t", $time, dma_vpa_lb3d_exec_time);
			$display("%t: -- nMSH execution time is equal to %t", $time, dma_vpa_nmsh_exec_time);
			$display("%t: -- HSS execution time is equal to %t", $time, dma_vpa_hss_exec_time);
			$display("%t: -- AP execution time is equal to %t", $time, dma_vpa_ap_exec_time);
			$display("%t: -- ED execution time is equal to %t", $time, dma_vpa_ed_exec_time);
			$display("%t: --------------------------------------------------------------------------", $time);
			
			$display("%t: ==========================================================================", $time);
			$display("%t: SIMULATION COMPLETED -----------------------------------------------------", $time);
			$display("%t: ==========================================================================", $time);
			
			$stop;
		end
   
	line_detector_bd_wrapper zynq_sys
	   (
		);

endmodule

