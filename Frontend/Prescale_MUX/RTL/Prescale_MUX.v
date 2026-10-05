module Prescale_MUX #(parameter DIV_RATIO_WIDTH = 8) (
    input   wire [5:0]                     Prescale,
    output  reg  [DIV_RATIO_WIDTH - 1 : 0] DIV_RATIO
    );

    always @(*) begin
        case (Prescale)

        6'd32    : DIV_RATIO = 'd1;
        6'd16    : DIV_RATIO = 'd2;
        6'd8     : DIV_RATIO = 'd4;
        6'd4     : DIV_RATIO = 'd8; 
            default: DIV_RATIO = 'd1;
        endcase
        
    end
endmodule
