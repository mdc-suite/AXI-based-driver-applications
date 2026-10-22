// Adapter for the exact HLS FIFO supplied with the ACL example.
// MDC supplies width and depth from the token type and bufferSize.
module mdc_hls_fifo_native #(
    parameter integer width = 32,
    parameter integer depth = 4
)(
    input wire clk, input wire ap_rst,
    input wire [width-1:0] din, input wire write,
    output wire full_n,
    output wire [width-1:0] dout, input wire read,
    output wire empty_n
);
    localparam integer ADDR_BITS = (depth > 1) ? $clog2(depth) : 1;
    // The supplied generated FIFO includes both the FIFO and ShiftReg modules.
    top_fifo_w32_d4_S #(
        .DATA_WIDTH(width), .ADDR_WIDTH(ADDR_BITS), .DEPTH(depth)
    ) storage (
        .clk(clk), .reset(ap_rst),
        .if_full_n(full_n), .if_write_ce(1'b1),
        .if_write(write && !ap_rst), .if_din(din),
        .if_dout(dout), .if_empty_n(empty_n), .if_read_ce(1'b1),
        .if_read(read && !ap_rst),
        .if_num_data_valid(), .if_fifo_cap()
    );
endmodule
