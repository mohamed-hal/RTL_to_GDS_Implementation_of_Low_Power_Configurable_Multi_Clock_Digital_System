module Data_Sampling #(parameter DATA_WIDTH = 8)(
    input   wire       CLK,
    input   wire       RST,
    input   wire [5:0] edge_cnt,
    input   wire       RX_IN,
    input   wire       dat_samp_en,
    input   wire [5:0] Prescale,

    output  reg        sampled_bit
    );

   
    reg  [2:0] Data_Sampled_reg;    //The three sampled bits
    wire [5:0] middle_bit_index;



    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            Data_Sampled_reg <= 'b0;
        end else begin
            if (dat_samp_en) begin
                if (edge_cnt == middle_bit_index - 'b1 ) begin
                    Data_Sampled_reg[2] <= RX_IN;
                end
                if (edge_cnt == middle_bit_index) begin
                    Data_Sampled_reg[1] <= RX_IN;
                end
                if (edge_cnt == middle_bit_index + 'b1) begin
                    Data_Sampled_reg[0] <= RX_IN;
                end 
            end else begin
                Data_Sampled_reg <= 'b0;
            end
        end
    end

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            sampled_bit <= 'b0;
        end else begin
            if (dat_samp_en) begin
                case (Data_Sampled_reg)
                  3'b011 , 3'b101 , 3'b110 , 3'b111  : sampled_bit <= 'b1; 
                  default:                             sampled_bit <= 'b0;  
                endcase 
            end    
        end
    end

    
    assign middle_bit_index = (Prescale >> 1) - 'b1;      

endmodule

