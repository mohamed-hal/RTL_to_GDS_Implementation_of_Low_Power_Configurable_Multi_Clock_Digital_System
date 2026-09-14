module CMP_UNIT#(parameter IP_DATA_WIDTH = 16, parameter CMP_OP_DATA_WIDTH = 2)(
    input signed [IP_DATA_WIDTH-1:0] A,B,
    input CLK,RST,
    input CMP_Enable,
    input [1:0] ALU_FUN_LS,
    output reg [CMP_OP_DATA_WIDTH-1:0] CMP_OUT,
    output reg CMP_Flag
    );
    always @(posedge CLK , negedge RST) begin
        if(!RST)begin
            CMP_Flag <= 0;
            CMP_OUT <= 0; 
        end
        else if(CMP_Enable)begin
            CMP_Flag <= 1;
            case (ALU_FUN_LS)
                2'b00: CMP_OUT <= 0;
                2'b01: begin
                    if(A == B) CMP_OUT <= 2'd1;
                    else CMP_OUT <= 2'd0;
                end
                2'b10: begin
                  if(A > B) CMP_OUT<= 2'd2;
                  else CMP_OUT <= 2'd0;
                end
                2'b11: begin
                  if(A < B) CMP_OUT <= 2'd3;
                  else CMP_OUT <= 2'd0;
                end
            endcase
        end
        else begin
          CMP_OUT <= 0;
          CMP_Flag <= 0;
        end
    end
endmodule

