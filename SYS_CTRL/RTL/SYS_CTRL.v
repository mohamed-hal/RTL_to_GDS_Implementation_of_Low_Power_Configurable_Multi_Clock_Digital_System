module SYS_CTRL#(
    parameter OP_WIDTH        = 8,
              ALU_OUT_WIDTH   = OP_WIDTH * 2, 

    parameter REG_WIDTH       = 8,
              REG_DEPTH       = 16,
              ADDRESS_WIDTH   = $clog2 (REG_DEPTH),

    parameter UART_DATA_WIDTH = 8               
) 
(
    input   wire                             CLK,
    input   wire                             RST,

    ///////////////////////////////////////////////////////
    //////////////////     ALU_CONTROL    /////////////////
    ///////////////////////////////////////////////////////
    input   wire  [ALU_OUT_WIDTH - 1 : 0]    ALU_OUT,
    input   wire                             OUT_Valid,
    output  reg   [3:0]                      ALU_FUN,
    output  reg                              EN,
    output  reg                              CLK_EN,

    ///////////////////////////////////////////////////////
    //////////////////     REG_FILE_CONTROL    ////////////
    ///////////////////////////////////////////////////////
    input   wire  [REG_WIDTH - 1 : 0]        RdData,
    input   wire                             RdData_Valid,
    output  reg   [ADDRESS_WIDTH - 1 : 0]    Address,
    output  reg                              WrEn,
    output  reg                              RdEn,
    output  reg   [REG_WIDTH - 1 : 0]        WrData,

    ///////////////////////////////////////////////////////
    //////////////////     UART_CONTROL    ////////////////
    ///////////////////////////////////////////////////////
    input   wire  [UART_DATA_WIDTH - 1 : 0]  RX_P_DATA,
    input   wire                             RX_D_VLD,
    output  reg   [UART_DATA_WIDTH - 1 : 0]  TX_P_DATA,
    output  reg                              TX_D_VLD,

    ///////////////////////////////////////////////////////
    //////////////////     FIFO_CONTROL    ////////////////
    ///////////////////////////////////////////////////////
    input   wire                             FIFO_FULL,


    ///////////////////////////////////////////////////////
    //////////////////     CLKDIV_CONTROL    //////////////
    ///////////////////////////////////////////////////////
    output  reg                              clk_div_en
);

reg  [ALU_OUT_WIDTH - 1 : 0] ALU_OUT_STORED;
reg  [ADDRESS_WIDTH - 1 : 0] Address_STORED;
reg                          ALU_OUT_STORE_FLAG;
reg                          Address_STORE_FLAG;
reg  [3:0]                   Current_State,
                             Next_State;

localparam   IDLE       = 4'b0000,
             RF_Wr_Addr = 4'b0001, RF_Wr_Data  = 4'b0010,
             RF_Rd_Addr = 4'b0011, SEND_DATA   = 4'b0100,
             OPERAND_A  = 4'b0101, OPERAND_B   = 4'b0110, ALU_FUN_ST  = 4'b0111,
             ALU_STORE  = 4'b1000, ALU_RESULT1 = 4'b1001, ALU_RESULT2 = 4'b1010;

localparam   RF_Wr_CMD          = 8'hAA,
             RF_Rd_CMD          = 8'hBB,
             ALU_OPER_W_OP_CMD  = 8'hCC,
             ALU_OPER_W_NOP_CMD = 8'hDD;             

always @(posedge CLK , negedge RST) begin
    if (!RST) begin
        ALU_OUT_STORED <= 'd0;
    end
    else if (ALU_OUT_STORE_FLAG) begin
        ALU_OUT_STORED <= ALU_OUT;
    end
end

always @(posedge CLK , negedge RST) begin
    if (!RST) begin
        Address_STORED <= 'd0;
    end
    else if (Address_STORE_FLAG) begin
        Address_STORED <= RX_P_DATA;
    end
end


always @(posedge CLK , negedge RST) begin
    if (!RST) begin
        Current_State <= IDLE;
    end else begin
        Current_State <= Next_State;
    end
end

