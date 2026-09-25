module UART_RX #(parameter DATA_WIDTH = 8)(
    input   wire                     CLK,
    input   wire                     RST,
    input   wire                     PAR_EN,
    input   wire                     PAR_TYP,
    input   wire [5:0]               Prescale,
    input   wire                     RX_IN,

    output  wire [DATA_WIDTH - 1:0]  P_DATA,
    output  wire                     Data_valid,
    output  wire                     Parity_Error,
    output  wire                     Stop_Error
    );

    //--------------------------------------------------
    // Internal interconnect wires
    //--------------------------------------------------
    wire        enable;
    wire        dat_samp_en;
    wire        par_chk_en;
    wire        strt_chk_en;
    wire        stp_chk_en;
    wire        deser_en;

    wire [3:0]  bit_cnt;
    wire [5:0]  edge_cnt;

    wire        sampled_bit;
    wire        strt_glitch;
 

    //--------------------------------------------------
    // FSM Controller
    //--------------------------------------------------
    FSM_RX #(.DATA_WIDTH(DATA_WIDTH)) u_FSM_RX (
        .CLK          (CLK),
        .RST          (RST),
        .PAR_EN       (PAR_EN),
        .RX_IN        (RX_IN),
        .edge_cnt     (edge_cnt),
        .bit_cnt      (bit_cnt),
        .Prescale     (Prescale),
        .par_err      (Parity_Error),
        .strt_glitch  (strt_glitch),
        .stp_err      (Stop_Error),

        .enable       (enable),
        .dat_samp_en  (dat_samp_en),
        .par_chk_en   (par_chk_en),
        .strt_chk_en  (strt_chk_en),
        .stp_chk_en   (stp_chk_en),
        .deser_en     (deser_en),
        .Data_Valid   (Data_valid)
    );

    //--------------------------------------------------
    // Edge / Bit Counter
    //--------------------------------------------------
    edge_bit_counter #(.DATA_WIDTH(DATA_WIDTH)) u_edge_bit_counter (
        .CLK      (CLK),
        .RST      (RST),
        .enable   (enable),
        .Prescale (Prescale),

        .bit_cnt  (bit_cnt),
        .edge_cnt (edge_cnt)
    );

    //--------------------------------------------------
    // Data Sampling 
    //--------------------------------------------------
    Data_Sampling #(.DATA_WIDTH(DATA_WIDTH)) u_Data_Sampling (
        .CLK          (CLK),
        .RST          (RST),
        .edge_cnt     (edge_cnt),
        .RX_IN        (RX_IN),
        .dat_samp_en  (dat_samp_en),
        .Prescale     (Prescale),

        .sampled_bit  (sampled_bit)
    );

    //--------------------------------------------------
    // Deserializer
    //--------------------------------------------------
    deserializer #(.DATA_WIDTH(DATA_WIDTH)) u_deserializer (
        .CLK          (CLK),
        .RST          (RST),
        .sampled_bit  (sampled_bit),
        .deser_en     (deser_en),
        .Prescale     (Prescale),
        .edge_cnt     (edge_cnt),

        .P_DATA       (P_DATA)
    );

    //--------------------------------------------------
    // Start Bit Check
    //--------------------------------------------------
    Start_Check #(.DATA_WIDTH(DATA_WIDTH)) u_Start_Check (
        .CLK          (CLK),
        .RST          (RST),
        .strt_chk_en  (strt_chk_en),
        .sampled_bit  (sampled_bit),

        .strt_glitch  (strt_glitch)
    );

    //--------------------------------------------------
    // Parity Check
    //--------------------------------------------------
    Parity_Check #(.DATA_WIDTH(DATA_WIDTH)) u_Parity_Check (
        .CLK          (CLK),
        .RST          (RST),
        .par_chk_en   (par_chk_en),
        .sampled_bit  (sampled_bit),
        .P_DATA       (P_DATA),
        .PAR_TYP      (PAR_TYP),

        .par_err      (Parity_Error)
    );

    //--------------------------------------------------
    // Stop Bit Check
    //--------------------------------------------------
    Stop_Check #(.DATA_WIDTH(DATA_WIDTH)) u_Stop_Check (
        .CLK          (CLK),
        .RST          (RST),
        .sampled_bit  (sampled_bit),
        .stp_chk_en   (stp_chk_en),

        .stp_err      (Stop_Error)
    );

endmodule
