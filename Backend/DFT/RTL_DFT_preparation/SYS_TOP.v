module SYS_TOP #(
    parameter DATA_WIDTH       = 8,
              FIFO_ADDR_SIZE   = 3,
              MEM_DEPTH        = 16,
              MEM_ADDR_SIZE    = $clog2 (MEM_DEPTH),
              RST_SYNC_STAGES  = 2, 
              DATA_SYNC_STAGES = 2,
              ALU_OUT_WIDTH    = DATA_WIDTH * 2,
              NUM_OF_CHAINS    = 4      
) 
(
    input   wire  REF_CLK,
    input   wire  UART_CLK,
    input   wire  RST_N,
    input   wire  UART_RX_IN,

    input   wire [NUM_OF_CHAINS - 1 : 0] SI,
    input   wire                         SE,
    input   wire                         test_mode,
    input   wire                         scan_clk,
    input   wire                         scan_rst,
    output  wire [NUM_OF_CHAINS - 1 : 0] SO,

    output  wire  UART_TX_O,
    output  wire  parity_error,
    output  wire  framing_error
);

wire                            SYNC_REF_RST;
wire                            SYNC_UART_RST;
wire  [DATA_WIDTH - 1 : 0]      UART_CONFIG;
wire                            clk_div_en;
wire  [3 : 0]                   RX_DIV_RATIO;
wire  [DATA_WIDTH - 1 : 0]      TX_DIV_RATIO;
wire                            RX_CLK;
wire                            TX_CLK;
wire  [DATA_WIDTH - 1 : 0]      TX_P_DATA;
wire                            F_EMPTY;
wire                            TX_Busy;
wire                            RD_INC;
wire  [DATA_WIDTH - 1 : 0]      RX_P_DATA;
wire  [DATA_WIDTH - 1 : 0]      SYNC_RX_P_DATA;
wire                            RX_Data_Valid;
wire                            SYNC_RX_Data_Valid;
wire                            WR_INC;
wire  [DATA_WIDTH - 1 : 0]      WR_DATA;
wire                            FIFO_FULL;
wire                            CLK_EN;
wire                            ALU_CLK;
wire  [DATA_WIDTH - 1 : 0]      OP_A;
wire  [DATA_WIDTH - 1 : 0]      OP_B;
wire                            ALU_EN;
wire  [3:0]                     ALU_FUN;
wire  [ALU_OUT_WIDTH - 1 : 0]   ALU_OUT;
wire                            ALU_OUT_VALID;
wire  [DATA_WIDTH - 1 : 0]      Wr_D;
wire  [MEM_ADDR_SIZE - 1 : 0]   MEM_Addr;
wire                            WrEn;
wire                            RdEn;
wire  [DATA_WIDTH - 1 : 0]      Rd_D;
wire                            Rd_D_Vld;

wire                            REF_CLK_M;
wire                            UART_CLK_M;
wire                            UART_CLK_neg_M;
wire                            TX_CLK_M;
wire                            RX_CLK_M;
wire                            RST_M;
wire                            RST_SYNC1_M;
wire                            RST_SYNC2_M;


RST_SYNC #(.NUM_STAGES (RST_SYNC_STAGES)) RST_SYNC_1 (
    .CLK      (REF_CLK_M),
    .RST      (RST_M),
    .SYNC_RST (SYNC_REF_RST)
);

RST_SYNC #(.NUM_STAGES (RST_SYNC_STAGES)) RST_SYNC_2 (
    .CLK      (UART_CLK_M),
    .RST      (RST_M),
    .SYNC_RST (SYNC_UART_RST)
);

ClkDiv #(.WIDTH (4)) RX_CLK_GEN (
    .i_ref_clk_pos (UART_CLK_M),
    .i_ref_clk_neg (UART_CLK_neg_M),
    .i_rst_n       (RST_SYNC2_M),
    .i_clk_en      (clk_div_en),
    .i_div_ratio   (RX_DIV_RATIO),
    .o_div_clk     (RX_CLK)
);

Prescale_MUX #(.DIV_RATIO_WIDTH (4)) RX_DIV_RATIO_GEN (
    .Prescale  (UART_CONFIG[7:2]),
    .DIV_RATIO (RX_DIV_RATIO)
);

ClkDiv #(.WIDTH (DATA_WIDTH)) TX_CLK_GEN (
    .i_ref_clk_pos (UART_CLK_M),
    .i_ref_clk_neg (UART_CLK_neg_M),
    .i_rst_n       (RST_SYNC2_M),
    .i_clk_en      (clk_div_en),
    .i_div_ratio   (TX_DIV_RATIO),
    .o_div_clk     (TX_CLK)  
);

UART #(.DATA_WIDTH (DATA_WIDTH)) UART_UNIT (
    .RST           (RST_SYNC2_M),
    .TX_CLK        (TX_CLK_M),
    .RX_CLK        (RX_CLK_M),
    .TX_P_DATA     (TX_P_DATA),
    .TX_Data_Valid (!F_EMPTY),
    .TX_OUT        (UART_TX_O),
    .TX_Busy       (TX_Busy),
    .RX_IN         (UART_RX_IN),
    .RX_P_DATA     (RX_P_DATA),
    .RX_Data_Valid (RX_Data_Valid),
    .Parity_Error  (parity_error),
    .Stop_Error    (framing_error),
    .PAR_EN        (UART_CONFIG[0]),
    .PAR_TYP       (UART_CONFIG[1]),
    .Prescale      (UART_CONFIG[7:2])
);

