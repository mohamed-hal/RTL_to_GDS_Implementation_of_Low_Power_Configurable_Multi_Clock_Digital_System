module MUX(
       input [1:0] mux_sel,
       input ser_data,
       input par_bit,
       output reg TX_OUT
    );
    localparam start_bit = 1'b0;
    localparam stop_bit  = 1'b1;

    localparam      sel_start = 2'b00,
                    sel_stop  = 2'b01, 
                    sel_data  = 2'b10,
                    sel_par   = 2'b11;

    always @(*) begin
       case (mux_sel)
       sel_start   :   TX_OUT = start_bit;
       sel_stop    :   TX_OUT = stop_bit;
       sel_data    :   TX_OUT = ser_data;
       sel_par     :   TX_OUT = par_bit;
       endcase
    end
endmodule