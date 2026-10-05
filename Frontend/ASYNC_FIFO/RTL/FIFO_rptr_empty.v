module FIFO_rptr_empty #(parameter ADDR_SIZE = 3) (
    input  wire                      rclk,
    input  wire                      rrst_n,
    input  wire                      rinc,
    input  wire [ADDR_SIZE     : 0]  rq2_wptr,
    output reg  [ADDR_SIZE - 1 : 0]  raddr,
    output reg  [ADDR_SIZE     : 0]  rptr,
    output reg                       rempty
);

    integer i;
    reg [ADDR_SIZE : 0] rbin;
    reg [ADDR_SIZE : 0] rbinnext;
    reg [ADDR_SIZE : 0] rgraynext;
    wire                 rempty_val;

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rbin   <= 'b0;
            rptr   <= 'b0;
        end else begin
            rbin   <= rbinnext;
            rptr   <= rgraynext;
        end
    end

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n)
            rempty <= 1'b1;   
        else
            rempty <= rempty_val;
    end

    always @(*) begin
        rbinnext = rbin + (rinc & ~rempty);

        rgraynext[ADDR_SIZE] = rbinnext[ADDR_SIZE];
        for (i = 0; i < ADDR_SIZE; i = i + 1)
            rgraynext[i] = rbinnext[i] ^ rbinnext[i+1];
    end

    always @(*) raddr = rbin[ADDR_SIZE - 1 : 0];

    assign rempty_val = (rgraynext == rq2_wptr);

endmodule