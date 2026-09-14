module serializer(
       input clk , RST,
       input [7:0] P_DATA,
       input ser_en,
       output ser_done,
       output reg ser_data
    );
reg [7:0] shift_reg;
reg [7:0] counter;

always @(posedge clk, negedge RST) begin
    if (!RST) begin
        shift_reg <= 8'b0;
        counter   <= 0;
        ser_data  <= 1'b0;
    end
    else if (ser_en && counter == 0) begin
        shift_reg <= P_DATA;        
        ser_data  <= P_DATA[0];     
        counter   <= counter + 1;
    end
    else if (ser_en && counter != 8) begin
        shift_reg <= shift_reg >> 1;   
        ser_data  <= shift_reg[1];    
        counter   <= counter + 1;
    end
    else begin
        counter <= 0;
    end
end

assign ser_done = (counter == 8);

endmodule