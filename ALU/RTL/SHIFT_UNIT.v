module SHIFT_UNIT#(parameter IP_DATA_WIDTH = 16, parameter OP_DATA_WIDTH = 16)(
    input [IP_DATA_WIDTH-1:0] A,B,
    input CLK,RST,
    input Shift_Enable,
    input [1:0] ALU_FUN_LS,
    output reg [OP_DATA_WIDTH-1:0] Shift_OUT,
    output reg Shift_Flag
    );
    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            Shift_Flag <= 0;
            Shift_OUT <= 0;            
        end
        else if(Shift_Enable) begin
            Shift_Flag <= 1;
            case (ALU_FUN_LS)
                2'b00: Shift_OUT <= A >> 1;
                2'b01: Shift_OUT <= A << 1;
                2'b10: Shift_OUT <= B >> 1;
                2'b11: Shift_OUT <= B << 1; 
            endcase
        end
        else begin
            Shift_Flag <= 0;
            Shift_OUT <= 0;
        end
    end
endmodule