PULSE_GEN RD_INC_UNIT (
    .CLK       (TX_CLK_M),
    .RST       (RST_SYNC2_M),
    .LVL_SIG   (TX_Busy),
    .PULSE_SIG (RD_INC)
);

DATA_SYNC #(.NUM_STAGES (DATA_SYNC_STAGES) , .BUS_WIDTH (DATA_WIDTH)) DATA_SYNC_UNIT (
    .CLK          (REF_CLK_M),
    .RST          (RST_SYNC1_M),
    .bus_enable   (RX_Data_Valid),
    .unsync_bus   (RX_P_DATA),
    .sync_bus     (SYNC_RX_P_DATA),
    .enable_pulse (SYNC_RX_Data_Valid)
);

FIFO_TOP #(.DATA_WIDTH (DATA_WIDTH) , .ADDR_SIZE (FIFO_ADDR_SIZE)) FIFO_UNIT (
    .wclk   (REF_CLK_M),
    .wrst_n (RST_SYNC1_M),
    .winc   (WR_INC),
    .wdata  (WR_DATA),
    .wfull  (FIFO_FULL),

    .rclk   (TX_CLK_M),
    .rrst_n (RST_SYNC2_M),
    .rinc   (RD_INC),
    .rdata  (TX_P_DATA),
    .rempty (F_EMPTY)
);

CLK_GATE CLK_GATE_UNIT (
    .CLK_EN    (CLK_EN || test_mode),
    .CLK       (REF_CLK_M),
    .GATED_CLK (ALU_CLK)
);

ALU #(.OPERAND_WIDTH (DATA_WIDTH) , .OUT_WIDTH(ALU_OUT_WIDTH)) ALU_UNIT (
    .CLK       (ALU_CLK),
    .RST       (RST_SYNC1_M),
    .A         (OP_A),
    .B         (OP_B),
    .EN        (ALU_EN),
    .ALU_FUN   (ALU_FUN),
    .ALU_OUT   (ALU_OUT),
    .OUT_VALID (ALU_OUT_VALID)
);

Register_File #(
    .DEPTH         (MEM_DEPTH),
    .DATA_WIDTH    (DATA_WIDTH),
    .ADDRESS_WIDTH (MEM_ADDR_SIZE)
) REG_FILE_UNIT (
    .CLK          (REF_CLK_M),
    .RST          (RST_SYNC1_M),
    .WrData       (Wr_D),
    .Address      (MEM_Addr),
    .WrEn         (WrEn),
    .RdEn         (RdEn),
    .RdData       (Rd_D),
    .RdData_Valid (Rd_D_Vld),
    .REG0         (OP_A),
    .REG1         (OP_B),
    .REG2         (UART_CONFIG),
    .REG3         (TX_DIV_RATIO)
);

SYS_CTRL #(
    .OP_WIDTH        (DATA_WIDTH),
    .ALU_OUT_WIDTH   (ALU_OUT_WIDTH),
    .REG_WIDTH       (DATA_WIDTH),
    .REG_DEPTH       (MEM_DEPTH),
    .ADDRESS_WIDTH   (MEM_ADDR_SIZE),
    .UART_DATA_WIDTH (DATA_WIDTH)
) SYS_CTRL_UNIT (
    .CLK          (REF_CLK_M),
    .RST          (RST_SYNC1_M),

    .ALU_OUT      (ALU_OUT),
    .OUT_Valid    (ALU_OUT_VALID),
    .ALU_FUN      (ALU_FUN),
    .EN           (ALU_EN),
    .CLK_EN       (CLK_EN),

    .RdData       (Rd_D),
    .RdData_Valid (Rd_D_Vld),
    .Address      (MEM_Addr),
    .WrEn         (WrEn),
    .RdEn         (RdEn),
    .WrData       (Wr_D),

    .RX_P_DATA    (SYNC_RX_P_DATA),
    .RX_D_VLD     (SYNC_RX_Data_Valid),
    .TX_P_DATA    (WR_DATA),
    .TX_D_VLD     (WR_INC),

    .FIFO_FULL    (FIFO_FULL),

    .clk_div_en   (clk_div_en)
);

//DFT
mux2X1 REF_SCAN_CLK (
.IN_0(REF_CLK),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(REF_CLK_M)
);

mux2X1 UART_SCAN_CLK (
.IN_0(UART_CLK),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(UART_CLK_M)
);

mux2X1 UART_SCAN_neg_CLK (
.IN_0(UART_CLK),
.IN_1(!scan_clk),
.SEL(test_mode),
.OUT(UART_CLK_neg_M)
);

mux2X1 RX_SCAN_CLK (
.IN_0(RX_CLK),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(RX_CLK_M)
);

mux2X1 TX_SCAN_CLK (
.IN_0(TX_CLK),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(TX_CLK_M)
);


mux2X1 RST_SCAN (
.IN_0(RST_N),
.IN_1(scan_rst),
.SEL(test_mode),
.OUT(RST_M)
);

mux2X1 RST_SYNC1_SCAN (
.IN_0(SYNC_REF_RST),
.IN_1(scan_rst),
.SEL(test_mode),
.OUT(RST_SYNC1_M)
);

mux2X1 RST_SYNC2_SCAN (
.IN_0(SYNC_UART_RST),
.IN_1(scan_rst),
.SEL(test_mode),
.OUT(RST_SYNC2_M)
);

endmodule


