/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Aug 13 04:53:26 2026
/////////////////////////////////////////////////////////////


module FSM ( Data_Valid, PAR_EN, ser_done, RST, clk, busy, ser_en, mux_sel );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, RST, clk;
  output busy, ser_en;
  wire   n10, busy_c, n3, n4, n5, n6, n7, n8, n9, n2;
  wire   [2:0] Current_State;
  wire   [2:0] Next_State;

  DFFRQX1M busy_reg ( .D(busy_c), .CK(clk), .RN(n2), .Q(n10) );
  DFFRX1M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(clk), .RN(n2), .Q(
        Current_State[1]), .QN(n3) );
  DFFRX1M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(clk), .RN(n2), .Q(
        Current_State[0]), .QN(n4) );
  DFFRX4M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(clk), .RN(n2), .Q(
        Current_State[2]) );
  NOR2X4M U3 ( .A(n3), .B(Current_State[2]), .Y(mux_sel[1]) );
  BUFX10M U4 ( .A(n10), .Y(busy) );
  NOR2X2M U5 ( .A(n4), .B(Current_State[2]), .Y(n9) );
  INVX2M U6 ( .A(n5), .Y(ser_en) );
  INVX2M U7 ( .A(n9), .Y(mux_sel[0]) );
  NAND2X2M U8 ( .A(mux_sel[1]), .B(n7), .Y(n5) );
  BUFX2M U9 ( .A(RST), .Y(n2) );
  NOR2BX2M U10 ( .AN(mux_sel[1]), .B(n6), .Y(Next_State[2]) );
  AOI2B1X1M U11 ( .A1N(PAR_EN), .A0(ser_done), .B0(n4), .Y(n6) );
  OAI22X1M U12 ( .A0(ser_done), .A1(mux_sel[0]), .B0(Current_State[1]), .B1(n8), .Y(Next_State[0]) );
  AOI2B1X1M U13 ( .A1N(Current_State[2]), .A0(Data_Valid), .B0(n9), .Y(n8) );
  XNOR2X4M U14 ( .A(Current_State[0]), .B(Current_State[1]), .Y(n7) );
  OAI21X2M U15 ( .A0(Current_State[2]), .A1(n7), .B0(n5), .Y(Next_State[1]) );
  OAI21X2M U16 ( .A0(Current_State[0]), .A1(n3), .B0(mux_sel[0]), .Y(busy_c)
         );
endmodule


