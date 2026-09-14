module ARITHMETIC_UNIT#(parameter IP_DATA_WIDTH = 16, parameter OP_DATA_WIDTH = 32)(
    input signed [IP_DATA_WIDTH-1:0] A,B,
    input CLK,RST,
    input Arith_Enable,
    input [1:0] ALU_FUN_LS,
    output reg [OP_DATA_WIDTH-1:0] Arith_OUT,
    output reg Arith_Flag
    );

    always @(posedge CLK, negedge RST) begin
    if (!RST) begin
        Arith_Flag <= 0;
        Arith_OUT  <= 0;
    end
    else if (Arith_Enable) begin
        Arith_Flag <= 1'b1;
        case (ALU_FUN_LS)
            2'b00: Arith_OUT <= A + B;
            2'b01: Arith_OUT <= A - B;
            2'b10: Arith_OUT <= A * B;
            2'b11: Arith_OUT <= (B != 0) ? A / B : 0;
        endcase
    end
    else begin            
        Arith_Flag <= 0;
        Arith_OUT  <= 0;
    end
end
endmodule

