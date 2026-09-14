module edge_bit_counter #(parameter DATA_WIDTH = 8)(
    input  wire         CLK,
    input  wire         RST,
    input  wire         enable,
    input  wire [5:0]   Prescale,

    output reg  [3:0]   bit_cnt,
    output reg  [5:0]   edge_cnt
    );

    //Edge Counter
    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            edge_cnt <= 'b0;
        end else if (enable && edge_cnt != Prescale - 1) begin
            edge_cnt <= edge_cnt + 'b1;
        end else begin
            edge_cnt <= 'b0;
        end
    end

    //Bit Counter
    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            bit_cnt <= 'b0;
        end else if (!enable) begin
            bit_cnt <= 'b0;                      
        end else if (edge_cnt == Prescale - 1) begin
            bit_cnt <= bit_cnt + 'b1;             
        end
    end

endmodule
