
wire kernel_monitor_reset;
wire kernel_monitor_clock;
wire kernel_monitor_report;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
assign kernel_monitor_report = 1'b0;
wire [1:0] axis_block_sigs;
wire [12:0] inst_idle_sigs;
wire [8:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~current_pos_TDATA_blk_n;
assign axis_block_sigs[1] = ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff1_U0.im_axis_in_TDATA_blk_n;

assign inst_idle_sigs[0] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.ap_idle;
assign inst_block_sigs[0] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.ap_continue);
assign inst_idle_sigs[1] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff1_U0.ap_idle;
assign inst_block_sigs[1] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff1_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff1_U0.ap_continue);
assign inst_idle_sigs[2] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.gaussian_U0.ap_idle;
assign inst_block_sigs[2] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.gaussian_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.gaussian_U0.ap_continue);
assign inst_idle_sigs[3] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff2_U0.ap_idle;
assign inst_block_sigs[3] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff2_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff2_U0.ap_continue);
assign inst_idle_sigs[4] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.gradient_U0.ap_idle;
assign inst_block_sigs[4] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.gradient_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.gradient_U0.ap_continue);
assign inst_idle_sigs[5] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff3_magn_U0.ap_idle;
assign inst_block_sigs[5] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff3_magn_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff3_magn_U0.ap_continue);
assign inst_idle_sigs[6] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff3_dir_U0.ap_idle;
assign inst_block_sigs[6] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff3_dir_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff3_dir_U0.ap_continue);
assign inst_idle_sigs[7] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.nMS_Hys_U0.ap_idle;
assign inst_block_sigs[7] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.nMS_Hys_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.nMS_Hys_U0.ap_continue);
assign inst_idle_sigs[8] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.hough_space_size_U0.ap_idle;
assign inst_block_sigs[8] = (grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.hough_space_size_U0.ap_done & ~grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.hough_space_size_U0.ap_continue);

assign inst_idle_sigs[9] = 1'b0;
assign inst_idle_sigs[10] = grp_dataflow_parent_loop_proc_fu_2615.ap_idle;
assign inst_idle_sigs[11] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.ap_idle;
assign inst_idle_sigs[12] = grp_dataflow_parent_loop_proc_fu_2615.dataflow_in_loop_VITIS_LOOP_190_1_U0.line_buff1_U0.ap_idle;

top_module_hls_deadlock_idx0_monitor top_module_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);


always @ (kernel_block or kernel_monitor_reset) begin
    if (kernel_block == 1'b1 && kernel_monitor_reset == 1'b0) begin
        find_kernel_block = 1'b1;
    end
    else begin
        find_kernel_block = 1'b0;
    end
end