module Serializer ( CLK, RST, DATA, Enable, Busy, Data_Valid, ser_out, 
        ser_done );
  input [7:0] DATA;
  input CLK, RST, Enable, Busy, Data_Valid;
  output ser_out, ser_done;
  wire   N23, N24, N25, N27, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28;
  wire   [7:1] DATA_V;
  wire   [2:0] ser_count;
  assign ser_done = N27;

  NOR2X12M U19 ( .A(n4), .B(n26), .Y(n7) );
  DFFRQX1M \DATA_V_reg[6]  ( .D(n20), .CK(CLK), .RN(n27), .Q(DATA_V[6]) );
  DFFRQX1M \DATA_V_reg[5]  ( .D(n21), .CK(CLK), .RN(n27), .Q(DATA_V[5]) );
  DFFRQX1M \DATA_V_reg[4]  ( .D(n22), .CK(CLK), .RN(n27), .Q(DATA_V[4]) );
  DFFRQX1M \DATA_V_reg[3]  ( .D(n23), .CK(CLK), .RN(n27), .Q(DATA_V[3]) );
  DFFRQX1M \DATA_V_reg[2]  ( .D(n24), .CK(CLK), .RN(n27), .Q(DATA_V[2]) );
  DFFRQX1M \DATA_V_reg[1]  ( .D(n25), .CK(CLK), .RN(n27), .Q(DATA_V[1]) );
  DFFRQX1M \DATA_V_reg[7]  ( .D(n19), .CK(CLK), .RN(n27), .Q(DATA_V[7]) );
  DFFRQX1M \ser_count_reg[1]  ( .D(N24), .CK(CLK), .RN(n27), .Q(ser_count[1])
         );
  DFFRQX1M \DATA_V_reg[0]  ( .D(n18), .CK(CLK), .RN(n27), .Q(ser_out) );
  DFFRX1M \ser_count_reg[0]  ( .D(N23), .CK(CLK), .RN(n27), .Q(ser_count[0]), 
        .QN(n3) );
  DFFRX4M \ser_count_reg[2]  ( .D(N25), .CK(CLK), .RN(n27), .QN(n1) );
  INVX2M U3 ( .A(Enable), .Y(n4) );
  NOR2X8M U4 ( .A(n26), .B(n7), .Y(n5) );
  INVX6M U5 ( .A(n28), .Y(n27) );
  INVX2M U6 ( .A(RST), .Y(n28) );
  CLKBUFX6M U7 ( .A(n8), .Y(n26) );
  NOR2BX1M U8 ( .AN(Data_Valid), .B(Busy), .Y(n8) );
  OAI2BB1X2M U9 ( .A0N(ser_out), .A1N(n5), .B0(n6), .Y(n18) );
  AOI22X1M U10 ( .A0(DATA_V[1]), .A1(n7), .B0(DATA[0]), .B1(n26), .Y(n6) );
  OAI2BB1X2M U11 ( .A0N(DATA_V[1]), .A1N(n5), .B0(n14), .Y(n25) );
  AOI22X1M U12 ( .A0(DATA_V[2]), .A1(n7), .B0(DATA[1]), .B1(n26), .Y(n14) );
  OAI2BB1X2M U13 ( .A0N(n5), .A1N(DATA_V[2]), .B0(n13), .Y(n24) );
  AOI22X1M U14 ( .A0(DATA_V[3]), .A1(n7), .B0(DATA[2]), .B1(n26), .Y(n13) );
  OAI2BB1X2M U15 ( .A0N(n5), .A1N(DATA_V[3]), .B0(n12), .Y(n23) );
  AOI22X1M U16 ( .A0(DATA_V[4]), .A1(n7), .B0(DATA[3]), .B1(n26), .Y(n12) );
  OAI2BB1X2M U17 ( .A0N(n5), .A1N(DATA_V[4]), .B0(n11), .Y(n22) );
  AOI22X1M U18 ( .A0(DATA_V[5]), .A1(n7), .B0(DATA[4]), .B1(n26), .Y(n11) );
  OAI2BB1X2M U20 ( .A0N(n5), .A1N(DATA_V[5]), .B0(n10), .Y(n21) );
  AOI22X1M U21 ( .A0(DATA_V[6]), .A1(n7), .B0(DATA[5]), .B1(n26), .Y(n10) );
  OAI2BB1X2M U22 ( .A0N(n5), .A1N(DATA_V[6]), .B0(n9), .Y(n20) );
  AOI22X1M U23 ( .A0(DATA_V[7]), .A1(n7), .B0(DATA[6]), .B1(n26), .Y(n9) );
  AO22X1M U24 ( .A0(n5), .A1(DATA_V[7]), .B0(DATA[7]), .B1(n26), .Y(n19) );
  OAI32X2M U25 ( .A0(n15), .A1(n3), .A2(n2), .B0(n16), .B1(n1), .Y(N25) );
  NAND2X2M U26 ( .A(Enable), .B(n1), .Y(n15) );
  AOI21X2M U27 ( .A0(Enable), .A1(n2), .B0(N23), .Y(n16) );
  NOR2X2M U28 ( .A(n4), .B(ser_count[0]), .Y(N23) );
  NOR3X4M U29 ( .A(n1), .B(n3), .C(n2), .Y(N27) );
  NOR2X2M U30 ( .A(n17), .B(n4), .Y(N24) );
  XNOR2X2M U31 ( .A(ser_count[0]), .B(ser_count[1]), .Y(n17) );
  INVX2M U32 ( .A(ser_count[1]), .Y(n2) );
endmodule


