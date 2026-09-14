module DECODER_UNIT(
input [1:0] ALU_FUN_MS,
output reg Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable
    );

always @(*)
begin
    //initialization
    Arith_Enable <= 0;
    Logic_Enable <= 0;
    CMP_Enable <= 0; 
    Shift_Enable <= 0;
    //case statement
    case(ALU_FUN_MS)
    2'b00: Arith_Enable <= 1;
    2'b01: Logic_Enable <= 1;
    2'b10: CMP_Enable <= 1;
    2'b11: Shift_Enable <= 1;
    default:
    begin
         Arith_Enable <= 0;
         Logic_Enable <= 0;
         CMP_Enable <= 0;
         Shift_Enable <= 0;
    end
    endcase
end
endmodule
