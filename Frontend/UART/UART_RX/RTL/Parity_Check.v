module Parity_Check#(parameter DATA_WIDTH = 8)(
    input   wire                     CLK,
    input   wire                     RST,
    input   wire                     par_chk_en,
    input   wire                     sampled_bit,
    input   wire [DATA_WIDTH -1 : 0] P_DATA,
    input   wire                     PAR_TYP,

    output  reg                      par_err
    );

    reg par_bit;
    wire par_chk;

    always @(posedge CLK , negedge RST ) begin
        if (!RST) begin
            par_err <= 'b0;
        end else if (par_chk_en) begin
            if (par_chk) begin
                par_err <= 'b0;
            end else begin
                par_err <= 'b1;
            end
        end 
    end

    always @(*) begin
        case (PAR_TYP)
        1'b0    :  begin
            par_bit = ^P_DATA  ;
        end
        1'b1     : begin
            par_bit = ~^P_DATA ;
        end
        endcase
    end


    assign par_chk = par_bit == sampled_bit;

endmodule

