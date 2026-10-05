module sync_r2w #(parameter ADDR_SIZE = 3) (
    input   wire                   wclk,
    input   wire                   wrst_n,
    input   wire  [ADDR_SIZE : 0]  rptr,
    output  reg   [ADDR_SIZE : 0]  wq2_rptr
    );

    reg [ADDR_SIZE : 0] wq1_rptr;
    
    always @(posedge wclk , negedge wrst_n) begin
        if (!wrst_n) begin
            wq1_rptr <= 'b0;
            wq2_rptr <= 'b0;
        end else begin
            {wq2_rptr , wq1_rptr} <= {wq1_rptr , rptr};
        end
    end
endmodule
