module RST_SYNC #(parameter NUM_STAGES = 5)(
    input    wire    CLK,
    input    wire    RST,
    output   wire    SYNC_RST
    );
    reg [NUM_STAGES - 1 : 0] STAGES_REG;

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            STAGES_REG <= 'b0;
        end else begin
            STAGES_REG <= {STAGES_REG[NUM_STAGES - 2 : 0] , 1'b1};
        end
    end

    assign SYNC_RST = STAGES_REG[NUM_STAGES - 1]; 

endmodule
