module LOGIC_UNIT#(parameter IP_DATA_WIDTH = 16, parameter OP_DATA_WIDTH = 16)(
    input [IP_DATA_WIDTH-1:0] A,B,
    input CLK,RST,
    input Logic_Enable,
    input [1:0] ALU_FUN_LS,
    output reg [OP_DATA_WIDTH-1:0] Logic_OUT,
    output reg Logic_Flag
    );
    always @(posedge CLK , negedge RST) begin
        if(!RST)begin
            Logic_Flag <= 0;
            Logic_OUT <= 0;
        end
        else if(Logic_Enable)begin
            Logic_Flag <= 1'b1;
            case (ALU_FUN_LS)
                2'b00: Logic_OUT <= A & B;
                2'b01: Logic_OUT <= A | B;
                2'b10: Logic_OUT <= ~(A & B);
                2'b11: Logic_OUT <= ~(A | B); 
            endcase
        end
        else begin
            Logic_Flag <= 0;
            Logic_OUT <= 0;
        end
    end
endmodule

