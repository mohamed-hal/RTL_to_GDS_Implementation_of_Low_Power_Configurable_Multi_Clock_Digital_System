/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Tue Sep  8 03:48:32 2026
/////////////////////////////////////////////////////////////


module FSM_test_1 ( Data_Valid, PAR_EN, ser_done, RST, clk, busy, ser_en, 
        mux_sel, test_si2, test_si1, test_so1, test_se );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, RST, clk, test_si2, test_si1, test_se;
  output busy, ser_en, test_so1;
  wire   Current_State_1_, Current_State_0_, busy_c, n9, n10, n11, n12, n13,
         n7, n14;
  wire   [2:0] Next_State;

  SDFFRQX2M busy_reg ( .D(busy_c), .SI(test_si2), .SE(test_se), .CK(clk), .RN(
        RST), .Q(busy) );
  SDFFRQX2M Current_State_reg_1_ ( .D(Next_State[1]), .SI(Current_State_0_), 
        .SE(test_se), .CK(clk), .RN(RST), .Q(Current_State_1_) );
  SDFFRQX2M Current_State_reg_2_ ( .D(Next_State[2]), .SI(Current_State_1_), 
        .SE(test_se), .CK(clk), .RN(RST), .Q(test_so1) );
  SDFFRX1M Current_State_reg_0_ ( .D(Next_State[0]), .SI(test_si1), .SE(
        test_se), .CK(clk), .RN(RST), .Q(Current_State_0_), .QN(n7) );
  INVX2M U8 ( .A(n9), .Y(ser_en) );
  INVX2M U9 ( .A(n13), .Y(mux_sel[0]) );
  NAND2X2M U10 ( .A(mux_sel[1]), .B(n11), .Y(n9) );
  NOR2X2M U11 ( .A(n14), .B(test_so1), .Y(mux_sel[1]) );
  NOR2X2M U12 ( .A(n7), .B(test_so1), .Y(n13) );
  INVX2M U13 ( .A(Current_State_1_), .Y(n14) );
  OAI22X1M U14 ( .A0(ser_done), .A1(mux_sel[0]), .B0(Current_State_1_), .B1(
        n12), .Y(Next_State[0]) );
  AOI2B1X1M U15 ( .A1N(test_so1), .A0(Data_Valid), .B0(n13), .Y(n12) );
  NOR2BX2M U16 ( .AN(mux_sel[1]), .B(n10), .Y(Next_State[2]) );
  AOI2B1X1M U17 ( .A1N(PAR_EN), .A0(ser_done), .B0(n7), .Y(n10) );
  XNOR2X2M U18 ( .A(Current_State_0_), .B(Current_State_1_), .Y(n11) );
  OAI21X2M U19 ( .A0(test_so1), .A1(n11), .B0(n9), .Y(Next_State[1]) );
  OAI21X2M U20 ( .A0(Current_State_0_), .A1(n14), .B0(mux_sel[0]), .Y(busy_c)
         );
endmodule


