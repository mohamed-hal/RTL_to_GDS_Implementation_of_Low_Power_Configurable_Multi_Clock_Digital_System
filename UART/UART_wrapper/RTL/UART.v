module UART #(parameter DATA_WIDTH = 8) (

    input   wire                        RST,
    input   wire                        TX_CLK,
    input   wire                        RX_CLK,

    ///////////////////////////////////////////////////////
    //////////////////     TX_INTERFACE    ////////////////
    ///////////////////////////////////////////////////////
    input   wire  [DATA_WIDTH - 1 : 0]  TX_P_DATA,
    input   wire                        TX_Data_Valid,

    output  wire                        TX_OUT,
    output  wire                        TX_Busy,

    ///////////////////////////////////////////////////////
    //////////////////     RX_INTERFACE    ////////////////
    ///////////////////////////////////////////////////////
    input   wire  [DATA_WIDTH - 1 : 0]  RX_IN,
    output  wire  [DATA_WIDTH - 1 : 0]  RX_P_DATA,
    output  wire                        RX_Data_Valid,
    output  wire                        Parity_Error,
    output  wire                        Stop_Error, 

    ///////////////////////////////////////////////////////
    //////////////////     CONFIG_INTERFACE    ////////////
    ///////////////////////////////////////////////////////
    input   wire                        PAR_EN,
    input   wire                        PAR_TYP,
    input   wire  [5:0]                 Prescale

    );

    UART_TX #(.WIDTH (DATA_WIDTH)) UART_TX_UNIT (
        .clk        (TX_CLK),
        .RST        (RST),

        .P_DATA     (TX_P_DATA),
        .Data_Valid (TX_Data_Valid),

        .TX_OUT     (TX_OUT),
        .Busy       (TX_Busy),

        .PAR_EN     (PAR_EN),
        .PAR_TYP    (PAR_TYP)
    );
    
    UART_RX #(.DATA_WIDTH (DATA_WIDTH)) UART_RX_UNIT (
        .CLK            (RX_CLK),
        .RST            (RST),

        .RX_IN          (RX_IN),

        .P_DATA         (RX_P_DATA),
        .Data_valid     (RX_Data_Valid),
        .Parity_Error   (Parity_Error),
        .Stop_Error     (Stop_Error),

        .PAR_EN         (PAR_EN),
        .PAR_TYP        (PAR_TYP),
        .Prescale       (Prescale)
    );
endmodule
