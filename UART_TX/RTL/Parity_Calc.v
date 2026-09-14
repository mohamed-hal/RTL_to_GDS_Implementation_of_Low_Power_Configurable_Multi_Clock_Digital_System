module Parity_Calc(
       input clk, RST,
       input [7:0] P_DATA,
       input Data_Valid,
       input PAR_TYP,
       output reg par_bit
    );

    always @(posedge clk, negedge RST) begin
       if (!RST)
              par_bit <= 1'b0;
       else if (Data_Valid) begin
              if (PAR_TYP)
                     par_bit <= ~(^P_DATA);  // odd parity
              else
                     par_bit <= ^P_DATA;     // even parity
       end
       // else: hold current value
    end
endmodule