module Serializer_test_1 ( CLK, RST, DATA, Enable, Busy, Data_Valid, ser_out, 
        ser_done, test_si, test_so, test_se );
  input [7:0] DATA;
  input CLK, RST, Enable, Busy, Data_Valid, test_si, test_se;
  output ser_out, ser_done, test_so;
  wire   N23, N24, N25, n12, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n13, n14, n15,
         n40, n41;
  wire   [7:1] DATA_V;
  wire   [1:0] ser_count;

  SDFFRQX2M DATA_V_reg_6_ ( .D(n31), .SI(DATA_V[5]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[6]) );
  SDFFRQX2M DATA_V_reg_5_ ( .D(n32), .SI(DATA_V[4]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[5]) );
  SDFFRQX2M DATA_V_reg_4_ ( .D(n33), .SI(DATA_V[3]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[4]) );
  SDFFRQX2M DATA_V_reg_3_ ( .D(n34), .SI(DATA_V[2]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[3]) );
  SDFFRQX2M DATA_V_reg_2_ ( .D(n35), .SI(DATA_V[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[2]) );
  SDFFRQX2M DATA_V_reg_1_ ( .D(n36), .SI(ser_out), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[1]) );
  SDFFRQX2M DATA_V_reg_7_ ( .D(n30), .SI(DATA_V[6]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(DATA_V[7]) );
  SDFFRQX2M ser_count_reg_1_ ( .D(N24), .SI(ser_count[0]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(ser_count[1]) );
  SDFFRQX2M ser_count_reg_0_ ( .D(N23), .SI(DATA_V[7]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(ser_count[0]) );
  SDFFRX1M ser_count_reg_2_ ( .D(N25), .SI(ser_count[1]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(test_so), .QN(n12) );
  SDFFRQX2M DATA_V_reg_0_ ( .D(n29), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(ser_out) );
  INVX2M U14 ( .A(Enable), .Y(n15) );
  NOR2X2M U15 ( .A(n15), .B(n19), .Y(n18) );
  NOR2X2M U16 ( .A(n19), .B(n18), .Y(n16) );
  NOR2BX2M U17 ( .AN(Data_Valid), .B(n41), .Y(n19) );
  OAI2BB1X2M U18 ( .A0N(ser_out), .A1N(n16), .B0(n17), .Y(n29) );
  AOI22X1M U19 ( .A0(DATA_V[1]), .A1(n18), .B0(DATA[0]), .B1(n19), .Y(n17) );
  OAI2BB1X2M U20 ( .A0N(DATA_V[1]), .A1N(n16), .B0(n25), .Y(n36) );
  AOI22X1M U21 ( .A0(DATA_V[2]), .A1(n18), .B0(DATA[1]), .B1(n19), .Y(n25) );
  OAI2BB1X2M U22 ( .A0N(n16), .A1N(DATA_V[2]), .B0(n24), .Y(n35) );
  AOI22X1M U23 ( .A0(DATA_V[3]), .A1(n18), .B0(DATA[2]), .B1(n19), .Y(n24) );
  OAI2BB1X2M U24 ( .A0N(n16), .A1N(DATA_V[3]), .B0(n23), .Y(n34) );
  AOI22X1M U25 ( .A0(DATA_V[4]), .A1(n18), .B0(DATA[3]), .B1(n19), .Y(n23) );
  OAI2BB1X2M U26 ( .A0N(n16), .A1N(DATA_V[4]), .B0(n22), .Y(n33) );
  AOI22X1M U27 ( .A0(DATA_V[5]), .A1(n18), .B0(DATA[4]), .B1(n19), .Y(n22) );
  OAI2BB1X2M U28 ( .A0N(n16), .A1N(DATA_V[5]), .B0(n21), .Y(n32) );
  AOI22X1M U29 ( .A0(DATA_V[6]), .A1(n18), .B0(DATA[5]), .B1(n19), .Y(n21) );
  OAI2BB1X2M U30 ( .A0N(n16), .A1N(DATA_V[6]), .B0(n20), .Y(n31) );
  AOI22X1M U31 ( .A0(DATA_V[7]), .A1(n18), .B0(DATA[6]), .B1(n19), .Y(n20) );
  AO22X1M U32 ( .A0(n16), .A1(DATA_V[7]), .B0(DATA[7]), .B1(n19), .Y(n30) );
  OAI32X1M U33 ( .A0(n26), .A1(n13), .A2(n14), .B0(n27), .B1(n12), .Y(N25) );
  NAND2X2M U34 ( .A(Enable), .B(n12), .Y(n26) );
  AOI21X2M U35 ( .A0(Enable), .A1(n14), .B0(N23), .Y(n27) );
  NOR3X2M U36 ( .A(n12), .B(n13), .C(n14), .Y(ser_done) );
  NOR2X2M U37 ( .A(n15), .B(ser_count[0]), .Y(N23) );
  NOR2X2M U38 ( .A(n28), .B(n15), .Y(N24) );
  XNOR2X2M U39 ( .A(ser_count[0]), .B(ser_count[1]), .Y(n28) );
  INVX2M U40 ( .A(ser_count[1]), .Y(n14) );
  INVX2M U41 ( .A(ser_count[0]), .Y(n13) );
  INVXLM U42 ( .A(Busy), .Y(n40) );
  INVXLM U43 ( .A(n40), .Y(n41) );
endmodule


module Parity_Calc_test_1 ( clk, RST, PAR_EN, PAR_TYP, Busy, P_DATA, 
        Data_Valid, par_bit, test_si, test_se );
  input [7:0] P_DATA;
  input clk, RST, PAR_EN, PAR_TYP, Busy, Data_Valid, test_si, test_se;
  output par_bit;
  wire   n1, n2, n4, n5, n6, n7, n9, n11, n13, n15, n17, n19, n21, n23, n25,
         n3, n12, n14;
  wire   [7:0] DATA_V;

  SDFFRQX2M DATA_V_reg_5_ ( .D(n21), .SI(DATA_V[4]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[5]) );
  SDFFRQX2M DATA_V_reg_1_ ( .D(n13), .SI(DATA_V[0]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[1]) );
  SDFFRQX2M DATA_V_reg_4_ ( .D(n19), .SI(DATA_V[3]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[4]) );
  SDFFRQX2M DATA_V_reg_0_ ( .D(n11), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[0]) );
  SDFFRQX2M DATA_V_reg_2_ ( .D(n15), .SI(DATA_V[1]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[2]) );
  SDFFRQX2M DATA_V_reg_3_ ( .D(n17), .SI(DATA_V[2]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[3]) );
  SDFFRQX2M DATA_V_reg_6_ ( .D(n23), .SI(DATA_V[5]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[6]) );
  SDFFRQX2M DATA_V_reg_7_ ( .D(n25), .SI(DATA_V[6]), .SE(test_se), .CK(clk), 
        .RN(RST), .Q(DATA_V[7]) );
  SDFFRQX2M par_bit_reg ( .D(n9), .SI(DATA_V[7]), .SE(test_se), .CK(clk), .RN(
        RST), .Q(par_bit) );
  NOR2BX2M U2 ( .AN(Data_Valid), .B(n14), .Y(n1) );
  OAI2BB2X1M U3 ( .B0(n2), .B1(n3), .A0N(par_bit), .A1N(n3), .Y(n9) );
  INVX2M U4 ( .A(PAR_EN), .Y(n3) );
  XOR3XLM U5 ( .A(n4), .B(PAR_TYP), .C(n5), .Y(n2) );
  XOR3XLM U6 ( .A(DATA_V[1]), .B(DATA_V[0]), .C(n6), .Y(n5) );
  AO2B2X2M U7 ( .B0(P_DATA[0]), .B1(n1), .A0(DATA_V[0]), .A1N(n1), .Y(n11) );
  AO2B2X2M U8 ( .B0(P_DATA[1]), .B1(n1), .A0(DATA_V[1]), .A1N(n1), .Y(n13) );
  AO2B2X2M U9 ( .B0(P_DATA[2]), .B1(n1), .A0(DATA_V[2]), .A1N(n1), .Y(n15) );
  AO2B2X2M U10 ( .B0(P_DATA[3]), .B1(n1), .A0(DATA_V[3]), .A1N(n1), .Y(n17) );
  AO2B2X2M U11 ( .B0(P_DATA[4]), .B1(n1), .A0(DATA_V[4]), .A1N(n1), .Y(n19) );
  AO2B2X2M U12 ( .B0(P_DATA[5]), .B1(n1), .A0(DATA_V[5]), .A1N(n1), .Y(n21) );
  AO2B2X2M U13 ( .B0(P_DATA[6]), .B1(n1), .A0(DATA_V[6]), .A1N(n1), .Y(n23) );
  AO2B2X2M U14 ( .B0(P_DATA[7]), .B1(n1), .A0(DATA_V[7]), .A1N(n1), .Y(n25) );
  XNOR2X2M U15 ( .A(DATA_V[2]), .B(DATA_V[3]), .Y(n6) );
  XOR3XLM U16 ( .A(DATA_V[5]), .B(DATA_V[4]), .C(n7), .Y(n4) );
  CLKXOR2X2M U17 ( .A(DATA_V[7]), .B(DATA_V[6]), .Y(n7) );
  INVXLM U27 ( .A(Busy), .Y(n12) );
  INVXLM U28 ( .A(n12), .Y(n14) );
endmodule


module MUX ( mux_sel, ser_data, par_bit, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, par_bit;
  output TX_OUT;
  wire   n2, n3, n1;

  OAI21X4M U3 ( .A0(n2), .A1(n1), .B0(n3), .Y(TX_OUT) );
  NAND3X2M U4 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  NOR2BX2M U5 ( .AN(mux_sel[1]), .B(par_bit), .Y(n2) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(n1) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, clk, RST, SI, SE, 
        test_mode, scan_clk, scan_rst, SO, TX_OUT, Busy );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, clk, RST, SI, SE, test_mode, scan_clk,
         scan_rst;
  output SO, TX_OUT, Busy;
  wire   ser_done, RST_M, CLK_M, ser_en, ser_data, par_bit, n2, n3, n5, n6;
  wire   [1:0] mux_sel;

  FSM_test_1 u_fsm ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(
        ser_done), .RST(RST_M), .clk(CLK_M), .busy(SO), .ser_en(ser_en), 
        .mux_sel(mux_sel), .test_si2(n2), .test_si1(SI), .test_so1(n3), 
        .test_se(SE) );
  Serializer_test_1 u_serializer ( .CLK(CLK_M), .RST(RST_M), .DATA(P_DATA), 
        .Enable(ser_en), .Busy(n5), .Data_Valid(Data_Valid), .ser_out(ser_data), .ser_done(ser_done), .test_si(par_bit), .test_so(n2), .test_se(SE) );
  Parity_Calc_test_1 u_parity ( .clk(CLK_M), .RST(RST_M), .PAR_EN(PAR_EN), 
        .PAR_TYP(PAR_TYP), .Busy(n6), .P_DATA(P_DATA), .Data_Valid(Data_Valid), 
        .par_bit(par_bit), .test_si(n3), .test_se(SE) );
  MUX u_mux ( .mux_sel(mux_sel), .ser_data(ser_data), .par_bit(par_bit), 
        .TX_OUT(TX_OUT) );
  mux2X1_0 U00_mux2X1 ( .IN_0(clk), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        CLK_M) );
  mux2X1_1 U01_scan_rstmux2X1 ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), 
        .OUT(RST_M) );
  BUFX2M U1 ( .A(SO), .Y(Busy) );
  CLKBUFX6M U2 ( .A(SO), .Y(n6) );
  CLKBUFX6M U3 ( .A(SO), .Y(n5) );
endmodule

