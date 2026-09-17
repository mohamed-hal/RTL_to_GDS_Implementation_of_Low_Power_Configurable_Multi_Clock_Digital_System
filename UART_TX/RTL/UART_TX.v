module UART_TX # ( parameter WIDTH = 8 )(
       input [WIDTH-1:0] P_DATA,
       input Data_Valid,
       input PAR_EN,
       input PAR_TYP,
       input clk, RST,

       input  wire                        SI,
       input  wire                        SE,
       input  wire                        test_mode,
       input  wire                        scan_clk,
       input  wire                        scan_rst,
       output wire                        SO,

       output TX_OUT,
       output Busy
    );

    // Internal wires connecting the sub-blocks
    wire       ser_en;
    wire       ser_done;
    wire       ser_data;
    wire       par_bit;
    wire [1:0] mux_sel;
    wire                  CLK_M;
    wire                  RST_M;

    FSM u_fsm (
        .Data_Valid (Data_Valid),
        .PAR_EN     (PAR_EN),
        .ser_done   (ser_done),
        .RST        (RST_M),
        .clk        (CLK_M),
        .busy       (Busy),
        .ser_en     (ser_en),
        .mux_sel    (mux_sel)
    );

    Serializer # (.WIDTH(WIDTH)) u_serializer (
        .CLK        (CLK_M),
        .RST        (RST_M),
        .DATA       (P_DATA),
        .Enable     (ser_en),
        .Busy       (Busy),
        .Data_Valid (Data_Valid),
        .ser_out    (ser_data),
        .ser_done   (ser_done)
    );

    Parity_Calc # (.WIDTH(WIDTH)) u_parity (
        .clk        (CLK_M),
        .RST        (RST_M),
        .P_DATA     (P_DATA),
        .Data_Valid (Data_Valid),
        .PAR_TYP    (PAR_TYP),
        .par_bit    (par_bit),
        .PAR_EN     (PAR_EN),
        .Busy       (Busy)
    );

    MUX u_mux (
        .mux_sel (mux_sel),
        .ser_data(ser_data),
        .par_bit (par_bit),
        .TX_OUT  (TX_OUT)
    );

mux2X1 U00_mux2X1 (
.IN_0(clk),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(CLK_M)
);


mux2X1 U01_scan_rstmux2X1 (
.IN_0(RST),
.IN_1(scan_rst),
.SEL(test_mode),
.OUT(RST_M)
);

endmodule
