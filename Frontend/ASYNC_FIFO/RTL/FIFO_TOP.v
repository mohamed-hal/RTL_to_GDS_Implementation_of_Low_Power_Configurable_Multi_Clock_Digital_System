module FIFO_TOP #(parameter DATA_WIDTH = 8, ADDR_SIZE = 3) (
    input  wire                       wclk,
    input  wire                       wrst_n,
    input  wire                       winc,
    input  wire  [DATA_WIDTH - 1 : 0] wdata,
    output wire                       wfull,

    input  wire                       rclk,
    input  wire                       rrst_n,
    input  wire                       rinc,
    output wire  [DATA_WIDTH - 1 : 0] rdata,
    output wire                       rempty
    );

    wire [ADDR_SIZE - 1 : 0] waddr, raddr;
    wire [ADDR_SIZE     : 0] wptr, rptr, wq2_rptr, rq2_wptr;

    sync_r2w #(ADDR_SIZE) sync_r2w (
        .wclk     (wclk),
        .wrst_n   (wrst_n),
        .rptr     (rptr),
        .wq2_rptr (wq2_rptr)
    );

    sync_w2r #(ADDR_SIZE) sync_w2r (
        .rclk     (rclk),
        .rrst_n   (rrst_n),
        .wptr     (wptr),
        .rq2_wptr (rq2_wptr)
    );

    FIFO_MEM #(DATA_WIDTH, ADDR_SIZE) fifomem (
        .wclk   (wclk),
        .wclken (winc),
        .wfull  (wfull),
        .waddr  (waddr),
        .raddr  (raddr),
        .wdata  (wdata),
        .rdata  (rdata)
    );

    FIFO_rptr_empty #(ADDR_SIZE) rptr_empty (
        .rclk     (rclk),
        .rrst_n   (rrst_n),
        .rinc     (rinc),
        .rq2_wptr (rq2_wptr),
        .raddr    (raddr),
        .rptr     (rptr),
        .rempty   (rempty)
    );

    FIFO_wptr_full #(ADDR_SIZE) wptr_full (
        .wclk     (wclk),
        .wrst_n   (wrst_n),
        .winc     (winc),
        .wq2_rptr (wq2_rptr),
        .waddr    (waddr),
        .wptr     (wptr),
        .wfull    (wfull)
    );

endmodule