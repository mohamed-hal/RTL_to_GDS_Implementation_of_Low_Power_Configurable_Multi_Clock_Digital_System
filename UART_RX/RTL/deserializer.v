module deserializer #(parameter DATA_WIDTH = 8)(
    input   wire                    CLK,
    input   wire                    RST,
    input   wire                    sampled_bit,
    input   wire                    deser_en,
    input   wire [5:0]              Prescale,
    input   wire [5:0]              edge_cnt,

    output  reg  [DATA_WIDTH - 1:0] P_DATA
    );

    wire edge_check;

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            P_DATA <= 'd0;
        end else if (edge_check) begin
            if (deser_en) begin
                P_DATA <= {sampled_bit , P_DATA[DATA_WIDTH - 1 : 1]};
            end
      
        end
    end

    assign edge_check = edge_cnt == Prescale - 'd1 ;
endmodule

