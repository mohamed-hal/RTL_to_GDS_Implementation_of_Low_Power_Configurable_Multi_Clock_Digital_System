module sync_w2r #(parameter ADDR_SIZE = 3) (
    input   wire                   rclk,
    input   wire                   rrst_n,
    input   wire  [ADDR_SIZE : 0]  wptr,
    output  reg   [ADDR_SIZE : 0]  rq2_wptr
    );

    reg [ADDR_SIZE : 0] rq1_wptr;

    always @(posedge rclk , negedge rrst_n) begin
        if (!rrst_n) begin
            rq1_wptr <= 'b0;
            rq2_wptr <= 'b0;
        end else begin
            {rq2_wptr , rq1_wptr} <= {rq1_wptr , wptr};
        end
    end
endmodule