always @(*) begin
    case (Current_State)

    IDLE   : begin
        if (RX_D_VLD) begin
            if (RX_P_DATA == RF_Wr_CMD) begin
                Next_State = RF_Rd_Addr;
            end
            else if (RX_P_DATA == RF_Rd_CMD) begin
                Next_State = RF_Rd_Addr;
            end
            else if (RX_P_DATA == ALU_OPER_W_OP_CMD) begin
                Next_State = OPERAND_A;
            end
            else if (RX_P_DATA == ALU_OPER_W_NOP_CMD) begin
                Next_State = ALU_FUN;
            end
            else begin
                Next_State = IDLE;
            end
        end
        else begin
            Next_State = IDLE;
        end
    end

    RF_Wr_Addr  : begin
        if (RX_D_VLD) begin
            Next_State = RF_Wr_Data;
        end
        else begin
            Next_State = RF_Wr_Addr;
        end
    end

    RF_Wr_Data  : begin
        if (RX_D_VLD) begin
            Next_State = IDLE;
        end
        else begin
            Next_State = RF_Wr_Data;
        end
    end

    RF_Rd_Addr  : begin
        if (RX_D_VLD) begin
            Next_State = SEND_DATA;
        end
        else begin
            Next_State = RF_Rd_Addr;
        end
    end

    SEND_DATA   : begin
        if (RdData_Valid) begin
            Next_State = IDLE;
        end
        else begin
            Next_State = SEND_DATA;
        end
    end

    OPERAND_A   : begin
        if (RX_D_VLD) begin
            Next_State = OPERAND_B;
        end
        else begin
            Next_State = OPERAND_A;
        end
    end

    OPERAND_B   : begin
        if (RX_D_VLD) begin
            Next_State = ALU_FUN;
        end
        else begin
            Next_State = OPERAND_B;
        end
    end

    ALU_FUN_ST  : begin
        if (RX_D_VLD) begin
            Next_State = ALU_STORE;
        end
        else begin
            Next_State = ALU_FUN_ST;
        end
    end

    ALU_STORE   : begin
        if (OUT_Valid) begin
            Next_State = ALU_RESULT1;
        end
        else begin
            Next_State = ALU_STORE;
        end
    end

    ALU_RESULT1  : begin
        if (FIFO_FULL) begin
            Next_State = ALU_RESULT1;
        end
        else begin
            Next_State = ALU_RESULT2;
        end
    end

    ALU_RESULT2  : begin
        if (FIFO_FULL) begin
            Next_State = ALU_RESULT2;
        end
        else begin
            Next_State = IDLE;
        end
    end

    default : begin
        Next_State = IDLE;
    end
endcase  
end


always @(*) begin
    ALU_FUN            = 'd0;
    EN                 = 'd0;
    CLK_EN             = 'd0;
    Address            = 'd0;
    WrEn               = 'd0;
    RdEn               = 'd0;
    WrData             = 'd0;
    TX_P_DATA          = 'd0;
    TX_D_VLD           = 'd0;
    clk_div_en         = 'd1;
    ALU_OUT_STORE_FLAG = 'd0;
    Address_STORE_FLAG = 'd0;

    case (Current_State)

    IDLE    : begin
        ALU_FUN            = 'd0;
        EN                 = 'd0;
        CLK_EN             = 'd0;
        Address            = 'd0;
        WrEn               = 'd0;
        RdEn               = 'd0;
        WrData             = 'd0;
        TX_P_DATA          = 'd0;
        TX_D_VLD           = 'd0;
        clk_div_en         = 'd1;
        ALU_OUT_STORE_FLAG = 'd0;
        Address_STORE_FLAG = 'd0;   
    end

    RF_Wr_Addr : begin
        if (RX_D_VLD) begin
            Address_STORE_FLAG = 'd1;
        end
    end

    RF_Wr_Data : begin
        if (RX_D_VLD) begin
            Address = Address_STORED;
            WrData  = RX_P_DATA;
            WrEn    = 'd1;
        end
    end

    RF_Rd_Addr : begin
        if (RX_D_VLD) begin
            Address_STORE_FLAG = 'd1;
        end
    end

    SEND_DATA  : begin
        RdEn = 'd1;
        Address = Address_STORED;
        if (RdData_Valid && !FIFO_FULL) begin
            TX_P_DATA = RdData;
            TX_D_VLD  = 'd1;
        end
    end

    OPERAND_A  : begin
        CLK_EN  = 'd1;
        if (RX_D_VLD) begin
            Address = 'd0;
            WrEn    = 'd1;
            WrData  = RX_P_DATA;
        end
    end

    OPERAND_B  : begin
        CLK_EN  = 'd1;
        if (RX_D_VLD) begin
            Address = 'd1;
            WrEn    = 'd1;
            WrData  = RX_P_DATA;
        end
    end

    ALU_FUN_ST : begin
        CLK_EN  = 'd1;
        if (RX_D_VLD) begin
            EN      = 'd1;
            ALU_FUN = RX_P_DATA;
        end
    end

    ALU_STORE  : begin
        CLK_EN  = 'd1;
        if (OUT_Valid) begin
            ALU_OUT_STORE_FLAG = 'd1;
        end
    end

    ALU_RESULT1 : begin
        CLK_EN  = 'd1;
        if (!FIFO_FULL) begin
            TX_P_DATA = ALU_OUT_STORED [UART_DATA_WIDTH - 1 : 0];
            TX_D_VLD  = 'd1;
        end
    end

    ALU_RESULT2 : begin
        CLK_EN  = 'd1;
        if (!FIFO_FULL) begin
            TX_P_DATA = ALU_OUT_STORED [UART_DATA_WIDTH * 2 - 1 : UART_DATA_WIDTH];
            TX_D_VLD  = 'd1;
        end
    end

        default: begin
            ALU_FUN            = 'd0;
            EN                 = 'd0;
            CLK_EN             = 'd0;
            Address            = 'd0;
            WrEn               = 'd0;
            RdEn               = 'd0;
            WrData             = 'd0;
            TX_P_DATA          = 'd0;
            TX_D_VLD           = 'd0;
            clk_div_en         = 'd1;
            ALU_OUT_STORE_FLAG = 'd0;
            Address_STORE_FLAG = 'd0;            
        end 
    endcase    
end

endmodule