module Parity_Calc ( clk, RST, PAR_EN, PAR_TYP, Busy, P_DATA, Data_Valid, 
        par_bit );
  input [7:0] P_DATA;
  input clk, RST, PAR_EN, PAR_TYP, Busy, Data_Valid;
  output par_bit;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19;
  wire   [7:0] DATA_V;

  AO2B2X1M U2 ( .B0(P_DATA[3]), .B1(n17), .A0(DATA_V[3]), .A1N(n17), .Y(n12)
         );
  AO2B2X1M U3 ( .B0(P_DATA[4]), .B1(n17), .A0(DATA_V[4]), .A1N(n17), .Y(n13)
         );
  AO2B2X1M U4 ( .B0(P_DATA[5]), .B1(n17), .A0(DATA_V[5]), .A1N(n17), .Y(n14)
         );
  AO2B2X1M U5 ( .B0(P_DATA[6]), .B1(n17), .A0(DATA_V[6]), .A1N(n17), .Y(n15)
         );
  AO2B2X1M U6 ( .B0(P_DATA[7]), .B1(n17), .A0(DATA_V[7]), .A1N(n17), .Y(n16)
         );
  OAI2BB2X1M U7 ( .B0(n2), .B1(n3), .A0N(par_bit), .A1N(n3), .Y(n8) );
  CLKINVX1M U8 ( .A(PAR_EN), .Y(n3) );
  XOR3XLM U9 ( .A(n4), .B(PAR_TYP), .C(n5), .Y(n2) );
  XOR3XLM U10 ( .A(DATA_V[1]), .B(DATA_V[0]), .C(n6), .Y(n5) );
  XNOR2X1M U11 ( .A(DATA_V[2]), .B(DATA_V[3]), .Y(n6) );
  XOR3XLM U12 ( .A(DATA_V[5]), .B(DATA_V[4]), .C(n7), .Y(n4) );
  CLKXOR2X2M U13 ( .A(DATA_V[7]), .B(DATA_V[6]), .Y(n7) );
  AO2B2X1M U14 ( .B0(P_DATA[0]), .B1(n17), .A0(DATA_V[0]), .A1N(n17), .Y(n9)
         );
  AO2B2X1M U15 ( .B0(P_DATA[1]), .B1(n17), .A0(DATA_V[1]), .A1N(n17), .Y(n10)
         );
  AO2B2X1M U16 ( .B0(P_DATA[2]), .B1(n17), .A0(DATA_V[2]), .A1N(n17), .Y(n11)
         );
  DFFRQX1M \DATA_V_reg[5]  ( .D(n14), .CK(clk), .RN(n18), .Q(DATA_V[5]) );
  DFFRQX1M \DATA_V_reg[1]  ( .D(n10), .CK(clk), .RN(n18), .Q(DATA_V[1]) );
  DFFRQX1M \DATA_V_reg[4]  ( .D(n13), .CK(clk), .RN(n18), .Q(DATA_V[4]) );
  DFFRQX1M \DATA_V_reg[0]  ( .D(n9), .CK(clk), .RN(n18), .Q(DATA_V[0]) );
  DFFRQX1M \DATA_V_reg[2]  ( .D(n11), .CK(clk), .RN(n18), .Q(DATA_V[2]) );
  DFFRQX1M \DATA_V_reg[3]  ( .D(n12), .CK(clk), .RN(n18), .Q(DATA_V[3]) );
  DFFRQX1M \DATA_V_reg[6]  ( .D(n15), .CK(clk), .RN(n18), .Q(DATA_V[6]) );
  DFFRQX1M \DATA_V_reg[7]  ( .D(n16), .CK(clk), .RN(n18), .Q(DATA_V[7]) );
  DFFRQX1M par_bit_reg ( .D(n8), .CK(clk), .RN(n18), .Q(par_bit) );
  INVX6M U17 ( .A(n19), .Y(n18) );
  INVX2M U18 ( .A(RST), .Y(n19) );
  CLKBUFX8M U19 ( .A(n1), .Y(n17) );
  NOR2BX1M U20 ( .AN(Data_Valid), .B(Busy), .Y(n1) );
endmodule


module MUX ( mux_sel, ser_data, par_bit, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, par_bit;
  output TX_OUT;
  wire   n5, n1, n2, n3;

  NOR2BX2M U3 ( .AN(mux_sel[1]), .B(par_bit), .Y(n2) );
  NAND3X2M U4 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  CLKBUFX8M U5 ( .A(n5), .Y(TX_OUT) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(n1) );
  OAI21X2M U7 ( .A0(n2), .A1(n1), .B0(n3), .Y(n5) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, clk, RST, TX_OUT, Busy
 );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, clk, RST;
  output TX_OUT, Busy;
  wire   ser_done, ser_en, ser_data, par_bit;
  wire   [1:0] mux_sel;

  FSM u_fsm ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(ser_done), 
        .RST(RST), .clk(clk), .busy(Busy), .ser_en(ser_en), .mux_sel(mux_sel)
         );
  Serializer u_serializer ( .CLK(clk), .RST(RST), .DATA(P_DATA), .Enable(
        ser_en), .Busy(Busy), .Data_Valid(Data_Valid), .ser_out(ser_data), 
        .ser_done(ser_done) );
  Parity_Calc u_parity ( .clk(clk), .RST(RST), .PAR_EN(PAR_EN), .PAR_TYP(
        PAR_TYP), .Busy(Busy), .P_DATA(P_DATA), .Data_Valid(Data_Valid), 
        .par_bit(par_bit) );
  MUX u_mux ( .mux_sel(mux_sel), .ser_data(ser_data), .par_bit(par_bit), 
        .TX_OUT(TX_OUT) );
endmodule

