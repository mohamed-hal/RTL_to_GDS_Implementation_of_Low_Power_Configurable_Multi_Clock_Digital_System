module ALU_TOP#(parameter IP_DATA_WIDTH = 16, parameter OP_DATA_WIDTH = 16 , parameter CMP_OP_DATA_WIDTH = 2)(
    input [IP_DATA_WIDTH-1:0] A , B ,
    input [3:0] ALU_FUN ,
    input CLK , RST ,
    output [2*OP_DATA_WIDTH-1:0] Arith_OUT ,
    output [OP_DATA_WIDTH-1:0]   Shift_OUT,
    output [OP_DATA_WIDTH-1:0]   Logic_OUT,
    output [CMP_OP_DATA_WIDTH-1:0]                 CMP_OUT,
    output Arith_Flag , Shift_Flag , Logic_Flag , CMP_Flag
    );
    wire [1:0] ALU_FUN_MS , ALU_FUN_LS;
    wire Arith_Enable , Shift_Enable , Logic_Enable , CMP_Enable;

    assign ALU_FUN_MS = ALU_FUN[3:2];
    assign ALU_FUN_LS = ALU_FUN[1:0];

    DECODER_UNIT U1 (.ALU_FUN_MS(ALU_FUN_MS), .Arith_Enable(Arith_Enable), .Shift_Enable(Shift_Enable), .Logic_Enable(Logic_Enable), .CMP_Enable(CMP_Enable));

    ARITHMETIC_UNIT #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .OP_DATA_WIDTH(2*OP_DATA_WIDTH)) U2
        (.A(A), .B(B), .CLK(CLK), .RST(RST), .ALU_FUN_LS(ALU_FUN_LS), .Arith_Enable(Arith_Enable), .Arith_Flag(Arith_Flag), .Arith_OUT(Arith_OUT));

    LOGIC_UNIT #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .OP_DATA_WIDTH(OP_DATA_WIDTH)) U3
        (.A(A), .B(B), .CLK(CLK), .RST(RST), .ALU_FUN_LS(ALU_FUN_LS), .Logic_Enable(Logic_Enable), .Logic_OUT(Logic_OUT), .Logic_Flag(Logic_Flag));

    CMP_UNIT #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .CMP_OP_DATA_WIDTH(CMP_OP_DATA_WIDTH)) U4
        (.A(A), .B(B), .CLK(CLK), .RST(RST), .ALU_FUN_LS(ALU_FUN_LS), .CMP_Enable(CMP_Enable), .CMP_Flag(CMP_Flag), .CMP_OUT(CMP_OUT));

    SHIFT_UNIT #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .OP_DATA_WIDTH(OP_DATA_WIDTH)) U5
        (.A(A), .B(B), .CLK(CLK), .RST(RST), .ALU_FUN_LS(ALU_FUN_LS), .Shift_Enable(Shift_Enable), .Shift_Flag(Shift_Flag), .Shift_OUT(Shift_OUT));

endmodule