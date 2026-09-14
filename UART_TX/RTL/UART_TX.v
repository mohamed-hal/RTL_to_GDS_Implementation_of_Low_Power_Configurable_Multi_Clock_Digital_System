module UART_TX(
       input [7:0] P_DATA,
       input Data_Valid,
       input PAR_EN,
       input PAR_TYP,
       input clk, RST,
       output TX_OUT,
       output Busy
    );

    // Internal wires connecting the sub-blocks
    wire       ser_en;
    wire       ser_done;
    wire       ser_data;
    wire       par_bit;
    wire [1:0] mux_sel;

    FSM u_fsm (
        .Data_Valid (Data_Valid),
        .PAR_EN     (PAR_EN),
        .ser_done   (ser_done),
        .RST        (RST),
        .clk        (clk),
        .busy       (Busy),
        .ser_en     (ser_en),
        .mux_sel    (mux_sel)
    );

    serializer u_serializer (
        .clk     (clk),
        .RST     (RST),
        .P_DATA  (P_DATA),
        .ser_en  (ser_en),
        .ser_done(ser_done),
        .ser_data(ser_data)
    );

    Parity_Calc u_parity (
        .clk        (clk),
        .RST        (RST),
        .P_DATA     (P_DATA),
        .Data_Valid (Data_Valid),
        .PAR_TYP    (PAR_TYP),
        .par_bit    (par_bit)
    );

    MUX u_mux (
        .mux_sel (mux_sel),
        .ser_data(ser_data),
        .par_bit (par_bit),
        .TX_OUT  (TX_OUT)
    );

endmodule