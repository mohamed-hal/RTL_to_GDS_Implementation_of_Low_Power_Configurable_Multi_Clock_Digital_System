module Stop_Check#(parameter DATA_WIDTH = 8)(
    input  wire CLK,
    input  wire RST,
    input  wire sampled_bit,
    input  wire stp_chk_en,

    output reg  stp_err
    );

    always @(posedge CLK , negedge RST ) begin
        if (!RST) begin
            stp_err <= 'b0;
        end else if (stp_chk_en) begin
            stp_err <= !sampled_bit;
        end
    end
endmodule

