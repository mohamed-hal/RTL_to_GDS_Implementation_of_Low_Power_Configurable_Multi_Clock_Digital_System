/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Mon Oct  5 16:43:14 2026
/////////////////////////////////////////////////////////////


module RST_SYNC_NUM_STAGES2_0 ( CLK, RST, SYNC_RST );
  input CLK, RST;
  output SYNC_RST;
  wire   \STAGES_REG[0] ;

  DFFRQX2M \STAGES_REG_reg[1]  ( .D(\STAGES_REG[0] ), .CK(CLK), .RN(RST), .Q(
        SYNC_RST) );
  DFFRQX2M \STAGES_REG_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(
        \STAGES_REG[0] ) );
endmodule


module RST_SYNC_NUM_STAGES2_1 ( CLK, RST, SYNC_RST );
  input CLK, RST;
  output SYNC_RST;
  wire   \STAGES_REG[0] ;

  DFFRQX2M \STAGES_REG_reg[1]  ( .D(\STAGES_REG[0] ), .CK(CLK), .RN(RST), .Q(
        SYNC_RST) );
  DFFRQX2M \STAGES_REG_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(
        \STAGES_REG[0] ) );
endmodule


module ClkDiv_WIDTH4 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk );
  input [3:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en;
  output o_div_clk;
  wire   n83, n41, n82, n40, n39, n81, outB, n79, outA, outA_r, n87, even_clk,
         n88, n24, n86, n84, n80, n90, n89, n85, even_r, N13, n28, n3, n4, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n25, n26, n27, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n91, n92, n93, n1,
         n2, n5;
  wire   [3:0] cnt_even;
  wire   [3:0] cnt_odd_pos;

  DFFNSRHX2M \cnt_odd_neg_reg[0]  ( .D(n83), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(n5), .QN(n41) );
  DFFNSRHX2M \cnt_odd_neg_reg[1]  ( .D(n82), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(n1), .QN(n40) );
  DFFNSRHX2M \cnt_odd_neg_reg[2]  ( .D(n3), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(n2), .QN(n39) );
  DFFNSRHX2M outB_r_reg ( .D(outB), .CKN(i_ref_clk), .SN(1'b1), .RN(i_rst_n), 
        .QN(n79) );
  MX3X1M U34 ( .A(even_r), .B(n28), .C(i_ref_clk), .S0(i_div_ratio[0]), .S1(
        N13), .Y(o_div_clk) );
  DFFRQX2M outA_r_reg ( .D(outA), .CK(i_ref_clk), .RN(i_rst_n), .Q(outA_r) );
  DFFRQX2M even_clk_reg ( .D(n87), .CK(i_ref_clk), .RN(i_rst_n), .Q(even_clk)
         );
  DFFRQX2M \cnt_odd_pos_reg[0]  ( .D(n86), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[0]) );
  DFFRQX2M \cnt_odd_pos_reg[3]  ( .D(n84), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[3]) );
  DFFRQX2M \cnt_odd_pos_reg[2]  ( .D(n11), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[2]) );
  DFFRQX2M \cnt_even_reg[2]  ( .D(n80), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[2]) );
  DFFRQX2M \cnt_even_reg[0]  ( .D(n90), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[0]) );
  DFFRQX2M \cnt_even_reg[1]  ( .D(n89), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[1]) );
  DFFRQX2M \cnt_odd_pos_reg[1]  ( .D(n85), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[1]) );
  DFFRX1M \cnt_even_reg[3]  ( .D(n88), .CK(i_ref_clk), .RN(i_rst_n), .QN(n24)
         );
  DFFRQX2M even_r_reg ( .D(even_clk), .CK(i_ref_clk), .RN(i_rst_n), .Q(even_r)
         );
  DFFNSRHX2M \cnt_odd_neg_reg[3]  ( .D(n81), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(n93), .QN(n7) );
  INVX2M U3 ( .A(N13), .Y(n22) );
  NOR2X2M U4 ( .A(n26), .B(n45), .Y(n44) );
  NOR2X2M U5 ( .A(n91), .B(i_div_ratio[3]), .Y(N13) );
  NAND2X2M U6 ( .A(i_div_ratio[3]), .B(n44), .Y(n27) );
  NAND2X2M U7 ( .A(i_div_ratio[3]), .B(n91), .Y(n92) );
  CLKXOR2X2M U8 ( .A(n26), .B(n25), .Y(n35) );
  NAND2X2M U9 ( .A(n91), .B(n45), .Y(n78) );
  OR2X2M U10 ( .A(n44), .B(i_div_ratio[3]), .Y(n30) );
  INVX2M U11 ( .A(n33), .Y(n23) );
  OAI21X2M U12 ( .A0(n4), .A1(n1), .B0(n68), .Y(n48) );
  INVX2M U13 ( .A(n71), .Y(n4) );
  AOI21X2M U14 ( .A0(n16), .A1(n59), .B0(n52), .Y(n53) );
  AOI21X2M U15 ( .A0(n13), .A1(n64), .B0(n60), .Y(n61) );
  OAI211X2M U16 ( .A0(n23), .A1(n19), .B0(n13), .C0(n35), .Y(n42) );
  OAI2BB2X1M U17 ( .B0(n61), .B1(n19), .A0N(n19), .A1N(n50), .Y(n85) );
  INVX2M U18 ( .A(n59), .Y(n10) );
  INVX2M U19 ( .A(n64), .Y(n12) );
  NOR2X2M U20 ( .A(n13), .B(n60), .Y(n50) );
  NAND2X2M U21 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n45) );
  INVX2M U22 ( .A(i_div_ratio[1]), .Y(n25) );
  NAND2BX2M U23 ( .AN(i_div_ratio[2]), .B(n25), .Y(n91) );
  INVX2M U24 ( .A(i_div_ratio[0]), .Y(n26) );
  CLKXOR2X2M U25 ( .A(n43), .B(i_div_ratio[2]), .Y(n33) );
  NAND2X2M U26 ( .A(i_div_ratio[0]), .B(i_div_ratio[1]), .Y(n43) );
  INVX2M U27 ( .A(n60), .Y(n20) );
  INVX2M U28 ( .A(n52), .Y(n21) );
  INVX2M U29 ( .A(n46), .Y(n3) );
  AOI32X1M U30 ( .A0(n39), .A1(n1), .A2(n47), .B0(n2), .B1(n48), .Y(n46) );
  OAI32X1M U31 ( .A0(n60), .A1(n4), .A2(n5), .B0(n41), .B1(n20), .Y(n83) );
  NAND4X2M U32 ( .A(n72), .B(n73), .C(n74), .D(n41), .Y(n71) );
  CLKXOR2X2M U33 ( .A(n7), .B(i_div_ratio[3]), .Y(n74) );
  CLKXOR2X2M U35 ( .A(n39), .B(i_div_ratio[2]), .Y(n72) );
  CLKXOR2X2M U36 ( .A(n35), .B(n1), .Y(n73) );
  OAI211X2M U37 ( .A0(n40), .A1(n23), .B0(n35), .C0(n41), .Y(n34) );
  AOI21XLM U38 ( .A0(n71), .A1(n41), .B0(n60), .Y(n68) );
  NOR2XLM U39 ( .A(n60), .B(n41), .Y(n47) );
  OAI2BB2X1M U40 ( .B0(n40), .B1(n68), .A0N(n40), .A1N(n47), .Y(n82) );
  OAI21X2M U41 ( .A0(n69), .A1(n7), .B0(n70), .Y(n81) );
  NAND4X2M U42 ( .A(n47), .B(n2), .C(n1), .D(n7), .Y(n70) );
  AOI21X2M U43 ( .A0(n39), .A1(n71), .B0(n48), .Y(n69) );
  OAI21X2M U44 ( .A0(n93), .A1(n27), .B0(n29), .Y(outB) );
  OAI211X2M U45 ( .A0(n30), .A1(n31), .B0(n32), .C0(n7), .Y(n29) );
  AO21XLM U46 ( .A0(n31), .A1(n30), .B0(n39), .Y(n32) );
  OAI21X2M U47 ( .A0(n33), .A1(n1), .B0(n34), .Y(n31) );
  OAI32X1M U48 ( .A0(n52), .A1(cnt_even[0]), .A2(n10), .B0(n21), .B1(n16), .Y(
        n90) );
  OAI32X1M U49 ( .A0(n54), .A1(cnt_even[2]), .A2(n18), .B0(n9), .B1(n15), .Y(
        n80) );
  INVX2M U50 ( .A(n57), .Y(n9) );
  OAI32X1M U51 ( .A0(n60), .A1(cnt_odd_pos[0]), .A2(n12), .B0(n20), .B1(n13), 
        .Y(n86) );
  OAI21X2M U52 ( .A0(cnt_even[1]), .A1(n10), .B0(n53), .Y(n57) );
  NAND4X2M U53 ( .A(n24), .B(n75), .C(n76), .D(n77), .Y(n59) );
  CLKXOR2X2M U54 ( .A(i_div_ratio[1]), .B(cnt_even[0]), .Y(n75) );
  CLKXOR2X2M U55 ( .A(n92), .B(cnt_even[2]), .Y(n76) );
  CLKXOR2X2M U56 ( .A(n18), .B(n78), .Y(n77) );
  OAI21X2M U57 ( .A0(cnt_odd_pos[3]), .A1(n27), .B0(n36), .Y(outA) );
  OAI211X2M U58 ( .A0(n30), .A1(n37), .B0(n38), .C0(n14), .Y(n36) );
  AO21XLM U59 ( .A0(n37), .A1(n30), .B0(n17), .Y(n38) );
  OAI21X2M U60 ( .A0(cnt_odd_pos[1]), .A1(n33), .B0(n42), .Y(n37) );
  OAI21X2M U61 ( .A0(cnt_odd_pos[1]), .A1(n12), .B0(n61), .Y(n51) );
  OAI22X1M U62 ( .A0(n53), .A1(n18), .B0(cnt_even[1]), .B1(n54), .Y(n89) );
  NAND4X2M U63 ( .A(n65), .B(n66), .C(n67), .D(n13), .Y(n64) );
  CLKXOR2X2M U64 ( .A(cnt_odd_pos[1]), .B(n35), .Y(n66) );
  CLKXOR2X2M U65 ( .A(n14), .B(i_div_ratio[3]), .Y(n67) );
  CLKXOR2X2M U66 ( .A(i_div_ratio[2]), .B(n17), .Y(n65) );
  NAND3X2M U67 ( .A(cnt_even[0]), .B(n59), .C(n21), .Y(n54) );
  OAI21X2M U68 ( .A0(n24), .A1(n55), .B0(n56), .Y(n88) );
  NAND4X2M U69 ( .A(n8), .B(n24), .C(cnt_even[2]), .D(cnt_even[1]), .Y(n56) );
  NOR2X2M U70 ( .A(n15), .B(n57), .Y(n55) );
  INVX2M U71 ( .A(n54), .Y(n8) );
  OAI21X2M U72 ( .A0(n62), .A1(n14), .B0(n63), .Y(n84) );
  NAND4X2M U73 ( .A(n50), .B(cnt_odd_pos[2]), .C(cnt_odd_pos[1]), .D(n14), .Y(
        n63) );
  AOI21X2M U74 ( .A0(n64), .A1(n17), .B0(n51), .Y(n62) );
  INVX2M U75 ( .A(cnt_odd_pos[0]), .Y(n13) );
  INVX2M U76 ( .A(cnt_odd_pos[3]), .Y(n14) );
  INVX2M U77 ( .A(cnt_odd_pos[1]), .Y(n19) );
  INVX2M U78 ( .A(cnt_even[1]), .Y(n18) );
  INVX2M U79 ( .A(cnt_odd_pos[2]), .Y(n17) );
  INVX2M U80 ( .A(n49), .Y(n11) );
  AOI32X1M U81 ( .A0(n50), .A1(n17), .A2(cnt_odd_pos[1]), .B0(n51), .B1(
        cnt_odd_pos[2]), .Y(n49) );
  INVX2M U82 ( .A(cnt_even[0]), .Y(n16) );
  CLKXOR2X2M U83 ( .A(even_clk), .B(n58), .Y(n87) );
  NOR2X2M U84 ( .A(n52), .B(n59), .Y(n58) );
  INVX2M U85 ( .A(cnt_even[2]), .Y(n15) );
  NAND3X2M U86 ( .A(i_div_ratio[0]), .B(n22), .C(i_clk_en), .Y(n60) );
  NAND3X2M U87 ( .A(n22), .B(n26), .C(i_clk_en), .Y(n52) );
  NOR2BX2M U88 ( .AN(outA_r), .B(n79), .Y(n28) );
endmodule


module Prescale_MUX_DIV_RATIO_WIDTH4 ( Prescale, DIV_RATIO );
  input [5:0] Prescale;
  output [3:0] DIV_RATIO;
  wire   n1, n2, n3, n4, n5, n6;

  NOR3BX2M U1 ( .AN(Prescale[4]), .B(Prescale[3]), .C(n4), .Y(DIV_RATIO[1]) );
  NOR3BX2M U2 ( .AN(Prescale[3]), .B(Prescale[4]), .C(n4), .Y(DIV_RATIO[2]) );
  AND3X2M U3 ( .A(n3), .B(n1), .C(n2), .Y(DIV_RATIO[3]) );
  OAI211X2M U4 ( .A0(n5), .A1(n3), .B0(n2), .C0(n1), .Y(DIV_RATIO[0]) );
  NOR3X2M U5 ( .A(n6), .B(Prescale[5]), .C(Prescale[2]), .Y(n5) );
  XNOR2X2M U6 ( .A(Prescale[3]), .B(Prescale[4]), .Y(n6) );
  NOR4BX1M U7 ( .AN(Prescale[2]), .B(Prescale[3]), .C(Prescale[4]), .D(
        Prescale[5]), .Y(n3) );
  INVX2M U8 ( .A(Prescale[1]), .Y(n1) );
  INVX2M U9 ( .A(Prescale[0]), .Y(n2) );
  OR4X1M U10 ( .A(Prescale[5]), .B(Prescale[0]), .C(Prescale[1]), .D(
        Prescale[2]), .Y(n4) );
endmodule


module ClkDiv_WIDTH8_DW01_inc_0 ( A, SUM );
  input [8:0] A;
  output [8:0] SUM;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CLKXOR2X2M U1 ( .A(n1), .B(n5), .Y(SUM[3]) );
  NOR3BX2M U2 ( .AN(A[4]), .B(n1), .C(n5), .Y(n3) );
  XNOR2X2M U3 ( .A(A[6]), .B(n4), .Y(SUM[6]) );
  NAND2X2M U4 ( .A(A[5]), .B(n3), .Y(n4) );
  XNOR2X2M U5 ( .A(A[7]), .B(n2), .Y(SUM[7]) );
  XNOR2X2M U6 ( .A(A[2]), .B(n7), .Y(SUM[2]) );
  NAND2X2M U7 ( .A(A[1]), .B(A[0]), .Y(n7) );
  NAND3X2M U8 ( .A(A[5]), .B(n3), .C(A[6]), .Y(n2) );
  NAND3X2M U9 ( .A(A[1]), .B(A[0]), .C(A[2]), .Y(n5) );
  NOR2BX2M U10 ( .AN(A[7]), .B(n2), .Y(SUM[8]) );
  INVX2M U11 ( .A(A[3]), .Y(n1) );
  CLKXOR2X2M U12 ( .A(A[5]), .B(n3), .Y(SUM[5]) );
  CLKXOR2X2M U13 ( .A(A[1]), .B(A[0]), .Y(SUM[1]) );
  CLKXOR2X2M U14 ( .A(A[4]), .B(n6), .Y(SUM[4]) );
  NOR2X2M U15 ( .A(n5), .B(n1), .Y(n6) );
endmodule


module ClkDiv_WIDTH8_DW01_inc_1 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n2, n3, n4, n5, n6, n7, n8;

  NOR3BX2M U1 ( .AN(A[4]), .B(n2), .C(n6), .Y(n5) );
  CLKXOR2X2M U2 ( .A(A[5]), .B(n5), .Y(SUM[5]) );
  XNOR2X2M U3 ( .A(A[2]), .B(n8), .Y(SUM[2]) );
  NAND2X2M U4 ( .A(A[1]), .B(A[0]), .Y(n8) );
  CLKXOR2X2M U5 ( .A(A[4]), .B(n7), .Y(SUM[4]) );
  NOR2X2M U6 ( .A(n6), .B(n2), .Y(n7) );
  CLKXOR2X2M U7 ( .A(n2), .B(n6), .Y(SUM[3]) );
  INVX2M U8 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U9 ( .A(A[1]), .B(A[0]), .Y(SUM[1]) );
  NAND3X2M U10 ( .A(A[1]), .B(A[0]), .C(A[2]), .Y(n6) );
  XNOR2X2M U11 ( .A(A[6]), .B(n4), .Y(SUM[6]) );
  CLKXOR2X2M U12 ( .A(A[7]), .B(n3), .Y(SUM[7]) );
  NOR2BX2M U13 ( .AN(A[6]), .B(n4), .Y(n3) );
  NAND2X2M U14 ( .A(A[5]), .B(n5), .Y(n4) );
  INVX2M U15 ( .A(A[3]), .Y(n2) );
endmodule


module ClkDiv_WIDTH8_DW01_inc_2 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n2, n3, n4, n5, n6, n7, n8;

  CLKXOR2X2M U1 ( .A(n2), .B(n6), .Y(SUM[3]) );
  NOR3BX2M U2 ( .AN(A[4]), .B(n2), .C(n6), .Y(n5) );
  NAND2X2M U3 ( .A(A[5]), .B(n5), .Y(n4) );
  NAND3X2M U4 ( .A(A[1]), .B(A[0]), .C(A[2]), .Y(n6) );
  CLKXOR2X2M U5 ( .A(A[1]), .B(A[0]), .Y(SUM[1]) );
  XNOR2X2M U6 ( .A(A[2]), .B(n8), .Y(SUM[2]) );
  NAND2X2M U7 ( .A(A[1]), .B(A[0]), .Y(n8) );
  CLKXOR2X2M U8 ( .A(A[4]), .B(n7), .Y(SUM[4]) );
  NOR2X2M U9 ( .A(n6), .B(n2), .Y(n7) );
  CLKXOR2X2M U10 ( .A(A[5]), .B(n5), .Y(SUM[5]) );
  XNOR2X2M U11 ( .A(A[6]), .B(n4), .Y(SUM[6]) );
  INVX2M U12 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U13 ( .A(A[7]), .B(n3), .Y(SUM[7]) );
  NOR2BX2M U14 ( .AN(A[6]), .B(n4), .Y(n3) );
  INVX2M U15 ( .A(A[3]), .Y(n2) );
endmodule


module ClkDiv_WIDTH8_DW01_inc_3 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n2, n3, n4, n5, n6, n7, n8;

  NOR3BX2M U1 ( .AN(A[4]), .B(n2), .C(n6), .Y(n5) );
  NAND2X2M U2 ( .A(A[5]), .B(n5), .Y(n4) );
  NAND3X2M U3 ( .A(A[1]), .B(A[0]), .C(A[2]), .Y(n6) );
  CLKXOR2X2M U4 ( .A(A[7]), .B(n3), .Y(SUM[7]) );
  NOR2BX2M U5 ( .AN(A[6]), .B(n4), .Y(n3) );
  XNOR2X2M U6 ( .A(A[6]), .B(n4), .Y(SUM[6]) );
  INVX2M U7 ( .A(A[3]), .Y(n2) );
  CLKXOR2X2M U8 ( .A(A[5]), .B(n5), .Y(SUM[5]) );
  CLKXOR2X2M U9 ( .A(A[1]), .B(A[0]), .Y(SUM[1]) );
  CLKXOR2X2M U10 ( .A(n2), .B(n6), .Y(SUM[3]) );
  CLKXOR2X2M U11 ( .A(A[4]), .B(n7), .Y(SUM[4]) );
  NOR2X2M U12 ( .A(n6), .B(n2), .Y(n7) );
  XNOR2X2M U13 ( .A(A[2]), .B(n8), .Y(SUM[2]) );
  NAND2X2M U14 ( .A(A[1]), .B(A[0]), .Y(n8) );
  INVX2M U15 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module ClkDiv_WIDTH8 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en;
  output o_div_clk;
  wire   n47, n128, n40, n122, n41, n129, n42, n123, n43, n125, n44, n124, n45,
         n126, n46, n127, outB, n121, N88, N87, N86, N85, N84, N83, N82, N81,
         N58, N57, N56, N55, N54, N53, N52, N51, N28, N27, N26, N25, N24, N23,
         N22, N21, outA, outA_r, n56, even_clk, n48, n57, n55, n64, n49, n50,
         n52, n51, n53, n62, n58, n59, n60, n61, n54, n63, even_r, n89, n90,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n1;
  wire   [7:0] cnt_odd_neg;
  wire   [7:0] half_ceil;
  wire   [7:0] cnt_odd_pos;
  wire   [7:0] cnt_even;
  wire   SYNOPSYS_UNCONNECTED__0;

  DFFNSRHX2M \cnt_odd_neg_reg[0]  ( .D(n47), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[0]), .QN(n128) );
  DFFNSRHX2M \cnt_odd_neg_reg[7]  ( .D(n40), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[7]), .QN(n122) );
  DFFNSRHX2M \cnt_odd_neg_reg[6]  ( .D(n41), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[6]), .QN(n129) );
  DFFNSRHX2M \cnt_odd_neg_reg[5]  ( .D(n42), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[5]), .QN(n123) );
  DFFNSRHX2M \cnt_odd_neg_reg[4]  ( .D(n43), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[4]), .QN(n125) );
  DFFNSRHX2M \cnt_odd_neg_reg[3]  ( .D(n44), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[3]), .QN(n124) );
  DFFNSRHX2M \cnt_odd_neg_reg[2]  ( .D(n45), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[2]), .QN(n126) );
  DFFNSRHX2M \cnt_odd_neg_reg[1]  ( .D(n46), .CKN(i_ref_clk), .SN(1'b1), .RN(
        i_rst_n), .Q(cnt_odd_neg[1]), .QN(n127) );
  DFFNSRHX2M outB_r_reg ( .D(outB), .CKN(i_ref_clk), .SN(1'b1), .RN(i_rst_n), 
        .QN(n121) );
  ClkDiv_WIDTH8_DW01_inc_0 add_91 ( .A({1'b0, i_div_ratio}), .SUM({half_ceil, 
        SYNOPSYS_UNCONNECTED__0}) );
  ClkDiv_WIDTH8_DW01_inc_1 add_56 ( .A(cnt_odd_neg), .SUM({N88, N87, N86, N85, 
        N84, N83, N82, N81}) );
  ClkDiv_WIDTH8_DW01_inc_2 add_45 ( .A(cnt_odd_pos), .SUM({N58, N57, N56, N55, 
        N54, N53, N52, N51}) );
  ClkDiv_WIDTH8_DW01_inc_3 add_33 ( .A(cnt_even), .SUM({N28, N27, N26, N25, 
        N24, N23, N22, N21}) );
  MX3X1M U79 ( .A(even_r), .B(n89), .C(i_ref_clk), .S0(i_div_ratio[0]), .S1(
        n90), .Y(o_div_clk) );
  DFFRQX2M outA_r_reg ( .D(outA), .CK(i_ref_clk), .RN(i_rst_n), .Q(outA_r) );
  DFFRQX2M even_clk_reg ( .D(n56), .CK(i_ref_clk), .RN(i_rst_n), .Q(even_clk)
         );
  DFFRQX2M \cnt_even_reg[3]  ( .D(n61), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[3]) );
  DFFRQX2M \cnt_odd_pos_reg[7]  ( .D(n48), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[7]) );
  DFFRQX2M \cnt_odd_pos_reg[6]  ( .D(n49), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[6]) );
  DFFRQX2M \cnt_even_reg[6]  ( .D(n58), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[6]) );
  DFFRQX2M \cnt_even_reg[4]  ( .D(n60), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[4]) );
  DFFRQX2M \cnt_odd_pos_reg[3]  ( .D(n52), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[3]) );
  DFFRQX2M \cnt_odd_pos_reg[4]  ( .D(n51), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[4]) );
  DFFRQX2M \cnt_even_reg[5]  ( .D(n59), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[5]) );
  DFFRQX2M \cnt_even_reg[2]  ( .D(n62), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[2]) );
  DFFRQX2M \cnt_odd_pos_reg[2]  ( .D(n53), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[2]) );
  DFFRQX2M \cnt_even_reg[7]  ( .D(n57), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[7]) );
  DFFRQX2M \cnt_odd_pos_reg[5]  ( .D(n50), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[5]) );
  DFFRQX2M \cnt_even_reg[1]  ( .D(n63), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[1]) );
  DFFRQX2M \cnt_odd_pos_reg[1]  ( .D(n54), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[1]) );
  DFFRQX2M \cnt_odd_pos_reg[0]  ( .D(n55), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_odd_pos[0]) );
  DFFRQX2M \cnt_even_reg[0]  ( .D(n64), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        cnt_even[0]) );
  DFFRQX2M even_r_reg ( .D(even_clk), .CK(i_ref_clk), .RN(i_rst_n), .Q(even_r)
         );
  INVX2M U3 ( .A(half_ceil[2]), .Y(n4) );
  OAI2BB1X2M U4 ( .A0N(n7), .A1N(half_ceil[7]), .B0(n28), .Y(outA) );
  OAI221X1M U5 ( .A0(half_ceil[6]), .A1(n9), .B0(half_ceil[7]), .B1(n7), .C0(
        n29), .Y(n28) );
  OAI2BB2X1M U6 ( .B0(n30), .B1(n31), .A0N(n9), .A1N(half_ceil[6]), .Y(n29) );
  NOR2X2M U7 ( .A(half_ceil[5]), .B(n10), .Y(n31) );
  NOR2BX2M U8 ( .AN(n39), .B(n1), .Y(n38) );
  AOI31X2M U9 ( .A0(n8), .A1(n14), .A2(half_ceil[0]), .B0(half_ceil[1]), .Y(
        n36) );
  OAI2BB2X1M U10 ( .B0(n15), .B1(n11), .A0N(N54), .A1N(n84), .Y(n52) );
  AOI21X2M U11 ( .A0(half_ceil[0]), .A1(n8), .B0(n14), .Y(n35) );
  INVX2M U12 ( .A(n87), .Y(n15) );
  OAI21X2M U13 ( .A0(n74), .A1(n17), .B0(n76), .Y(n75) );
  NAND2X2M U14 ( .A(n80), .B(n16), .Y(n81) );
  NAND2X2M U15 ( .A(n74), .B(n17), .Y(n76) );
  INVX2M U16 ( .A(half_ceil[4]), .Y(n6) );
  INVX2M U17 ( .A(half_ceil[3]), .Y(n5) );
  AOI221XLM U18 ( .A0(n123), .A1(half_ceil[5]), .B0(n125), .B1(half_ceil[4]), 
        .C0(n23), .Y(n21) );
  AOI221XLM U19 ( .A0(cnt_odd_neg[4]), .A1(n6), .B0(cnt_odd_neg[3]), .B1(n5), 
        .C0(n24), .Y(n23) );
  AOI221XLM U20 ( .A0(n124), .A1(half_ceil[3]), .B0(n126), .B1(half_ceil[2]), 
        .C0(n25), .Y(n24) );
  AOI211X2M U21 ( .A0(cnt_odd_neg[2]), .A1(n4), .B0(n26), .C0(n27), .Y(n25) );
  AOI21X2M U22 ( .A0(n128), .A1(half_ceil[0]), .B0(n127), .Y(n27) );
  AOI31X2M U23 ( .A0(n127), .A1(half_ceil[0]), .A2(n128), .B0(half_ceil[1]), 
        .Y(n26) );
  OAI2BB2X1M U24 ( .B0(n123), .B1(n15), .A0N(N86), .A1N(n97), .Y(n42) );
  OAI2BB2X1M U25 ( .B0(n126), .B1(n15), .A0N(N83), .A1N(n97), .Y(n45) );
  OAI2BB2X1M U26 ( .B0(n125), .B1(n15), .A0N(N85), .A1N(n97), .Y(n43) );
  OAI2BB2X1M U27 ( .B0(n124), .B1(n15), .A0N(N84), .A1N(n97), .Y(n44) );
  OAI2BB2X1M U28 ( .B0(n128), .B1(n15), .A0N(N81), .A1N(n97), .Y(n47) );
  OAI2BB2X1M U29 ( .B0(n127), .B1(n15), .A0N(N82), .A1N(n97), .Y(n46) );
  AOI2BB1X2M U30 ( .A0N(n98), .A1N(n99), .B0(n87), .Y(n97) );
  NAND4X2M U31 ( .A(n100), .B(n101), .C(n102), .D(n103), .Y(n99) );
  NAND4X2M U32 ( .A(n104), .B(n105), .C(n106), .D(n128), .Y(n98) );
  CLKXOR2X2M U33 ( .A(n129), .B(i_div_ratio[6]), .Y(n103) );
  OAI2BB2X1M U34 ( .B0(n129), .B1(n15), .A0N(N87), .A1N(n97), .Y(n41) );
  OAI2BB2X1M U35 ( .B0(n122), .B1(n15), .A0N(N88), .A1N(n97), .Y(n40) );
  CLKXOR2X2M U36 ( .A(n125), .B(i_div_ratio[4]), .Y(n101) );
  CLKXOR2X2M U37 ( .A(n123), .B(i_div_ratio[5]), .Y(n102) );
  CLKXOR2X2M U38 ( .A(n124), .B(i_div_ratio[3]), .Y(n105) );
  CLKXOR2X2M U39 ( .A(n126), .B(i_div_ratio[2]), .Y(n106) );
  CLKXOR2X2M U40 ( .A(n127), .B(i_div_ratio[1]), .Y(n100) );
  OAI2BB1X2M U41 ( .A0N(half_ceil[7]), .A1N(n122), .B0(n19), .Y(outB) );
  OAI221X1M U42 ( .A0(n129), .A1(half_ceil[6]), .B0(n122), .B1(half_ceil[7]), 
        .C0(n20), .Y(n19) );
  OAI2BB2X1M U43 ( .B0(n21), .B1(n22), .A0N(half_ceil[6]), .A1N(n129), .Y(n20)
         );
  NOR2X2M U44 ( .A(half_ceil[5]), .B(n123), .Y(n22) );
  AO22X1M U45 ( .A0(n1), .A1(cnt_even[7]), .B0(N28), .B1(n38), .Y(n57) );
  AOI2BB1X2M U46 ( .A0N(n85), .A1N(n86), .B0(n87), .Y(n84) );
  NAND4X2M U47 ( .A(n94), .B(n95), .C(n96), .D(n8), .Y(n85) );
  NAND4X2M U48 ( .A(n88), .B(n91), .C(n92), .D(n93), .Y(n86) );
  CLKXOR2X2M U49 ( .A(n7), .B(i_div_ratio[7]), .Y(n94) );
  AOI221XLM U50 ( .A0(half_ceil[5]), .A1(n10), .B0(half_ceil[4]), .B1(n12), 
        .C0(n32), .Y(n30) );
  AOI221XLM U51 ( .A0(cnt_odd_pos[3]), .A1(n5), .B0(cnt_odd_pos[4]), .B1(n6), 
        .C0(n33), .Y(n32) );
  AOI221XLM U52 ( .A0(half_ceil[2]), .A1(n13), .B0(half_ceil[3]), .B1(n11), 
        .C0(n34), .Y(n33) );
  AOI211X2M U53 ( .A0(cnt_odd_pos[2]), .A1(n4), .B0(n35), .C0(n36), .Y(n34) );
  XNOR2X2M U54 ( .A(cnt_even[3]), .B(n82), .Y(n77) );
  AOI21X2M U55 ( .A0(i_div_ratio[4]), .A1(n76), .B0(n80), .Y(n82) );
  NOR4X1M U56 ( .A(cnt_even[7]), .B(n70), .C(n71), .D(n72), .Y(n69) );
  XNOR2X2M U57 ( .A(cnt_even[1]), .B(n73), .Y(n71) );
  XNOR2X2M U58 ( .A(cnt_even[0]), .B(i_div_ratio[1]), .Y(n72) );
  CLKXOR2X2M U59 ( .A(n75), .B(cnt_even[2]), .Y(n70) );
  AO22X1M U60 ( .A0(n1), .A1(cnt_even[6]), .B0(N27), .B1(n38), .Y(n58) );
  NAND4X2M U61 ( .A(n66), .B(n67), .C(n68), .D(n69), .Y(n39) );
  CLKXOR2X2M U62 ( .A(n83), .B(cnt_even[6]), .Y(n67) );
  NOR2X2M U63 ( .A(n77), .B(n78), .Y(n68) );
  XOR3XLM U64 ( .A(i_div_ratio[6]), .B(cnt_even[5]), .C(n81), .Y(n66) );
  OAI2BB2X1M U65 ( .B0(n15), .B1(n14), .A0N(N52), .A1N(n84), .Y(n54) );
  OAI2BB2X1M U66 ( .B0(n15), .B1(n13), .A0N(N53), .A1N(n84), .Y(n53) );
  OAI2BB2X1M U67 ( .B0(n15), .B1(n12), .A0N(N55), .A1N(n84), .Y(n51) );
  OAI2BB2X1M U68 ( .B0(n15), .B1(n10), .A0N(N56), .A1N(n84), .Y(n50) );
  OAI2BB2X1M U69 ( .B0(n15), .B1(n9), .A0N(N57), .A1N(n84), .Y(n49) );
  OAI2BB2X1M U70 ( .B0(n15), .B1(n8), .A0N(N51), .A1N(n84), .Y(n55) );
  OAI2BB2X1M U71 ( .B0(n15), .B1(n7), .A0N(N58), .A1N(n84), .Y(n48) );
  INVX2M U72 ( .A(cnt_odd_pos[0]), .Y(n8) );
  INVX2M U73 ( .A(cnt_odd_pos[1]), .Y(n14) );
  INVX2M U74 ( .A(cnt_odd_pos[5]), .Y(n10) );
  CLKXOR2X2M U75 ( .A(n122), .B(i_div_ratio[7]), .Y(n104) );
  INVX2M U76 ( .A(cnt_odd_pos[2]), .Y(n13) );
  INVX2M U77 ( .A(cnt_odd_pos[6]), .Y(n9) );
  INVX2M U78 ( .A(cnt_odd_pos[4]), .Y(n12) );
  INVX2M U80 ( .A(cnt_odd_pos[3]), .Y(n11) );
  INVX2M U81 ( .A(cnt_odd_pos[7]), .Y(n7) );
  CLKXOR2X2M U82 ( .A(n79), .B(cnt_even[4]), .Y(n78) );
  OAI21X2M U83 ( .A0(n80), .A1(n16), .B0(n81), .Y(n79) );
  CLKXOR2X2M U84 ( .A(n14), .B(i_div_ratio[1]), .Y(n88) );
  CLKXOR2X2M U85 ( .A(n12), .B(i_div_ratio[4]), .Y(n91) );
  CLKXOR2X2M U86 ( .A(n11), .B(i_div_ratio[3]), .Y(n95) );
  CLKXOR2X2M U87 ( .A(n9), .B(i_div_ratio[6]), .Y(n93) );
  CLKXOR2X2M U88 ( .A(n10), .B(i_div_ratio[5]), .Y(n92) );
  CLKXOR2X2M U89 ( .A(n13), .B(i_div_ratio[2]), .Y(n96) );
  AO22X1M U90 ( .A0(n1), .A1(cnt_even[5]), .B0(N26), .B1(n38), .Y(n59) );
  AO22X1M U91 ( .A0(n1), .A1(cnt_even[1]), .B0(N22), .B1(n38), .Y(n63) );
  AO22X1M U92 ( .A0(n1), .A1(cnt_even[3]), .B0(N24), .B1(n38), .Y(n61) );
  AO22X1M U93 ( .A0(n1), .A1(cnt_even[4]), .B0(N25), .B1(n38), .Y(n60) );
  AO22X1M U94 ( .A0(n1), .A1(cnt_even[2]), .B0(N23), .B1(n38), .Y(n62) );
  AO22X1M U95 ( .A0(n1), .A1(cnt_even[0]), .B0(N21), .B1(n38), .Y(n64) );
  CLKXOR2X2M U96 ( .A(even_clk), .B(n65), .Y(n56) );
  NOR2X2M U97 ( .A(n1), .B(n39), .Y(n65) );
  NAND3BX2M U98 ( .AN(n90), .B(i_clk_en), .C(i_div_ratio[0]), .Y(n87) );
  NOR2X2M U99 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n74) );
  NOR2X2M U100 ( .A(n76), .B(i_div_ratio[4]), .Y(n80) );
  NOR3X2M U101 ( .A(i_div_ratio[6]), .B(i_div_ratio[7]), .C(n81), .Y(n90) );
  OAI21X2M U102 ( .A0(i_div_ratio[6]), .A1(n81), .B0(i_div_ratio[7]), .Y(n83)
         );
  AOI21X2M U103 ( .A0(i_div_ratio[2]), .A1(i_div_ratio[1]), .B0(n74), .Y(n73)
         );
  NOR2BX2M U104 ( .AN(outA_r), .B(n121), .Y(n89) );
  INVX2M U105 ( .A(i_div_ratio[5]), .Y(n16) );
  INVX2M U106 ( .A(i_div_ratio[3]), .Y(n17) );
  BUFX2M U107 ( .A(n37), .Y(n1) );
  NAND3BX2M U108 ( .AN(n90), .B(i_clk_en), .C(n18), .Y(n37) );
  INVX2M U109 ( .A(i_div_ratio[0]), .Y(n18) );
endmodule


module FSM ( Data_Valid, PAR_EN, ser_done, RST, clk, busy, ser_en, mux_sel );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, RST, clk;
  output busy, ser_en;
  wire   busy_c, n2, n3, n4, n5, n6, n7, n8;
  wire   [2:0] Current_State;
  wire   [2:0] Next_State;

  DFFRQX2M busy_reg ( .D(busy_c), .CK(clk), .RN(RST), .Q(busy) );
  DFFRQX2M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(clk), .RN(RST), .Q(
        Current_State[0]) );
  DFFRQX2M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(clk), .RN(RST), .Q(
        Current_State[1]) );
  DFFRQX2M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(clk), .RN(RST), .Q(
        Current_State[2]) );
  INVX2M U3 ( .A(n4), .Y(ser_en) );
  INVX2M U4 ( .A(n8), .Y(mux_sel[0]) );
  NAND2X2M U5 ( .A(mux_sel[1]), .B(n6), .Y(n4) );
  NOR2X2M U6 ( .A(n2), .B(Current_State[2]), .Y(mux_sel[1]) );
  NOR2X2M U7 ( .A(n3), .B(Current_State[2]), .Y(n8) );
  INVX2M U8 ( .A(Current_State[1]), .Y(n2) );
  INVX2M U9 ( .A(Current_State[0]), .Y(n3) );
  XNOR2X2M U10 ( .A(Current_State[0]), .B(Current_State[1]), .Y(n6) );
  OAI22X1M U11 ( .A0(ser_done), .A1(mux_sel[0]), .B0(Current_State[1]), .B1(n7), .Y(Next_State[0]) );
  AOI2B1X1M U12 ( .A1N(Current_State[2]), .A0(Data_Valid), .B0(n8), .Y(n7) );
  OAI21X2M U13 ( .A0(Current_State[2]), .A1(n6), .B0(n4), .Y(Next_State[1]) );
  OAI21X2M U14 ( .A0(Current_State[0]), .A1(n2), .B0(mux_sel[0]), .Y(busy_c)
         );
  NOR2BX2M U15 ( .AN(mux_sel[1]), .B(n5), .Y(Next_State[2]) );
  AOI2B1X1M U16 ( .A1N(PAR_EN), .A0(ser_done), .B0(n3), .Y(n5) );
endmodule


module Serializer_WIDTH8 ( CLK, RST, DATA, Enable, Busy, Data_Valid, ser_out, 
        ser_done );
  input [7:0] DATA;
  input CLK, RST, Enable, Busy, Data_Valid;
  output ser_out, ser_done;
  wire   n19, n20, n21, n22, n23, n24, n18, N25, N23, n17, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35;
  wire   [7:1] DATA_V;
  wire   [2:0] ser_count;

  DFFRQX2M \DATA_V_reg[6]  ( .D(n19), .CK(CLK), .RN(RST), .Q(DATA_V[6]) );
  DFFRQX2M \DATA_V_reg[5]  ( .D(n20), .CK(CLK), .RN(RST), .Q(DATA_V[5]) );
  DFFRQX2M \DATA_V_reg[4]  ( .D(n21), .CK(CLK), .RN(RST), .Q(DATA_V[4]) );
  DFFRQX2M \DATA_V_reg[3]  ( .D(n22), .CK(CLK), .RN(RST), .Q(DATA_V[3]) );
  DFFRQX2M \DATA_V_reg[2]  ( .D(n23), .CK(CLK), .RN(RST), .Q(DATA_V[2]) );
  DFFRQX2M \DATA_V_reg[7]  ( .D(n18), .CK(CLK), .RN(RST), .Q(DATA_V[7]) );
  DFFRQX2M \DATA_V_reg[1]  ( .D(n24), .CK(CLK), .RN(RST), .Q(DATA_V[1]) );
  DFFRQX2M \ser_count_reg[2]  ( .D(N25), .CK(CLK), .RN(RST), .Q(ser_count[2])
         );
  DFFRQX2M \ser_count_reg[1]  ( .D(n9), .CK(CLK), .RN(RST), .Q(ser_count[1])
         );
  DFFRQX2M \ser_count_reg[0]  ( .D(N23), .CK(CLK), .RN(RST), .Q(ser_count[0])
         );
  DFFRQX2M \DATA_V_reg[0]  ( .D(n17), .CK(CLK), .RN(RST), .Q(ser_out) );
  INVX2M U1 ( .A(n29), .Y(n11) );
  INVX2M U2 ( .A(n30), .Y(n10) );
  INVX2M U3 ( .A(Enable), .Y(n12) );
  NOR2X2M U4 ( .A(n12), .B(n34), .Y(n29) );
  NOR2X2M U5 ( .A(n29), .B(n35), .Y(n30) );
  OAI221X1M U6 ( .A0(n10), .A1(n5), .B0(n11), .B1(n4), .C0(n16), .Y(n23) );
  NAND2X2M U7 ( .A(DATA[2]), .B(n34), .Y(n16) );
  OAI221X1M U8 ( .A0(n10), .A1(n4), .B0(n11), .B1(n3), .C0(n25), .Y(n22) );
  NAND2X2M U9 ( .A(DATA[3]), .B(n35), .Y(n25) );
  OAI221X1M U10 ( .A0(n10), .A1(n3), .B0(n11), .B1(n2), .C0(n26), .Y(n21) );
  NAND2X2M U11 ( .A(DATA[4]), .B(n34), .Y(n26) );
  OAI221X1M U12 ( .A0(n10), .A1(n2), .B0(n11), .B1(n1), .C0(n27), .Y(n20) );
  NAND2X2M U13 ( .A(DATA[5]), .B(n35), .Y(n27) );
  OAI221X1M U14 ( .A0(n10), .A1(n1), .B0(n11), .B1(n7), .C0(n28), .Y(n19) );
  NAND2X2M U15 ( .A(DATA[6]), .B(n34), .Y(n28) );
  OAI2BB2X1M U16 ( .B0(n10), .B1(n7), .A0N(DATA[7]), .A1N(n34), .Y(n18) );
  BUFX2M U17 ( .A(n15), .Y(n34) );
  BUFX2M U18 ( .A(n15), .Y(n35) );
  NOR2X2M U19 ( .A(n13), .B(n8), .Y(ser_done) );
  OAI32X1M U20 ( .A0(n12), .A1(ser_count[2]), .A2(n13), .B0(n32), .B1(n8), .Y(
        N25) );
  AOI2BB1X2M U21 ( .A0N(ser_count[1]), .A1N(n12), .B0(N23), .Y(n32) );
  OAI221X1M U22 ( .A0(n10), .A1(n6), .B0(n11), .B1(n5), .C0(n14), .Y(n24) );
  INVX2M U23 ( .A(DATA_V[1]), .Y(n6) );
  NAND2X2M U24 ( .A(DATA[1]), .B(n35), .Y(n14) );
  NOR2BX2M U25 ( .AN(Data_Valid), .B(Busy), .Y(n15) );
  NOR2X2M U26 ( .A(n12), .B(ser_count[0]), .Y(N23) );
  OAI2BB1X2M U27 ( .A0N(DATA[0]), .A1N(n35), .B0(n31), .Y(n17) );
  AOI22X1M U28 ( .A0(ser_out), .A1(n30), .B0(n29), .B1(DATA_V[1]), .Y(n31) );
  INVX2M U29 ( .A(n33), .Y(n9) );
  OAI211X2M U30 ( .A0(ser_count[0]), .A1(ser_count[1]), .B0(Enable), .C0(n13), 
        .Y(n33) );
  NAND2X2M U31 ( .A(ser_count[1]), .B(ser_count[0]), .Y(n13) );
  INVX2M U32 ( .A(ser_count[2]), .Y(n8) );
  INVX2M U33 ( .A(DATA_V[7]), .Y(n7) );
  INVX2M U34 ( .A(DATA_V[2]), .Y(n5) );
  INVX2M U35 ( .A(DATA_V[3]), .Y(n4) );
  INVX2M U36 ( .A(DATA_V[4]), .Y(n3) );
  INVX2M U37 ( .A(DATA_V[5]), .Y(n2) );
  INVX2M U38 ( .A(DATA_V[6]), .Y(n1) );
endmodule


module Parity_Calc_WIDTH8 ( clk, RST, PAR_EN, PAR_TYP, Busy, P_DATA, 
        Data_Valid, par_bit );
  input [7:0] P_DATA;
  input clk, RST, PAR_EN, PAR_TYP, Busy, Data_Valid;
  output par_bit;
  wire   n10, n9, n11, n12, n14, n13, n15, n16, n8, n1, n2, n3, n4, n5, n6, n7
;
  wire   [7:0] DATA_V;

  DFFRQX2M \DATA_V_reg[1]  ( .D(n10), .CK(clk), .RN(RST), .Q(DATA_V[1]) );
  DFFRQX2M \DATA_V_reg[0]  ( .D(n9), .CK(clk), .RN(RST), .Q(DATA_V[0]) );
  DFFRQX2M \DATA_V_reg[2]  ( .D(n11), .CK(clk), .RN(RST), .Q(DATA_V[2]) );
  DFFRQX2M \DATA_V_reg[3]  ( .D(n12), .CK(clk), .RN(RST), .Q(DATA_V[3]) );
  DFFRQX2M \DATA_V_reg[5]  ( .D(n14), .CK(clk), .RN(RST), .Q(DATA_V[5]) );
  DFFRQX2M \DATA_V_reg[4]  ( .D(n13), .CK(clk), .RN(RST), .Q(DATA_V[4]) );
  DFFRQX2M \DATA_V_reg[6]  ( .D(n15), .CK(clk), .RN(RST), .Q(DATA_V[6]) );
  DFFRQX2M \DATA_V_reg[7]  ( .D(n16), .CK(clk), .RN(RST), .Q(DATA_V[7]) );
  DFFRQX2M par_bit_reg ( .D(n8), .CK(clk), .RN(RST), .Q(par_bit) );
  OAI2BB2X1M U1 ( .B0(n3), .B1(n1), .A0N(par_bit), .A1N(n1), .Y(n8) );
  INVX2M U2 ( .A(PAR_EN), .Y(n1) );
  XOR3XLM U3 ( .A(n4), .B(PAR_TYP), .C(n5), .Y(n3) );
  XOR3XLM U4 ( .A(DATA_V[1]), .B(DATA_V[0]), .C(n6), .Y(n5) );
  XOR3XLM U5 ( .A(DATA_V[5]), .B(DATA_V[4]), .C(n7), .Y(n4) );
  CLKXOR2X2M U6 ( .A(DATA_V[7]), .B(DATA_V[6]), .Y(n7) );
  AO2B2X2M U7 ( .B0(P_DATA[7]), .B1(n2), .A0(DATA_V[7]), .A1N(n2), .Y(n16) );
  AO2B2X2M U8 ( .B0(P_DATA[6]), .B1(n2), .A0(DATA_V[6]), .A1N(n2), .Y(n15) );
  AO2B2X2M U9 ( .B0(P_DATA[4]), .B1(n2), .A0(DATA_V[4]), .A1N(n2), .Y(n13) );
  AO2B2X2M U10 ( .B0(P_DATA[5]), .B1(n2), .A0(DATA_V[5]), .A1N(n2), .Y(n14) );
  AO2B2X2M U11 ( .B0(P_DATA[3]), .B1(n2), .A0(DATA_V[3]), .A1N(n2), .Y(n12) );
  AO2B2X2M U12 ( .B0(P_DATA[2]), .B1(n2), .A0(DATA_V[2]), .A1N(n2), .Y(n11) );
  AO2B2X2M U13 ( .B0(P_DATA[0]), .B1(n2), .A0(DATA_V[0]), .A1N(n2), .Y(n9) );
  AO2B2X2M U14 ( .B0(P_DATA[1]), .B1(n2), .A0(DATA_V[1]), .A1N(n2), .Y(n10) );
  NOR2BX2M U15 ( .AN(Data_Valid), .B(Busy), .Y(n2) );
  XNOR2X2M U16 ( .A(DATA_V[2]), .B(DATA_V[3]), .Y(n6) );
endmodule


module MUX ( mux_sel, ser_data, par_bit, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, par_bit;
  output TX_OUT;
  wire   n1, n2, n3;

  OAI21X4M U3 ( .A0(n2), .A1(n1), .B0(n3), .Y(TX_OUT) );
  NAND3X2M U4 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  INVX2M U5 ( .A(mux_sel[0]), .Y(n1) );
  NOR2BX2M U6 ( .AN(mux_sel[1]), .B(par_bit), .Y(n2) );
endmodule


module UART_TX_WIDTH8 ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, clk, RST, TX_OUT, 
        Busy );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, clk, RST;
  output TX_OUT, Busy;
  wire   ser_done, ser_en, ser_data, par_bit, n1, n2;
  wire   [1:0] mux_sel;

  FSM u_fsm ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(ser_done), 
        .RST(n1), .clk(clk), .busy(Busy), .ser_en(ser_en), .mux_sel(mux_sel)
         );
  Serializer_WIDTH8 u_serializer ( .CLK(clk), .RST(n1), .DATA(P_DATA), 
        .Enable(ser_en), .Busy(Busy), .Data_Valid(Data_Valid), .ser_out(
        ser_data), .ser_done(ser_done) );
  Parity_Calc_WIDTH8 u_parity ( .clk(clk), .RST(n1), .PAR_EN(PAR_EN), 
        .PAR_TYP(PAR_TYP), .Busy(Busy), .P_DATA(P_DATA), .Data_Valid(
        Data_Valid), .par_bit(par_bit) );
  MUX u_mux ( .mux_sel(mux_sel), .ser_data(ser_data), .par_bit(par_bit), 
        .TX_OUT(TX_OUT) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module FSM_RX_DATA_WIDTH8 ( CLK, RST, PAR_EN, RX_IN, edge_cnt, bit_cnt, 
        Prescale, par_err, strt_glitch, stp_err, enable, dat_samp_en, 
        par_chk_en, strt_chk_en, stp_chk_en, deser_en, Data_Valid );
  input [5:0] edge_cnt;
  input [3:0] bit_cnt;
  input [5:0] Prescale;
  input CLK, RST, PAR_EN, RX_IN, par_err, strt_glitch, stp_err;
  output enable, dat_samp_en, par_chk_en, strt_chk_en, stp_chk_en, deser_en,
         Data_Valid;
  wire   Data_Valid_v, n3, n4, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59;
  wire   [2:0] Next_State;
  wire   [2:0] Current_State;

  DFFRQX2M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(CLK), .RN(RST), .Q(
        Current_State[0]) );
  DFFRQX2M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(CLK), .RN(RST), .Q(
        Current_State[2]) );
  DFFRQX2M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(CLK), .RN(RST), .Q(
        Current_State[1]) );
  DFFRQX2M Data_Valid_reg ( .D(Data_Valid_v), .CK(CLK), .RN(RST), .Q(
        Data_Valid) );
  AO21XLM U1 ( .A0(n6), .A1(RX_IN), .B0(Current_State[2]), .Y(n12) );
  NAND2X2M U2 ( .A(n14), .B(n12), .Y(enable) );
  NAND2X2M U3 ( .A(n4), .B(n12), .Y(dat_samp_en) );
  INVX2M U4 ( .A(n14), .Y(n3) );
  INVX2M U5 ( .A(n21), .Y(n9) );
  NOR2X2M U6 ( .A(n43), .B(n44), .Y(n35) );
  AOI21X2M U7 ( .A0(n46), .A1(n36), .B0(n29), .Y(n45) );
  AOI21X2M U8 ( .A0(n43), .A1(n44), .B0(n35), .Y(n42) );
  NAND2X2M U9 ( .A(n35), .B(n34), .Y(n36) );
  NOR2X2M U10 ( .A(n36), .B(n46), .Y(n29) );
  NOR2X2M U11 ( .A(Current_State[1]), .B(n12), .Y(strt_chk_en) );
  OAI221X1M U12 ( .A0(RX_IN), .A1(n22), .B0(n17), .B1(n18), .C0(n23), .Y(
        Next_State[0]) );
  AOI31X2M U13 ( .A0(n4), .A1(n7), .A2(n24), .B0(n25), .Y(n23) );
  NOR4X1M U14 ( .A(n26), .B(n27), .C(n13), .D(n28), .Y(n25) );
  OAI22X1M U15 ( .A0(RX_IN), .A1(Current_State[0]), .B0(n49), .B1(n6), .Y(n24)
         );
  XNOR2X2M U16 ( .A(Prescale[0]), .B(edge_cnt[0]), .Y(n32) );
  NOR4BX1M U17 ( .AN(strt_glitch), .B(bit_cnt[3]), .C(bit_cnt[0]), .D(n21), 
        .Y(n49) );
  NOR4X1M U18 ( .A(bit_cnt[2]), .B(bit_cnt[1]), .C(n48), .D(n32), .Y(n53) );
  NAND4X2M U19 ( .A(n50), .B(n51), .C(n52), .D(n53), .Y(n21) );
  CLKXOR2X2M U20 ( .A(n30), .B(edge_cnt[5]), .Y(n51) );
  XNOR2X2M U21 ( .A(n46), .B(edge_cnt[4]), .Y(n50) );
  NOR2X2M U22 ( .A(n54), .B(n55), .Y(n52) );
  NOR3BX2M U23 ( .AN(bit_cnt[3]), .B(n21), .C(bit_cnt[0]), .Y(n17) );
  AOI211X2M U24 ( .A0(n29), .A1(n30), .B0(n41), .C0(bit_cnt[2]), .Y(n40) );
  AOI33X2M U25 ( .A0(n8), .A1(n10), .A2(bit_cnt[0]), .B0(PAR_EN), .B1(n11), 
        .B2(bit_cnt[1]), .Y(n41) );
  INVX2M U26 ( .A(bit_cnt[1]), .Y(n10) );
  INVX2M U27 ( .A(bit_cnt[0]), .Y(n11) );
  XNOR2X2M U28 ( .A(n47), .B(edge_cnt[1]), .Y(n48) );
  XNOR2X2M U29 ( .A(n34), .B(edge_cnt[3]), .Y(n55) );
  XNOR3X2M U30 ( .A(edge_cnt[5]), .B(n29), .C(n30), .Y(n28) );
  NAND2X2M U31 ( .A(Current_State[1]), .B(n6), .Y(n14) );
  NAND2X2M U32 ( .A(Current_State[2]), .B(n3), .Y(n13) );
  NAND4X2M U33 ( .A(n37), .B(n38), .C(n39), .D(n40), .Y(n26) );
  CLKXOR2X2M U34 ( .A(edge_cnt[2]), .B(n42), .Y(n39) );
  CLKXOR2X2M U35 ( .A(edge_cnt[4]), .B(n45), .Y(n38) );
  XNOR2X2M U36 ( .A(Prescale[0]), .B(n48), .Y(n37) );
  NAND3X2M U37 ( .A(Current_State[1]), .B(n7), .C(Current_State[0]), .Y(n18)
         );
  NAND3X2M U38 ( .A(bit_cnt[3]), .B(n31), .C(n32), .Y(n27) );
  XNOR2X2M U39 ( .A(edge_cnt[3]), .B(n33), .Y(n31) );
  OAI21X2M U40 ( .A0(n34), .A1(n35), .B0(n36), .Y(n33) );
  NOR2X2M U41 ( .A(Current_State[2]), .B(n14), .Y(par_chk_en) );
  INVX2M U42 ( .A(n13), .Y(stp_chk_en) );
  OAI21X2M U43 ( .A0(Current_State[2]), .A1(n19), .B0(n14), .Y(Next_State[1])
         );
  AOI31X2M U44 ( .A0(n9), .A1(Current_State[0]), .A2(n20), .B0(
        Current_State[1]), .Y(n19) );
  NOR3X2M U45 ( .A(bit_cnt[0]), .B(strt_glitch), .C(bit_cnt[3]), .Y(n20) );
  INVX2M U46 ( .A(Current_State[1]), .Y(n4) );
  INVX2M U47 ( .A(Current_State[0]), .Y(n6) );
  INVX2M U48 ( .A(Current_State[2]), .Y(n7) );
  NAND3X2M U49 ( .A(n15), .B(n13), .C(n16), .Y(Next_State[2]) );
  NAND4X2M U50 ( .A(bit_cnt[3]), .B(bit_cnt[0]), .C(n9), .D(n3), .Y(n15) );
  NAND3X2M U51 ( .A(n17), .B(n8), .C(deser_en), .Y(n16) );
  INVX2M U52 ( .A(n18), .Y(deser_en) );
  CLKXOR2X2M U53 ( .A(n44), .B(edge_cnt[2]), .Y(n54) );
  NOR3X2M U54 ( .A(n22), .B(stp_err), .C(par_err), .Y(Data_Valid_v) );
  NAND3X2M U55 ( .A(Current_State[2]), .B(Current_State[1]), .C(
        Current_State[0]), .Y(n22) );
  AOI21X2M U56 ( .A0(n56), .A1(Prescale[3]), .B0(n57), .Y(n34) );
  NOR2X2M U57 ( .A(n56), .B(Prescale[3]), .Y(n57) );
  NAND2X2M U58 ( .A(Prescale[0]), .B(n47), .Y(n43) );
  NAND2X2M U59 ( .A(n56), .B(n58), .Y(n44) );
  OAI21X2M U60 ( .A0(Prescale[0]), .A1(Prescale[1]), .B0(Prescale[2]), .Y(n58)
         );
  OR3X2M U61 ( .A(Prescale[1]), .B(Prescale[2]), .C(Prescale[0]), .Y(n56) );
  CLKXOR2X2M U62 ( .A(n57), .B(Prescale[4]), .Y(n46) );
  CLKXOR2X2M U63 ( .A(Prescale[1]), .B(Prescale[0]), .Y(n47) );
  CLKXOR2X2M U64 ( .A(n59), .B(Prescale[5]), .Y(n30) );
  NAND2BX2M U65 ( .AN(Prescale[4]), .B(n57), .Y(n59) );
  INVX2M U66 ( .A(PAR_EN), .Y(n8) );
endmodule


module edge_bit_counter_DATA_WIDTH8 ( CLK, RST, enable, Prescale, bit_cnt, 
        edge_cnt );
  input [5:0] Prescale;
  output [3:0] bit_cnt;
  output [5:0] edge_cnt;
  input CLK, RST, enable;
  wire   n22, n20, n23, N25, n21, n9, N20, N24, N23, N22, N21, n2, n3, n4, n5,
         n6, n8, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53;

  DFFRX1M \bit_cnt_reg[2]  ( .D(n21), .CK(CLK), .RN(RST), .Q(bit_cnt[2]), .QN(
        n9) );
  DFFRQX2M \edge_cnt_reg[5]  ( .D(N25), .CK(CLK), .RN(RST), .Q(edge_cnt[5]) );
  DFFRQX2M \edge_cnt_reg[3]  ( .D(N23), .CK(CLK), .RN(RST), .Q(edge_cnt[3]) );
  DFFRQX2M \edge_cnt_reg[2]  ( .D(N22), .CK(CLK), .RN(RST), .Q(edge_cnt[2]) );
  DFFRQX2M \bit_cnt_reg[3]  ( .D(n20), .CK(CLK), .RN(RST), .Q(bit_cnt[3]) );
  DFFRQX2M \bit_cnt_reg[1]  ( .D(n22), .CK(CLK), .RN(RST), .Q(bit_cnt[1]) );
  DFFRQX2M \edge_cnt_reg[4]  ( .D(N24), .CK(CLK), .RN(RST), .Q(edge_cnt[4]) );
  DFFRQX2M \bit_cnt_reg[0]  ( .D(n23), .CK(CLK), .RN(RST), .Q(bit_cnt[0]) );
  DFFRQX2M \edge_cnt_reg[1]  ( .D(N21), .CK(CLK), .RN(RST), .Q(edge_cnt[1]) );
  DFFRQX2M \edge_cnt_reg[0]  ( .D(N20), .CK(CLK), .RN(RST), .Q(edge_cnt[0]) );
  INVX2M U1 ( .A(n16), .Y(n5) );
  INVX2M U2 ( .A(n17), .Y(n6) );
  NAND2X2M U3 ( .A(enable), .B(n27), .Y(n16) );
  NAND2BX2M U4 ( .AN(n27), .B(enable), .Y(n17) );
  NOR3X2M U5 ( .A(n8), .B(n11), .C(n10), .Y(n32) );
  OAI21X2M U6 ( .A0(n52), .A1(n15), .B0(n44), .Y(n51) );
  OAI21X2M U7 ( .A0(n45), .A1(n14), .B0(n50), .Y(n53) );
  NAND2X2M U8 ( .A(n52), .B(n15), .Y(n44) );
  NAND2X2M U9 ( .A(n45), .B(n14), .Y(n50) );
  OAI32X1M U10 ( .A0(n25), .A1(bit_cnt[3]), .A2(n17), .B0(n26), .B1(n3), .Y(
        n20) );
  INVX2M U11 ( .A(bit_cnt[3]), .Y(n3) );
  AOI21X2M U12 ( .A0(enable), .A1(n25), .B0(n5), .Y(n26) );
  NAND2BX2M U13 ( .AN(n19), .B(bit_cnt[2]), .Y(n25) );
  OAI32X1M U14 ( .A0(n4), .A1(bit_cnt[1]), .A2(n17), .B0(n18), .B1(n2), .Y(n22) );
  INVX2M U15 ( .A(bit_cnt[1]), .Y(n2) );
  AOI21X2M U16 ( .A0(n6), .A1(n4), .B0(n5), .Y(n18) );
  OAI32X1M U17 ( .A0(bit_cnt[2]), .A1(n17), .A2(n19), .B0(n9), .B1(n24), .Y(
        n21) );
  AOI21X2M U18 ( .A0(n6), .A1(n19), .B0(n5), .Y(n24) );
  OAI22X1M U19 ( .A0(n16), .A1(n4), .B0(bit_cnt[0]), .B1(n17), .Y(n23) );
  NOR2X2M U20 ( .A(n16), .B(edge_cnt[0]), .Y(N20) );
  OAI21X2M U21 ( .A0(n34), .A1(n10), .B0(n35), .Y(N22) );
  NAND4X2M U22 ( .A(n5), .B(edge_cnt[0]), .C(edge_cnt[1]), .D(n10), .Y(n35) );
  AOI21X2M U23 ( .A0(n5), .A1(n11), .B0(N20), .Y(n34) );
  NOR2X2M U24 ( .A(n36), .B(n16), .Y(N21) );
  CLKXOR2X2M U25 ( .A(n8), .B(edge_cnt[1]), .Y(n36) );
  NOR2X2M U26 ( .A(n33), .B(n16), .Y(N23) );
  XNOR2X2M U27 ( .A(n32), .B(edge_cnt[3]), .Y(n33) );
  NOR2X2M U28 ( .A(n31), .B(n16), .Y(N24) );
  XNOR2X2M U29 ( .A(edge_cnt[4]), .B(n30), .Y(n31) );
  NOR2X2M U30 ( .A(n28), .B(n16), .Y(N25) );
  CLKXOR2X2M U31 ( .A(n29), .B(edge_cnt[5]), .Y(n28) );
  NAND2X2M U32 ( .A(n30), .B(edge_cnt[4]), .Y(n29) );
  AOI211X2M U33 ( .A0(n13), .A1(n12), .B0(n41), .C0(n42), .Y(n40) );
  INVX2M U34 ( .A(n50), .Y(n13) );
  INVX2M U35 ( .A(Prescale[5]), .Y(n12) );
  XNOR2X2M U36 ( .A(edge_cnt[3]), .B(n43), .Y(n42) );
  OAI2B2X1M U37 ( .A1N(Prescale[0]), .A0(n46), .B0(Prescale[0]), .B1(n47), .Y(
        n41) );
  NOR2X2M U38 ( .A(edge_cnt[0]), .B(n49), .Y(n46) );
  NOR2X2M U39 ( .A(n48), .B(n8), .Y(n47) );
  CLKXOR2X2M U40 ( .A(edge_cnt[1]), .B(Prescale[1]), .Y(n49) );
  NAND4X2M U41 ( .A(n37), .B(n38), .C(n39), .D(n40), .Y(n27) );
  XNOR2X2M U42 ( .A(edge_cnt[4]), .B(n53), .Y(n37) );
  CLKXOR2X2M U43 ( .A(n10), .B(n51), .Y(n38) );
  XOR3XLM U44 ( .A(edge_cnt[5]), .B(Prescale[5]), .C(n50), .Y(n39) );
  INVX2M U45 ( .A(edge_cnt[0]), .Y(n8) );
  INVX2M U46 ( .A(edge_cnt[1]), .Y(n11) );
  CLKXOR2X2M U47 ( .A(Prescale[1]), .B(n11), .Y(n48) );
  INVX2M U48 ( .A(edge_cnt[2]), .Y(n10) );
  NAND2X2M U49 ( .A(bit_cnt[1]), .B(bit_cnt[0]), .Y(n19) );
  INVX2M U50 ( .A(bit_cnt[0]), .Y(n4) );
  AND2X2M U51 ( .A(n32), .B(edge_cnt[3]), .Y(n30) );
  NOR2X2M U52 ( .A(n44), .B(Prescale[3]), .Y(n45) );
  NOR2X2M U53 ( .A(Prescale[1]), .B(Prescale[0]), .Y(n52) );
  AOI21X2M U54 ( .A0(Prescale[3]), .A1(n44), .B0(n45), .Y(n43) );
  INVX2M U55 ( .A(Prescale[2]), .Y(n15) );
  INVX2M U56 ( .A(Prescale[4]), .Y(n14) );
endmodule


module Data_Sampling_DATA_WIDTH8 ( CLK, RST, edge_cnt, RX_IN, dat_samp_en, 
        Prescale, sampled_bit );
  input [5:0] edge_cnt;
  input [5:0] Prescale;
  input CLK, RST, RX_IN, dat_samp_en;
  output sampled_bit;
  wire   n26, n24, n25, n23, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60;
  wire   [2:0] Data_Sampled_reg;

  DFFRQX2M \Data_Sampled_reg_reg[2]  ( .D(n26), .CK(CLK), .RN(RST), .Q(
        Data_Sampled_reg[2]) );
  DFFRQX2M \Data_Sampled_reg_reg[1]  ( .D(n25), .CK(CLK), .RN(RST), .Q(
        Data_Sampled_reg[1]) );
  DFFRQX2M \Data_Sampled_reg_reg[0]  ( .D(n24), .CK(CLK), .RN(RST), .Q(
        Data_Sampled_reg[0]) );
  DFFRQX2M sampled_bit_reg ( .D(n23), .CK(CLK), .RN(RST), .Q(sampled_bit) );
  INVX2M U1 ( .A(dat_samp_en), .Y(n8) );
  OAI21X2M U2 ( .A0(n31), .A1(n9), .B0(n33), .Y(n36) );
  NAND2X2M U3 ( .A(n31), .B(n9), .Y(n33) );
  INVX2M U4 ( .A(n52), .Y(n10) );
  NAND2X2M U5 ( .A(RX_IN), .B(dat_samp_en), .Y(n15) );
  XNOR2X2M U6 ( .A(n37), .B(n7), .Y(n17) );
  NAND2X2M U7 ( .A(n33), .B(n32), .Y(n37) );
  XOR3XLM U8 ( .A(n7), .B(n32), .C(n54), .Y(n47) );
  NOR2X2M U9 ( .A(n9), .B(n52), .Y(n54) );
  NOR2X2M U10 ( .A(n30), .B(n29), .Y(n31) );
  NAND3X2M U11 ( .A(n30), .B(n14), .C(n12), .Y(n52) );
  INVX2M U12 ( .A(n38), .Y(n12) );
  INVX2M U13 ( .A(n53), .Y(n9) );
  INVX2M U14 ( .A(n55), .Y(n11) );
  INVX2M U15 ( .A(n58), .Y(n13) );
  OAI32X1M U16 ( .A0(n3), .A1(n4), .A2(n8), .B0(n15), .B1(n39), .Y(n25) );
  INVX2M U17 ( .A(n39), .Y(n4) );
  NAND4X2M U18 ( .A(n35), .B(n27), .C(n40), .D(n41), .Y(n39) );
  XNOR2X2M U19 ( .A(edge_cnt[4]), .B(n32), .Y(n40) );
  OAI32X1M U20 ( .A0(n2), .A1(n6), .A2(n8), .B0(n15), .B1(n45), .Y(n24) );
  INVX2M U21 ( .A(n45), .Y(n6) );
  NAND4X2M U22 ( .A(n46), .B(n47), .C(n48), .D(n49), .Y(n45) );
  AOI31X2M U23 ( .A0(n53), .A1(n32), .A2(n10), .B0(edge_cnt[5]), .Y(n48) );
  OAI32X1M U24 ( .A0(n8), .A1(n5), .A2(n1), .B0(n15), .B1(n16), .Y(n26) );
  INVX2M U25 ( .A(n16), .Y(n5) );
  NAND4X2M U26 ( .A(n17), .B(n18), .C(n19), .D(n20), .Y(n16) );
  XNOR2X2M U27 ( .A(edge_cnt[3]), .B(n36), .Y(n18) );
  OAI2BB2X1M U28 ( .B0(n59), .B1(n8), .A0N(sampled_bit), .A1N(n8), .Y(n23) );
  AOI21X2M U29 ( .A0(Data_Sampled_reg[0]), .A1(Data_Sampled_reg[1]), .B0(n60), 
        .Y(n59) );
  AOI21X2M U30 ( .A0(n3), .A1(n2), .B0(n1), .Y(n60) );
  XNOR2X2M U31 ( .A(n14), .B(edge_cnt[0]), .Y(n27) );
  NOR3X2M U32 ( .A(n50), .B(n27), .C(n51), .Y(n49) );
  XOR3XLM U33 ( .A(n9), .B(edge_cnt[3]), .C(n52), .Y(n50) );
  XNOR2X2M U34 ( .A(n14), .B(n35), .Y(n51) );
  NOR3X2M U35 ( .A(n42), .B(n43), .C(n21), .Y(n41) );
  XNOR2X2M U36 ( .A(edge_cnt[3]), .B(n9), .Y(n42) );
  CLKXOR2X2M U37 ( .A(n30), .B(edge_cnt[2]), .Y(n43) );
  NOR3X2M U38 ( .A(n21), .B(n22), .C(n27), .Y(n20) );
  XNOR2X2M U39 ( .A(edge_cnt[2]), .B(n28), .Y(n22) );
  AOI21X2M U40 ( .A0(n29), .A1(n30), .B0(n31), .Y(n28) );
  XOR3XLM U41 ( .A(edge_cnt[2]), .B(n30), .C(n57), .Y(n46) );
  NAND2X2M U42 ( .A(n14), .B(n12), .Y(n57) );
  AOI2BB1X2M U43 ( .A0N(n32), .A1N(n33), .B0(n34), .Y(n19) );
  XNOR2X2M U44 ( .A(n35), .B(Prescale[1]), .Y(n34) );
  CLKXOR2X2M U45 ( .A(n38), .B(edge_cnt[1]), .Y(n35) );
  CLKXOR2X2M U46 ( .A(edge_cnt[5]), .B(n44), .Y(n21) );
  INVX2M U47 ( .A(edge_cnt[4]), .Y(n7) );
  INVX2M U48 ( .A(Data_Sampled_reg[1]), .Y(n3) );
  INVX2M U49 ( .A(Data_Sampled_reg[0]), .Y(n2) );
  INVX2M U50 ( .A(Data_Sampled_reg[2]), .Y(n1) );
  OAI2BB1X2M U51 ( .A0N(n13), .A1N(Prescale[3]), .B0(n11), .Y(n30) );
  AOI21X2M U52 ( .A0(Prescale[1]), .A1(Prescale[2]), .B0(n58), .Y(n38) );
  NOR3X2M U53 ( .A(Prescale[4]), .B(Prescale[5]), .C(n11), .Y(n44) );
  NOR2X2M U54 ( .A(n13), .B(Prescale[3]), .Y(n55) );
  NOR2X2M U55 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n58) );
  INVX2M U56 ( .A(Prescale[1]), .Y(n14) );
  NAND2X2M U57 ( .A(n38), .B(Prescale[1]), .Y(n29) );
  NAND2BX2M U58 ( .AN(n44), .B(n56), .Y(n32) );
  OAI21X2M U59 ( .A0(Prescale[4]), .A1(n11), .B0(Prescale[5]), .Y(n56) );
  CLKXOR2X2M U60 ( .A(n55), .B(Prescale[4]), .Y(n53) );
endmodule


module deserializer_DATA_WIDTH8 ( CLK, RST, sampled_bit, deser_en, Prescale, 
        edge_cnt, P_DATA );
  input [5:0] Prescale;
  input [5:0] edge_cnt;
  output [7:0] P_DATA;
  input CLK, RST, sampled_bit, deser_en;
  wire   n19, n7, n15, n11, n18, n8, n14, n21, n5, n17, n9, n20, n6, n16, n10,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n1;

  DFFRX1M \P_DATA_reg[4]  ( .D(n18), .CK(CLK), .RN(RST), .Q(P_DATA[4]), .QN(n8) );
  DFFRX1M \P_DATA_reg[3]  ( .D(n17), .CK(CLK), .RN(RST), .Q(P_DATA[3]), .QN(n9) );
  DFFRX1M \P_DATA_reg[6]  ( .D(n20), .CK(CLK), .RN(RST), .Q(P_DATA[6]), .QN(n6) );
  DFFRX1M \P_DATA_reg[5]  ( .D(n19), .CK(CLK), .RN(RST), .Q(P_DATA[5]), .QN(n7) );
  DFFRX1M \P_DATA_reg[1]  ( .D(n15), .CK(CLK), .RN(RST), .Q(P_DATA[1]), .QN(
        n11) );
  DFFRX1M \P_DATA_reg[2]  ( .D(n16), .CK(CLK), .RN(RST), .Q(P_DATA[2]), .QN(
        n10) );
  DFFRQX2M \P_DATA_reg[0]  ( .D(n14), .CK(CLK), .RN(RST), .Q(P_DATA[0]) );
  DFFRX1M \P_DATA_reg[7]  ( .D(n21), .CK(CLK), .RN(RST), .Q(P_DATA[7]), .QN(n5) );
  INVX2M U1 ( .A(n1), .Y(n23) );
  NAND2X2M U2 ( .A(n38), .B(n24), .Y(n39) );
  INVX2M U3 ( .A(n36), .Y(n25) );
  OAI22X1M U4 ( .A0(n10), .A1(n23), .B0(n9), .B1(n1), .Y(n16) );
  OAI22X1M U5 ( .A0(n6), .A1(n23), .B0(n5), .B1(n1), .Y(n20) );
  OAI22X1M U6 ( .A0(n9), .A1(n23), .B0(n8), .B1(n1), .Y(n17) );
  OAI22X1M U7 ( .A0(n8), .A1(n23), .B0(n7), .B1(n1), .Y(n18) );
  OAI22X1M U8 ( .A0(n11), .A1(n23), .B0(n10), .B1(n1), .Y(n15) );
  OAI22X1M U9 ( .A0(n7), .A1(n23), .B0(n6), .B1(n1), .Y(n19) );
  XNOR2X2M U10 ( .A(Prescale[1]), .B(edge_cnt[1]), .Y(n43) );
  BUFX2M U11 ( .A(n26), .Y(n1) );
  NAND4BX1M U12 ( .AN(n27), .B(n28), .C(n29), .D(n30), .Y(n26) );
  AOI2BB1X2M U13 ( .A0N(n39), .A1N(Prescale[5]), .B0(n40), .Y(n29) );
  AOI2B1X1M U14 ( .A1N(n43), .A0(edge_cnt[0]), .B0(Prescale[0]), .Y(n27) );
  XOR3XLM U15 ( .A(edge_cnt[5]), .B(Prescale[5]), .C(n39), .Y(n31) );
  OAI21X2M U16 ( .A0(edge_cnt[0]), .A1(n42), .B0(Prescale[0]), .Y(n28) );
  CLKXOR2X2M U17 ( .A(edge_cnt[1]), .B(Prescale[1]), .Y(n42) );
  OAI2BB2X1M U18 ( .B0(n11), .B1(n1), .A0N(P_DATA[0]), .A1N(n1), .Y(n14) );
  OAI2BB2X1M U19 ( .B0(n5), .B1(n23), .A0N(sampled_bit), .A1N(n23), .Y(n21) );
  CLKXOR2X2M U20 ( .A(n41), .B(edge_cnt[4]), .Y(n40) );
  OAI21X2M U21 ( .A0(n38), .A1(n24), .B0(n39), .Y(n41) );
  AND4X2M U22 ( .A(n31), .B(deser_en), .C(n32), .D(n33), .Y(n30) );
  CLKXOR2X2M U23 ( .A(edge_cnt[3]), .B(n37), .Y(n32) );
  CLKXOR2X2M U24 ( .A(edge_cnt[2]), .B(n34), .Y(n33) );
  NOR2X2M U25 ( .A(n25), .B(Prescale[3]), .Y(n38) );
  NOR2X2M U26 ( .A(n35), .B(Prescale[2]), .Y(n36) );
  AOI21X2M U27 ( .A0(Prescale[2]), .A1(n35), .B0(n36), .Y(n34) );
  AOI21X2M U28 ( .A0(Prescale[3]), .A1(n25), .B0(n38), .Y(n37) );
  INVX2M U29 ( .A(Prescale[4]), .Y(n24) );
  OR2X2M U30 ( .A(Prescale[1]), .B(Prescale[0]), .Y(n35) );
endmodule


module Start_Check_DATA_WIDTH8 ( CLK, RST, strt_chk_en, sampled_bit, 
        strt_glitch );
  input CLK, RST, strt_chk_en, sampled_bit;
  output strt_glitch;
  wire   n1;

  DFFRQX2M strt_glitch_reg ( .D(n1), .CK(CLK), .RN(RST), .Q(strt_glitch) );
  AO2B2X2M U1 ( .B0(strt_chk_en), .B1(sampled_bit), .A0(strt_glitch), .A1N(
        strt_chk_en), .Y(n1) );
endmodule


module Parity_Check_DATA_WIDTH8 ( CLK, RST, par_chk_en, sampled_bit, P_DATA, 
        PAR_TYP, par_err );
  input [7:0] P_DATA;
  input CLK, RST, par_chk_en, sampled_bit, PAR_TYP;
  output par_err;
  wire   n8, n1, n2, n3, n4, n5, n6;

  DFFRQX2M par_err_reg ( .D(n8), .CK(CLK), .RN(RST), .Q(par_err) );
  XOR3XLM U1 ( .A(n4), .B(P_DATA[1]), .C(n5), .Y(n3) );
  XOR3XLM U2 ( .A(P_DATA[6]), .B(P_DATA[5]), .C(n6), .Y(n5) );
  XOR3XLM U3 ( .A(P_DATA[4]), .B(P_DATA[0]), .C(PAR_TYP), .Y(n4) );
  XNOR2X2M U4 ( .A(sampled_bit), .B(P_DATA[7]), .Y(n6) );
  OAI2BB2X1M U5 ( .B0(n2), .B1(n1), .A0N(par_err), .A1N(n1), .Y(n8) );
  INVX2M U6 ( .A(par_chk_en), .Y(n1) );
  XOR3XLM U7 ( .A(P_DATA[3]), .B(P_DATA[2]), .C(n3), .Y(n2) );
endmodule


module Stop_Check_DATA_WIDTH8 ( CLK, RST, sampled_bit, stp_chk_en, stp_err );
  input CLK, RST, sampled_bit, stp_chk_en;
  output stp_err;
  wire   n2, n1;

  DFFRQX2M stp_err_reg ( .D(n2), .CK(CLK), .RN(RST), .Q(stp_err) );
  OAI2BB2X1M U1 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n2)
         );
  INVX2M U2 ( .A(stp_chk_en), .Y(n1) );
endmodule


module UART_RX_DATA_WIDTH8 ( CLK, RST, PAR_EN, PAR_TYP, Prescale, RX_IN, 
        P_DATA, Data_valid, Parity_Error, Stop_Error );
  input [5:0] Prescale;
  output [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, RX_IN;
  output Data_valid, Parity_Error, Stop_Error;
  wire   strt_glitch, enable, dat_samp_en, par_chk_en, strt_chk_en, stp_chk_en,
         deser_en, sampled_bit, n1, n2;
  wire   [5:0] edge_cnt;
  wire   [3:0] bit_cnt;

  FSM_RX_DATA_WIDTH8 u_FSM_RX ( .CLK(CLK), .RST(n1), .PAR_EN(PAR_EN), .RX_IN(
        RX_IN), .edge_cnt(edge_cnt), .bit_cnt(bit_cnt), .Prescale(Prescale), 
        .par_err(Parity_Error), .strt_glitch(strt_glitch), .stp_err(Stop_Error), .enable(enable), .dat_samp_en(dat_samp_en), .par_chk_en(par_chk_en), 
        .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), .deser_en(deser_en), .Data_Valid(Data_valid) );
  edge_bit_counter_DATA_WIDTH8 u_edge_bit_counter ( .CLK(CLK), .RST(n1), 
        .enable(enable), .Prescale(Prescale), .bit_cnt(bit_cnt), .edge_cnt(
        edge_cnt) );
  Data_Sampling_DATA_WIDTH8 u_Data_Sampling ( .CLK(CLK), .RST(n1), .edge_cnt(
        edge_cnt), .RX_IN(RX_IN), .dat_samp_en(dat_samp_en), .Prescale(
        Prescale), .sampled_bit(sampled_bit) );
  deserializer_DATA_WIDTH8 u_deserializer ( .CLK(CLK), .RST(n1), .sampled_bit(
        sampled_bit), .deser_en(deser_en), .Prescale(Prescale), .edge_cnt(
        edge_cnt), .P_DATA(P_DATA) );
  Start_Check_DATA_WIDTH8 u_Start_Check ( .CLK(CLK), .RST(n1), .strt_chk_en(
        strt_chk_en), .sampled_bit(sampled_bit), .strt_glitch(strt_glitch) );
  Parity_Check_DATA_WIDTH8 u_Parity_Check ( .CLK(CLK), .RST(n1), .par_chk_en(
        par_chk_en), .sampled_bit(sampled_bit), .P_DATA(P_DATA), .PAR_TYP(
        PAR_TYP), .par_err(Parity_Error) );
  Stop_Check_DATA_WIDTH8 u_Stop_Check ( .CLK(CLK), .RST(n1), .sampled_bit(
        sampled_bit), .stp_chk_en(stp_chk_en), .stp_err(Stop_Error) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module UART_DATA_WIDTH8 ( RST, TX_CLK, RX_CLK, TX_P_DATA, TX_Data_Valid, 
        TX_OUT, TX_Busy, RX_IN, RX_P_DATA, RX_Data_Valid, Parity_Error, 
        Stop_Error, PAR_EN, PAR_TYP, Prescale );
  input [7:0] TX_P_DATA;
  output [7:0] RX_P_DATA;
  input [5:0] Prescale;
  input RST, TX_CLK, RX_CLK, TX_Data_Valid, RX_IN, PAR_EN, PAR_TYP;
  output TX_OUT, TX_Busy, RX_Data_Valid, Parity_Error, Stop_Error;
  wire   n1, n2;

  UART_TX_WIDTH8 UART_TX_UNIT ( .P_DATA(TX_P_DATA), .Data_Valid(TX_Data_Valid), 
        .PAR_EN(PAR_EN), .PAR_TYP(PAR_TYP), .clk(TX_CLK), .RST(n1), .TX_OUT(
        TX_OUT), .Busy(TX_Busy) );
  UART_RX_DATA_WIDTH8 UART_RX_UNIT ( .CLK(RX_CLK), .RST(n1), .PAR_EN(PAR_EN), 
        .PAR_TYP(PAR_TYP), .Prescale(Prescale), .RX_IN(RX_IN), .P_DATA(
        RX_P_DATA), .Data_valid(RX_Data_Valid), .Parity_Error(Parity_Error), 
        .Stop_Error(Stop_Error) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module PULSE_GEN ( CLK, RST, LVL_SIG, PULSE_SIG );
  input CLK, RST, LVL_SIG;
  output PULSE_SIG;
  wire   LVL_SIG_reg;

  DFFRQX2M LVL_SIG_reg_reg ( .D(LVL_SIG), .CK(CLK), .RN(RST), .Q(LVL_SIG_reg)
         );
  NOR2BX2M U3 ( .AN(LVL_SIG), .B(LVL_SIG_reg), .Y(PULSE_SIG) );
endmodule


module DATA_SYNC_NUM_STAGES2_BUS_WIDTH8 ( CLK, RST, bus_enable, unsync_bus, 
        sync_bus, enable_pulse );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input CLK, RST, bus_enable;
  output enable_pulse;
  wire   pulse_gen_reg, n9, n8, n6, n7, n5, n3, n4, n2, n1, n10;
  wire   [1:0] enable_reg;

  DFFRQX2M pulse_gen_reg_reg ( .D(enable_reg[1]), .CK(CLK), .RN(RST), .Q(
        pulse_gen_reg) );
  DFFRQX2M \sync_bus_reg[7]  ( .D(n9), .CK(CLK), .RN(RST), .Q(sync_bus[7]) );
  DFFRQX2M \enable_reg_reg[1]  ( .D(enable_reg[0]), .CK(CLK), .RN(RST), .Q(
        enable_reg[1]) );
  DFFRQX2M \sync_bus_reg[5]  ( .D(n7), .CK(CLK), .RN(RST), .Q(sync_bus[5]) );
  DFFRQX2M \sync_bus_reg[4]  ( .D(n6), .CK(CLK), .RN(RST), .Q(sync_bus[4]) );
  DFFRQX2M \sync_bus_reg[6]  ( .D(n8), .CK(CLK), .RN(RST), .Q(sync_bus[6]) );
  DFFRQX2M \sync_bus_reg[0]  ( .D(n2), .CK(CLK), .RN(RST), .Q(sync_bus[0]) );
  DFFRQX2M \sync_bus_reg[3]  ( .D(n5), .CK(CLK), .RN(RST), .Q(sync_bus[3]) );
  DFFRQX2M \sync_bus_reg[1]  ( .D(n3), .CK(CLK), .RN(RST), .Q(sync_bus[1]) );
  DFFRQX2M enable_pulse_reg ( .D(n1), .CK(CLK), .RN(RST), .Q(enable_pulse) );
  DFFRQX2M \sync_bus_reg[2]  ( .D(n4), .CK(CLK), .RN(RST), .Q(sync_bus[2]) );
  DFFRQX2M \enable_reg_reg[0]  ( .D(bus_enable), .CK(CLK), .RN(RST), .Q(
        enable_reg[0]) );
  INVX2M U1 ( .A(n10), .Y(n1) );
  NAND2BX2M U2 ( .AN(pulse_gen_reg), .B(enable_reg[1]), .Y(n10) );
  AO22X1M U3 ( .A0(sync_bus[0]), .A1(n10), .B0(unsync_bus[0]), .B1(n1), .Y(n2)
         );
  AO22X1M U4 ( .A0(sync_bus[2]), .A1(n10), .B0(unsync_bus[2]), .B1(n1), .Y(n4)
         );
  AO22X1M U5 ( .A0(sync_bus[1]), .A1(n10), .B0(unsync_bus[1]), .B1(n1), .Y(n3)
         );
  AO22X1M U6 ( .A0(sync_bus[3]), .A1(n10), .B0(unsync_bus[3]), .B1(n1), .Y(n5)
         );
  AO22X1M U7 ( .A0(sync_bus[5]), .A1(n10), .B0(unsync_bus[5]), .B1(n1), .Y(n7)
         );
  AO22X1M U8 ( .A0(sync_bus[4]), .A1(n10), .B0(unsync_bus[4]), .B1(n1), .Y(n6)
         );
  AO22X1M U9 ( .A0(sync_bus[6]), .A1(n10), .B0(unsync_bus[6]), .B1(n1), .Y(n8)
         );
  AO22X1M U10 ( .A0(sync_bus[7]), .A1(n10), .B0(unsync_bus[7]), .B1(n1), .Y(n9) );
endmodule


module sync_r2w_ADDR_SIZE3 ( wclk, wrst_n, rptr, wq2_rptr );
  input [3:0] rptr;
  output [3:0] wq2_rptr;
  input wclk, wrst_n;

  wire   [3:0] wq1_rptr;

  DFFRQX2M \wq2_rptr_reg[2]  ( .D(wq1_rptr[2]), .CK(wclk), .RN(wrst_n), .Q(
        wq2_rptr[2]) );
  DFFRQX2M \wq2_rptr_reg[3]  ( .D(wq1_rptr[3]), .CK(wclk), .RN(wrst_n), .Q(
        wq2_rptr[3]) );
  DFFRQX2M \wq2_rptr_reg[1]  ( .D(wq1_rptr[1]), .CK(wclk), .RN(wrst_n), .Q(
        wq2_rptr[1]) );
  DFFRQX2M \wq2_rptr_reg[0]  ( .D(wq1_rptr[0]), .CK(wclk), .RN(wrst_n), .Q(
        wq2_rptr[0]) );
  DFFRQX2M \wq1_rptr_reg[3]  ( .D(rptr[3]), .CK(wclk), .RN(wrst_n), .Q(
        wq1_rptr[3]) );
  DFFRQX2M \wq1_rptr_reg[2]  ( .D(rptr[2]), .CK(wclk), .RN(wrst_n), .Q(
        wq1_rptr[2]) );
  DFFRQX2M \wq1_rptr_reg[1]  ( .D(rptr[1]), .CK(wclk), .RN(wrst_n), .Q(
        wq1_rptr[1]) );
  DFFRQX2M \wq1_rptr_reg[0]  ( .D(rptr[0]), .CK(wclk), .RN(wrst_n), .Q(
        wq1_rptr[0]) );
endmodule


module sync_w2r_ADDR_SIZE3 ( rclk, rrst_n, wptr, rq2_wptr );
  input [3:0] wptr;
  output [3:0] rq2_wptr;
  input rclk, rrst_n;

  wire   [3:0] rq1_wptr;

  DFFRQX2M \rq2_wptr_reg[3]  ( .D(rq1_wptr[3]), .CK(rclk), .RN(rrst_n), .Q(
        rq2_wptr[3]) );
  DFFRQX2M \rq2_wptr_reg[2]  ( .D(rq1_wptr[2]), .CK(rclk), .RN(rrst_n), .Q(
        rq2_wptr[2]) );
  DFFRQX2M \rq2_wptr_reg[1]  ( .D(rq1_wptr[1]), .CK(rclk), .RN(rrst_n), .Q(
        rq2_wptr[1]) );
  DFFRQX2M \rq2_wptr_reg[0]  ( .D(rq1_wptr[0]), .CK(rclk), .RN(rrst_n), .Q(
        rq2_wptr[0]) );
  DFFRQX2M \rq1_wptr_reg[3]  ( .D(wptr[3]), .CK(rclk), .RN(rrst_n), .Q(
        rq1_wptr[3]) );
  DFFRQX2M \rq1_wptr_reg[2]  ( .D(wptr[2]), .CK(rclk), .RN(rrst_n), .Q(
        rq1_wptr[2]) );
  DFFRQX2M \rq1_wptr_reg[1]  ( .D(wptr[1]), .CK(rclk), .RN(rrst_n), .Q(
        rq1_wptr[1]) );
  DFFRQX2M \rq1_wptr_reg[0]  ( .D(wptr[0]), .CK(rclk), .RN(rrst_n), .Q(
        rq1_wptr[0]) );
endmodule


module FIFO_MEM_DATA_WIDTH8_ADDR_SIZE3 ( wclk, wrst_n, wclken, wfull, waddr, 
        raddr, wdata, rdata );
  input [2:0] waddr;
  input [2:0] raddr;
  input [7:0] wdata;
  output [7:0] rdata;
  input wclk, wrst_n, wclken, wfull;
  wire   n37, \mem[1][7] , n36, \mem[1][6] , n35, \mem[1][5] , n34,
         \mem[1][4] , n33, \mem[1][3] , n32, \mem[1][2] , n31, \mem[1][1] ,
         n30, \mem[1][0] , n29, \mem[0][7] , n28, \mem[0][6] , n27,
         \mem[0][5] , n26, \mem[0][4] , n25, \mem[0][3] , n24, \mem[0][2] ,
         n23, \mem[0][1] , n22, \mem[0][0] , n69, \mem[5][7] , n68,
         \mem[5][6] , n67, \mem[5][5] , n66, \mem[5][4] , n65, \mem[5][3] ,
         n64, \mem[5][2] , n63, \mem[5][1] , n62, \mem[5][0] , n61,
         \mem[4][7] , n60, \mem[4][6] , n59, \mem[4][5] , n58, \mem[4][4] ,
         n57, \mem[4][3] , n56, \mem[4][2] , n55, \mem[4][1] , n54,
         \mem[4][0] , n85, \mem[7][7] , n84, \mem[7][6] , n83, \mem[7][5] ,
         n82, \mem[7][4] , n81, \mem[7][3] , n80, \mem[7][2] , n79,
         \mem[7][1] , n78, \mem[7][0] , n77, \mem[6][7] , n76, \mem[6][6] ,
         n75, \mem[6][5] , n74, \mem[6][4] , n73, \mem[6][3] , n72,
         \mem[6][2] , n71, \mem[6][1] , n70, \mem[6][0] , n53, \mem[3][7] ,
         n52, \mem[3][6] , n51, \mem[3][5] , n50, \mem[3][4] , n49,
         \mem[3][3] , n48, \mem[3][2] , n47, \mem[3][1] , n46, \mem[3][0] ,
         n45, \mem[2][7] , n44, \mem[2][6] , n43, \mem[2][5] , n42,
         \mem[2][4] , n41, \mem[2][3] , n40, \mem[2][2] , n39, \mem[2][1] ,
         n38, \mem[2][0] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n155, n158, n154, n156, n157,
         n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174;

  DFFRQX2M \mem_reg[1][7]  ( .D(n37), .CK(wclk), .RN(n165), .Q(\mem[1][7] ) );
  DFFRQX2M \mem_reg[1][6]  ( .D(n36), .CK(wclk), .RN(n165), .Q(\mem[1][6] ) );
  DFFRQX2M \mem_reg[1][5]  ( .D(n35), .CK(wclk), .RN(n165), .Q(\mem[1][5] ) );
  DFFRQX2M \mem_reg[1][4]  ( .D(n34), .CK(wclk), .RN(n165), .Q(\mem[1][4] ) );
  DFFRQX2M \mem_reg[1][3]  ( .D(n33), .CK(wclk), .RN(n165), .Q(\mem[1][3] ) );
  DFFRQX2M \mem_reg[1][2]  ( .D(n32), .CK(wclk), .RN(n165), .Q(\mem[1][2] ) );
  DFFRQX2M \mem_reg[1][1]  ( .D(n31), .CK(wclk), .RN(n165), .Q(\mem[1][1] ) );
  DFFRQX2M \mem_reg[1][0]  ( .D(n30), .CK(wclk), .RN(n165), .Q(\mem[1][0] ) );
  DFFRQX2M \mem_reg[0][7]  ( .D(n29), .CK(wclk), .RN(n165), .Q(\mem[0][7] ) );
  DFFRQX2M \mem_reg[0][6]  ( .D(n28), .CK(wclk), .RN(n165), .Q(\mem[0][6] ) );
  DFFRQX2M \mem_reg[0][5]  ( .D(n27), .CK(wclk), .RN(n165), .Q(\mem[0][5] ) );
  DFFRQX2M \mem_reg[0][4]  ( .D(n26), .CK(wclk), .RN(n165), .Q(\mem[0][4] ) );
  DFFRQX2M \mem_reg[0][3]  ( .D(n25), .CK(wclk), .RN(n164), .Q(\mem[0][3] ) );
  DFFRQX2M \mem_reg[0][2]  ( .D(n24), .CK(wclk), .RN(n164), .Q(\mem[0][2] ) );
  DFFRQX2M \mem_reg[0][1]  ( .D(n23), .CK(wclk), .RN(n164), .Q(\mem[0][1] ) );
  DFFRQX2M \mem_reg[0][0]  ( .D(n22), .CK(wclk), .RN(n164), .Q(\mem[0][0] ) );
  DFFRQX2M \mem_reg[3][7]  ( .D(n53), .CK(wclk), .RN(n162), .Q(\mem[3][7] ) );
  DFFRQX2M \mem_reg[3][6]  ( .D(n52), .CK(wclk), .RN(n162), .Q(\mem[3][6] ) );
  DFFRQX2M \mem_reg[3][5]  ( .D(n51), .CK(wclk), .RN(n162), .Q(\mem[3][5] ) );
  DFFRQX2M \mem_reg[3][4]  ( .D(n50), .CK(wclk), .RN(n161), .Q(\mem[3][4] ) );
  DFFRQX2M \mem_reg[3][3]  ( .D(n49), .CK(wclk), .RN(n161), .Q(\mem[3][3] ) );
  DFFRQX2M \mem_reg[3][2]  ( .D(n48), .CK(wclk), .RN(n161), .Q(\mem[3][2] ) );
  DFFRQX2M \mem_reg[3][1]  ( .D(n47), .CK(wclk), .RN(n161), .Q(\mem[3][1] ) );
  DFFRQX2M \mem_reg[3][0]  ( .D(n46), .CK(wclk), .RN(n161), .Q(\mem[3][0] ) );
  DFFRQX2M \mem_reg[2][7]  ( .D(n45), .CK(wclk), .RN(n161), .Q(\mem[2][7] ) );
  DFFRQX2M \mem_reg[2][6]  ( .D(n44), .CK(wclk), .RN(n161), .Q(\mem[2][6] ) );
  DFFRQX2M \mem_reg[2][5]  ( .D(n43), .CK(wclk), .RN(n161), .Q(\mem[2][5] ) );
  DFFRQX2M \mem_reg[2][4]  ( .D(n42), .CK(wclk), .RN(n161), .Q(\mem[2][4] ) );
  DFFRQX2M \mem_reg[2][3]  ( .D(n41), .CK(wclk), .RN(n161), .Q(\mem[2][3] ) );
  DFFRQX2M \mem_reg[2][2]  ( .D(n40), .CK(wclk), .RN(n161), .Q(\mem[2][2] ) );
  DFFRQX2M \mem_reg[2][1]  ( .D(n39), .CK(wclk), .RN(n161), .Q(\mem[2][1] ) );
  DFFRQX2M \mem_reg[2][0]  ( .D(n38), .CK(wclk), .RN(n161), .Q(\mem[2][0] ) );
  DFFRQX2M \mem_reg[5][7]  ( .D(n69), .CK(wclk), .RN(n164), .Q(\mem[5][7] ) );
  DFFRQX2M \mem_reg[5][6]  ( .D(n68), .CK(wclk), .RN(n164), .Q(\mem[5][6] ) );
  DFFRQX2M \mem_reg[5][5]  ( .D(n67), .CK(wclk), .RN(n164), .Q(\mem[5][5] ) );
  DFFRQX2M \mem_reg[5][4]  ( .D(n66), .CK(wclk), .RN(n164), .Q(\mem[5][4] ) );
  DFFRQX2M \mem_reg[5][3]  ( .D(n65), .CK(wclk), .RN(n164), .Q(\mem[5][3] ) );
  DFFRQX2M \mem_reg[5][2]  ( .D(n64), .CK(wclk), .RN(n164), .Q(\mem[5][2] ) );
  DFFRQX2M \mem_reg[5][1]  ( .D(n63), .CK(wclk), .RN(n164), .Q(\mem[5][1] ) );
  DFFRQX2M \mem_reg[5][0]  ( .D(n62), .CK(wclk), .RN(n164), .Q(\mem[5][0] ) );
  DFFRQX2M \mem_reg[4][7]  ( .D(n61), .CK(wclk), .RN(n164), .Q(\mem[4][7] ) );
  DFFRQX2M \mem_reg[4][6]  ( .D(n60), .CK(wclk), .RN(n163), .Q(\mem[4][6] ) );
  DFFRQX2M \mem_reg[4][5]  ( .D(n59), .CK(wclk), .RN(n163), .Q(\mem[4][5] ) );
  DFFRQX2M \mem_reg[4][4]  ( .D(n58), .CK(wclk), .RN(n163), .Q(\mem[4][4] ) );
  DFFRQX2M \mem_reg[4][3]  ( .D(n57), .CK(wclk), .RN(n163), .Q(\mem[4][3] ) );
  DFFRQX2M \mem_reg[4][2]  ( .D(n56), .CK(wclk), .RN(n163), .Q(\mem[4][2] ) );
  DFFRQX2M \mem_reg[4][1]  ( .D(n55), .CK(wclk), .RN(n163), .Q(\mem[4][1] ) );
  DFFRQX2M \mem_reg[4][0]  ( .D(n54), .CK(wclk), .RN(n163), .Q(\mem[4][0] ) );
  DFFRQX2M \mem_reg[7][7]  ( .D(n85), .CK(wclk), .RN(n163), .Q(\mem[7][7] ) );
  DFFRQX2M \mem_reg[7][6]  ( .D(n84), .CK(wclk), .RN(n163), .Q(\mem[7][6] ) );
  DFFRQX2M \mem_reg[7][5]  ( .D(n83), .CK(wclk), .RN(n163), .Q(\mem[7][5] ) );
  DFFRQX2M \mem_reg[7][4]  ( .D(n82), .CK(wclk), .RN(n163), .Q(\mem[7][4] ) );
  DFFRQX2M \mem_reg[7][3]  ( .D(n81), .CK(wclk), .RN(n163), .Q(\mem[7][3] ) );
  DFFRQX2M \mem_reg[7][2]  ( .D(n80), .CK(wclk), .RN(n163), .Q(\mem[7][2] ) );
  DFFRQX2M \mem_reg[7][1]  ( .D(n79), .CK(wclk), .RN(n162), .Q(\mem[7][1] ) );
  DFFRQX2M \mem_reg[7][0]  ( .D(n78), .CK(wclk), .RN(n162), .Q(\mem[7][0] ) );
  DFFRQX2M \mem_reg[6][7]  ( .D(n77), .CK(wclk), .RN(n162), .Q(\mem[6][7] ) );
  DFFRQX2M \mem_reg[6][6]  ( .D(n76), .CK(wclk), .RN(n162), .Q(\mem[6][6] ) );
  DFFRQX2M \mem_reg[6][5]  ( .D(n75), .CK(wclk), .RN(n162), .Q(\mem[6][5] ) );
  DFFRQX2M \mem_reg[6][4]  ( .D(n74), .CK(wclk), .RN(n162), .Q(\mem[6][4] ) );
  DFFRQX2M \mem_reg[6][3]  ( .D(n73), .CK(wclk), .RN(n162), .Q(\mem[6][3] ) );
  DFFRQX2M \mem_reg[6][2]  ( .D(n72), .CK(wclk), .RN(n162), .Q(\mem[6][2] ) );
  DFFRQX2M \mem_reg[6][1]  ( .D(n71), .CK(wclk), .RN(n162), .Q(\mem[6][1] ) );
  DFFRQX2M \mem_reg[6][0]  ( .D(n70), .CK(wclk), .RN(n162), .Q(\mem[6][0] ) );
  NAND3X2M U1 ( .A(waddr[1]), .B(n102), .C(n155), .Y(n154) );
  NAND3X2M U2 ( .A(waddr[1]), .B(waddr[0]), .C(n155), .Y(n156) );
  NAND3X2M U3 ( .A(waddr[0]), .B(n101), .C(n155), .Y(n157) );
  BUFX2M U4 ( .A(n159), .Y(n161) );
  BUFX2M U5 ( .A(n159), .Y(n162) );
  BUFX2M U6 ( .A(n159), .Y(n163) );
  BUFX2M U7 ( .A(n160), .Y(n164) );
  BUFX2M U8 ( .A(n160), .Y(n165) );
  INVX2M U9 ( .A(n170), .Y(n100) );
  BUFX2M U10 ( .A(wrst_n), .Y(n159) );
  BUFX2M U11 ( .A(wrst_n), .Y(n160) );
  OAI22X1M U12 ( .A0(n169), .A1(n96), .B0(n112), .B1(n99), .Y(n70) );
  OAI22X1M U13 ( .A0(n169), .A1(n95), .B0(n111), .B1(n99), .Y(n71) );
  OAI22X1M U14 ( .A0(n169), .A1(n94), .B0(n110), .B1(n99), .Y(n72) );
  OAI22X1M U15 ( .A0(n169), .A1(n93), .B0(n109), .B1(n99), .Y(n73) );
  OAI22X1M U16 ( .A0(n169), .A1(n92), .B0(n108), .B1(n99), .Y(n74) );
  OAI22X1M U17 ( .A0(n169), .A1(n91), .B0(n107), .B1(n99), .Y(n75) );
  OAI22X1M U18 ( .A0(n169), .A1(n90), .B0(n106), .B1(n99), .Y(n76) );
  OAI22X1M U19 ( .A0(n169), .A1(n89), .B0(n105), .B1(n99), .Y(n77) );
  OAI22X1M U20 ( .A0(n167), .A1(n16), .B0(n112), .B1(n97), .Y(n54) );
  OAI22X1M U21 ( .A0(n167), .A1(n15), .B0(n111), .B1(n97), .Y(n55) );
  OAI22X1M U22 ( .A0(n167), .A1(n14), .B0(n110), .B1(n97), .Y(n56) );
  OAI22X1M U23 ( .A0(n167), .A1(n13), .B0(n109), .B1(n97), .Y(n57) );
  OAI22X1M U24 ( .A0(n167), .A1(n12), .B0(n108), .B1(n97), .Y(n58) );
  OAI22X1M U25 ( .A0(n167), .A1(n11), .B0(n107), .B1(n97), .Y(n59) );
  OAI22X1M U26 ( .A0(n167), .A1(n10), .B0(n106), .B1(n97), .Y(n60) );
  OAI22X1M U27 ( .A0(n167), .A1(n9), .B0(n105), .B1(n97), .Y(n61) );
  OAI22X1M U28 ( .A0(n168), .A1(n8), .B0(n112), .B1(n98), .Y(n62) );
  OAI22X1M U29 ( .A0(n168), .A1(n7), .B0(n111), .B1(n98), .Y(n63) );
  OAI22X1M U30 ( .A0(n168), .A1(n6), .B0(n110), .B1(n98), .Y(n64) );
  OAI22X1M U31 ( .A0(n168), .A1(n5), .B0(n109), .B1(n98), .Y(n65) );
  OAI22X1M U32 ( .A0(n168), .A1(n4), .B0(n108), .B1(n98), .Y(n66) );
  OAI22X1M U33 ( .A0(n168), .A1(n3), .B0(n107), .B1(n98), .Y(n67) );
  OAI22X1M U34 ( .A0(n168), .A1(n2), .B0(n106), .B1(n98), .Y(n68) );
  OAI22X1M U35 ( .A0(n168), .A1(n1), .B0(n105), .B1(n98), .Y(n69) );
  OAI22X1M U36 ( .A0(n170), .A1(n88), .B0(n100), .B1(n112), .Y(n78) );
  OAI22X1M U37 ( .A0(n170), .A1(n87), .B0(n100), .B1(n111), .Y(n79) );
  OAI22X1M U38 ( .A0(n170), .A1(n86), .B0(n100), .B1(n110), .Y(n80) );
  OAI22X1M U39 ( .A0(n170), .A1(n21), .B0(n100), .B1(n109), .Y(n81) );
  OAI22X1M U40 ( .A0(n170), .A1(n20), .B0(n100), .B1(n108), .Y(n82) );
  OAI22X1M U41 ( .A0(n170), .A1(n19), .B0(n100), .B1(n107), .Y(n83) );
  OAI22X1M U42 ( .A0(n170), .A1(n18), .B0(n100), .B1(n106), .Y(n84) );
  OAI22X1M U43 ( .A0(n170), .A1(n17), .B0(n100), .B1(n105), .Y(n85) );
  INVX2M U44 ( .A(n169), .Y(n99) );
  INVX2M U45 ( .A(n167), .Y(n97) );
  INVX2M U46 ( .A(n168), .Y(n98) );
  BUFX2M U47 ( .A(n158), .Y(n166) );
  NAND3X2M U48 ( .A(n102), .B(n101), .C(n155), .Y(n158) );
  BUFX2M U49 ( .A(n149), .Y(n170) );
  NOR3X2M U50 ( .A(n102), .B(n150), .C(n101), .Y(n149) );
  OAI22X1M U51 ( .A0(n172), .A1(n2), .B0(n174), .B1(n18), .Y(n124) );
  OAI22X1M U52 ( .A0(n172), .A1(n4), .B0(n174), .B1(n20), .Y(n132) );
  OAI22X1M U53 ( .A0(n172), .A1(n3), .B0(n174), .B1(n19), .Y(n128) );
  OAI22X1M U54 ( .A0(n171), .A1(n5), .B0(n173), .B1(n21), .Y(n136) );
  OAI22X1M U55 ( .A0(n171), .A1(n6), .B0(n173), .B1(n86), .Y(n140) );
  OAI22X1M U56 ( .A0(n171), .A1(n7), .B0(n173), .B1(n87), .Y(n144) );
  OAI22X1M U57 ( .A0(n171), .A1(n8), .B0(n173), .B1(n88), .Y(n148) );
  OAI22X1M U58 ( .A0(n172), .A1(n1), .B0(n174), .B1(n17), .Y(n120) );
  BUFX2M U59 ( .A(n118), .Y(n171) );
  BUFX2M U60 ( .A(n118), .Y(n172) );
  BUFX2M U61 ( .A(n119), .Y(n173) );
  BUFX2M U62 ( .A(n119), .Y(n174) );
  NOR3BX2M U63 ( .AN(wclken), .B(waddr[2]), .C(wfull), .Y(n155) );
  NAND3BX2M U64 ( .AN(wfull), .B(waddr[2]), .C(wclken), .Y(n150) );
  OAI2BB2X1M U65 ( .B0(n112), .B1(n154), .A0N(n154), .A1N(\mem[2][0] ), .Y(n38) );
  OAI2BB2X1M U66 ( .B0(n111), .B1(n154), .A0N(n154), .A1N(\mem[2][1] ), .Y(n39) );
  OAI2BB2X1M U67 ( .B0(n110), .B1(n154), .A0N(n154), .A1N(\mem[2][2] ), .Y(n40) );
  OAI2BB2X1M U68 ( .B0(n109), .B1(n154), .A0N(n154), .A1N(\mem[2][3] ), .Y(n41) );
  OAI2BB2X1M U69 ( .B0(n108), .B1(n154), .A0N(n154), .A1N(\mem[2][4] ), .Y(n42) );
  OAI2BB2X1M U70 ( .B0(n107), .B1(n154), .A0N(n154), .A1N(\mem[2][5] ), .Y(n43) );
  OAI2BB2X1M U71 ( .B0(n106), .B1(n154), .A0N(n154), .A1N(\mem[2][6] ), .Y(n44) );
  OAI2BB2X1M U72 ( .B0(n105), .B1(n154), .A0N(n154), .A1N(\mem[2][7] ), .Y(n45) );
  OAI2BB2X1M U73 ( .B0(n112), .B1(n156), .A0N(n156), .A1N(\mem[3][0] ), .Y(n46) );
  OAI2BB2X1M U74 ( .B0(n111), .B1(n156), .A0N(n156), .A1N(\mem[3][1] ), .Y(n47) );
  OAI2BB2X1M U75 ( .B0(n110), .B1(n156), .A0N(n156), .A1N(\mem[3][2] ), .Y(n48) );
  OAI2BB2X1M U76 ( .B0(n109), .B1(n156), .A0N(n156), .A1N(\mem[3][3] ), .Y(n49) );
  OAI2BB2X1M U77 ( .B0(n108), .B1(n156), .A0N(n156), .A1N(\mem[3][4] ), .Y(n50) );
  OAI2BB2X1M U78 ( .B0(n107), .B1(n156), .A0N(n156), .A1N(\mem[3][5] ), .Y(n51) );
  OAI2BB2X1M U79 ( .B0(n106), .B1(n156), .A0N(n156), .A1N(\mem[3][6] ), .Y(n52) );
  OAI2BB2X1M U80 ( .B0(n105), .B1(n156), .A0N(n156), .A1N(\mem[3][7] ), .Y(n53) );
  OAI2BB2X1M U81 ( .B0(n112), .B1(n166), .A0N(n166), .A1N(\mem[0][0] ), .Y(n22) );
  OAI2BB2X1M U82 ( .B0(n111), .B1(n166), .A0N(n166), .A1N(\mem[0][1] ), .Y(n23) );
  OAI2BB2X1M U83 ( .B0(n110), .B1(n166), .A0N(n166), .A1N(\mem[0][2] ), .Y(n24) );
  OAI2BB2X1M U84 ( .B0(n109), .B1(n166), .A0N(n166), .A1N(\mem[0][3] ), .Y(n25) );
  OAI2BB2X1M U85 ( .B0(n108), .B1(n166), .A0N(n166), .A1N(\mem[0][4] ), .Y(n26) );
  OAI2BB2X1M U86 ( .B0(n107), .B1(n166), .A0N(n166), .A1N(\mem[0][5] ), .Y(n27) );
  OAI2BB2X1M U87 ( .B0(n106), .B1(n166), .A0N(n166), .A1N(\mem[0][6] ), .Y(n28) );
  OAI2BB2X1M U88 ( .B0(n105), .B1(n166), .A0N(n166), .A1N(\mem[0][7] ), .Y(n29) );
  OAI2BB2X1M U89 ( .B0(n112), .B1(n157), .A0N(n157), .A1N(\mem[1][0] ), .Y(n30) );
  OAI2BB2X1M U90 ( .B0(n111), .B1(n157), .A0N(n157), .A1N(\mem[1][1] ), .Y(n31) );
  OAI2BB2X1M U91 ( .B0(n110), .B1(n157), .A0N(n157), .A1N(\mem[1][2] ), .Y(n32) );
  OAI2BB2X1M U92 ( .B0(n109), .B1(n157), .A0N(n157), .A1N(\mem[1][3] ), .Y(n33) );
  OAI2BB2X1M U93 ( .B0(n108), .B1(n157), .A0N(n157), .A1N(\mem[1][4] ), .Y(n34) );
  OAI2BB2X1M U94 ( .B0(n107), .B1(n157), .A0N(n157), .A1N(\mem[1][5] ), .Y(n35) );
  OAI2BB2X1M U95 ( .B0(n106), .B1(n157), .A0N(n157), .A1N(\mem[1][6] ), .Y(n36) );
  OAI2BB2X1M U96 ( .B0(n105), .B1(n157), .A0N(n157), .A1N(\mem[1][7] ), .Y(n37) );
  BUFX2M U97 ( .A(n151), .Y(n169) );
  NOR3X2M U98 ( .A(n150), .B(waddr[0]), .C(n101), .Y(n151) );
  BUFX2M U99 ( .A(n152), .Y(n168) );
  NOR3X2M U100 ( .A(n150), .B(waddr[1]), .C(n102), .Y(n152) );
  BUFX2M U101 ( .A(n153), .Y(n167) );
  NOR3X2M U102 ( .A(waddr[0]), .B(waddr[1]), .C(n150), .Y(n153) );
  INVX2M U103 ( .A(wdata[0]), .Y(n112) );
  INVX2M U104 ( .A(wdata[1]), .Y(n111) );
  INVX2M U105 ( .A(wdata[2]), .Y(n110) );
  INVX2M U106 ( .A(wdata[3]), .Y(n109) );
  INVX2M U107 ( .A(wdata[4]), .Y(n108) );
  INVX2M U108 ( .A(wdata[5]), .Y(n107) );
  INVX2M U109 ( .A(wdata[6]), .Y(n106) );
  INVX2M U110 ( .A(wdata[7]), .Y(n105) );
  INVX2M U111 ( .A(waddr[0]), .Y(n102) );
  INVX2M U112 ( .A(waddr[1]), .Y(n101) );
  INVX2M U113 ( .A(\mem[7][6] ), .Y(n18) );
  INVX2M U114 ( .A(\mem[6][6] ), .Y(n90) );
  INVX2M U115 ( .A(\mem[7][4] ), .Y(n20) );
  INVX2M U116 ( .A(\mem[6][4] ), .Y(n92) );
  INVX2M U117 ( .A(\mem[7][5] ), .Y(n19) );
  INVX2M U118 ( .A(\mem[6][5] ), .Y(n91) );
  INVX2M U119 ( .A(\mem[7][3] ), .Y(n21) );
  INVX2M U120 ( .A(\mem[6][3] ), .Y(n93) );
  INVX2M U121 ( .A(\mem[7][2] ), .Y(n86) );
  INVX2M U122 ( .A(\mem[6][2] ), .Y(n94) );
  INVX2M U123 ( .A(\mem[7][1] ), .Y(n87) );
  INVX2M U124 ( .A(\mem[6][1] ), .Y(n95) );
  INVX2M U125 ( .A(\mem[7][0] ), .Y(n88) );
  INVX2M U126 ( .A(\mem[6][0] ), .Y(n96) );
  INVX2M U127 ( .A(\mem[7][7] ), .Y(n17) );
  INVX2M U128 ( .A(\mem[6][7] ), .Y(n89) );
  INVX2M U129 ( .A(\mem[5][6] ), .Y(n2) );
  INVX2M U130 ( .A(\mem[4][6] ), .Y(n10) );
  INVX2M U131 ( .A(\mem[5][4] ), .Y(n4) );
  INVX2M U132 ( .A(\mem[4][4] ), .Y(n12) );
  INVX2M U133 ( .A(\mem[5][5] ), .Y(n3) );
  INVX2M U134 ( .A(\mem[4][5] ), .Y(n11) );
  INVX2M U135 ( .A(\mem[5][3] ), .Y(n5) );
  INVX2M U136 ( .A(\mem[4][3] ), .Y(n13) );
  INVX2M U137 ( .A(\mem[5][2] ), .Y(n6) );
  INVX2M U138 ( .A(\mem[4][2] ), .Y(n14) );
  INVX2M U139 ( .A(\mem[5][1] ), .Y(n7) );
  INVX2M U140 ( .A(\mem[4][1] ), .Y(n15) );
  INVX2M U141 ( .A(\mem[5][0] ), .Y(n8) );
  INVX2M U142 ( .A(\mem[4][0] ), .Y(n16) );
  INVX2M U143 ( .A(\mem[5][7] ), .Y(n1) );
  INVX2M U144 ( .A(\mem[4][7] ), .Y(n9) );
  NOR2X2M U145 ( .A(n103), .B(raddr[2]), .Y(n116) );
  NOR2X2M U146 ( .A(raddr[1]), .B(raddr[2]), .Y(n115) );
  OAI22X1M U147 ( .A0(n121), .A1(n104), .B0(raddr[0]), .B1(n122), .Y(rdata[6])
         );
  AOI221XLM U148 ( .A0(\mem[0][6] ), .A1(n115), .B0(\mem[2][6] ), .B1(n116), 
        .C0(n123), .Y(n122) );
  AOI221XLM U149 ( .A0(\mem[1][6] ), .A1(n115), .B0(\mem[3][6] ), .B1(n116), 
        .C0(n124), .Y(n121) );
  OAI22X1M U150 ( .A0(n172), .A1(n10), .B0(n174), .B1(n90), .Y(n123) );
  OAI22X1M U151 ( .A0(n129), .A1(n104), .B0(raddr[0]), .B1(n130), .Y(rdata[4])
         );
  AOI221XLM U152 ( .A0(\mem[0][4] ), .A1(n115), .B0(\mem[2][4] ), .B1(n116), 
        .C0(n131), .Y(n130) );
  AOI221XLM U153 ( .A0(\mem[1][4] ), .A1(n115), .B0(\mem[3][4] ), .B1(n116), 
        .C0(n132), .Y(n129) );
  OAI22X1M U154 ( .A0(n172), .A1(n12), .B0(n174), .B1(n92), .Y(n131) );
  OAI22X1M U155 ( .A0(n125), .A1(n104), .B0(raddr[0]), .B1(n126), .Y(rdata[5])
         );
  AOI221XLM U156 ( .A0(\mem[0][5] ), .A1(n115), .B0(\mem[2][5] ), .B1(n116), 
        .C0(n127), .Y(n126) );
  AOI221XLM U157 ( .A0(\mem[1][5] ), .A1(n115), .B0(\mem[3][5] ), .B1(n116), 
        .C0(n128), .Y(n125) );
  OAI22X1M U158 ( .A0(n172), .A1(n11), .B0(n174), .B1(n91), .Y(n127) );
  OAI22X1M U159 ( .A0(n133), .A1(n104), .B0(raddr[0]), .B1(n134), .Y(rdata[3])
         );
  AOI221XLM U160 ( .A0(\mem[0][3] ), .A1(n115), .B0(\mem[2][3] ), .B1(n116), 
        .C0(n135), .Y(n134) );
  AOI221XLM U161 ( .A0(\mem[1][3] ), .A1(n115), .B0(\mem[3][3] ), .B1(n116), 
        .C0(n136), .Y(n133) );
  OAI22X1M U162 ( .A0(n171), .A1(n13), .B0(n173), .B1(n93), .Y(n135) );
  OAI22X1M U163 ( .A0(n137), .A1(n104), .B0(raddr[0]), .B1(n138), .Y(rdata[2])
         );
  AOI221XLM U164 ( .A0(\mem[0][2] ), .A1(n115), .B0(\mem[2][2] ), .B1(n116), 
        .C0(n139), .Y(n138) );
  AOI221XLM U165 ( .A0(\mem[1][2] ), .A1(n115), .B0(\mem[3][2] ), .B1(n116), 
        .C0(n140), .Y(n137) );
  OAI22X1M U166 ( .A0(n171), .A1(n14), .B0(n173), .B1(n94), .Y(n139) );
  OAI22X1M U167 ( .A0(n141), .A1(n104), .B0(raddr[0]), .B1(n142), .Y(rdata[1])
         );
  AOI221XLM U168 ( .A0(\mem[0][1] ), .A1(n115), .B0(\mem[2][1] ), .B1(n116), 
        .C0(n143), .Y(n142) );
  AOI221XLM U169 ( .A0(\mem[1][1] ), .A1(n115), .B0(\mem[3][1] ), .B1(n116), 
        .C0(n144), .Y(n141) );
  OAI22X1M U170 ( .A0(n171), .A1(n15), .B0(n173), .B1(n95), .Y(n143) );
  OAI22X1M U171 ( .A0(n145), .A1(n104), .B0(raddr[0]), .B1(n146), .Y(rdata[0])
         );
  AOI221XLM U172 ( .A0(\mem[0][0] ), .A1(n115), .B0(\mem[2][0] ), .B1(n116), 
        .C0(n147), .Y(n146) );
  AOI221XLM U173 ( .A0(\mem[1][0] ), .A1(n115), .B0(\mem[3][0] ), .B1(n116), 
        .C0(n148), .Y(n145) );
  OAI22X1M U174 ( .A0(n171), .A1(n16), .B0(n173), .B1(n96), .Y(n147) );
  OAI22X1M U175 ( .A0(n113), .A1(n104), .B0(raddr[0]), .B1(n114), .Y(rdata[7])
         );
  AOI221XLM U176 ( .A0(\mem[0][7] ), .A1(n115), .B0(\mem[2][7] ), .B1(n116), 
        .C0(n117), .Y(n114) );
  AOI221XLM U177 ( .A0(\mem[1][7] ), .A1(n115), .B0(\mem[3][7] ), .B1(n116), 
        .C0(n120), .Y(n113) );
  OAI22X1M U178 ( .A0(n172), .A1(n9), .B0(n174), .B1(n89), .Y(n117) );
  INVX2M U179 ( .A(raddr[0]), .Y(n104) );
  NAND2X2M U180 ( .A(raddr[2]), .B(n103), .Y(n118) );
  NAND2X2M U181 ( .A(raddr[2]), .B(raddr[1]), .Y(n119) );
  INVX2M U182 ( .A(raddr[1]), .Y(n103) );
endmodule


module FIFO_rptr_empty_ADDR_SIZE3 ( rclk, rrst_n, rinc, rq2_wptr, raddr, rptr, 
        rempty );
  input [3:0] rq2_wptr;
  output [2:0] raddr;
  output [3:0] rptr;
  input rclk, rrst_n, rinc;
  output rempty;
  wire   \rbin[3] , rempty_val, n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [3:0] rbinnext;
  wire   [2:0] rgraynext;

  DFFRQX2M \rbin_reg[3]  ( .D(rbinnext[3]), .CK(rclk), .RN(rrst_n), .Q(
        \rbin[3] ) );
  DFFRQX2M \rbin_reg[1]  ( .D(rbinnext[1]), .CK(rclk), .RN(rrst_n), .Q(
        raddr[1]) );
  DFFRQX2M \rbin_reg[2]  ( .D(rbinnext[2]), .CK(rclk), .RN(rrst_n), .Q(
        raddr[2]) );
  DFFRQX2M \rptr_reg[3]  ( .D(rbinnext[3]), .CK(rclk), .RN(rrst_n), .Q(rptr[3]) );
  DFFRQX2M \rptr_reg[2]  ( .D(rgraynext[2]), .CK(rclk), .RN(rrst_n), .Q(
        rptr[2]) );
  DFFRQX2M \rptr_reg[1]  ( .D(rgraynext[1]), .CK(rclk), .RN(rrst_n), .Q(
        rptr[1]) );
  DFFRQX2M \rptr_reg[0]  ( .D(rgraynext[0]), .CK(rclk), .RN(rrst_n), .Q(
        rptr[0]) );
  DFFRQX2M \rbin_reg[0]  ( .D(rbinnext[0]), .CK(rclk), .RN(rrst_n), .Q(
        raddr[0]) );
  DFFSX1M rempty_reg ( .D(rempty_val), .CK(rclk), .SN(rrst_n), .Q(rempty), 
        .QN(n1) );
  CLKXOR2X2M U1 ( .A(rbinnext[2]), .B(rbinnext[1]), .Y(rgraynext[1]) );
  CLKXOR2X2M U2 ( .A(rbinnext[1]), .B(rbinnext[0]), .Y(rgraynext[0]) );
  CLKXOR2X2M U3 ( .A(rbinnext[3]), .B(rbinnext[2]), .Y(rgraynext[2]) );
  XNOR2X2M U4 ( .A(n8), .B(raddr[1]), .Y(rbinnext[1]) );
  XNOR2X2M U5 ( .A(n9), .B(raddr[0]), .Y(rbinnext[0]) );
  NAND2X2M U6 ( .A(rinc), .B(n1), .Y(n9) );
  NOR2BX2M U7 ( .AN(raddr[1]), .B(n8), .Y(n7) );
  NOR4X1M U8 ( .A(n2), .B(n3), .C(n4), .D(n5), .Y(rempty_val) );
  CLKXOR2X2M U9 ( .A(rq2_wptr[3]), .B(rbinnext[3]), .Y(n3) );
  CLKXOR2X2M U10 ( .A(rq2_wptr[0]), .B(rgraynext[0]), .Y(n4) );
  CLKXOR2X2M U11 ( .A(rq2_wptr[2]), .B(rgraynext[2]), .Y(n2) );
  NAND3X2M U12 ( .A(raddr[0]), .B(n1), .C(rinc), .Y(n8) );
  XNOR2X2M U13 ( .A(n6), .B(\rbin[3] ), .Y(rbinnext[3]) );
  NAND2X2M U14 ( .A(raddr[2]), .B(n7), .Y(n6) );
  CLKXOR2X2M U15 ( .A(n7), .B(raddr[2]), .Y(rbinnext[2]) );
  CLKXOR2X2M U16 ( .A(rq2_wptr[1]), .B(rgraynext[1]), .Y(n5) );
endmodule


module FIFO_wptr_full_ADDR_SIZE3 ( wclk, wrst_n, winc, wq2_rptr, waddr, wptr, 
        wfull );
  input [3:0] wq2_rptr;
  output [2:0] waddr;
  output [3:0] wptr;
  input wclk, wrst_n, winc;
  output wfull;
  wire   \wbin[3] , wfull_val, n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [3:0] wbinnext;
  wire   [2:0] wgraynext;

  DFFRQX2M \wbin_reg[3]  ( .D(wbinnext[3]), .CK(wclk), .RN(wrst_n), .Q(
        \wbin[3] ) );
  DFFRQX2M \wbin_reg[2]  ( .D(wbinnext[2]), .CK(wclk), .RN(wrst_n), .Q(
        waddr[2]) );
  DFFRQX2M wfull_reg ( .D(wfull_val), .CK(wclk), .RN(wrst_n), .Q(wfull) );
  DFFRQX2M \wbin_reg[1]  ( .D(wbinnext[1]), .CK(wclk), .RN(wrst_n), .Q(
        waddr[1]) );
  DFFRQX2M \wbin_reg[0]  ( .D(wbinnext[0]), .CK(wclk), .RN(wrst_n), .Q(
        waddr[0]) );
  DFFRQX2M \wptr_reg[3]  ( .D(wbinnext[3]), .CK(wclk), .RN(wrst_n), .Q(wptr[3]) );
  DFFRQX2M \wptr_reg[2]  ( .D(wgraynext[2]), .CK(wclk), .RN(wrst_n), .Q(
        wptr[2]) );
  DFFRQX2M \wptr_reg[1]  ( .D(wgraynext[1]), .CK(wclk), .RN(wrst_n), .Q(
        wptr[1]) );
  DFFRQX2M \wptr_reg[0]  ( .D(wgraynext[0]), .CK(wclk), .RN(wrst_n), .Q(
        wptr[0]) );
  CLKXOR2X2M U1 ( .A(wbinnext[2]), .B(wbinnext[1]), .Y(wgraynext[1]) );
  CLKXOR2X2M U2 ( .A(wbinnext[1]), .B(wbinnext[0]), .Y(wgraynext[0]) );
  CLKXOR2X2M U3 ( .A(wbinnext[3]), .B(wbinnext[2]), .Y(wgraynext[2]) );
  XNOR2X2M U4 ( .A(n8), .B(waddr[1]), .Y(wbinnext[1]) );
  NOR2BX2M U5 ( .AN(waddr[1]), .B(n8), .Y(n7) );
  NOR4X1M U6 ( .A(n2), .B(n3), .C(n4), .D(n5), .Y(wfull_val) );
  XNOR2X2M U7 ( .A(wbinnext[3]), .B(wq2_rptr[3]), .Y(n3) );
  CLKXOR2X2M U8 ( .A(wq2_rptr[0]), .B(wgraynext[0]), .Y(n4) );
  XNOR2X2M U9 ( .A(wgraynext[2]), .B(wq2_rptr[2]), .Y(n2) );
  NAND3X2M U10 ( .A(waddr[0]), .B(n1), .C(winc), .Y(n8) );
  XNOR2X2M U11 ( .A(n9), .B(waddr[0]), .Y(wbinnext[0]) );
  NAND2X2M U12 ( .A(winc), .B(n1), .Y(n9) );
  CLKXOR2X2M U13 ( .A(n7), .B(waddr[2]), .Y(wbinnext[2]) );
  CLKXOR2X2M U14 ( .A(wq2_rptr[1]), .B(wgraynext[1]), .Y(n5) );
  XNOR2X2M U15 ( .A(n6), .B(\wbin[3] ), .Y(wbinnext[3]) );
  NAND2X2M U16 ( .A(waddr[2]), .B(n7), .Y(n6) );
  INVX2M U17 ( .A(wfull), .Y(n1) );
endmodule


module FIFO_TOP_DATA_WIDTH8_ADDR_SIZE3 ( wclk, wrst_n, winc, wdata, wfull, 
        rclk, rrst_n, rinc, rdata, rempty );
  input [7:0] wdata;
  output [7:0] rdata;
  input wclk, wrst_n, winc, rclk, rrst_n, rinc;
  output wfull, rempty;
  wire   n1, n2;
  wire   [3:0] rptr;
  wire   [3:0] wq2_rptr;
  wire   [3:0] wptr;
  wire   [3:0] rq2_wptr;
  wire   [2:0] waddr;
  wire   [2:0] raddr;

  sync_r2w_ADDR_SIZE3 sync_r2w ( .wclk(wclk), .wrst_n(n1), .rptr(rptr), 
        .wq2_rptr(wq2_rptr) );
  sync_w2r_ADDR_SIZE3 sync_w2r ( .rclk(rclk), .rrst_n(rrst_n), .wptr(wptr), 
        .rq2_wptr(rq2_wptr) );
  FIFO_MEM_DATA_WIDTH8_ADDR_SIZE3 fifomem ( .wclk(wclk), .wrst_n(n1), .wclken(
        winc), .wfull(wfull), .waddr(waddr), .raddr(raddr), .wdata(wdata), 
        .rdata(rdata) );
  FIFO_rptr_empty_ADDR_SIZE3 rptr_empty ( .rclk(rclk), .rrst_n(rrst_n), .rinc(
        rinc), .rq2_wptr(rq2_wptr), .raddr(raddr), .rptr(rptr), .rempty(rempty) );
  FIFO_wptr_full_ADDR_SIZE3 wptr_full ( .wclk(wclk), .wrst_n(n1), .winc(winc), 
        .wq2_rptr(wq2_rptr), .waddr(waddr), .wptr(wptr), .wfull(wfull) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(wrst_n), .Y(n2) );
endmodule


module CLK_GATE ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;
  wire   Latch_Out;

  AND2X2M U2 ( .A(Latch_Out), .B(CLK), .Y(GATED_CLK) );
  TLATNX2M Latch_Out_reg ( .D(CLK_EN), .GN(CLK), .Q(Latch_Out) );
endmodule


module ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW_div_uns_0 ( a, b, quotient, remainder, 
        divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   n6, n7, n8, n11, n14, n15, n16, n17, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95,
         n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n1, n2;

  AOI22X1M U1 ( .A0(n112), .A1(n113), .B0(n114), .B1(n111), .Y(n107) );
  AOI22X1M U2 ( .A0(n142), .A1(n143), .B0(n144), .B1(n141), .Y(n136) );
  OAI2B2X1M U3 ( .A1N(n77), .A0(n75), .B0(b[3]), .B1(n98), .Y(n72) );
  NOR2BX2M U4 ( .AN(n65), .B(b[7]), .Y(quotient[1]) );
  OAI2B2X1M U5 ( .A1N(n91), .A0(n90), .B0(n92), .B1(n16), .Y(quotient[2]) );
  NOR2X2M U6 ( .A(n118), .B(n120), .Y(n133) );
  OAI22X1M U7 ( .A0(n11), .A1(n100), .B0(b[2]), .B1(n121), .Y(n97) );
  AND2X2M U8 ( .A(n100), .B(n11), .Y(n121) );
  INVX2M U9 ( .A(n102), .Y(n11) );
  XNOR2X2M U10 ( .A(n117), .B(n118), .Y(n95) );
  NAND2X2M U11 ( .A(quotient[4]), .B(n119), .Y(n117) );
  XNOR2X2M U12 ( .A(b[2]), .B(n120), .Y(n119) );
  NOR2X2M U13 ( .A(n129), .B(quotient[4]), .Y(n111) );
  XNOR2X2M U14 ( .A(n99), .B(n100), .Y(n75) );
  NAND2X2M U15 ( .A(n101), .B(quotient[3]), .Y(n99) );
  XNOR2X2M U16 ( .A(b[2]), .B(n102), .Y(n101) );
  XNOR2X2M U17 ( .A(n122), .B(n123), .Y(n100) );
  NAND2X2M U18 ( .A(quotient[4]), .B(n124), .Y(n122) );
  XNOR2X2M U19 ( .A(b[1]), .B(n14), .Y(n124) );
  OAI21X2M U20 ( .A0(n8), .A1(n80), .B0(n103), .Y(n77) );
  OAI2BB1X2M U21 ( .A0N(n80), .A1N(n8), .B0(n2), .Y(n103) );
  INVX2M U22 ( .A(n82), .Y(n8) );
  OAI21X2M U23 ( .A0(n6), .A1(n51), .B0(n83), .Y(n46) );
  OAI2BB1X2M U24 ( .A0N(n51), .A1N(n6), .B0(n2), .Y(n83) );
  INVX2M U25 ( .A(n53), .Y(n6) );
  OAI21X2M U26 ( .A0(n107), .A1(n108), .B0(n110), .Y(n85) );
  OAI21X2M U27 ( .A0(n107), .A1(n20), .B0(a[3]), .Y(n110) );
  OAI2BB2X1M U28 ( .B0(b[1]), .B1(n125), .A0N(n105), .A1N(n108), .Y(n102) );
  NOR2X2M U29 ( .A(n108), .B(n105), .Y(n125) );
  INVX2M U30 ( .A(n107), .Y(quotient[3]) );
  NOR2X2M U31 ( .A(n16), .B(b[4]), .Y(n113) );
  CLKXOR2X2M U32 ( .A(n104), .B(n105), .Y(n80) );
  NAND2X2M U33 ( .A(n106), .B(quotient[3]), .Y(n104) );
  XNOR2X2M U34 ( .A(b[1]), .B(n108), .Y(n106) );
  INVX2M U35 ( .A(n126), .Y(quotient[4]) );
  OAI22X1M U36 ( .A0(n123), .A1(n128), .B0(b[1]), .B1(n139), .Y(n120) );
  AND2X2M U37 ( .A(n123), .B(n128), .Y(n139) );
  AND2X2M U38 ( .A(n55), .B(n54), .Y(n56) );
  NAND2X2M U39 ( .A(n141), .B(n136), .Y(n129) );
  NOR2X2M U40 ( .A(n148), .B(quotient[6]), .Y(n141) );
  INVX2M U41 ( .A(n147), .Y(quotient[6]) );
  XNOR2X2M U42 ( .A(n134), .B(n135), .Y(n118) );
  NOR2X2M U43 ( .A(n136), .B(n137), .Y(n135) );
  XNOR2X2M U44 ( .A(n138), .B(b[1]), .Y(n137) );
  INVX2M U45 ( .A(b[1]), .Y(n1) );
  INVX2M U46 ( .A(b[2]), .Y(n2) );
  NAND2X2M U47 ( .A(n111), .B(n107), .Y(n90) );
  NOR2X2M U48 ( .A(n20), .B(a[5]), .Y(n138) );
  INVX2M U49 ( .A(n128), .Y(n14) );
  INVX2M U50 ( .A(n64), .Y(n15) );
  INVX2M U51 ( .A(n21), .Y(quotient[7]) );
  AO21XLM U52 ( .A0(n115), .A1(n112), .B0(n113), .Y(n114) );
  OAI2BB1X2M U53 ( .A0N(n97), .A1N(n95), .B0(n116), .Y(n112) );
  OAI21X2M U54 ( .A0(n95), .A1(n97), .B0(n17), .Y(n116) );
  AOI22X1M U55 ( .A0(a[5]), .A1(n140), .B0(quotient[5]), .B1(n138), .Y(n123)
         );
  NAND2X2M U56 ( .A(quotient[5]), .B(b[0]), .Y(n140) );
  INVX2M U57 ( .A(n136), .Y(quotient[5]) );
  OAI211X2M U58 ( .A0(a[7]), .A1(n20), .B0(n1), .C0(n143), .Y(n21) );
  OAI2B2X1M U59 ( .A1N(n39), .A0(n37), .B0(b[4]), .B1(n73), .Y(n32) );
  NOR2BX2M U60 ( .AN(n37), .B(n39), .Y(n73) );
  OAI21X2M U61 ( .A0(n20), .A1(n147), .B0(a[6]), .Y(n134) );
  NOR2BX2M U62 ( .AN(n145), .B(b[2]), .Y(n143) );
  OAI2BB1X2M U63 ( .A0N(n85), .A1N(n87), .B0(n109), .Y(n82) );
  OAI21X2M U64 ( .A0(n87), .A1(n85), .B0(n1), .Y(n109) );
  OAI2BB1X2M U65 ( .A0N(n58), .A1N(n15), .B0(n88), .Y(n53) );
  OAI21X2M U66 ( .A0(n15), .A1(n58), .B0(n1), .Y(n88) );
  OAI21X2M U67 ( .A0(n14), .A1(n126), .B0(n127), .Y(n105) );
  OAI21X2M U68 ( .A0(n20), .A1(n126), .B0(a[4]), .Y(n127) );
  NAND2X2M U69 ( .A(n113), .B(n130), .Y(n126) );
  OAI21X2M U70 ( .A0(n131), .A1(n129), .B0(n132), .Y(n130) );
  OAI2BB1X2M U71 ( .A0N(n129), .A1N(n131), .B0(n17), .Y(n132) );
  AOI2BB2XLM U72 ( .B0(n120), .B1(n118), .A0N(b[2]), .A1N(n133), .Y(n131) );
  NAND2X2M U73 ( .A(n143), .B(n149), .Y(n147) );
  OAI22X1M U74 ( .A0(n150), .A1(n148), .B0(b[1]), .B1(n150), .Y(n149) );
  NOR2X2M U75 ( .A(n20), .B(a[6]), .Y(n150) );
  NAND2X2M U76 ( .A(a[7]), .B(n21), .Y(n148) );
  NAND2X2M U77 ( .A(b[0]), .B(quotient[1]), .Y(n63) );
  AO21XLM U78 ( .A0(n145), .A1(n142), .B0(n143), .Y(n144) );
  OAI21X2M U79 ( .A0(n138), .A1(n134), .B0(n146), .Y(n142) );
  OAI2BB1X2M U80 ( .A0N(n134), .A1N(n138), .B0(n1), .Y(n146) );
  INVX2M U81 ( .A(n115), .Y(n16) );
  NOR2X2M U82 ( .A(n27), .B(n26), .Y(n28) );
  OA21X2M U83 ( .A0(n60), .A1(n61), .B0(n62), .Y(n54) );
  OAI2BB1X2M U84 ( .A0N(n61), .A1N(n60), .B0(n1), .Y(n62) );
  AOI22X1M U85 ( .A0(a[1]), .A1(n63), .B0(n64), .B1(quotient[1]), .Y(n60) );
  NOR2X2M U86 ( .A(a[0]), .B(n20), .Y(n61) );
  OA21X2M U87 ( .A0(n47), .A1(n48), .B0(n49), .Y(n40) );
  OAI2BB1X2M U88 ( .A0N(n48), .A1N(n47), .B0(n17), .Y(n49) );
  XNOR2X2M U89 ( .A(n50), .B(n51), .Y(n48) );
  OA22X2M U90 ( .A0(n54), .A1(n55), .B0(b[2]), .B1(n56), .Y(n47) );
  AND2X2M U91 ( .A(n41), .B(n40), .Y(n42) );
  XNOR2X2M U92 ( .A(n79), .B(n80), .Y(n44) );
  NAND2X2M U93 ( .A(n81), .B(quotient[2]), .Y(n79) );
  XNOR2X2M U94 ( .A(b[2]), .B(n82), .Y(n81) );
  CLKXOR2X2M U95 ( .A(n57), .B(n58), .Y(n55) );
  NAND2X2M U96 ( .A(quotient[1]), .B(n59), .Y(n57) );
  XNOR2X2M U97 ( .A(b[1]), .B(n15), .Y(n59) );
  NAND2X2M U98 ( .A(quotient[1]), .B(n52), .Y(n50) );
  XNOR2X2M U99 ( .A(b[2]), .B(n53), .Y(n52) );
  INVX2M U100 ( .A(b[0]), .Y(n20) );
  CLKXOR2X2M U101 ( .A(n84), .B(n85), .Y(n51) );
  NAND2X2M U102 ( .A(n86), .B(quotient[2]), .Y(n84) );
  XNOR2X2M U103 ( .A(b[1]), .B(n87), .Y(n86) );
  XNOR2X2M U104 ( .A(n69), .B(n70), .Y(n30) );
  NAND2X2M U105 ( .A(n71), .B(quotient[2]), .Y(n69) );
  XNOR2X2M U106 ( .A(b[4]), .B(n72), .Y(n71) );
  NOR2X2M U107 ( .A(n90), .B(quotient[2]), .Y(n25) );
  NAND2X2M U108 ( .A(quotient[1]), .B(n38), .Y(n36) );
  XNOR2X2M U109 ( .A(b[4]), .B(n39), .Y(n38) );
  NAND2BX2M U110 ( .AN(quotient[1]), .B(n25), .Y(n23) );
  NOR2X2M U111 ( .A(n20), .B(a[4]), .Y(n128) );
  NAND2BX2M U112 ( .AN(a[3]), .B(b[0]), .Y(n108) );
  NOR2X2M U113 ( .A(n20), .B(a[1]), .Y(n64) );
  OAI31X1M U114 ( .A0(b[6]), .A1(b[7]), .A2(n92), .B0(n16), .Y(n91) );
  AOI2BB2XLM U115 ( .B0(n72), .B1(n70), .A0N(b[4]), .A1N(n93), .Y(n92) );
  NOR2X2M U116 ( .A(n70), .B(n72), .Y(n93) );
  OAI2BB2X1M U117 ( .B0(b[6]), .B1(n66), .A0N(n67), .A1N(n25), .Y(n65) );
  NOR2X2M U118 ( .A(n25), .B(n67), .Y(n66) );
  OAI2BB1X2M U119 ( .A0N(n32), .A1N(n30), .B0(n68), .Y(n67) );
  NOR2BX2M U120 ( .AN(n75), .B(n77), .Y(n98) );
  OAI21X2M U121 ( .A0(n22), .A1(n23), .B0(n24), .Y(quotient[0]) );
  AO21XLM U122 ( .A0(n23), .A1(n22), .B0(b[7]), .Y(n24) );
  AOI2BB2XLM U123 ( .B0(n26), .B1(n27), .A0N(b[6]), .A1N(n28), .Y(n22) );
  OAI2B2X1M U124 ( .A1N(n46), .A0(n44), .B0(b[3]), .B1(n78), .Y(n39) );
  NOR2BX2M U125 ( .AN(n44), .B(n46), .Y(n78) );
  NOR3X2M U126 ( .A(b[6]), .B(b[7]), .C(b[5]), .Y(n115) );
  OAI21X2M U127 ( .A0(n7), .A1(n87), .B0(n89), .Y(n58) );
  OAI21X2M U128 ( .A0(n7), .A1(n20), .B0(a[2]), .Y(n89) );
  INVX2M U129 ( .A(quotient[2]), .Y(n7) );
  NOR2BX2M U130 ( .AN(n113), .B(b[3]), .Y(n145) );
  OAI21BX1M U131 ( .A0(n30), .A1(n32), .B0N(b[5]), .Y(n68) );
  OAI22X1M U132 ( .A0(n33), .A1(n34), .B0(b[5]), .B1(n35), .Y(n26) );
  AND2X2M U133 ( .A(n34), .B(n33), .Y(n35) );
  OA22X2M U134 ( .A0(n40), .A1(n41), .B0(b[4]), .B1(n42), .Y(n33) );
  XNOR2X2M U135 ( .A(n36), .B(n37), .Y(n34) );
  XNOR2X2M U136 ( .A(n94), .B(n95), .Y(n70) );
  NAND2X2M U137 ( .A(n96), .B(quotient[3]), .Y(n94) );
  XNOR2X2M U138 ( .A(b[3]), .B(n97), .Y(n96) );
  XNOR2X2M U139 ( .A(n74), .B(n75), .Y(n37) );
  NAND2X2M U140 ( .A(n76), .B(quotient[2]), .Y(n74) );
  XNOR2X2M U141 ( .A(b[3]), .B(n77), .Y(n76) );
  XNOR2X2M U142 ( .A(n43), .B(n44), .Y(n41) );
  NAND2X2M U143 ( .A(quotient[1]), .B(n45), .Y(n43) );
  XNOR2X2M U144 ( .A(b[3]), .B(n46), .Y(n45) );
  XNOR2X2M U145 ( .A(n29), .B(n30), .Y(n27) );
  NAND2X2M U146 ( .A(quotient[1]), .B(n31), .Y(n29) );
  XNOR2X2M U147 ( .A(b[5]), .B(n32), .Y(n31) );
  INVX2M U148 ( .A(b[3]), .Y(n17) );
  NAND2BX2M U149 ( .AN(a[2]), .B(b[0]), .Y(n87) );
endmodule


module ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19;

  OAI2BB2X1M U1 ( .B0(B[4]), .B1(n12), .A0N(n13), .A1N(A[4]), .Y(n11) );
  NOR2X2M U2 ( .A(A[4]), .B(n13), .Y(n12) );
  OAI2BB2X1M U3 ( .B0(B[1]), .B1(n18), .A0N(n19), .A1N(A[1]), .Y(n17) );
  NOR2X2M U4 ( .A(A[1]), .B(n19), .Y(n18) );
  NAND2X2M U5 ( .A(B[0]), .B(n5), .Y(n19) );
  INVX2M U6 ( .A(A[0]), .Y(n5) );
  OAI21X2M U7 ( .A0(n4), .A1(n3), .B0(n16), .Y(n15) );
  AO21XLM U8 ( .A0(n3), .A1(n4), .B0(B[2]), .Y(n16) );
  INVX2M U9 ( .A(n17), .Y(n4) );
  XNOR3X2M U10 ( .A(B[1]), .B(A[1]), .C(n19), .Y(DIFF[1]) );
  XNOR3X2M U11 ( .A(B[4]), .B(A[4]), .C(n13), .Y(DIFF[4]) );
  INVX2M U12 ( .A(A[6]), .Y(n1) );
  OAI21X2M U13 ( .A0(B[0]), .A1(n5), .B0(n19), .Y(DIFF[0]) );
  OAI2BB2X1M U14 ( .B0(B[3]), .B1(n14), .A0N(n15), .A1N(A[3]), .Y(n13) );
  NOR2X2M U15 ( .A(A[3]), .B(n15), .Y(n14) );
  OAI21X2M U16 ( .A0(A[7]), .A1(n6), .B0(n7), .Y(DIFF[8]) );
  OAI2BB1X2M U17 ( .A0N(n6), .A1N(A[7]), .B0(B[7]), .Y(n7) );
  INVX2M U18 ( .A(A[2]), .Y(n3) );
  OAI2BB2X1M U19 ( .B0(B[5]), .B1(n10), .A0N(n11), .A1N(A[5]), .Y(n9) );
  NOR2X2M U20 ( .A(A[5]), .B(n11), .Y(n10) );
  OAI21X2M U21 ( .A0(n2), .A1(n1), .B0(n8), .Y(n6) );
  AO21XLM U22 ( .A0(n1), .A1(n2), .B0(B[6]), .Y(n8) );
  INVX2M U23 ( .A(n9), .Y(n2) );
  XNOR3X2M U24 ( .A(B[5]), .B(A[5]), .C(n11), .Y(DIFF[5]) );
  XOR3XLM U25 ( .A(B[6]), .B(n1), .C(n9), .Y(DIFF[6]) );
  XNOR3X2M U26 ( .A(B[7]), .B(A[7]), .C(n6), .Y(DIFF[7]) );
  XOR3XLM U27 ( .A(B[2]), .B(n3), .C(n17), .Y(DIFF[2]) );
  XNOR3X2M U28 ( .A(B[3]), .B(A[3]), .C(n15), .Y(DIFF[3]) );
endmodule


module ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14;

  OAI2BB1X2M U1 ( .A0N(n13), .A1N(A[1]), .B0(n14), .Y(n11) );
  OAI21X2M U2 ( .A0(n13), .A1(A[1]), .B0(B[1]), .Y(n14) );
  AO22X1M U3 ( .A0(n7), .A1(A[4]), .B0(n8), .B1(B[4]), .Y(n5) );
  OR2X2M U4 ( .A(A[4]), .B(n7), .Y(n8) );
  NOR2X2M U5 ( .A(A[7]), .B(n1), .Y(n2) );
  AND2X2M U6 ( .A(B[0]), .B(A[0]), .Y(n13) );
  XOR3XLM U7 ( .A(B[1]), .B(A[1]), .C(n13), .Y(SUM[1]) );
  XOR3XLM U8 ( .A(B[4]), .B(A[4]), .C(n7), .Y(SUM[4]) );
  CLKXOR2X2M U9 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  AO2B2X2M U10 ( .B0(n1), .B1(A[7]), .A0(B[7]), .A1N(n2), .Y(SUM[8]) );
  XOR3XLM U11 ( .A(B[5]), .B(A[5]), .C(n5), .Y(SUM[5]) );
  XOR3XLM U12 ( .A(B[6]), .B(A[6]), .C(n3), .Y(SUM[6]) );
  OAI2BB1X2M U13 ( .A0N(n5), .A1N(A[5]), .B0(n6), .Y(n3) );
  OAI21X2M U14 ( .A0(A[5]), .A1(n5), .B0(B[5]), .Y(n6) );
  OAI2BB1X2M U15 ( .A0N(n11), .A1N(A[2]), .B0(n12), .Y(n9) );
  OAI21X2M U16 ( .A0(A[2]), .A1(n11), .B0(B[2]), .Y(n12) );
  XOR3XLM U17 ( .A(B[7]), .B(A[7]), .C(n1), .Y(SUM[7]) );
  AO22X1M U18 ( .A0(n3), .A1(A[6]), .B0(n4), .B1(B[6]), .Y(n1) );
  OR2X2M U19 ( .A(A[6]), .B(n3), .Y(n4) );
  AO22X1M U20 ( .A0(n9), .A1(A[3]), .B0(n10), .B1(B[3]), .Y(n7) );
  OR2X2M U21 ( .A(A[3]), .B(n9), .Y(n10) );
  XOR3XLM U22 ( .A(B[2]), .B(A[2]), .C(n11), .Y(SUM[2]) );
  XOR3XLM U23 ( .A(B[3]), .B(A[3]), .C(n9), .Y(SUM[3]) );
endmodule


module ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
;

  OAI21X2M U1 ( .A0(n5), .A1(n2), .B0(n4), .Y(n14) );
  NAND2X2M U2 ( .A(B[8]), .B(A[8]), .Y(n8) );
  NAND2X2M U3 ( .A(B[7]), .B(A[7]), .Y(n6) );
  OA21X2M U4 ( .A0(n16), .A1(n6), .B0(n8), .Y(n2) );
  NOR2X2M U5 ( .A(B[8]), .B(A[8]), .Y(n16) );
  NOR2X2M U6 ( .A(B[9]), .B(A[9]), .Y(n5) );
  NAND2X2M U7 ( .A(B[9]), .B(A[9]), .Y(n4) );
  OAI22X1M U8 ( .A0(A[10]), .A1(n14), .B0(B[10]), .B1(n15), .Y(n12) );
  AND2X2M U9 ( .A(n14), .B(A[10]), .Y(n15) );
  OAI21X2M U10 ( .A0(n12), .A1(n1), .B0(n13), .Y(n10) );
  OAI2BB1X2M U11 ( .A0N(n12), .A1N(n1), .B0(B[11]), .Y(n13) );
  INVX2M U12 ( .A(A[11]), .Y(n1) );
  AOI21X2M U13 ( .A0(A[12]), .A1(n10), .B0(B[12]), .Y(n11) );
  XOR3XLM U14 ( .A(B[12]), .B(A[12]), .C(n10), .Y(SUM[12]) );
  CLKXOR2X2M U15 ( .A(B[13]), .B(n9), .Y(SUM[13]) );
  AOI2BB1X2M U16 ( .A0N(n10), .A1N(A[12]), .B0(n11), .Y(n9) );
  CLKXOR2X2M U17 ( .A(n6), .B(n7), .Y(SUM[8]) );
  OAI21X2M U18 ( .A0(B[8]), .A1(A[8]), .B0(n8), .Y(n7) );
  XNOR2X2M U19 ( .A(n2), .B(n3), .Y(SUM[9]) );
  NOR2BX2M U20 ( .AN(n4), .B(n5), .Y(n3) );
  XOR3XLM U21 ( .A(B[10]), .B(A[10]), .C(n14), .Y(SUM[10]) );
  XOR3XLM U22 ( .A(B[11]), .B(n1), .C(n12), .Y(SUM[11]) );
  CLKXOR2X2M U23 ( .A(B[7]), .B(A[7]), .Y(SUM[7]) );
  BUFX2M U24 ( .A(A[6]), .Y(SUM[6]) );
  BUFX2M U25 ( .A(A[5]), .Y(SUM[5]) );
  BUFX2M U26 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U27 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U28 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U29 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U30 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   n10, n16, n14, n13, n15, n11, n12, \A1[12] , \A1[11] , \A1[10] ,
         \A1[9] , \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n1, n2, n4, n5, n6, n7, n8, n9, n17, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n198, n199, n200, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n214, n3, n18, n170, n197,
         n201, n212, n213, n215;

  ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , 
        \A1[11] , \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , 
        \A1[4] , \A1[3] , \A1[2] , \A1[1] , \A1[0] }), .B({n10, n16, n14, n13, 
        n15, n11, n12, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), 
        .SUM(PRODUCT[15:2]) );
  AOI2BB2XLM U2 ( .B0(n35), .B1(n33), .A0N(n34), .A1N(n86), .Y(n28) );
  AOI2BB2XLM U3 ( .B0(n45), .B1(n46), .A0N(n47), .A1N(n48), .Y(n22) );
  AOI2BB2XLM U4 ( .B0(n41), .B1(n42), .A0N(n43), .A1N(n44), .Y(n26) );
  AOI2BB2XLM U5 ( .B0(n165), .B1(n166), .A0N(n167), .A1N(n168), .Y(n20) );
  NOR2X2M U6 ( .A(n28), .B(n29), .Y(n12) );
  CLKXOR2X2M U7 ( .A(n28), .B(n29), .Y(\A1[6] ) );
  AOI2BB2XLM U8 ( .B0(n67), .B1(n68), .A0N(n69), .A1N(n70), .Y(n30) );
  NOR2X2M U9 ( .A(n68), .B(n67), .Y(n70) );
  NOR2X2M U10 ( .A(n30), .B(n31), .Y(n11) );
  XOR3XLM U11 ( .A(n68), .B(n69), .C(n67), .Y(n29) );
  CLKXOR2X2M U12 ( .A(n23), .B(n22), .Y(\A1[8] ) );
  AOI2BB2XLM U13 ( .B0(n102), .B1(n103), .A0N(n104), .A1N(n105), .Y(n84) );
  NOR2X2M U14 ( .A(n103), .B(n102), .Y(n105) );
  NOR2X2M U15 ( .A(n33), .B(n35), .Y(n86) );
  CLKXOR2X2M U16 ( .A(n30), .B(n31), .Y(\A1[7] ) );
  NOR2X2M U17 ( .A(n22), .B(n23), .Y(n15) );
  XOR3XLM U18 ( .A(n103), .B(n104), .C(n102), .Y(n87) );
  NOR2X2M U19 ( .A(n26), .B(n27), .Y(n13) );
  CLKXOR2X2M U20 ( .A(n26), .B(n27), .Y(\A1[9] ) );
  NAND2X2M U21 ( .A(B[2]), .B(A[3]), .Y(n114) );
  BUFX2M U22 ( .A(n215), .Y(n213) );
  NAND2X2M U23 ( .A(B[4]), .B(A[3]), .Y(n92) );
  XNOR3X2M U24 ( .A(n33), .B(n34), .C(n35), .Y(\SUMB[7][0] ) );
  NAND2X2M U25 ( .A(B[1]), .B(A[3]), .Y(n133) );
  BUFX2M U26 ( .A(n215), .Y(n212) );
  AND2X2M U27 ( .A(A[5]), .B(B[1]), .Y(n103) );
  AND2X2M U28 ( .A(B[2]), .B(A[5]), .Y(n79) );
  NAND2X2M U29 ( .A(B[4]), .B(A[5]), .Y(n56) );
  NOR2X2M U30 ( .A(n46), .B(n45), .Y(n48) );
  OAI22X1M U31 ( .A0(n113), .A1(n114), .B0(n115), .B1(n116), .Y(n101) );
  AND2X2M U32 ( .A(n114), .B(n113), .Y(n116) );
  XNOR3X2M U33 ( .A(n64), .B(n65), .C(n63), .Y(n67) );
  XOR3XLM U34 ( .A(n99), .B(n101), .C(n98), .Y(n102) );
  XOR3XLM U35 ( .A(n42), .B(n41), .C(n44), .Y(n23) );
  XOR3XLM U36 ( .A(n46), .B(n47), .C(n45), .Y(n31) );
  XNOR3X2M U37 ( .A(n82), .B(n84), .C(n83), .Y(n35) );
  XOR3XLM U38 ( .A(n139), .B(n137), .C(n136), .Y(\A1[2] ) );
  XOR3XLM U39 ( .A(n79), .B(n80), .C(n78), .Y(n83) );
  XOR3XLM U40 ( .A(n91), .B(n92), .C(n93), .Y(n76) );
  XOR3XLM U41 ( .A(n71), .B(n72), .C(n73), .Y(n62) );
  AOI2BB2XLM U42 ( .B0(n63), .B1(n64), .A0N(n65), .A1N(n66), .Y(n47) );
  NOR2X2M U43 ( .A(n64), .B(n63), .Y(n66) );
  AOI2BB2XLM U44 ( .B0(n78), .B1(n79), .A0N(n80), .A1N(n81), .Y(n65) );
  NOR2X2M U45 ( .A(n79), .B(n78), .Y(n81) );
  OA22X2M U46 ( .A0(n91), .A1(n93), .B0(n190), .B1(n92), .Y(n72) );
  AND2X2M U47 ( .A(n91), .B(n93), .Y(n190) );
  OA22X2M U48 ( .A0(n82), .A1(n83), .B0(n84), .B1(n85), .Y(n69) );
  AND2X2M U49 ( .A(n82), .B(n83), .Y(n85) );
  AOI21BX2M U50 ( .A0(n98), .A1(n99), .B0N(n100), .Y(n80) );
  OAI21X2M U51 ( .A0(n99), .A1(n98), .B0(n101), .Y(n100) );
  NOR3X2M U52 ( .A(n213), .B(n6), .C(n150), .Y(n143) );
  OAI21X2M U53 ( .A0(n72), .A1(n73), .B0(n186), .Y(n58) );
  OAI2BB1X2M U54 ( .A0N(n73), .A1N(n72), .B0(n71), .Y(n186) );
  NOR2X2M U55 ( .A(n42), .B(n41), .Y(n43) );
  OAI22X1M U56 ( .A0(n132), .A1(n133), .B0(n134), .B1(n135), .Y(n120) );
  AND2X2M U57 ( .A(n133), .B(n132), .Y(n135) );
  OAI22X1M U58 ( .A0(n146), .A1(n147), .B0(n148), .B1(n149), .Y(n139) );
  AND2X2M U59 ( .A(n147), .B(n146), .Y(n149) );
  AOI2BB2XLM U60 ( .B0(n58), .B1(n57), .A0N(n182), .A1N(n56), .Y(n51) );
  NOR2X2M U61 ( .A(n58), .B(n57), .Y(n182) );
  XOR3XLM U62 ( .A(n117), .B(n120), .C(n118), .Y(n121) );
  XOR3XLM U63 ( .A(n38), .B(n39), .C(n40), .Y(n27) );
  XNOR3X2M U64 ( .A(n56), .B(n57), .C(n58), .Y(n55) );
  XOR3XLM U65 ( .A(n134), .B(n133), .C(n132), .Y(n136) );
  XOR3XLM U66 ( .A(n115), .B(n114), .C(n113), .Y(n118) );
  XOR3XLM U67 ( .A(n49), .B(n50), .C(n51), .Y(n44) );
  AOI2BB2XLM U68 ( .B0(n121), .B1(n4), .A0N(n122), .A1N(n123), .Y(n89) );
  NOR2X2M U69 ( .A(n4), .B(n121), .Y(n123) );
  INVX2M U70 ( .A(n124), .Y(n4) );
  OAI2BB2X1M U71 ( .B0(n177), .B1(n38), .A0N(n40), .A1N(n39), .Y(n25) );
  NOR2X2M U72 ( .A(n39), .B(n40), .Y(n177) );
  OA22X2M U73 ( .A0(n87), .A1(n88), .B0(n89), .B1(n90), .Y(n34) );
  AND2X2M U74 ( .A(n88), .B(n87), .Y(n90) );
  CLKXOR2X2M U75 ( .A(n25), .B(n24), .Y(\A1[10] ) );
  OA21X2M U76 ( .A0(n117), .A1(n118), .B0(n119), .Y(n104) );
  OAI2BB1X2M U77 ( .A0N(n117), .A1N(n118), .B0(n120), .Y(n119) );
  OA21X2M U78 ( .A0(n136), .A1(n137), .B0(n138), .Y(n122) );
  OAI2BB1X2M U79 ( .A0N(n137), .A1N(n136), .B0(n139), .Y(n138) );
  OAI22X1M U80 ( .A0(n51), .A1(n50), .B0(n178), .B1(n49), .Y(n40) );
  AND2X2M U81 ( .A(n51), .B(n50), .Y(n178) );
  INVX2M U82 ( .A(B[1]), .Y(n215) );
  NOR3X2M U83 ( .A(n36), .B(n7), .C(n212), .Y(n153) );
  XNOR2X2M U84 ( .A(n150), .B(n214), .Y(n152) );
  NOR2X2M U85 ( .A(n6), .B(n213), .Y(n214) );
  XNOR3X2M U86 ( .A(n89), .B(n88), .C(n87), .Y(\A1[4] ) );
  AND2X2M U87 ( .A(n24), .B(n25), .Y(n14) );
  CLKXOR2X2M U88 ( .A(n20), .B(n21), .Y(\A1[11] ) );
  NOR2X2M U89 ( .A(n212), .B(n1), .Y(n68) );
  NOR2X2M U90 ( .A(n19), .B(n1), .Y(n33) );
  NOR2X2M U91 ( .A(n20), .B(n21), .Y(n16) );
  NOR2X2M U92 ( .A(n7), .B(n19), .Y(PRODUCT[0]) );
  CLKXOR2X2M U93 ( .A(n36), .B(n37), .Y(PRODUCT[1]) );
  NAND2X2M U94 ( .A(B[1]), .B(A[0]), .Y(n37) );
  XNOR3X2M U95 ( .A(n152), .B(n155), .C(n153), .Y(\A1[0] ) );
  XNOR3X2M U96 ( .A(n148), .B(n147), .C(n146), .Y(\A1[1] ) );
  NOR3X2M U97 ( .A(n7), .B(n195), .C(n8), .Y(n193) );
  NOR3X2M U98 ( .A(n17), .B(n6), .C(n125), .Y(n110) );
  NOR3X2M U99 ( .A(n7), .B(n9), .C(n126), .Y(n108) );
  XNOR2X2M U100 ( .A(n207), .B(n208), .Y(n192) );
  NOR2X2M U101 ( .A(n6), .B(n8), .Y(n208) );
  XNOR2X2M U102 ( .A(n126), .B(n127), .Y(n109) );
  NOR2X2M U103 ( .A(n9), .B(n7), .Y(n127) );
  XNOR2X2M U104 ( .A(n195), .B(n196), .Y(n107) );
  NOR2X2M U105 ( .A(n7), .B(n8), .Y(n196) );
  OAI21X2M U106 ( .A0(n94), .A1(n95), .B0(n96), .Y(n74) );
  OAI2BB1X2M U107 ( .A0N(n95), .A1N(n94), .B0(n97), .Y(n96) );
  OAI2BB1X2M U108 ( .A0N(n52), .A1N(n53), .B0(n54), .Y(n41) );
  OAI21X2M U109 ( .A0(n53), .A1(n52), .B0(n55), .Y(n54) );
  XOR3XLM U110 ( .A(n53), .B(n52), .C(n55), .Y(n45) );
  XOR3XLM U111 ( .A(n74), .B(n77), .C(n76), .Y(n78) );
  XOR3XLM U112 ( .A(n60), .B(n59), .C(n62), .Y(n63) );
  OAI21X2M U113 ( .A0(n59), .A1(n60), .B0(n61), .Y(n52) );
  OAI2BB1X2M U114 ( .A0N(n60), .A1N(n59), .B0(n62), .Y(n61) );
  INVX2M U115 ( .A(A[0]), .Y(n7) );
  XOR3XLM U116 ( .A(n112), .B(n109), .C(n110), .Y(n113) );
  AOI2BB2XLM U117 ( .B0(n74), .B1(n5), .A0N(n75), .A1N(n76), .Y(n59) );
  NOR2X2M U118 ( .A(n5), .B(n74), .Y(n75) );
  INVX2M U119 ( .A(n77), .Y(n5) );
  XOR3XLM U120 ( .A(n94), .B(n95), .C(n97), .Y(n98) );
  XOR3XLM U121 ( .A(n191), .B(n192), .C(n193), .Y(n93) );
  XNOR3X2M U122 ( .A(n106), .B(n107), .C(n108), .Y(n97) );
  NOR2X2M U123 ( .A(n32), .B(n1), .Y(n10) );
  NAND2X2M U124 ( .A(B[4]), .B(A[0]), .Y(n125) );
  AOI2BB2XLM U125 ( .B0(n109), .B1(n110), .A0N(n111), .A1N(n112), .Y(n94) );
  NOR2X2M U126 ( .A(n110), .B(n109), .Y(n111) );
  AOI2BB2XLM U127 ( .B0(n107), .B1(n108), .A0N(n194), .A1N(n106), .Y(n91) );
  NOR2X2M U128 ( .A(n108), .B(n107), .Y(n194) );
  NOR3X2M U129 ( .A(n140), .B(n7), .C(n17), .Y(n129) );
  XNOR2X2M U130 ( .A(n140), .B(n151), .Y(n142) );
  NOR2X2M U131 ( .A(n7), .B(n17), .Y(n151) );
  XNOR2X2M U132 ( .A(n125), .B(n141), .Y(n128) );
  NOR2X2M U133 ( .A(n6), .B(n17), .Y(n141) );
  OAI2BB2X1M U134 ( .B0(n198), .B1(n199), .A0N(n200), .A1N(n3), .Y(n173) );
  NAND2X2M U135 ( .A(n199), .B(n198), .Y(n3) );
  OAI2BB2X1M U136 ( .B0(n180), .B1(n179), .A0N(n181), .A1N(n18), .Y(n169) );
  NAND2X2M U137 ( .A(n179), .B(n180), .Y(n18) );
  OAI2BB2X1M U138 ( .B0(n202), .B1(n203), .A0N(n204), .A1N(n170), .Y(n200) );
  NAND2X2M U139 ( .A(n203), .B(n202), .Y(n170) );
  OAI2BB2X1M U140 ( .B0(n184), .B1(n183), .A0N(n185), .A1N(n197), .Y(n181) );
  NAND2X2M U141 ( .A(n183), .B(n184), .Y(n197) );
  OAI22X1M U142 ( .A0(n189), .A1(n188), .B0(n187), .B1(n205), .Y(n185) );
  AND2X2M U143 ( .A(n188), .B(n189), .Y(n205) );
  XOR3XLM U144 ( .A(n183), .B(n184), .C(n185), .Y(n57) );
  XOR3XLM U145 ( .A(n172), .B(n171), .C(n169), .Y(n39) );
  XOR3XLM U146 ( .A(n131), .B(n128), .C(n129), .Y(n132) );
  XOR3XLM U147 ( .A(n209), .B(n210), .C(n211), .Y(n189) );
  XOR3XLM U148 ( .A(n145), .B(n142), .C(n143), .Y(n146) );
  XNOR3X2M U149 ( .A(n202), .B(n203), .C(n204), .Y(n184) );
  XNOR3X2M U150 ( .A(n175), .B(n176), .C(n173), .Y(n171) );
  XNOR3X2M U151 ( .A(n198), .B(n199), .C(n200), .Y(n180) );
  XNOR3X2M U152 ( .A(n179), .B(n180), .C(n181), .Y(n50) );
  XOR3XLM U153 ( .A(n187), .B(n188), .C(n189), .Y(n73) );
  OAI21X2M U154 ( .A0(n209), .A1(n210), .B0(n211), .Y(n204) );
  INVX2M U155 ( .A(A[1]), .Y(n6) );
  NAND2X2M U156 ( .A(B[2]), .B(A[0]), .Y(n150) );
  AOI2BB2XLM U157 ( .B0(n142), .B1(n143), .A0N(n144), .A1N(n145), .Y(n134) );
  NOR2X2M U158 ( .A(n143), .B(n142), .Y(n144) );
  AOI2BB2XLM U159 ( .B0(n128), .B1(n129), .A0N(n130), .A1N(n131), .Y(n115) );
  NOR2X2M U160 ( .A(n129), .B(n128), .Y(n130) );
  AOI2BB2XLM U161 ( .B0(n192), .B1(n193), .A0N(n206), .A1N(n191), .Y(n187) );
  NOR2X2M U162 ( .A(n193), .B(n192), .Y(n206) );
  NAND2X2M U163 ( .A(B[4]), .B(A[1]), .Y(n126) );
  NAND2X2M U164 ( .A(B[2]), .B(A[1]), .Y(n140) );
  OR3X2M U165 ( .A(n207), .B(n8), .C(n6), .Y(n211) );
  OAI2BB2X1M U166 ( .B0(n171), .B1(n172), .A0N(n169), .A1N(n201), .Y(n165) );
  NAND2X2M U167 ( .A(n172), .B(n171), .Y(n201) );
  NAND2X2M U168 ( .A(n168), .B(n167), .Y(n166) );
  XOR3XLM U169 ( .A(n161), .B(n162), .C(n163), .Y(n167) );
  NOR2X2M U170 ( .A(n17), .B(n1), .Y(n42) );
  XOR3XLM U171 ( .A(n168), .B(n167), .C(n165), .Y(n24) );
  XOR3XLM U172 ( .A(n124), .B(n122), .C(n121), .Y(\A1[3] ) );
  AOI2BB2XLM U173 ( .B0(n173), .B1(n174), .A0N(n175), .A1N(n176), .Y(n163) );
  NAND2X2M U174 ( .A(n176), .B(n175), .Y(n174) );
  NAND2X2M U175 ( .A(B[0]), .B(A[1]), .Y(n36) );
  AOI2BB2XLM U176 ( .B0(n152), .B1(n153), .A0N(n154), .A1N(n155), .Y(n148) );
  NOR2X2M U177 ( .A(n153), .B(n152), .Y(n154) );
  NAND2X2M U178 ( .A(B[0]), .B(A[3]), .Y(n147) );
  AND2X2M U179 ( .A(B[2]), .B(A[6]), .Y(n64) );
  NAND2X2M U180 ( .A(B[1]), .B(A[6]), .Y(n82) );
  NAND2X2M U181 ( .A(B[0]), .B(A[4]), .Y(n137) );
  NAND2X2M U182 ( .A(B[1]), .B(A[4]), .Y(n117) );
  AND2X2M U183 ( .A(B[2]), .B(A[4]), .Y(n99) );
  AND2X2M U184 ( .A(B[4]), .B(A[4]), .Y(n71) );
  AOI22X1M U185 ( .A0(n2), .A1(n157), .B0(n158), .B1(n159), .Y(n32) );
  INVX2M U186 ( .A(n160), .Y(n2) );
  NAND2BX2M U187 ( .AN(n157), .B(n160), .Y(n159) );
  OAI22X1M U188 ( .A0(n161), .A1(n162), .B0(n163), .B1(n164), .Y(n158) );
  AND2X2M U189 ( .A(n162), .B(n161), .Y(n164) );
  XOR3XLM U190 ( .A(n160), .B(n157), .C(n158), .Y(n21) );
  INVX2M U191 ( .A(A[7]), .Y(n1) );
  NAND2X2M U192 ( .A(B[0]), .B(A[5]), .Y(n124) );
  NAND2X2M U193 ( .A(B[0]), .B(A[6]), .Y(n88) );
  AND2X2M U194 ( .A(B[2]), .B(A[7]), .Y(n46) );
  INVX2M U195 ( .A(B[0]), .Y(n19) );
  NAND2X2M U196 ( .A(B[4]), .B(A[7]), .Y(n38) );
  NAND2X2M U197 ( .A(B[4]), .B(A[6]), .Y(n49) );
  INVX2M U198 ( .A(B[3]), .Y(n17) );
  INVX2M U199 ( .A(B[6]), .Y(n8) );
  NAND2X2M U200 ( .A(B[7]), .B(A[0]), .Y(n207) );
  NAND2X2M U201 ( .A(A[1]), .B(B[5]), .Y(n195) );
  INVX2M U202 ( .A(B[5]), .Y(n9) );
  NAND2X2M U203 ( .A(B[7]), .B(A[2]), .Y(n203) );
  NAND2X2M U204 ( .A(B[3]), .B(A[4]), .Y(n77) );
  NAND2X2M U205 ( .A(B[3]), .B(A[3]), .Y(n95) );
  NAND2X2M U206 ( .A(B[7]), .B(A[1]), .Y(n210) );
  NAND2X2M U207 ( .A(A[4]), .B(B[5]), .Y(n183) );
  NAND2X2M U208 ( .A(A[3]), .B(B[7]), .Y(n199) );
  NAND2X2M U209 ( .A(A[3]), .B(B[5]), .Y(n188) );
  NAND2X2M U210 ( .A(B[6]), .B(A[2]), .Y(n209) );
  NAND2X2M U211 ( .A(A[3]), .B(B[6]), .Y(n202) );
  NAND2X2M U212 ( .A(A[4]), .B(B[6]), .Y(n198) );
  NAND2X2M U213 ( .A(B[5]), .B(A[2]), .Y(n191) );
  NAND2X2M U214 ( .A(B[3]), .B(A[2]), .Y(n112) );
  NAND2X2M U215 ( .A(B[2]), .B(A[2]), .Y(n131) );
  NAND2X2M U216 ( .A(B[1]), .B(A[2]), .Y(n145) );
  NAND2X2M U217 ( .A(B[4]), .B(A[2]), .Y(n106) );
  NAND2X2M U218 ( .A(A[4]), .B(B[7]), .Y(n176) );
  NAND2X2M U219 ( .A(B[3]), .B(A[5]), .Y(n60) );
  NAND2X2M U220 ( .A(A[5]), .B(B[6]), .Y(n175) );
  NAND2X2M U221 ( .A(A[6]), .B(B[5]), .Y(n172) );
  NAND2X2M U222 ( .A(A[5]), .B(B[5]), .Y(n179) );
  NAND2X2M U223 ( .A(B[0]), .B(A[2]), .Y(n155) );
  AND2X2M U224 ( .A(A[6]), .B(B[3]), .Y(n53) );
  NAND2X2M U225 ( .A(A[7]), .B(B[6]), .Y(n160) );
  NAND2X2M U226 ( .A(A[7]), .B(B[5]), .Y(n168) );
  NAND2X2M U227 ( .A(A[5]), .B(B[7]), .Y(n162) );
  NAND2X2M U228 ( .A(A[6]), .B(B[6]), .Y(n161) );
  AND2X2M U229 ( .A(A[6]), .B(B[7]), .Y(n157) );
  CLKXOR2X2M U230 ( .A(n156), .B(n32), .Y(\A1[12] ) );
  NAND2X2M U231 ( .A(A[7]), .B(B[7]), .Y(n156) );
endmodule


module ALU_OPERAND_WIDTH8_OUT_WIDTH16 ( A, B, EN, ALU_FUN, CLK, RST, ALU_OUT, 
        OUT_VALID );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST;
  output OUT_VALID;
  wire   N132, N131, N130, N129, N128, N127, N126, N125, N108, N107, N106,
         N105, N104, N103, N102, N101, N100, N99, N98, N97, N96, N95, N94, N93,
         N92, N91, N124, N123, N122, N121, N120, N119, N118, N117, N116, N115,
         N114, N113, N112, N111, N110, N109, n1, n2, n3, n5, n6, n7, n9, n10,
         n11, n12, n13, n14, n16, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n138, n4, n8, n15, n17, n18, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151;
  wire   [15:0] ALU_OUT_Comb;

  ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW_div_uns_0 div_58 ( .a({n140, n139, n150, 
        n18, n148, A[2], n17, n15}), .b({B[7:5], n146, B[3], n144, n142, n8}), 
        .quotient({N132, N131, N130, N129, N128, N127, N126, N125}) );
  ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW01_sub_0 sub_52 ( .A({1'b0, n140, n139, 
        n150, n18, n148, A[2], n17, n15}), .B({1'b0, B[7:5], n146, B[3], n144, 
        n142, n4}), .CI(1'b0), .DIFF({N108, N107, N106, N105, N104, N103, N102, 
        N101, N100}) );
  ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW01_add_0 add_49 ( .A({1'b0, n140, n139, 
        n150, n18, n148, A[2], n17, n15}), .B({1'b0, B[7:5], n146, B[3], n144, 
        n142, n8}), .CI(1'b0), .SUM({N99, N98, N97, N96, N95, N94, N93, N92, 
        N91}) );
  ALU_OPERAND_WIDTH8_OUT_WIDTH16_DW02_mult_0 mult_55 ( .A({n140, n139, n150, 
        n18, n148, A[2], n17, n15}), .B({B[7:5], n146, B[3], n144, n142, n4}), 
        .TC(1'b0), .PRODUCT({N124, N123, N122, N121, N120, N119, N118, N117, 
        N116, N115, N114, N113, N112, N111, N110, N109}) );
  DFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_Comb[7]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[7]) );
  DFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_Comb[6]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[6]) );
  DFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_Comb[5]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[5]) );
  DFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_Comb[4]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[4]) );
  DFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_Comb[3]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[3]) );
  DFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_Comb[2]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[2]) );
  DFFRQX2M \ALU_OUT_reg[1]  ( .D(ALU_OUT_Comb[1]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[1]) );
  DFFRQX2M \ALU_OUT_reg[0]  ( .D(ALU_OUT_Comb[0]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[0]) );
  DFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_Comb[15]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[15]) );
  DFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_Comb[14]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[14]) );
  DFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_Comb[13]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[13]) );
  DFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_Comb[12]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[12]) );
  DFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_Comb[11]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[11]) );
  DFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_Comb[10]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[10]) );
  DFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_Comb[9]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[9]) );
  DFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_Comb[8]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[8]) );
  DFFRQX2M OUT_VALID_reg ( .D(EN), .CK(CLK), .RN(RST), .Q(OUT_VALID) );
  OAI31X1M U2 ( .A0(n63), .A1(n24), .A2(n108), .B0(EN), .Y(n34) );
  BUFX2M U3 ( .A(B[0]), .Y(n8) );
  BUFX2M U4 ( .A(A[0]), .Y(n15) );
  BUFX2M U5 ( .A(B[0]), .Y(n4) );
  INVX2M U6 ( .A(n50), .Y(n25) );
  INVX2M U7 ( .A(n63), .Y(n27) );
  INVX2M U8 ( .A(n49), .Y(n24) );
  INVX2M U9 ( .A(n48), .Y(n28) );
  INVX2M U10 ( .A(n141), .Y(n23) );
  OAI22X1M U11 ( .A0(n136), .A1(n29), .B0(n137), .B1(n103), .Y(n63) );
  AOI22X1M U12 ( .A0(n31), .A1(n119), .B0(n26), .B1(n117), .Y(n50) );
  NOR2BX2M U13 ( .AN(n138), .B(n136), .Y(n54) );
  NOR2BX2M U14 ( .AN(n138), .B(n103), .Y(n52) );
  NAND2X2M U15 ( .A(n26), .B(n107), .Y(n49) );
  NAND2X2M U16 ( .A(n117), .B(n119), .Y(n48) );
  BUFX2M U17 ( .A(n53), .Y(n141) );
  NOR2X2M U18 ( .A(n136), .B(n137), .Y(n53) );
  INVX2M U19 ( .A(n137), .Y(n26) );
  INVX2M U20 ( .A(n106), .Y(n22) );
  INVX2M U21 ( .A(n136), .Y(n31) );
  INVX2M U22 ( .A(n119), .Y(n29) );
  AND2X2M U23 ( .A(n117), .B(n138), .Y(n37) );
  INVX2M U24 ( .A(n51), .Y(n21) );
  AO21XLM U25 ( .A0(N113), .A1(n33), .B0(n71), .Y(ALU_OUT_Comb[4]) );
  AOI31X2M U26 ( .A0(n72), .A1(n73), .A2(n74), .B0(n20), .Y(n71) );
  AOI22X1M U27 ( .A0(N130), .A1(n52), .B0(n150), .B1(n141), .Y(n66) );
  NOR2X2M U28 ( .A(n32), .B(ALU_FUN[0]), .Y(n107) );
  NOR2X2M U29 ( .A(ALU_FUN[0]), .B(ALU_FUN[1]), .Y(n117) );
  NOR2X2M U30 ( .A(n30), .B(ALU_FUN[2]), .Y(n119) );
  NAND2X2M U31 ( .A(ALU_FUN[0]), .B(n32), .Y(n136) );
  NAND2X2M U32 ( .A(ALU_FUN[2]), .B(n30), .Y(n137) );
  NOR2X2M U33 ( .A(ALU_FUN[2]), .B(ALU_FUN[3]), .Y(n138) );
  NAND2X2M U34 ( .A(ALU_FUN[0]), .B(ALU_FUN[1]), .Y(n103) );
  NAND3X2M U35 ( .A(ALU_FUN[3]), .B(ALU_FUN[2]), .C(n31), .Y(n106) );
  INVX2M U36 ( .A(ALU_FUN[3]), .Y(n30) );
  INVX2M U37 ( .A(ALU_FUN[1]), .Y(n32) );
  INVX2M U38 ( .A(n83), .Y(n7) );
  XNOR2X2M U39 ( .A(n146), .B(n6), .Y(n75) );
  NAND3X2M U40 ( .A(ALU_FUN[2]), .B(n107), .C(ALU_FUN[3]), .Y(n51) );
  AND3X2M U41 ( .A(n138), .B(n107), .C(EN), .Y(n33) );
  INVX2M U42 ( .A(EN), .Y(n20) );
  AO21XLM U43 ( .A0(N109), .A1(n33), .B0(n109), .Y(ALU_OUT_Comb[0]) );
  AOI31X2M U44 ( .A0(n110), .A1(n111), .A2(n112), .B0(n20), .Y(n109) );
  AOI22X1M U45 ( .A0(N91), .A1(n37), .B0(N100), .B1(n54), .Y(n110) );
  INVX2M U46 ( .A(n147), .Y(n146) );
  INVX2M U47 ( .A(n145), .Y(n144) );
  INVX2M U48 ( .A(n143), .Y(n142) );
  INVX2M U49 ( .A(n151), .Y(n150) );
  AOI222X1M U50 ( .A0(n17), .A1(n141), .B0(n24), .B1(n10), .C0(N126), .C1(n52), 
        .Y(n97) );
  AO21XLM U51 ( .A0(N110), .A1(n33), .B0(n95), .Y(ALU_OUT_Comb[1]) );
  AOI31X2M U52 ( .A0(n96), .A1(n97), .A2(n98), .B0(n20), .Y(n95) );
  INVX2M U53 ( .A(n149), .Y(n148) );
  AO21XLM U54 ( .A0(N111), .A1(n33), .B0(n87), .Y(ALU_OUT_Comb[2]) );
  AOI31X2M U55 ( .A0(n88), .A1(n89), .A2(n90), .B0(n20), .Y(n87) );
  AOI222X1M U56 ( .A0(n148), .A1(n141), .B0(n24), .B1(n149), .C0(N128), .C1(
        n52), .Y(n81) );
  AO21XLM U57 ( .A0(N112), .A1(n33), .B0(n79), .Y(ALU_OUT_Comb[3]) );
  AOI31X2M U58 ( .A0(n80), .A1(n81), .A2(n82), .B0(n20), .Y(n79) );
  AOI222X1M U59 ( .A0(n18), .A1(n141), .B0(n24), .B1(n6), .C0(N129), .C1(n52), 
        .Y(n73) );
  OAI2BB1X2M U60 ( .A0N(N123), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U61 ( .A0N(N124), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[15]) );
  OAI2BB1X2M U62 ( .A0N(N119), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U63 ( .A0N(N120), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U64 ( .A0N(N121), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U65 ( .A0N(N122), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[13]) );
  AO21XLM U66 ( .A0(N114), .A1(n33), .B0(n64), .Y(ALU_OUT_Comb[5]) );
  AOI31X2M U67 ( .A0(n65), .A1(n66), .A2(n67), .B0(n20), .Y(n64) );
  OAI2BB1X2M U68 ( .A0N(N118), .A1N(n33), .B0(n34), .Y(ALU_OUT_Comb[9]) );
  OAI2BB2X1M U69 ( .B0(n38), .B1(n20), .A0N(N116), .A1N(n33), .Y(
        ALU_OUT_Comb[7]) );
  AND4X2M U70 ( .A(n39), .B(n40), .C(n41), .D(n42), .Y(n38) );
  AOI22X1M U71 ( .A0(N132), .A1(n52), .B0(n141), .B1(n140), .Y(n40) );
  AO21XLM U72 ( .A0(N115), .A1(n33), .B0(n55), .Y(ALU_OUT_Comb[6]) );
  AOI31X2M U73 ( .A0(n56), .A1(n57), .A2(n58), .B0(n20), .Y(n55) );
  AOI222X1M U74 ( .A0(n141), .A1(n139), .B0(n24), .B1(n3), .C0(N131), .C1(n52), 
        .Y(n57) );
  OAI31X1M U75 ( .A0(n91), .A1(n134), .A2(n135), .B0(n7), .Y(n133) );
  AOI21X2M U76 ( .A0(n4), .A1(n11), .B0(n10), .Y(n135) );
  AOI31X2M U77 ( .A0(n11), .A1(n10), .A2(n4), .B0(n142), .Y(n134) );
  AOI221XLM U78 ( .A0(n15), .A1(n28), .B0(n63), .B1(n11), .C0(n24), .Y(n115)
         );
  AOI221XLM U79 ( .A0(n28), .A1(n10), .B0(n17), .B1(n25), .C0(n141), .Y(n105)
         );
  AOI221XLM U80 ( .A0(n22), .A1(n150), .B0(n28), .B1(n75), .C0(n76), .Y(n74)
         );
  OAI222X1M U81 ( .A0(n77), .A1(n147), .B0(n146), .B1(n78), .C0(n51), .C1(n149), .Y(n76) );
  AOI21X2M U82 ( .A0(n63), .A1(n6), .B0(n24), .Y(n78) );
  AOI21X2M U83 ( .A0(n18), .A1(n25), .B0(n141), .Y(n77) );
  AOI221XLM U84 ( .A0(n8), .A1(n113), .B0(n17), .B1(n22), .C0(n114), .Y(n112)
         );
  OAI221X1M U85 ( .A0(n50), .A1(n11), .B0(n15), .B1(n48), .C0(n23), .Y(n113)
         );
  OAI211X2M U86 ( .A0(n8), .A1(n115), .B0(n116), .C0(n104), .Y(n114) );
  NAND4BX1M U87 ( .AN(n118), .B(n102), .C(n119), .D(n107), .Y(n116) );
  AOI211X2M U88 ( .A0(n99), .A1(n143), .B0(n100), .C0(n101), .Y(n98) );
  OAI31X1M U89 ( .A0(n29), .A1(n102), .A2(n103), .B0(n104), .Y(n101) );
  OAI221X1M U90 ( .A0(n17), .A1(n27), .B0(n48), .B1(n10), .C0(n49), .Y(n99) );
  OAI222X1M U91 ( .A0(n51), .A1(n11), .B0(n105), .B1(n143), .C0(n106), .C1(n9), 
        .Y(n100) );
  OAI21BX1M U92 ( .A0(n144), .A1(n9), .B0N(n132), .Y(n91) );
  NOR2X2M U93 ( .A(n16), .B(n148), .Y(n83) );
  NAND4X2M U94 ( .A(n117), .B(ALU_FUN[3]), .C(ALU_FUN[2]), .D(n118), .Y(n104)
         );
  OAI21X2M U95 ( .A0(n140), .A1(n27), .B0(n49), .Y(n44) );
  INVX2M U96 ( .A(n15), .Y(n11) );
  INVX2M U97 ( .A(n17), .Y(n10) );
  AOI22X1M U98 ( .A0(N92), .A1(n37), .B0(N101), .B1(n54), .Y(n96) );
  AOI22X1M U99 ( .A0(N95), .A1(n37), .B0(N104), .B1(n54), .Y(n72) );
  AOI22X1M U100 ( .A0(n139), .A1(n21), .B0(n24), .B1(n1), .Y(n41) );
  AOI31X2M U101 ( .A0(n17), .A1(n19), .A2(n15), .B0(n143), .Y(n127) );
  AOI21X2M U102 ( .A0(n15), .A1(n19), .B0(n17), .Y(n128) );
  INVX2M U103 ( .A(n140), .Y(n1) );
  NAND2X2M U104 ( .A(n150), .B(n14), .Y(n124) );
  INVX2M U105 ( .A(n18), .Y(n6) );
  INVX2M U106 ( .A(n59), .Y(n2) );
  INVX2M U107 ( .A(n139), .Y(n3) );
  INVX2M U108 ( .A(n4), .Y(n19) );
  AOI222X1M U109 ( .A0(n15), .A1(n141), .B0(n24), .B1(n11), .C0(N125), .C1(n52), .Y(n111) );
  BUFX2M U110 ( .A(A[7]), .Y(n140) );
  BUFX2M U111 ( .A(A[6]), .Y(n139) );
  INVX2M U112 ( .A(B[2]), .Y(n145) );
  INVX2M U113 ( .A(B[1]), .Y(n143) );
  INVX2M U114 ( .A(B[4]), .Y(n147) );
  INVX2M U115 ( .A(A[5]), .Y(n151) );
  BUFX2M U116 ( .A(A[4]), .Y(n18) );
  AOI222X1M U117 ( .A0(A[2]), .A1(n141), .B0(n24), .B1(n9), .C0(N127), .C1(n52), .Y(n89) );
  INVX2M U118 ( .A(A[3]), .Y(n149) );
  BUFX2M U119 ( .A(A[1]), .Y(n17) );
  OAI211X2M U120 ( .A0(n35), .A1(n20), .B0(n34), .C0(n36), .Y(ALU_OUT_Comb[8])
         );
  AOI22X1M U121 ( .A0(n140), .A1(n21), .B0(N99), .B1(n37), .Y(n35) );
  NAND2X2M U122 ( .A(N117), .B(n33), .Y(n36) );
  AND2X2M U123 ( .A(N108), .B(n54), .Y(n108) );
  AOI221XLM U124 ( .A0(n22), .A1(n140), .B0(n28), .B1(n59), .C0(n60), .Y(n58)
         );
  OAI222X1M U125 ( .A0(n61), .A1(n13), .B0(B[6]), .B1(n62), .C0(n51), .C1(n151), .Y(n60) );
  AOI21X2M U126 ( .A0(n63), .A1(n3), .B0(n24), .Y(n62) );
  AOI21X2M U127 ( .A0(n139), .A1(n25), .B0(n141), .Y(n61) );
  AOI221XLM U128 ( .A0(B[7]), .A1(n43), .B0(n44), .B1(n12), .C0(n45), .Y(n42)
         );
  INVX2M U129 ( .A(B[7]), .Y(n12) );
  AOI2B1X1M U130 ( .A1N(n46), .A0(n47), .B0(n48), .Y(n45) );
  OAI21X2M U131 ( .A0(n50), .A1(n1), .B0(n23), .Y(n43) );
  AOI221XLM U132 ( .A0(n148), .A1(n22), .B0(n28), .B1(n91), .C0(n92), .Y(n90)
         );
  OAI222X1M U133 ( .A0(n93), .A1(n145), .B0(n144), .B1(n94), .C0(n51), .C1(n10), .Y(n92) );
  AOI21X2M U134 ( .A0(n63), .A1(n9), .B0(n24), .Y(n94) );
  AOI21X2M U135 ( .A0(A[2]), .A1(n25), .B0(n141), .Y(n93) );
  AOI221XLM U136 ( .A0(n22), .A1(n139), .B0(n24), .B1(n151), .C0(n68), .Y(n67)
         );
  OAI222X1M U137 ( .A0(n69), .A1(n14), .B0(B[5]), .B1(n70), .C0(n51), .C1(n6), 
        .Y(n68) );
  AOI221XLM U138 ( .A0(n150), .A1(n28), .B0(n63), .B1(n151), .C0(n24), .Y(n70)
         );
  AOI221XLM U139 ( .A0(n28), .A1(n151), .B0(n150), .B1(n25), .C0(n141), .Y(n69) );
  AOI22X1M U140 ( .A0(N96), .A1(n37), .B0(N105), .B1(n54), .Y(n65) );
  AOI22X1M U141 ( .A0(N97), .A1(n37), .B0(N106), .B1(n54), .Y(n56) );
  OAI211X2M U142 ( .A0(n125), .A1(n126), .B0(n7), .C0(n5), .Y(n123) );
  INVX2M U143 ( .A(n75), .Y(n5) );
  NOR2X2M U144 ( .A(B[3]), .B(n149), .Y(n125) );
  OAI32X1M U145 ( .A0(n91), .A1(n127), .A2(n128), .B0(n144), .B1(n9), .Y(n126)
         );
  OAI21X2M U146 ( .A0(n46), .A1(n129), .B0(n47), .Y(n118) );
  AOI32X1M U147 ( .A0(n130), .A1(n124), .A2(n2), .B0(B[6]), .B1(n3), .Y(n129)
         );
  OAI222X1M U148 ( .A0(n18), .A1(n147), .B0(n75), .B1(n131), .C0(n150), .C1(
        n14), .Y(n130) );
  OAI22X1M U149 ( .A0(B[3]), .A1(n149), .B0(n132), .B1(n133), .Y(n131) );
  INVX2M U150 ( .A(A[2]), .Y(n9) );
  AOI2B1X1M U151 ( .A1N(n120), .A0(n47), .B0(n46), .Y(n102) );
  AOI32X1M U152 ( .A0(n121), .A1(n122), .A2(n2), .B0(n139), .B1(n13), .Y(n120)
         );
  NAND2X2M U153 ( .A(B[5]), .B(n151), .Y(n121) );
  OAI211X2M U154 ( .A0(n146), .A1(n6), .B0(n123), .C0(n124), .Y(n122) );
  INVX2M U155 ( .A(B[3]), .Y(n16) );
  NOR2X2M U156 ( .A(n145), .B(A[2]), .Y(n132) );
  AOI22X1M U157 ( .A0(N98), .A1(n37), .B0(N107), .B1(n54), .Y(n39) );
  AOI221XLM U158 ( .A0(n18), .A1(n22), .B0(n83), .B1(n28), .C0(n84), .Y(n82)
         );
  OAI222X1M U159 ( .A0(B[3]), .A1(n85), .B0(n86), .B1(n16), .C0(n51), .C1(n9), 
        .Y(n84) );
  AOI221XLM U160 ( .A0(n148), .A1(n28), .B0(n63), .B1(n149), .C0(n24), .Y(n85)
         );
  AOI21X2M U161 ( .A0(n148), .A1(n25), .B0(n141), .Y(n86) );
  XNOR2X2M U162 ( .A(B[6]), .B(n3), .Y(n59) );
  AOI22X1M U163 ( .A0(N93), .A1(n37), .B0(N102), .B1(n54), .Y(n88) );
  AOI22X1M U164 ( .A0(N94), .A1(n37), .B0(N103), .B1(n54), .Y(n80) );
  NAND2X2M U165 ( .A(B[7]), .B(n1), .Y(n47) );
  NOR2X2M U166 ( .A(n1), .B(B[7]), .Y(n46) );
  INVX2M U167 ( .A(B[5]), .Y(n14) );
  INVX2M U168 ( .A(B[6]), .Y(n13) );
endmodule


module Register_File_DEPTH16_DATA_WIDTH8_ADDRESS_WIDTH4 ( WrData, Address, 
        WrEn, RdEn, CLK, RST, RdData, RdData_Valid, REG0, REG1, REG2, REG3 );
  input [7:0] WrData;
  input [3:0] Address;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input WrEn, RdEn, CLK, RST;
  output RdData_Valid;
  wire   n136, \regfile[5][7] , n135, \regfile[5][6] , n134, \regfile[5][5] ,
         n133, \regfile[5][4] , n132, \regfile[5][3] , n131, \regfile[5][2] ,
         n130, \regfile[5][1] , n129, \regfile[5][0] , n120, \regfile[7][7] ,
         n119, \regfile[7][6] , n118, \regfile[7][5] , n117, \regfile[7][4] ,
         n116, \regfile[7][3] , n115, \regfile[7][2] , n114, \regfile[7][1] ,
         n113, \regfile[7][0] , n104, \regfile[9][7] , n103, \regfile[9][6] ,
         n102, \regfile[9][5] , n101, \regfile[9][4] , n100, \regfile[9][3] ,
         n99, \regfile[9][2] , n98, \regfile[9][1] , n97, \regfile[9][0] , n88,
         \regfile[11][7] , n87, \regfile[11][6] , n86, \regfile[11][5] , n85,
         \regfile[11][4] , n84, \regfile[11][3] , n83, \regfile[11][2] , n82,
         \regfile[11][1] , n81, \regfile[11][0] , n72, \regfile[13][7] , n71,
         \regfile[13][6] , n70, \regfile[13][5] , n69, \regfile[13][4] , n68,
         \regfile[13][3] , n67, \regfile[13][2] , n66, \regfile[13][1] , n65,
         \regfile[13][0] , n56, \regfile[15][7] , n55, \regfile[15][6] , n54,
         \regfile[15][5] , n53, \regfile[15][4] , n52, \regfile[15][3] , n51,
         \regfile[15][2] , n50, \regfile[15][1] , n49, \regfile[15][0] , n144,
         \regfile[4][7] , n143, \regfile[4][6] , n142, \regfile[4][5] , n141,
         \regfile[4][4] , n140, \regfile[4][3] , n139, \regfile[4][2] , n138,
         \regfile[4][1] , n137, \regfile[4][0] , n128, \regfile[6][7] , n127,
         \regfile[6][6] , n126, \regfile[6][5] , n125, \regfile[6][4] , n124,
         \regfile[6][3] , n123, \regfile[6][2] , n122, \regfile[6][1] , n121,
         \regfile[6][0] , n112, \regfile[8][7] , n111, \regfile[8][6] , n110,
         \regfile[8][5] , n109, \regfile[8][4] , n108, \regfile[8][3] , n107,
         \regfile[8][2] , n106, \regfile[8][1] , n105, \regfile[8][0] , n96,
         \regfile[10][7] , n95, \regfile[10][6] , n94, \regfile[10][5] , n93,
         \regfile[10][4] , n92, \regfile[10][3] , n91, \regfile[10][2] , n90,
         \regfile[10][1] , n89, \regfile[10][0] , n80, \regfile[12][7] , n79,
         \regfile[12][6] , n78, \regfile[12][5] , n77, \regfile[12][4] , n76,
         \regfile[12][3] , n75, \regfile[12][2] , n74, \regfile[12][1] , n73,
         \regfile[12][0] , n64, \regfile[14][7] , n63, \regfile[14][6] , n62,
         \regfile[14][5] , n61, \regfile[14][4] , n60, \regfile[14][3] , n59,
         \regfile[14][2] , n58, \regfile[14][1] , n57, \regfile[14][0] , n48,
         n47, n46, n45, n44, n43, n42, n41, n154, n150, n153, n149, n147, n148,
         n152, n151, n157, n145, n146, n160, n156, n159, n158, n155, n177,
         n170, n169, n171, n172, n173, n174, n176, n175, n167, n162, n166,
         n165, n168, n164, n163, n161, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n247, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268,
         n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279,
         n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290,
         n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301,
         n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312,
         n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323,
         n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n334,
         n335, n245, n246, n248, n249, n336, n337, n338, n339, n340, n341,
         n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352,
         n353, n354, n355, n356, n357, n358;

  DFFRQX2M \regfile_reg[5][7]  ( .D(n136), .CK(CLK), .RN(n344), .Q(
        \regfile[5][7] ) );
  DFFRQX2M \regfile_reg[5][6]  ( .D(n135), .CK(CLK), .RN(n336), .Q(
        \regfile[5][6] ) );
  DFFRQX2M \regfile_reg[5][5]  ( .D(n134), .CK(CLK), .RN(n340), .Q(
        \regfile[5][5] ) );
  DFFRQX2M \regfile_reg[5][4]  ( .D(n133), .CK(CLK), .RN(n337), .Q(
        \regfile[5][4] ) );
  DFFRQX2M \regfile_reg[5][3]  ( .D(n132), .CK(CLK), .RN(n337), .Q(
        \regfile[5][3] ) );
  DFFRQX2M \regfile_reg[5][2]  ( .D(n131), .CK(CLK), .RN(n337), .Q(
        \regfile[5][2] ) );
  DFFRQX2M \regfile_reg[5][1]  ( .D(n130), .CK(CLK), .RN(n337), .Q(
        \regfile[5][1] ) );
  DFFRQX2M \regfile_reg[5][0]  ( .D(n129), .CK(CLK), .RN(n337), .Q(
        \regfile[5][0] ) );
  DFFRQX2M \regfile_reg[4][7]  ( .D(n144), .CK(CLK), .RN(n340), .Q(
        \regfile[4][7] ) );
  DFFRQX2M \regfile_reg[4][6]  ( .D(n143), .CK(CLK), .RN(n340), .Q(
        \regfile[4][6] ) );
  DFFRQX2M \regfile_reg[4][5]  ( .D(n142), .CK(CLK), .RN(n340), .Q(
        \regfile[4][5] ) );
  DFFRQX2M \regfile_reg[4][4]  ( .D(n141), .CK(CLK), .RN(n340), .Q(
        \regfile[4][4] ) );
  DFFRQX2M \regfile_reg[4][3]  ( .D(n140), .CK(CLK), .RN(n340), .Q(
        \regfile[4][3] ) );
  DFFRQX2M \regfile_reg[4][2]  ( .D(n139), .CK(CLK), .RN(n339), .Q(
        \regfile[4][2] ) );
  DFFRQX2M \regfile_reg[4][1]  ( .D(n138), .CK(CLK), .RN(n339), .Q(
        \regfile[4][1] ) );
  DFFRQX2M \regfile_reg[4][0]  ( .D(n137), .CK(CLK), .RN(n339), .Q(
        \regfile[4][0] ) );
  DFFRQX2M \RdData_reg[7]  ( .D(n48), .CK(CLK), .RN(n343), .Q(RdData[7]) );
  DFFRQX2M \RdData_reg[6]  ( .D(n47), .CK(CLK), .RN(n343), .Q(RdData[6]) );
  DFFRQX2M \RdData_reg[5]  ( .D(n46), .CK(CLK), .RN(n342), .Q(RdData[5]) );
  DFFRQX2M \RdData_reg[4]  ( .D(n45), .CK(CLK), .RN(n342), .Q(RdData[4]) );
  DFFRQX2M \RdData_reg[3]  ( .D(n44), .CK(CLK), .RN(n342), .Q(RdData[3]) );
  DFFRQX2M \RdData_reg[2]  ( .D(n43), .CK(CLK), .RN(n342), .Q(RdData[2]) );
  DFFRQX2M \RdData_reg[1]  ( .D(n42), .CK(CLK), .RN(n342), .Q(RdData[1]) );
  DFFRQX2M \RdData_reg[0]  ( .D(n41), .CK(CLK), .RN(n342), .Q(RdData[0]) );
  DFFRQX2M \regfile_reg[7][7]  ( .D(n120), .CK(CLK), .RN(n336), .Q(
        \regfile[7][7] ) );
  DFFRQX2M \regfile_reg[7][6]  ( .D(n119), .CK(CLK), .RN(n336), .Q(
        \regfile[7][6] ) );
  DFFRQX2M \regfile_reg[7][5]  ( .D(n118), .CK(CLK), .RN(n336), .Q(
        \regfile[7][5] ) );
  DFFRQX2M \regfile_reg[7][4]  ( .D(n117), .CK(CLK), .RN(n336), .Q(
        \regfile[7][4] ) );
  DFFRQX2M \regfile_reg[7][3]  ( .D(n116), .CK(CLK), .RN(n336), .Q(
        \regfile[7][3] ) );
  DFFRQX2M \regfile_reg[7][2]  ( .D(n115), .CK(CLK), .RN(n336), .Q(
        \regfile[7][2] ) );
  DFFRQX2M \regfile_reg[7][1]  ( .D(n114), .CK(CLK), .RN(n336), .Q(
        \regfile[7][1] ) );
  DFFRQX2M \regfile_reg[7][0]  ( .D(n113), .CK(CLK), .RN(n336), .Q(
        \regfile[7][0] ) );
  DFFRQX2M \regfile_reg[6][7]  ( .D(n128), .CK(CLK), .RN(n339), .Q(
        \regfile[6][7] ) );
  DFFRQX2M \regfile_reg[6][6]  ( .D(n127), .CK(CLK), .RN(n339), .Q(
        \regfile[6][6] ) );
  DFFRQX2M \regfile_reg[6][5]  ( .D(n126), .CK(CLK), .RN(n339), .Q(
        \regfile[6][5] ) );
  DFFRQX2M \regfile_reg[6][4]  ( .D(n125), .CK(CLK), .RN(n339), .Q(
        \regfile[6][4] ) );
  DFFRQX2M \regfile_reg[6][3]  ( .D(n124), .CK(CLK), .RN(n339), .Q(
        \regfile[6][3] ) );
  DFFRQX2M \regfile_reg[6][2]  ( .D(n123), .CK(CLK), .RN(n339), .Q(
        \regfile[6][2] ) );
  DFFRQX2M \regfile_reg[6][1]  ( .D(n122), .CK(CLK), .RN(n339), .Q(
        \regfile[6][1] ) );
  DFFRQX2M \regfile_reg[6][0]  ( .D(n121), .CK(CLK), .RN(n341), .Q(
        \regfile[6][0] ) );
  DFFRQX2M \regfile_reg[9][7]  ( .D(n104), .CK(CLK), .RN(n336), .Q(
        \regfile[9][7] ) );
  DFFRQX2M \regfile_reg[9][6]  ( .D(n103), .CK(CLK), .RN(n336), .Q(
        \regfile[9][6] ) );
  DFFRQX2M \regfile_reg[9][5]  ( .D(n102), .CK(CLK), .RN(n338), .Q(
        \regfile[9][5] ) );
  DFFRQX2M \regfile_reg[9][4]  ( .D(n101), .CK(CLK), .RN(n338), .Q(
        \regfile[9][4] ) );
  DFFRQX2M \regfile_reg[9][3]  ( .D(n100), .CK(CLK), .RN(n338), .Q(
        \regfile[9][3] ) );
  DFFRQX2M \regfile_reg[9][2]  ( .D(n99), .CK(CLK), .RN(n338), .Q(
        \regfile[9][2] ) );
  DFFRQX2M \regfile_reg[9][1]  ( .D(n98), .CK(CLK), .RN(n338), .Q(
        \regfile[9][1] ) );
  DFFRQX2M \regfile_reg[9][0]  ( .D(n97), .CK(CLK), .RN(n337), .Q(
        \regfile[9][0] ) );
  DFFRQX2M \regfile_reg[11][7]  ( .D(n88), .CK(CLK), .RN(n337), .Q(
        \regfile[11][7] ) );
  DFFRQX2M \regfile_reg[11][6]  ( .D(n87), .CK(CLK), .RN(n337), .Q(
        \regfile[11][6] ) );
  DFFRQX2M \regfile_reg[11][5]  ( .D(n86), .CK(CLK), .RN(n337), .Q(
        \regfile[11][5] ) );
  DFFRQX2M \regfile_reg[11][4]  ( .D(n85), .CK(CLK), .RN(n337), .Q(
        \regfile[11][4] ) );
  DFFRQX2M \regfile_reg[11][3]  ( .D(n84), .CK(CLK), .RN(n337), .Q(
        \regfile[11][3] ) );
  DFFRQX2M \regfile_reg[11][2]  ( .D(n83), .CK(CLK), .RN(n337), .Q(
        \regfile[11][2] ) );
  DFFRQX2M \regfile_reg[11][1]  ( .D(n82), .CK(CLK), .RN(n337), .Q(
        \regfile[11][1] ) );
  DFFRQX2M \regfile_reg[11][0]  ( .D(n81), .CK(CLK), .RN(n337), .Q(
        \regfile[11][0] ) );
  DFFRQX2M \regfile_reg[13][7]  ( .D(n72), .CK(CLK), .RN(n337), .Q(
        \regfile[13][7] ) );
  DFFRQX2M \regfile_reg[13][6]  ( .D(n71), .CK(CLK), .RN(n339), .Q(
        \regfile[13][6] ) );
  DFFRQX2M \regfile_reg[13][5]  ( .D(n70), .CK(CLK), .RN(n339), .Q(
        \regfile[13][5] ) );
  DFFRQX2M \regfile_reg[13][4]  ( .D(n69), .CK(CLK), .RN(n339), .Q(
        \regfile[13][4] ) );
  DFFRQX2M \regfile_reg[13][3]  ( .D(n68), .CK(CLK), .RN(n339), .Q(
        \regfile[13][3] ) );
  DFFRQX2M \regfile_reg[13][2]  ( .D(n67), .CK(CLK), .RN(n339), .Q(
        \regfile[13][2] ) );
  DFFRQX2M \regfile_reg[13][1]  ( .D(n66), .CK(CLK), .RN(n338), .Q(
        \regfile[13][1] ) );
  DFFRQX2M \regfile_reg[13][0]  ( .D(n65), .CK(CLK), .RN(n338), .Q(
        \regfile[13][0] ) );
  DFFRQX2M \regfile_reg[15][7]  ( .D(n56), .CK(CLK), .RN(n338), .Q(
        \regfile[15][7] ) );
  DFFRQX2M \regfile_reg[15][6]  ( .D(n55), .CK(CLK), .RN(n338), .Q(
        \regfile[15][6] ) );
  DFFRQX2M \regfile_reg[15][5]  ( .D(n54), .CK(CLK), .RN(n338), .Q(
        \regfile[15][5] ) );
  DFFRQX2M \regfile_reg[15][4]  ( .D(n53), .CK(CLK), .RN(n338), .Q(
        \regfile[15][4] ) );
  DFFRQX2M \regfile_reg[15][3]  ( .D(n52), .CK(CLK), .RN(n338), .Q(
        \regfile[15][3] ) );
  DFFRQX2M \regfile_reg[15][2]  ( .D(n51), .CK(CLK), .RN(n338), .Q(
        \regfile[15][2] ) );
  DFFRQX2M \regfile_reg[15][1]  ( .D(n50), .CK(CLK), .RN(n338), .Q(
        \regfile[15][1] ) );
  DFFRQX2M \regfile_reg[15][0]  ( .D(n49), .CK(CLK), .RN(n338), .Q(
        \regfile[15][0] ) );
  DFFRQX2M \regfile_reg[8][7]  ( .D(n112), .CK(CLK), .RN(n341), .Q(
        \regfile[8][7] ) );
  DFFRQX2M \regfile_reg[8][6]  ( .D(n111), .CK(CLK), .RN(n341), .Q(
        \regfile[8][6] ) );
  DFFRQX2M \regfile_reg[8][5]  ( .D(n110), .CK(CLK), .RN(n341), .Q(
        \regfile[8][5] ) );
  DFFRQX2M \regfile_reg[8][4]  ( .D(n109), .CK(CLK), .RN(n341), .Q(
        \regfile[8][4] ) );
  DFFRQX2M \regfile_reg[8][3]  ( .D(n108), .CK(CLK), .RN(n341), .Q(
        \regfile[8][3] ) );
  DFFRQX2M \regfile_reg[8][2]  ( .D(n107), .CK(CLK), .RN(n340), .Q(
        \regfile[8][2] ) );
  DFFRQX2M \regfile_reg[8][1]  ( .D(n106), .CK(CLK), .RN(n340), .Q(
        \regfile[8][1] ) );
  DFFRQX2M \regfile_reg[8][0]  ( .D(n105), .CK(CLK), .RN(n340), .Q(
        \regfile[8][0] ) );
  DFFRQX2M \regfile_reg[10][7]  ( .D(n96), .CK(CLK), .RN(n340), .Q(
        \regfile[10][7] ) );
  DFFRQX2M \regfile_reg[10][6]  ( .D(n95), .CK(CLK), .RN(n340), .Q(
        \regfile[10][6] ) );
  DFFRQX2M \regfile_reg[10][5]  ( .D(n94), .CK(CLK), .RN(n340), .Q(
        \regfile[10][5] ) );
  DFFRQX2M \regfile_reg[10][4]  ( .D(n93), .CK(CLK), .RN(n340), .Q(
        \regfile[10][4] ) );
  DFFRQX2M \regfile_reg[10][3]  ( .D(n92), .CK(CLK), .RN(n340), .Q(
        \regfile[10][3] ) );
  DFFRQX2M \regfile_reg[10][2]  ( .D(n91), .CK(CLK), .RN(n342), .Q(
        \regfile[10][2] ) );
  DFFRQX2M \regfile_reg[10][1]  ( .D(n90), .CK(CLK), .RN(n342), .Q(
        \regfile[10][1] ) );
  DFFRQX2M \regfile_reg[10][0]  ( .D(n89), .CK(CLK), .RN(n342), .Q(
        \regfile[10][0] ) );
  DFFRQX2M \regfile_reg[12][7]  ( .D(n80), .CK(CLK), .RN(n342), .Q(
        \regfile[12][7] ) );
  DFFRQX2M \regfile_reg[12][6]  ( .D(n79), .CK(CLK), .RN(n342), .Q(
        \regfile[12][6] ) );
  DFFRQX2M \regfile_reg[12][5]  ( .D(n78), .CK(CLK), .RN(n342), .Q(
        \regfile[12][5] ) );
  DFFRQX2M \regfile_reg[12][4]  ( .D(n77), .CK(CLK), .RN(n341), .Q(
        \regfile[12][4] ) );
  DFFRQX2M \regfile_reg[12][3]  ( .D(n76), .CK(CLK), .RN(n341), .Q(
        \regfile[12][3] ) );
  DFFRQX2M \regfile_reg[12][2]  ( .D(n75), .CK(CLK), .RN(n341), .Q(
        \regfile[12][2] ) );
  DFFRQX2M \regfile_reg[12][1]  ( .D(n74), .CK(CLK), .RN(n341), .Q(
        \regfile[12][1] ) );
  DFFRQX2M \regfile_reg[12][0]  ( .D(n73), .CK(CLK), .RN(n341), .Q(
        \regfile[12][0] ) );
  DFFRQX2M \regfile_reg[14][7]  ( .D(n64), .CK(CLK), .RN(n341), .Q(
        \regfile[14][7] ) );
  DFFRQX2M \regfile_reg[14][6]  ( .D(n63), .CK(CLK), .RN(n341), .Q(
        \regfile[14][6] ) );
  DFFRQX2M \regfile_reg[14][5]  ( .D(n62), .CK(CLK), .RN(n341), .Q(
        \regfile[14][5] ) );
  DFFRQX2M \regfile_reg[14][4]  ( .D(n61), .CK(CLK), .RN(n341), .Q(
        \regfile[14][4] ) );
  DFFRQX2M \regfile_reg[14][3]  ( .D(n60), .CK(CLK), .RN(n343), .Q(
        \regfile[14][3] ) );
  DFFRQX2M \regfile_reg[14][2]  ( .D(n59), .CK(CLK), .RN(n343), .Q(
        \regfile[14][2] ) );
  DFFRQX2M \regfile_reg[14][1]  ( .D(n58), .CK(CLK), .RN(n343), .Q(
        \regfile[14][1] ) );
  DFFRQX2M \regfile_reg[14][0]  ( .D(n57), .CK(CLK), .RN(n343), .Q(
        \regfile[14][0] ) );
  DFFRQX2M \regfile_reg[2][1]  ( .D(n154), .CK(CLK), .RN(n342), .Q(REG2[1]) );
  DFFSQX2M \regfile_reg[2][0]  ( .D(n153), .CK(CLK), .SN(n336), .Q(REG2[0]) );
  DFFRQX2M \regfile_reg[3][3]  ( .D(n148), .CK(CLK), .RN(n342), .Q(REG3[3]) );
  DFFRQX2M \regfile_reg[3][7]  ( .D(n152), .CK(CLK), .RN(n344), .Q(REG3[7]) );
  DFFRQX2M \regfile_reg[3][4]  ( .D(n149), .CK(CLK), .RN(n342), .Q(REG3[4]) );
  DFFRQX2M \regfile_reg[3][0]  ( .D(n145), .CK(CLK), .RN(n344), .Q(REG3[0]) );
  DFFRQX2M \regfile_reg[3][2]  ( .D(n147), .CK(CLK), .RN(n344), .Q(REG3[2]) );
  DFFSQX2M \regfile_reg[3][5]  ( .D(n150), .CK(CLK), .SN(n336), .Q(REG3[5]) );
  DFFRQX2M \regfile_reg[3][6]  ( .D(n151), .CK(CLK), .RN(n344), .Q(REG3[6]) );
  DFFSQX2M \regfile_reg[2][7]  ( .D(n160), .CK(CLK), .SN(n336), .Q(REG2[7]) );
  DFFRQX2M \regfile_reg[3][1]  ( .D(n146), .CK(CLK), .RN(n343), .Q(REG3[1]) );
  DFFRQX2M RdData_Valid_reg ( .D(n177), .CK(CLK), .RN(n343), .Q(RdData_Valid)
         );
  DFFRQX2M \regfile_reg[0][0]  ( .D(n169), .CK(CLK), .RN(n343), .Q(REG0[0]) );
  DFFRQX2M \regfile_reg[0][1]  ( .D(n170), .CK(CLK), .RN(n343), .Q(REG0[1]) );
  DFFRQX2M \regfile_reg[0][3]  ( .D(n172), .CK(CLK), .RN(n345), .Q(REG0[3]) );
  DFFRQX2M \regfile_reg[0][4]  ( .D(n173), .CK(CLK), .RN(n343), .Q(REG0[4]) );
  DFFRQX2M \regfile_reg[0][5]  ( .D(n174), .CK(CLK), .RN(n344), .Q(REG0[5]) );
  DFFRQX2M \regfile_reg[1][1]  ( .D(n162), .CK(CLK), .RN(n344), .Q(REG1[1]) );
  DFFRQX2M \regfile_reg[1][4]  ( .D(n165), .CK(CLK), .RN(n344), .Q(REG1[4]) );
  DFFRQX2M \regfile_reg[1][2]  ( .D(n163), .CK(CLK), .RN(n344), .Q(REG1[2]) );
  DFFRQX2M \regfile_reg[0][7]  ( .D(n176), .CK(CLK), .RN(n336), .Q(REG0[7]) );
  DFFRQX2M \regfile_reg[0][6]  ( .D(n175), .CK(CLK), .RN(n344), .Q(REG0[6]) );
  DFFRQX2M \regfile_reg[1][0]  ( .D(n161), .CK(CLK), .RN(n340), .Q(REG1[0]) );
  DFFRQX2M \regfile_reg[2][6]  ( .D(n159), .CK(CLK), .RN(n344), .Q(REG2[6]) );
  DFFRQX2M \regfile_reg[2][4]  ( .D(n157), .CK(CLK), .RN(n344), .Q(REG2[4]) );
  DFFRQX2M \regfile_reg[2][5]  ( .D(n158), .CK(CLK), .RN(n343), .Q(REG2[5]) );
  DFFRQX2M \regfile_reg[2][2]  ( .D(n155), .CK(CLK), .RN(n343), .Q(REG2[2]) );
  DFFRQX2M \regfile_reg[2][3]  ( .D(n156), .CK(CLK), .RN(n343), .Q(REG2[3]) );
  DFFRQX2M \regfile_reg[1][6]  ( .D(n167), .CK(CLK), .RN(n345), .Q(REG1[6]) );
  DFFRQX2M \regfile_reg[0][2]  ( .D(n171), .CK(CLK), .RN(n343), .Q(REG0[2]) );
  DFFRQX2M \regfile_reg[1][7]  ( .D(n168), .CK(CLK), .RN(n344), .Q(REG1[7]) );
  DFFRQX2M \regfile_reg[1][5]  ( .D(n166), .CK(CLK), .RN(n344), .Q(REG1[5]) );
  DFFRQX2M \regfile_reg[1][3]  ( .D(n164), .CK(CLK), .RN(n344), .Q(REG1[3]) );
  NOR3BX2M U1 ( .AN(n323), .B(Address[0]), .C(Address[3]), .Y(n325) );
  NOR3BX2M U2 ( .AN(n323), .B(Address[3]), .C(n220), .Y(n328) );
  NOR2X2M U3 ( .A(n218), .B(Address[3]), .Y(n245) );
  NAND2X2M U4 ( .A(Address[3]), .B(n218), .Y(n246) );
  NOR2X2M U5 ( .A(Address[3]), .B(Address[2]), .Y(n248) );
  NAND2X2M U6 ( .A(Address[2]), .B(Address[3]), .Y(n249) );
  NOR2X2M U7 ( .A(n218), .B(Address[1]), .Y(n229) );
  NOR2X2M U8 ( .A(n219), .B(Address[2]), .Y(n225) );
  NOR2X2M U9 ( .A(Address[2]), .B(Address[1]), .Y(n326) );
  INVX2M U10 ( .A(WrData[6]), .Y(n203) );
  INVX2M U11 ( .A(WrData[7]), .Y(n202) );
  INVX2M U12 ( .A(n223), .Y(n213) );
  INVX2M U13 ( .A(n231), .Y(n211) );
  INVX2M U14 ( .A(n228), .Y(n212) );
  INVX2M U15 ( .A(n335), .Y(n210) );
  INVX2M U16 ( .A(n222), .Y(n214) );
  INVX2M U17 ( .A(n233), .Y(n215) );
  INVX2M U18 ( .A(n230), .Y(n216) );
  INVX2M U19 ( .A(n226), .Y(n217) );
  NAND2X2M U20 ( .A(n224), .B(n225), .Y(n223) );
  NAND2X2M U21 ( .A(n232), .B(n224), .Y(n231) );
  NAND2X2M U22 ( .A(n229), .B(n224), .Y(n228) );
  NAND2X2M U23 ( .A(n224), .B(n326), .Y(n335) );
  BUFX2M U24 ( .A(n324), .Y(n358) );
  NAND2X2M U25 ( .A(n325), .B(n326), .Y(n324) );
  BUFX2M U26 ( .A(n329), .Y(n356) );
  NAND2X2M U27 ( .A(n325), .B(n225), .Y(n329) );
  BUFX2M U28 ( .A(n333), .Y(n352) );
  NAND2X2M U29 ( .A(n325), .B(n232), .Y(n333) );
  BUFX2M U30 ( .A(n331), .Y(n354) );
  NAND2X2M U31 ( .A(n325), .B(n229), .Y(n331) );
  BUFX2M U32 ( .A(n327), .Y(n357) );
  NAND2X2M U33 ( .A(n328), .B(n326), .Y(n327) );
  BUFX2M U34 ( .A(n330), .Y(n355) );
  NAND2X2M U35 ( .A(n328), .B(n225), .Y(n330) );
  BUFX2M U36 ( .A(n334), .Y(n351) );
  NAND2X2M U37 ( .A(n328), .B(n232), .Y(n334) );
  BUFX2M U38 ( .A(n332), .Y(n353) );
  NAND2X2M U39 ( .A(n328), .B(n229), .Y(n332) );
  NOR2X2M U40 ( .A(n218), .B(n219), .Y(n232) );
  NAND2X2M U41 ( .A(n227), .B(n326), .Y(n222) );
  NAND2X2M U42 ( .A(n232), .B(n227), .Y(n233) );
  NAND2X2M U43 ( .A(n229), .B(n227), .Y(n230) );
  NAND2X2M U44 ( .A(n225), .B(n227), .Y(n226) );
  NOR2X2M U45 ( .A(n219), .B(n220), .Y(n236) );
  NAND2X2M U46 ( .A(n219), .B(n220), .Y(n242) );
  AND3X2M U47 ( .A(n323), .B(n220), .C(Address[3]), .Y(n224) );
  INVX2M U48 ( .A(Address[0]), .Y(n220) );
  INVX2M U49 ( .A(Address[2]), .Y(n218) );
  NOR2X2M U50 ( .A(n221), .B(RdEn), .Y(n323) );
  INVX2M U51 ( .A(WrEn), .Y(n221) );
  NAND2X2M U52 ( .A(RdEn), .B(n221), .Y(n235) );
  AND3X2M U53 ( .A(n323), .B(Address[0]), .C(Address[3]), .Y(n227) );
  NAND2X2M U54 ( .A(Address[0]), .B(n219), .Y(n244) );
  NOR2X2M U55 ( .A(n219), .B(Address[0]), .Y(n238) );
  INVX2M U56 ( .A(Address[1]), .Y(n219) );
  BUFX2M U57 ( .A(n350), .Y(n336) );
  BUFX2M U58 ( .A(n347), .Y(n343) );
  BUFX2M U59 ( .A(n347), .Y(n342) );
  BUFX2M U60 ( .A(n348), .Y(n341) );
  BUFX2M U61 ( .A(n349), .Y(n339) );
  BUFX2M U62 ( .A(n349), .Y(n338) );
  BUFX2M U63 ( .A(n350), .Y(n337) );
  BUFX2M U64 ( .A(n348), .Y(n340) );
  BUFX2M U65 ( .A(n346), .Y(n344) );
  BUFX2M U66 ( .A(n346), .Y(n345) );
  OAI22X1M U67 ( .A0(n8), .A1(n246), .B0(n24), .B1(n249), .Y(n319) );
  OAI22X1M U68 ( .A0(n7), .A1(n246), .B0(n23), .B1(n249), .Y(n309) );
  OAI22X1M U69 ( .A0(n6), .A1(n246), .B0(n22), .B1(n249), .Y(n299) );
  OAI22X1M U70 ( .A0(n246), .A1(n5), .B0(n21), .B1(n249), .Y(n289) );
  OAI22X1M U71 ( .A0(n246), .A1(n4), .B0(n20), .B1(n249), .Y(n279) );
  OAI22X1M U72 ( .A0(n246), .A1(n3), .B0(n19), .B1(n249), .Y(n269) );
  OAI22X1M U73 ( .A0(n246), .A1(n2), .B0(n18), .B1(n249), .Y(n259) );
  OAI22X1M U74 ( .A0(n246), .A1(n1), .B0(n17), .B1(n249), .Y(n247) );
  OAI22X1M U75 ( .A0(n211), .A1(n201), .B0(n209), .B1(n231), .Y(n57) );
  OAI22X1M U76 ( .A0(n211), .A1(n200), .B0(n208), .B1(n231), .Y(n58) );
  OAI22X1M U77 ( .A0(n211), .A1(n199), .B0(n207), .B1(n231), .Y(n59) );
  OAI22X1M U78 ( .A0(n211), .A1(n198), .B0(n206), .B1(n231), .Y(n60) );
  OAI22X1M U79 ( .A0(n211), .A1(n197), .B0(n205), .B1(n231), .Y(n61) );
  OAI22X1M U80 ( .A0(n211), .A1(n196), .B0(n204), .B1(n231), .Y(n62) );
  OAI22X1M U81 ( .A0(n211), .A1(n195), .B0(n203), .B1(n231), .Y(n63) );
  OAI22X1M U82 ( .A0(n211), .A1(n194), .B0(n202), .B1(n231), .Y(n64) );
  OAI22X1M U83 ( .A0(n212), .A1(n193), .B0(n209), .B1(n228), .Y(n73) );
  OAI22X1M U84 ( .A0(n212), .A1(n192), .B0(n208), .B1(n228), .Y(n74) );
  OAI22X1M U85 ( .A0(n212), .A1(n191), .B0(n207), .B1(n228), .Y(n75) );
  OAI22X1M U86 ( .A0(n212), .A1(n190), .B0(n206), .B1(n228), .Y(n76) );
  OAI22X1M U87 ( .A0(n212), .A1(n189), .B0(n205), .B1(n228), .Y(n77) );
  OAI22X1M U88 ( .A0(n212), .A1(n188), .B0(n204), .B1(n228), .Y(n78) );
  OAI22X1M U89 ( .A0(n212), .A1(n187), .B0(n203), .B1(n228), .Y(n79) );
  OAI22X1M U90 ( .A0(n212), .A1(n186), .B0(n202), .B1(n228), .Y(n80) );
  OAI22X1M U91 ( .A0(n213), .A1(n179), .B0(n223), .B1(n203), .Y(n95) );
  OAI22X1M U92 ( .A0(n213), .A1(n178), .B0(n223), .B1(n202), .Y(n96) );
  OAI22X1M U93 ( .A0(n213), .A1(n182), .B0(n223), .B1(n206), .Y(n92) );
  OAI22X1M U94 ( .A0(n213), .A1(n181), .B0(n223), .B1(n205), .Y(n93) );
  OAI22X1M U95 ( .A0(n213), .A1(n180), .B0(n223), .B1(n204), .Y(n94) );
  OAI22X1M U96 ( .A0(n210), .A1(n34), .B0(n203), .B1(n335), .Y(n111) );
  OAI22X1M U97 ( .A0(n210), .A1(n33), .B0(n202), .B1(n335), .Y(n112) );
  OAI22X1M U98 ( .A0(n213), .A1(n185), .B0(n209), .B1(n223), .Y(n89) );
  OAI22X1M U99 ( .A0(n213), .A1(n184), .B0(n208), .B1(n223), .Y(n90) );
  OAI22X1M U100 ( .A0(n213), .A1(n183), .B0(n207), .B1(n223), .Y(n91) );
  OAI22X1M U101 ( .A0(n210), .A1(n40), .B0(n209), .B1(n335), .Y(n105) );
  OAI22X1M U102 ( .A0(n210), .A1(n39), .B0(n208), .B1(n335), .Y(n106) );
  OAI22X1M U103 ( .A0(n210), .A1(n38), .B0(n207), .B1(n335), .Y(n107) );
  OAI22X1M U104 ( .A0(n210), .A1(n37), .B0(n206), .B1(n335), .Y(n108) );
  OAI22X1M U105 ( .A0(n210), .A1(n36), .B0(n205), .B1(n335), .Y(n109) );
  OAI22X1M U106 ( .A0(n210), .A1(n35), .B0(n204), .B1(n335), .Y(n110) );
  INVX2M U107 ( .A(WrData[0]), .Y(n209) );
  INVX2M U108 ( .A(WrData[1]), .Y(n208) );
  INVX2M U109 ( .A(WrData[2]), .Y(n207) );
  INVX2M U110 ( .A(WrData[3]), .Y(n206) );
  INVX2M U111 ( .A(WrData[4]), .Y(n205) );
  INVX2M U112 ( .A(WrData[5]), .Y(n204) );
  OAI22X1M U113 ( .A0(n217), .A1(n16), .B0(n209), .B1(n226), .Y(n81) );
  OAI22X1M U114 ( .A0(n217), .A1(n15), .B0(n208), .B1(n226), .Y(n82) );
  OAI22X1M U115 ( .A0(n217), .A1(n14), .B0(n207), .B1(n226), .Y(n83) );
  OAI22X1M U116 ( .A0(n217), .A1(n13), .B0(n206), .B1(n226), .Y(n84) );
  OAI22X1M U117 ( .A0(n217), .A1(n12), .B0(n205), .B1(n226), .Y(n85) );
  OAI22X1M U118 ( .A0(n217), .A1(n11), .B0(n204), .B1(n226), .Y(n86) );
  OAI22X1M U119 ( .A0(n217), .A1(n10), .B0(n203), .B1(n226), .Y(n87) );
  OAI22X1M U120 ( .A0(n217), .A1(n9), .B0(n202), .B1(n226), .Y(n88) );
  OAI22X1M U121 ( .A0(n215), .A1(n32), .B0(n209), .B1(n233), .Y(n49) );
  OAI22X1M U122 ( .A0(n215), .A1(n31), .B0(n208), .B1(n233), .Y(n50) );
  OAI22X1M U123 ( .A0(n215), .A1(n30), .B0(n207), .B1(n233), .Y(n51) );
  OAI22X1M U124 ( .A0(n215), .A1(n29), .B0(n206), .B1(n233), .Y(n52) );
  OAI22X1M U125 ( .A0(n215), .A1(n28), .B0(n205), .B1(n233), .Y(n53) );
  OAI22X1M U126 ( .A0(n215), .A1(n27), .B0(n204), .B1(n233), .Y(n54) );
  OAI22X1M U127 ( .A0(n215), .A1(n26), .B0(n203), .B1(n233), .Y(n55) );
  OAI22X1M U128 ( .A0(n215), .A1(n25), .B0(n202), .B1(n233), .Y(n56) );
  OAI22X1M U129 ( .A0(n216), .A1(n24), .B0(n209), .B1(n230), .Y(n65) );
  OAI22X1M U130 ( .A0(n216), .A1(n23), .B0(n208), .B1(n230), .Y(n66) );
  OAI22X1M U131 ( .A0(n216), .A1(n22), .B0(n207), .B1(n230), .Y(n67) );
  OAI22X1M U132 ( .A0(n216), .A1(n21), .B0(n206), .B1(n230), .Y(n68) );
  OAI22X1M U133 ( .A0(n216), .A1(n20), .B0(n205), .B1(n230), .Y(n69) );
  OAI22X1M U134 ( .A0(n216), .A1(n19), .B0(n204), .B1(n230), .Y(n70) );
  OAI22X1M U135 ( .A0(n216), .A1(n18), .B0(n203), .B1(n230), .Y(n71) );
  OAI22X1M U136 ( .A0(n216), .A1(n17), .B0(n202), .B1(n230), .Y(n72) );
  OAI22X1M U137 ( .A0(n214), .A1(n2), .B0(n222), .B1(n203), .Y(n103) );
  OAI22X1M U138 ( .A0(n214), .A1(n1), .B0(n222), .B1(n202), .Y(n104) );
  OAI22X1M U139 ( .A0(n214), .A1(n8), .B0(n222), .B1(n209), .Y(n97) );
  OAI22X1M U140 ( .A0(n214), .A1(n7), .B0(n222), .B1(n208), .Y(n98) );
  OAI22X1M U141 ( .A0(n214), .A1(n6), .B0(n222), .B1(n207), .Y(n99) );
  OAI22X1M U142 ( .A0(n214), .A1(n5), .B0(n222), .B1(n206), .Y(n100) );
  OAI22X1M U143 ( .A0(n214), .A1(n4), .B0(n222), .B1(n205), .Y(n101) );
  OAI22X1M U144 ( .A0(n214), .A1(n3), .B0(n222), .B1(n204), .Y(n102) );
  BUFX2M U145 ( .A(RST), .Y(n347) );
  BUFX2M U146 ( .A(RST), .Y(n349) );
  BUFX2M U147 ( .A(RST), .Y(n348) );
  BUFX2M U148 ( .A(RST), .Y(n350) );
  BUFX2M U149 ( .A(RST), .Y(n346) );
  OAI2BB2X1M U150 ( .B0(n293), .B1(n235), .A0N(RdData[2]), .A1N(n235), .Y(n43)
         );
  AOI221XLM U151 ( .A0(n236), .A1(n294), .B0(n238), .B1(n295), .C0(n296), .Y(
        n293) );
  OAI221X1M U152 ( .A0(n30), .A1(n249), .B0(n14), .B1(n246), .C0(n302), .Y(
        n294) );
  OAI221X1M U153 ( .A0(n199), .A1(n249), .B0(n183), .B1(n246), .C0(n301), .Y(
        n295) );
  OAI2BB2X1M U154 ( .B0(n283), .B1(n235), .A0N(RdData[3]), .A1N(n235), .Y(n44)
         );
  AOI221XLM U155 ( .A0(n236), .A1(n284), .B0(n238), .B1(n285), .C0(n286), .Y(
        n283) );
  OAI221X1M U156 ( .A0(n29), .A1(n249), .B0(n13), .B1(n246), .C0(n292), .Y(
        n284) );
  OAI221X1M U157 ( .A0(n198), .A1(n249), .B0(n182), .B1(n246), .C0(n291), .Y(
        n285) );
  OAI2BB2X1M U158 ( .B0(n273), .B1(n235), .A0N(RdData[4]), .A1N(n235), .Y(n45)
         );
  AOI221XLM U159 ( .A0(n236), .A1(n274), .B0(n238), .B1(n275), .C0(n276), .Y(
        n273) );
  OAI221X1M U160 ( .A0(n28), .A1(n249), .B0(n12), .B1(n246), .C0(n282), .Y(
        n274) );
  OAI221X1M U161 ( .A0(n197), .A1(n249), .B0(n181), .B1(n246), .C0(n281), .Y(
        n275) );
  OAI2BB2X1M U162 ( .B0(n263), .B1(n235), .A0N(RdData[5]), .A1N(n235), .Y(n46)
         );
  AOI221XLM U163 ( .A0(n236), .A1(n264), .B0(n238), .B1(n265), .C0(n266), .Y(
        n263) );
  OAI221X1M U164 ( .A0(n27), .A1(n249), .B0(n11), .B1(n246), .C0(n272), .Y(
        n264) );
  OAI221X1M U165 ( .A0(n196), .A1(n249), .B0(n180), .B1(n246), .C0(n271), .Y(
        n265) );
  OAI2BB2X1M U166 ( .B0(n253), .B1(n235), .A0N(RdData[6]), .A1N(n235), .Y(n47)
         );
  AOI221XLM U167 ( .A0(n236), .A1(n254), .B0(n238), .B1(n255), .C0(n256), .Y(
        n253) );
  OAI221X1M U168 ( .A0(n26), .A1(n249), .B0(n10), .B1(n246), .C0(n262), .Y(
        n254) );
  OAI221X1M U169 ( .A0(n195), .A1(n249), .B0(n179), .B1(n246), .C0(n261), .Y(
        n255) );
  OAI2BB2X1M U170 ( .B0(n234), .B1(n235), .A0N(RdData[7]), .A1N(n235), .Y(n48)
         );
  AOI221XLM U171 ( .A0(n236), .A1(n237), .B0(n238), .B1(n239), .C0(n240), .Y(
        n234) );
  OAI221X1M U172 ( .A0(n25), .A1(n249), .B0(n9), .B1(n246), .C0(n252), .Y(n237) );
  OAI221X1M U173 ( .A0(n194), .A1(n249), .B0(n178), .B1(n246), .C0(n251), .Y(
        n239) );
  OAI22X1M U174 ( .A0(n317), .A1(n242), .B0(n318), .B1(n244), .Y(n316) );
  AOI221XLM U175 ( .A0(\regfile[4][0] ), .A1(n245), .B0(REG0[0]), .B1(n248), 
        .C0(n320), .Y(n317) );
  AOI221XLM U176 ( .A0(\regfile[5][0] ), .A1(n245), .B0(REG1[0]), .B1(n248), 
        .C0(n319), .Y(n318) );
  OAI22X1M U177 ( .A0(n246), .A1(n40), .B0(n193), .B1(n249), .Y(n320) );
  OAI22X1M U178 ( .A0(n307), .A1(n242), .B0(n308), .B1(n244), .Y(n306) );
  AOI221XLM U179 ( .A0(\regfile[4][1] ), .A1(n245), .B0(REG0[1]), .B1(n248), 
        .C0(n310), .Y(n307) );
  AOI221XLM U180 ( .A0(\regfile[5][1] ), .A1(n245), .B0(REG1[1]), .B1(n248), 
        .C0(n309), .Y(n308) );
  OAI22X1M U181 ( .A0(n246), .A1(n39), .B0(n192), .B1(n249), .Y(n310) );
  OAI22X1M U182 ( .A0(n297), .A1(n242), .B0(n298), .B1(n244), .Y(n296) );
  AOI221XLM U183 ( .A0(\regfile[4][2] ), .A1(n245), .B0(REG0[2]), .B1(n248), 
        .C0(n300), .Y(n297) );
  AOI221XLM U184 ( .A0(\regfile[5][2] ), .A1(n245), .B0(REG1[2]), .B1(n248), 
        .C0(n299), .Y(n298) );
  OAI22X1M U185 ( .A0(n246), .A1(n38), .B0(n191), .B1(n249), .Y(n300) );
  OAI22X1M U186 ( .A0(n287), .A1(n242), .B0(n288), .B1(n244), .Y(n286) );
  AOI221XLM U187 ( .A0(\regfile[4][3] ), .A1(n245), .B0(REG0[3]), .B1(n248), 
        .C0(n290), .Y(n287) );
  AOI221XLM U188 ( .A0(\regfile[5][3] ), .A1(n245), .B0(REG1[3]), .B1(n248), 
        .C0(n289), .Y(n288) );
  OAI22X1M U189 ( .A0(n246), .A1(n37), .B0(n190), .B1(n249), .Y(n290) );
  OAI22X1M U190 ( .A0(n277), .A1(n242), .B0(n278), .B1(n244), .Y(n276) );
  AOI221XLM U191 ( .A0(\regfile[4][4] ), .A1(n245), .B0(REG0[4]), .B1(n248), 
        .C0(n280), .Y(n277) );
  AOI221XLM U192 ( .A0(\regfile[5][4] ), .A1(n245), .B0(REG1[4]), .B1(n248), 
        .C0(n279), .Y(n278) );
  OAI22X1M U193 ( .A0(n246), .A1(n36), .B0(n189), .B1(n249), .Y(n280) );
  OAI22X1M U194 ( .A0(n267), .A1(n242), .B0(n268), .B1(n244), .Y(n266) );
  AOI221XLM U195 ( .A0(\regfile[4][5] ), .A1(n245), .B0(REG0[5]), .B1(n248), 
        .C0(n270), .Y(n267) );
  AOI221XLM U196 ( .A0(\regfile[5][5] ), .A1(n245), .B0(REG1[5]), .B1(n248), 
        .C0(n269), .Y(n268) );
  OAI22X1M U197 ( .A0(n246), .A1(n35), .B0(n188), .B1(n249), .Y(n270) );
  OAI22X1M U198 ( .A0(n257), .A1(n242), .B0(n258), .B1(n244), .Y(n256) );
  AOI221XLM U199 ( .A0(\regfile[4][6] ), .A1(n245), .B0(REG0[6]), .B1(n248), 
        .C0(n260), .Y(n257) );
  AOI221XLM U200 ( .A0(\regfile[5][6] ), .A1(n245), .B0(REG1[6]), .B1(n248), 
        .C0(n259), .Y(n258) );
  OAI22X1M U201 ( .A0(n246), .A1(n34), .B0(n187), .B1(n249), .Y(n260) );
  OAI22X1M U202 ( .A0(n241), .A1(n242), .B0(n243), .B1(n244), .Y(n240) );
  AOI221XLM U203 ( .A0(\regfile[4][7] ), .A1(n245), .B0(REG0[7]), .B1(n248), 
        .C0(n250), .Y(n241) );
  AOI221XLM U204 ( .A0(\regfile[5][7] ), .A1(n245), .B0(REG1[7]), .B1(n248), 
        .C0(n247), .Y(n243) );
  OAI22X1M U205 ( .A0(n246), .A1(n33), .B0(n186), .B1(n249), .Y(n250) );
  AOI22X1M U206 ( .A0(\regfile[6][4] ), .A1(n245), .B0(REG2[4]), .B1(n248), 
        .Y(n281) );
  AOI22X1M U207 ( .A0(\regfile[7][4] ), .A1(n245), .B0(REG3[4]), .B1(n248), 
        .Y(n282) );
  AOI22X1M U208 ( .A0(\regfile[6][5] ), .A1(n245), .B0(REG2[5]), .B1(n248), 
        .Y(n271) );
  AOI22X1M U209 ( .A0(\regfile[7][5] ), .A1(n245), .B0(REG3[5]), .B1(n248), 
        .Y(n272) );
  AOI22X1M U210 ( .A0(\regfile[6][6] ), .A1(n245), .B0(REG2[6]), .B1(n248), 
        .Y(n261) );
  AOI22X1M U211 ( .A0(\regfile[7][6] ), .A1(n245), .B0(REG3[6]), .B1(n248), 
        .Y(n262) );
  AOI22X1M U212 ( .A0(\regfile[7][7] ), .A1(n245), .B0(REG3[7]), .B1(n248), 
        .Y(n252) );
  AOI22X1M U213 ( .A0(\regfile[6][0] ), .A1(n245), .B0(REG2[0]), .B1(n248), 
        .Y(n321) );
  AOI22X1M U214 ( .A0(\regfile[7][0] ), .A1(n245), .B0(REG3[0]), .B1(n248), 
        .Y(n322) );
  AOI22X1M U215 ( .A0(\regfile[6][1] ), .A1(n245), .B0(REG2[1]), .B1(n248), 
        .Y(n311) );
  AOI22X1M U216 ( .A0(\regfile[7][1] ), .A1(n245), .B0(REG3[1]), .B1(n248), 
        .Y(n312) );
  AOI22X1M U217 ( .A0(\regfile[6][2] ), .A1(n245), .B0(REG2[2]), .B1(n248), 
        .Y(n301) );
  AOI22X1M U218 ( .A0(\regfile[7][2] ), .A1(n245), .B0(REG3[2]), .B1(n248), 
        .Y(n302) );
  AOI22X1M U219 ( .A0(\regfile[6][3] ), .A1(n245), .B0(REG2[3]), .B1(n248), 
        .Y(n291) );
  AOI22X1M U220 ( .A0(\regfile[7][3] ), .A1(n245), .B0(REG3[3]), .B1(n248), 
        .Y(n292) );
  AOI22X1M U221 ( .A0(\regfile[6][7] ), .A1(n245), .B0(REG2[7]), .B1(n248), 
        .Y(n251) );
  OAI2BB2X1M U222 ( .B0(n313), .B1(n235), .A0N(RdData[0]), .A1N(n235), .Y(n41)
         );
  AOI221XLM U223 ( .A0(n236), .A1(n314), .B0(n238), .B1(n315), .C0(n316), .Y(
        n313) );
  OAI221X1M U224 ( .A0(n32), .A1(n249), .B0(n16), .B1(n246), .C0(n322), .Y(
        n314) );
  OAI221X1M U225 ( .A0(n201), .A1(n249), .B0(n185), .B1(n246), .C0(n321), .Y(
        n315) );
  OAI2BB2X1M U226 ( .B0(n303), .B1(n235), .A0N(RdData[1]), .A1N(n235), .Y(n42)
         );
  AOI221XLM U227 ( .A0(n236), .A1(n304), .B0(n238), .B1(n305), .C0(n306), .Y(
        n303) );
  OAI221X1M U228 ( .A0(n31), .A1(n249), .B0(n15), .B1(n246), .C0(n312), .Y(
        n304) );
  OAI221X1M U229 ( .A0(n200), .A1(n249), .B0(n184), .B1(n246), .C0(n311), .Y(
        n305) );
  OAI2BB2X1M U230 ( .B0(n209), .B1(n357), .A0N(n357), .A1N(REG1[0]), .Y(n161)
         );
  OAI2BB2X1M U231 ( .B0(n207), .B1(n357), .A0N(n357), .A1N(REG1[2]), .Y(n163)
         );
  OAI2BB2X1M U232 ( .B0(n206), .B1(n357), .A0N(n357), .A1N(REG1[3]), .Y(n164)
         );
  OAI2BB2X1M U233 ( .B0(n202), .B1(n357), .A0N(n357), .A1N(REG1[7]), .Y(n168)
         );
  OAI2BB2X1M U234 ( .B0(n205), .B1(n357), .A0N(n357), .A1N(REG1[4]), .Y(n165)
         );
  OAI2BB2X1M U235 ( .B0(n204), .B1(n357), .A0N(n357), .A1N(REG1[5]), .Y(n166)
         );
  OAI2BB2X1M U236 ( .B0(n208), .B1(n357), .A0N(n357), .A1N(REG1[1]), .Y(n162)
         );
  OAI2BB2X1M U237 ( .B0(n203), .B1(n357), .A0N(n357), .A1N(REG1[6]), .Y(n167)
         );
  OAI2BB2X1M U238 ( .B0(n203), .B1(n358), .A0N(n358), .A1N(REG0[6]), .Y(n175)
         );
  OAI2BB2X1M U239 ( .B0(n202), .B1(n358), .A0N(n358), .A1N(REG0[7]), .Y(n176)
         );
  OAI2BB2X1M U240 ( .B0(n204), .B1(n358), .A0N(n358), .A1N(REG0[5]), .Y(n174)
         );
  OAI2BB2X1M U241 ( .B0(n205), .B1(n358), .A0N(n358), .A1N(REG0[4]), .Y(n173)
         );
  OAI2BB2X1M U242 ( .B0(n206), .B1(n358), .A0N(n358), .A1N(REG0[3]), .Y(n172)
         );
  OAI2BB2X1M U243 ( .B0(n207), .B1(n358), .A0N(n358), .A1N(REG0[2]), .Y(n171)
         );
  OAI2BB2X1M U244 ( .B0(n209), .B1(n358), .A0N(n358), .A1N(REG0[0]), .Y(n169)
         );
  OAI2BB2X1M U245 ( .B0(n208), .B1(n358), .A0N(n358), .A1N(REG0[1]), .Y(n170)
         );
  OAI2BB2X1M U246 ( .B0(n207), .B1(n356), .A0N(n356), .A1N(REG2[2]), .Y(n155)
         );
  OAI2BB2X1M U247 ( .B0(n204), .B1(n356), .A0N(n356), .A1N(REG2[5]), .Y(n158)
         );
  OAI2BB2X1M U248 ( .B0(n203), .B1(n356), .A0N(n356), .A1N(REG2[6]), .Y(n159)
         );
  OAI2BB2X1M U249 ( .B0(n206), .B1(n356), .A0N(n356), .A1N(REG2[3]), .Y(n156)
         );
  OAI2BB2X1M U250 ( .B0(n208), .B1(n355), .A0N(n355), .A1N(REG3[1]), .Y(n146)
         );
  OAI2BB2X1M U251 ( .B0(n209), .B1(n355), .A0N(n355), .A1N(REG3[0]), .Y(n145)
         );
  OAI2BB2X1M U252 ( .B0(n205), .B1(n356), .A0N(n356), .A1N(REG2[4]), .Y(n157)
         );
  OAI2BB2X1M U253 ( .B0(n203), .B1(n355), .A0N(n355), .A1N(REG3[6]), .Y(n151)
         );
  OAI2BB2X1M U254 ( .B0(n202), .B1(n355), .A0N(n355), .A1N(REG3[7]), .Y(n152)
         );
  OAI2BB2X1M U255 ( .B0(n206), .B1(n355), .A0N(n355), .A1N(REG3[3]), .Y(n148)
         );
  OAI2BB2X1M U256 ( .B0(n207), .B1(n355), .A0N(n355), .A1N(REG3[2]), .Y(n147)
         );
  OAI2BB2X1M U257 ( .B0(n205), .B1(n355), .A0N(n355), .A1N(REG3[4]), .Y(n149)
         );
  OAI2BB2X1M U258 ( .B0(n208), .B1(n356), .A0N(n356), .A1N(REG2[1]), .Y(n154)
         );
  OAI2BB2X1M U259 ( .B0(n209), .B1(n352), .A0N(n352), .A1N(\regfile[6][0] ), 
        .Y(n121) );
  OAI2BB2X1M U260 ( .B0(n208), .B1(n352), .A0N(n352), .A1N(\regfile[6][1] ), 
        .Y(n122) );
  OAI2BB2X1M U261 ( .B0(n207), .B1(n352), .A0N(n352), .A1N(\regfile[6][2] ), 
        .Y(n123) );
  OAI2BB2X1M U262 ( .B0(n206), .B1(n352), .A0N(n352), .A1N(\regfile[6][3] ), 
        .Y(n124) );
  OAI2BB2X1M U263 ( .B0(n205), .B1(n352), .A0N(n352), .A1N(\regfile[6][4] ), 
        .Y(n125) );
  OAI2BB2X1M U264 ( .B0(n204), .B1(n352), .A0N(n352), .A1N(\regfile[6][5] ), 
        .Y(n126) );
  OAI2BB2X1M U265 ( .B0(n203), .B1(n352), .A0N(n352), .A1N(\regfile[6][6] ), 
        .Y(n127) );
  OAI2BB2X1M U266 ( .B0(n202), .B1(n352), .A0N(n352), .A1N(\regfile[6][7] ), 
        .Y(n128) );
  OAI2BB2X1M U267 ( .B0(n209), .B1(n354), .A0N(n354), .A1N(\regfile[4][0] ), 
        .Y(n137) );
  OAI2BB2X1M U268 ( .B0(n208), .B1(n354), .A0N(n354), .A1N(\regfile[4][1] ), 
        .Y(n138) );
  OAI2BB2X1M U269 ( .B0(n207), .B1(n354), .A0N(n354), .A1N(\regfile[4][2] ), 
        .Y(n139) );
  OAI2BB2X1M U270 ( .B0(n206), .B1(n354), .A0N(n354), .A1N(\regfile[4][3] ), 
        .Y(n140) );
  OAI2BB2X1M U271 ( .B0(n205), .B1(n354), .A0N(n354), .A1N(\regfile[4][4] ), 
        .Y(n141) );
  OAI2BB2X1M U272 ( .B0(n204), .B1(n354), .A0N(n354), .A1N(\regfile[4][5] ), 
        .Y(n142) );
  OAI2BB2X1M U273 ( .B0(n203), .B1(n354), .A0N(n354), .A1N(\regfile[4][6] ), 
        .Y(n143) );
  OAI2BB2X1M U274 ( .B0(n202), .B1(n354), .A0N(n354), .A1N(\regfile[4][7] ), 
        .Y(n144) );
  OAI2BB2X1M U275 ( .B0(n209), .B1(n351), .A0N(n351), .A1N(\regfile[7][0] ), 
        .Y(n113) );
  OAI2BB2X1M U276 ( .B0(n208), .B1(n351), .A0N(n351), .A1N(\regfile[7][1] ), 
        .Y(n114) );
  OAI2BB2X1M U277 ( .B0(n207), .B1(n351), .A0N(n351), .A1N(\regfile[7][2] ), 
        .Y(n115) );
  OAI2BB2X1M U278 ( .B0(n206), .B1(n351), .A0N(n351), .A1N(\regfile[7][3] ), 
        .Y(n116) );
  OAI2BB2X1M U279 ( .B0(n205), .B1(n351), .A0N(n351), .A1N(\regfile[7][4] ), 
        .Y(n117) );
  OAI2BB2X1M U280 ( .B0(n204), .B1(n351), .A0N(n351), .A1N(\regfile[7][5] ), 
        .Y(n118) );
  OAI2BB2X1M U281 ( .B0(n203), .B1(n351), .A0N(n351), .A1N(\regfile[7][6] ), 
        .Y(n119) );
  OAI2BB2X1M U282 ( .B0(n202), .B1(n351), .A0N(n351), .A1N(\regfile[7][7] ), 
        .Y(n120) );
  OAI2BB2X1M U283 ( .B0(n209), .B1(n353), .A0N(n353), .A1N(\regfile[5][0] ), 
        .Y(n129) );
  OAI2BB2X1M U284 ( .B0(n208), .B1(n353), .A0N(n353), .A1N(\regfile[5][1] ), 
        .Y(n130) );
  OAI2BB2X1M U285 ( .B0(n207), .B1(n353), .A0N(n353), .A1N(\regfile[5][2] ), 
        .Y(n131) );
  OAI2BB2X1M U286 ( .B0(n206), .B1(n353), .A0N(n353), .A1N(\regfile[5][3] ), 
        .Y(n132) );
  OAI2BB2X1M U287 ( .B0(n205), .B1(n353), .A0N(n353), .A1N(\regfile[5][4] ), 
        .Y(n133) );
  OAI2BB2X1M U288 ( .B0(n204), .B1(n353), .A0N(n353), .A1N(\regfile[5][5] ), 
        .Y(n134) );
  OAI2BB2X1M U289 ( .B0(n203), .B1(n353), .A0N(n353), .A1N(\regfile[5][6] ), 
        .Y(n135) );
  OAI2BB2X1M U290 ( .B0(n202), .B1(n353), .A0N(n353), .A1N(\regfile[5][7] ), 
        .Y(n136) );
  OAI2BB2X1M U291 ( .B0(n202), .B1(n356), .A0N(n356), .A1N(REG2[7]), .Y(n160)
         );
  OAI2BB2X1M U292 ( .B0(n209), .B1(n356), .A0N(n356), .A1N(REG2[0]), .Y(n153)
         );
  OAI2BB2X1M U293 ( .B0(n204), .B1(n355), .A0N(n355), .A1N(REG3[5]), .Y(n150)
         );
  OAI2BB1X2M U294 ( .A0N(RdData_Valid), .A1N(n323), .B0(n235), .Y(n177) );
  INVX2M U295 ( .A(\regfile[9][0] ), .Y(n8) );
  INVX2M U296 ( .A(\regfile[9][1] ), .Y(n7) );
  INVX2M U297 ( .A(\regfile[9][2] ), .Y(n6) );
  INVX2M U298 ( .A(\regfile[13][0] ), .Y(n24) );
  INVX2M U299 ( .A(\regfile[12][0] ), .Y(n193) );
  INVX2M U300 ( .A(\regfile[13][1] ), .Y(n23) );
  INVX2M U301 ( .A(\regfile[12][1] ), .Y(n192) );
  INVX2M U302 ( .A(\regfile[13][2] ), .Y(n22) );
  INVX2M U303 ( .A(\regfile[12][2] ), .Y(n191) );
  INVX2M U304 ( .A(\regfile[13][3] ), .Y(n21) );
  INVX2M U305 ( .A(\regfile[12][3] ), .Y(n190) );
  INVX2M U306 ( .A(\regfile[13][4] ), .Y(n20) );
  INVX2M U307 ( .A(\regfile[12][4] ), .Y(n189) );
  INVX2M U308 ( .A(\regfile[13][5] ), .Y(n19) );
  INVX2M U309 ( .A(\regfile[12][5] ), .Y(n188) );
  INVX2M U310 ( .A(\regfile[13][6] ), .Y(n18) );
  INVX2M U311 ( .A(\regfile[12][6] ), .Y(n187) );
  INVX2M U312 ( .A(\regfile[13][7] ), .Y(n17) );
  INVX2M U313 ( .A(\regfile[12][7] ), .Y(n186) );
  INVX2M U314 ( .A(\regfile[8][0] ), .Y(n40) );
  INVX2M U315 ( .A(\regfile[8][1] ), .Y(n39) );
  INVX2M U316 ( .A(\regfile[8][2] ), .Y(n38) );
  INVX2M U317 ( .A(\regfile[9][3] ), .Y(n5) );
  INVX2M U318 ( .A(\regfile[8][3] ), .Y(n37) );
  INVX2M U319 ( .A(\regfile[9][4] ), .Y(n4) );
  INVX2M U320 ( .A(\regfile[8][4] ), .Y(n36) );
  INVX2M U321 ( .A(\regfile[9][5] ), .Y(n3) );
  INVX2M U322 ( .A(\regfile[8][5] ), .Y(n35) );
  INVX2M U323 ( .A(\regfile[9][6] ), .Y(n2) );
  INVX2M U324 ( .A(\regfile[8][6] ), .Y(n34) );
  INVX2M U325 ( .A(\regfile[9][7] ), .Y(n1) );
  INVX2M U326 ( .A(\regfile[8][7] ), .Y(n33) );
  INVX2M U327 ( .A(\regfile[14][0] ), .Y(n201) );
  INVX2M U328 ( .A(\regfile[15][0] ), .Y(n32) );
  INVX2M U329 ( .A(\regfile[14][1] ), .Y(n200) );
  INVX2M U330 ( .A(\regfile[15][1] ), .Y(n31) );
  INVX2M U331 ( .A(\regfile[14][2] ), .Y(n199) );
  INVX2M U332 ( .A(\regfile[15][2] ), .Y(n30) );
  INVX2M U333 ( .A(\regfile[14][3] ), .Y(n198) );
  INVX2M U334 ( .A(\regfile[15][3] ), .Y(n29) );
  INVX2M U335 ( .A(\regfile[14][4] ), .Y(n197) );
  INVX2M U336 ( .A(\regfile[15][4] ), .Y(n28) );
  INVX2M U337 ( .A(\regfile[14][5] ), .Y(n196) );
  INVX2M U338 ( .A(\regfile[15][5] ), .Y(n27) );
  INVX2M U339 ( .A(\regfile[14][6] ), .Y(n195) );
  INVX2M U340 ( .A(\regfile[15][6] ), .Y(n26) );
  INVX2M U341 ( .A(\regfile[14][7] ), .Y(n194) );
  INVX2M U342 ( .A(\regfile[15][7] ), .Y(n25) );
  INVX2M U343 ( .A(\regfile[10][0] ), .Y(n185) );
  INVX2M U344 ( .A(\regfile[11][0] ), .Y(n16) );
  INVX2M U345 ( .A(\regfile[10][1] ), .Y(n184) );
  INVX2M U346 ( .A(\regfile[11][1] ), .Y(n15) );
  INVX2M U347 ( .A(\regfile[10][2] ), .Y(n183) );
  INVX2M U348 ( .A(\regfile[11][2] ), .Y(n14) );
  INVX2M U349 ( .A(\regfile[10][3] ), .Y(n182) );
  INVX2M U350 ( .A(\regfile[11][3] ), .Y(n13) );
  INVX2M U351 ( .A(\regfile[10][4] ), .Y(n181) );
  INVX2M U352 ( .A(\regfile[11][4] ), .Y(n12) );
  INVX2M U353 ( .A(\regfile[10][5] ), .Y(n180) );
  INVX2M U354 ( .A(\regfile[11][5] ), .Y(n11) );
  INVX2M U355 ( .A(\regfile[10][6] ), .Y(n179) );
  INVX2M U356 ( .A(\regfile[11][6] ), .Y(n10) );
  INVX2M U357 ( .A(\regfile[10][7] ), .Y(n178) );
  INVX2M U358 ( .A(\regfile[11][7] ), .Y(n9) );
endmodule



    module SYS_CTRL_OP_WIDTH8_ALU_OUT_WIDTH16_REG_WIDTH8_REG_DEPTH16_ADDRESS_WIDTH4_UART_DATA_WIDTH8 ( 
        CLK, RST, ALU_OUT, OUT_Valid, ALU_FUN, EN, CLK_EN, RdData, 
        RdData_Valid, Address, WrEn, RdEn, WrData, RX_P_DATA, RX_D_VLD, 
        TX_P_DATA, TX_D_VLD, FIFO_FULL, clk_div_en );
  input [15:0] ALU_OUT;
  output [3:0] ALU_FUN;
  input [7:0] RdData;
  output [3:0] Address;
  output [7:0] WrData;
  input [7:0] RX_P_DATA;
  output [7:0] TX_P_DATA;
  input CLK, RST, OUT_Valid, RdData_Valid, RX_D_VLD, FIFO_FULL;
  output EN, CLK_EN, WrEn, RdEn, TX_D_VLD, clk_div_en;
  wire   n94, n95, n96, n97, n98, n99, n100, n101, n87, n88, n89, n90, n91,
         n92, n93, n102, n83, n84, n85, n86, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n103, n104, n105, n106, n107, n108, n109, n3
;
  wire   [15:8] ALU_OUT_STORED;
  wire   [3:0] Next_State;
  wire   [3:0] Current_State;

  DFFRQX2M \ALU_OUT_STORED_reg[8]  ( .D(n94), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[8]) );
  DFFRQX2M \ALU_OUT_STORED_reg[9]  ( .D(n95), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[9]) );
  DFFRQX2M \ALU_OUT_STORED_reg[10]  ( .D(n96), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[10]) );
  DFFRQX2M \ALU_OUT_STORED_reg[11]  ( .D(n97), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[11]) );
  DFFRQX2M \ALU_OUT_STORED_reg[12]  ( .D(n98), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[12]) );
  DFFRQX2M \ALU_OUT_STORED_reg[13]  ( .D(n99), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[13]) );
  DFFRQX2M \ALU_OUT_STORED_reg[14]  ( .D(n100), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[14]) );
  DFFRQX2M \ALU_OUT_STORED_reg[15]  ( .D(n101), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_STORED[15]) );
  DFFRX1M \ALU_OUT_STORED_reg[1]  ( .D(n87), .CK(CLK), .RN(RST), .QN(n14) );
  DFFRX1M \ALU_OUT_STORED_reg[2]  ( .D(n88), .CK(CLK), .RN(RST), .QN(n15) );
  DFFRX1M \ALU_OUT_STORED_reg[3]  ( .D(n89), .CK(CLK), .RN(RST), .QN(n16) );
  DFFRX1M \ALU_OUT_STORED_reg[4]  ( .D(n90), .CK(CLK), .RN(RST), .QN(n17) );
  DFFRX1M \ALU_OUT_STORED_reg[5]  ( .D(n91), .CK(CLK), .RN(RST), .QN(n18) );
  DFFRX1M \ALU_OUT_STORED_reg[6]  ( .D(n92), .CK(CLK), .RN(RST), .QN(n19) );
  DFFRX1M \ALU_OUT_STORED_reg[7]  ( .D(n93), .CK(CLK), .RN(RST), .QN(n20) );
  DFFRX1M \ALU_OUT_STORED_reg[0]  ( .D(n102), .CK(CLK), .RN(RST), .QN(n21) );
  DFFRX1M \Address_STORED_reg[1]  ( .D(n83), .CK(CLK), .RN(RST), .QN(n22) );
  DFFRX1M \Address_STORED_reg[2]  ( .D(n84), .CK(CLK), .RN(RST), .QN(n23) );
  DFFRX1M \Address_STORED_reg[3]  ( .D(n85), .CK(CLK), .RN(RST), .QN(n24) );
  DFFRX1M \Address_STORED_reg[0]  ( .D(n86), .CK(CLK), .RN(RST), .QN(n25) );
  DFFRQX2M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(CLK), .RN(RST), .Q(
        Current_State[1]) );
  DFFRQX2M \Current_State_reg[3]  ( .D(Next_State[3]), .CK(CLK), .RN(RST), .Q(
        Current_State[3]) );
  DFFRQX2M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(CLK), .RN(RST), .Q(
        Current_State[0]) );
  DFFRQX2M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(CLK), .RN(RST), .Q(
        Current_State[2]) );
  INVX2M U2 ( .A(1'b0), .Y(clk_div_en) );
  NOR2X2M U4 ( .A(n42), .B(n35), .Y(ALU_FUN[3]) );
  OAI22X1M U5 ( .A0(n46), .A1(n68), .B0(n109), .B1(n25), .Y(Address[0]) );
  NOR2X2M U6 ( .A(n109), .B(n24), .Y(Address[3]) );
  NOR2X2M U7 ( .A(n109), .B(n23), .Y(Address[2]) );
  NOR2X2M U8 ( .A(n43), .B(n35), .Y(ALU_FUN[2]) );
  NOR2X2M U9 ( .A(n45), .B(n35), .Y(ALU_FUN[0]) );
  AOI21X2M U10 ( .A0(RX_D_VLD), .A1(n49), .B0(RdEn), .Y(n109) );
  INVX2M U11 ( .A(EN), .Y(n35) );
  INVX2M U12 ( .A(WrEn), .Y(n30) );
  NOR2X2M U13 ( .A(n36), .B(n71), .Y(n50) );
  INVX2M U14 ( .A(n65), .Y(n31) );
  NAND4X2M U15 ( .A(n50), .B(n80), .C(n63), .D(n31), .Y(CLK_EN) );
  INVX2M U16 ( .A(n68), .Y(n36) );
  NAND3BX2M U17 ( .AN(n54), .B(n51), .C(n29), .Y(TX_D_VLD) );
  INVX2M U18 ( .A(n3), .Y(n29) );
  AOI2B1X1M U19 ( .A1N(n49), .A0(n50), .B0(n46), .Y(WrEn) );
  NOR2X2M U20 ( .A(n80), .B(n46), .Y(EN) );
  NOR2X2M U21 ( .A(n44), .B(n35), .Y(ALU_FUN[1]) );
  INVX2M U22 ( .A(n62), .Y(RdEn) );
  INVX2M U23 ( .A(n63), .Y(n27) );
  NOR3BX2M U24 ( .AN(n106), .B(n40), .C(n44), .Y(n81) );
  NOR2X2M U25 ( .A(n45), .B(n30), .Y(WrData[0]) );
  NOR2X2M U26 ( .A(n44), .B(n30), .Y(WrData[1]) );
  NOR2X2M U27 ( .A(n43), .B(n30), .Y(WrData[2]) );
  NOR2X2M U28 ( .A(n42), .B(n30), .Y(WrData[3]) );
  NOR2X2M U29 ( .A(n30), .B(n41), .Y(WrData[4]) );
  NOR2X2M U30 ( .A(n30), .B(n40), .Y(WrData[5]) );
  NOR2X2M U31 ( .A(n109), .B(n22), .Y(Address[1]) );
  OAI22X1M U32 ( .A0(n48), .A1(n45), .B0(n33), .B1(n25), .Y(n86) );
  OAI22X1M U33 ( .A0(n48), .A1(n42), .B0(n33), .B1(n24), .Y(n85) );
  OAI22X1M U34 ( .A0(n48), .A1(n43), .B0(n33), .B1(n23), .Y(n84) );
  OAI22X1M U35 ( .A0(n48), .A1(n44), .B0(n33), .B1(n22), .Y(n83) );
  INVX2M U36 ( .A(n47), .Y(n32) );
  INVX2M U37 ( .A(n48), .Y(n33) );
  AO21XLM U38 ( .A0(n34), .A1(n73), .B0(n71), .Y(n105) );
  NOR3X2M U39 ( .A(Current_State[0]), .B(Current_State[2]), .C(n34), .Y(n65)
         );
  NOR2X2M U40 ( .A(n38), .B(Current_State[2]), .Y(n73) );
  NOR2X2M U41 ( .A(n37), .B(Current_State[3]), .Y(n103) );
  NAND3X2M U42 ( .A(Current_State[3]), .B(n37), .C(n73), .Y(n63) );
  INVX2M U43 ( .A(Current_State[1]), .Y(n37) );
  NAND3X2M U44 ( .A(n103), .B(n38), .C(Current_State[2]), .Y(n68) );
  NAND3X2M U45 ( .A(n103), .B(Current_State[0]), .C(Current_State[2]), .Y(n80)
         );
  INVX2M U46 ( .A(Current_State[3]), .Y(n34) );
  AND4X2M U47 ( .A(Current_State[2]), .B(Current_State[0]), .C(n37), .D(n34), 
        .Y(n71) );
  INVX2M U48 ( .A(Current_State[0]), .Y(n38) );
  NOR3BX2M U49 ( .AN(n103), .B(Current_State[2]), .C(Current_State[0]), .Y(n49) );
  NOR3X2M U50 ( .A(n31), .B(FIFO_FULL), .C(n37), .Y(n54) );
  NAND2BX2M U51 ( .AN(FIFO_FULL), .B(n27), .Y(n51) );
  NAND4X2M U52 ( .A(Current_State[2]), .B(n38), .C(n37), .D(n34), .Y(n62) );
  INVX2M U53 ( .A(RX_D_VLD), .Y(n46) );
  INVX2M U54 ( .A(RX_P_DATA[1]), .Y(n44) );
  INVX2M U55 ( .A(RX_P_DATA[2]), .Y(n43) );
  INVX2M U56 ( .A(RX_P_DATA[3]), .Y(n42) );
  BUFX2M U57 ( .A(n53), .Y(n3) );
  NOR3X2M U58 ( .A(n62), .B(FIFO_FULL), .C(n39), .Y(n53) );
  NAND4X2M U59 ( .A(n51), .B(n68), .C(n69), .D(n70), .Y(Next_State[1]) );
  AOI32X1M U60 ( .A0(Current_State[1]), .A1(n65), .A2(FIFO_FULL), .B0(n33), 
        .B1(n37), .Y(n69) );
  AOI221XLM U61 ( .A0(n71), .A1(RX_D_VLD), .B0(n49), .B1(n46), .C0(n72), .Y(
        n70) );
  NOR2BX2M U62 ( .AN(RX_P_DATA[6]), .B(n30), .Y(WrData[6]) );
  NOR2BX2M U63 ( .AN(RX_P_DATA[7]), .B(n30), .Y(WrData[7]) );
  INVX2M U64 ( .A(n77), .Y(n26) );
  OAI32X1M U65 ( .A0(n78), .A1(n41), .A2(n79), .B0(RX_D_VLD), .B1(n80), .Y(n77) );
  NAND3X2M U66 ( .A(n44), .B(n40), .C(RX_P_DATA[0]), .Y(n78) );
  OAI21X2M U67 ( .A0(n21), .A1(n51), .B0(n61), .Y(TX_P_DATA[0]) );
  AOI22X1M U68 ( .A0(RdData[0]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[8]), 
        .Y(n61) );
  OAI21X2M U69 ( .A0(n14), .A1(n51), .B0(n60), .Y(TX_P_DATA[1]) );
  AOI22X1M U70 ( .A0(RdData[1]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[9]), 
        .Y(n60) );
  OAI21X2M U71 ( .A0(n15), .A1(n51), .B0(n59), .Y(TX_P_DATA[2]) );
  AOI22X1M U72 ( .A0(RdData[2]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[10]), 
        .Y(n59) );
  OAI21X2M U73 ( .A0(n16), .A1(n51), .B0(n58), .Y(TX_P_DATA[3]) );
  AOI22X1M U74 ( .A0(RdData[3]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[11]), 
        .Y(n58) );
  OAI21X2M U75 ( .A0(n17), .A1(n51), .B0(n57), .Y(TX_P_DATA[4]) );
  AOI22X1M U76 ( .A0(RdData[4]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[12]), 
        .Y(n57) );
  OAI21X2M U77 ( .A0(n18), .A1(n51), .B0(n56), .Y(TX_P_DATA[5]) );
  AOI22X1M U78 ( .A0(RdData[5]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[13]), 
        .Y(n56) );
  OAI21X2M U79 ( .A0(n19), .A1(n51), .B0(n55), .Y(TX_P_DATA[6]) );
  AOI22X1M U80 ( .A0(RdData[6]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[14]), 
        .Y(n55) );
  OAI21X2M U81 ( .A0(n20), .A1(n51), .B0(n52), .Y(TX_P_DATA[7]) );
  AOI22X1M U82 ( .A0(RdData[7]), .A1(n3), .B0(n54), .B1(ALU_OUT_STORED[15]), 
        .Y(n52) );
  NAND2X2M U83 ( .A(n76), .B(n26), .Y(n72) );
  AOI33X2M U84 ( .A0(n81), .A1(RX_P_DATA[4]), .A2(n82), .B0(n73), .B1(n46), 
        .B2(n103), .Y(n76) );
  NOR3X2M U85 ( .A(n45), .B(RX_P_DATA[6]), .C(RX_P_DATA[2]), .Y(n82) );
  INVX2M U86 ( .A(RX_P_DATA[0]), .Y(n45) );
  NAND4BX1M U87 ( .AN(n67), .B(n47), .C(n74), .D(n75), .Y(Next_State[0]) );
  AOI32X1M U88 ( .A0(n81), .A1(n45), .A2(n104), .B0(n105), .B1(n46), .Y(n74)
         );
  AOI221XLM U89 ( .A0(FIFO_FULL), .A1(n27), .B0(n36), .B1(RX_D_VLD), .C0(n72), 
        .Y(n75) );
  NOR3X2M U90 ( .A(RX_P_DATA[2]), .B(RX_P_DATA[6]), .C(RX_P_DATA[4]), .Y(n104)
         );
  AND4X2M U91 ( .A(RX_P_DATA[3]), .B(RX_D_VLD), .C(RX_P_DATA[7]), .D(n108), 
        .Y(n106) );
  NOR4X1M U92 ( .A(Current_State[3]), .B(Current_State[2]), .C(
        Current_State[1]), .D(Current_State[0]), .Y(n108) );
  NAND3X2M U93 ( .A(RX_P_DATA[6]), .B(RX_P_DATA[2]), .C(n106), .Y(n79) );
  NAND3X2M U94 ( .A(n26), .B(n50), .C(n66), .Y(Next_State[2]) );
  AOI221XLM U95 ( .A0(RdEn), .A1(n39), .B0(Current_State[1]), .B1(n33), .C0(
        n67), .Y(n66) );
  INVX2M U96 ( .A(RdData_Valid), .Y(n39) );
  NOR3BX2M U97 ( .AN(n107), .B(n79), .C(RX_P_DATA[0]), .Y(n67) );
  NOR3X2M U98 ( .A(RX_P_DATA[1]), .B(RX_P_DATA[5]), .C(RX_P_DATA[4]), .Y(n107)
         );
  NAND3X2M U99 ( .A(n65), .B(n37), .C(OUT_Valid), .Y(n47) );
  NAND3X2M U100 ( .A(n73), .B(n34), .C(RX_D_VLD), .Y(n48) );
  OAI2BB2X1M U101 ( .B0(n32), .B1(n21), .A0N(ALU_OUT[0]), .A1N(n32), .Y(n102)
         );
  OAI2BB2X1M U102 ( .B0(n32), .B1(n20), .A0N(ALU_OUT[7]), .A1N(n32), .Y(n93)
         );
  OAI2BB2X1M U103 ( .B0(n32), .B1(n19), .A0N(ALU_OUT[6]), .A1N(n32), .Y(n92)
         );
  OAI2BB2X1M U104 ( .B0(n32), .B1(n18), .A0N(ALU_OUT[5]), .A1N(n32), .Y(n91)
         );
  OAI2BB2X1M U105 ( .B0(n32), .B1(n17), .A0N(ALU_OUT[4]), .A1N(n32), .Y(n90)
         );
  OAI2BB2X1M U106 ( .B0(n32), .B1(n16), .A0N(ALU_OUT[3]), .A1N(n32), .Y(n89)
         );
  OAI2BB2X1M U107 ( .B0(n32), .B1(n15), .A0N(ALU_OUT[2]), .A1N(n32), .Y(n88)
         );
  OAI2BB2X1M U108 ( .B0(n32), .B1(n14), .A0N(ALU_OUT[1]), .A1N(n32), .Y(n87)
         );
  INVX2M U109 ( .A(RX_P_DATA[5]), .Y(n40) );
  INVX2M U110 ( .A(RX_P_DATA[4]), .Y(n41) );
  NAND3X2M U111 ( .A(n63), .B(n35), .C(n64), .Y(Next_State[3]) );
  OAI21X2M U112 ( .A0(FIFO_FULL), .A1(n37), .B0(n65), .Y(n64) );
  AO22X1M U113 ( .A0(n47), .A1(ALU_OUT_STORED[15]), .B0(ALU_OUT[15]), .B1(n32), 
        .Y(n101) );
  AO22X1M U114 ( .A0(n47), .A1(ALU_OUT_STORED[14]), .B0(ALU_OUT[14]), .B1(n32), 
        .Y(n100) );
  AO22X1M U115 ( .A0(n47), .A1(ALU_OUT_STORED[13]), .B0(ALU_OUT[13]), .B1(n32), 
        .Y(n99) );
  AO22X1M U116 ( .A0(n47), .A1(ALU_OUT_STORED[12]), .B0(ALU_OUT[12]), .B1(n32), 
        .Y(n98) );
  AO22X1M U117 ( .A0(n47), .A1(ALU_OUT_STORED[11]), .B0(ALU_OUT[11]), .B1(n32), 
        .Y(n97) );
  AO22X1M U118 ( .A0(n47), .A1(ALU_OUT_STORED[10]), .B0(ALU_OUT[10]), .B1(n32), 
        .Y(n96) );
  AO22X1M U119 ( .A0(n47), .A1(ALU_OUT_STORED[9]), .B0(ALU_OUT[9]), .B1(n32), 
        .Y(n95) );
  AO22X1M U120 ( .A0(n47), .A1(ALU_OUT_STORED[8]), .B0(ALU_OUT[8]), .B1(n32), 
        .Y(n94) );
endmodule


module SYS_TOP ( REF_CLK, UART_CLK, RST_N, UART_RX_IN, UART_TX_O, parity_error, 
        framing_error );
  input REF_CLK, UART_CLK, RST_N, UART_RX_IN;
  output UART_TX_O, parity_error, framing_error;
  wire   SYNC_REF_RST, SYNC_UART_RST, RX_CLK, TX_CLK, TX_Busy, RX_Data_Valid,
         RD_INC, SYNC_RX_Data_Valid, WR_INC, FIFO_FULL, F_EMPTY, CLK_EN,
         ALU_CLK, ALU_EN, ALU_OUT_VALID, WrEn, RdEn, Rd_D_Vld, n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11;
  wire   [3:0] RX_DIV_RATIO;
  wire   [7:0] UART_CONFIG;
  wire   [7:0] TX_DIV_RATIO;
  wire   [7:0] TX_P_DATA;
  wire   [7:0] RX_P_DATA;
  wire   [7:0] SYNC_RX_P_DATA;
  wire   [7:0] WR_DATA;
  wire   [7:0] OP_A;
  wire   [7:0] OP_B;
  wire   [3:0] ALU_FUN;
  wire   [15:0] ALU_OUT;
  wire   [7:0] Wr_D;
  wire   [3:0] MEM_Addr;
  wire   [7:0] Rd_D;

  RST_SYNC_NUM_STAGES2_0 RST_SYNC_1 ( .CLK(REF_CLK), .RST(RST_N), .SYNC_RST(
        SYNC_REF_RST) );
  RST_SYNC_NUM_STAGES2_1 RST_SYNC_2 ( .CLK(UART_CLK), .RST(RST_N), .SYNC_RST(
        SYNC_UART_RST) );
  ClkDiv_WIDTH4 RX_CLK_GEN ( .i_ref_clk(UART_CLK), .i_rst_n(n8), .i_clk_en(
        1'b1), .i_div_ratio(RX_DIV_RATIO), .o_div_clk(RX_CLK) );
  Prescale_MUX_DIV_RATIO_WIDTH4 RX_DIV_RATIO_GEN ( .Prescale(UART_CONFIG[7:2]), 
        .DIV_RATIO(RX_DIV_RATIO) );
  ClkDiv_WIDTH8 TX_CLK_GEN ( .i_ref_clk(UART_CLK), .i_rst_n(n8), .i_clk_en(
        1'b1), .i_div_ratio(TX_DIV_RATIO), .o_div_clk(TX_CLK) );
  UART_DATA_WIDTH8 UART_UNIT ( .RST(n8), .TX_CLK(TX_CLK), .RX_CLK(RX_CLK), 
        .TX_P_DATA(TX_P_DATA), .TX_Data_Valid(n1), .TX_OUT(UART_TX_O), 
        .TX_Busy(TX_Busy), .RX_IN(n2), .RX_P_DATA(RX_P_DATA), .RX_Data_Valid(
        RX_Data_Valid), .Parity_Error(parity_error), .Stop_Error(framing_error), .PAR_EN(UART_CONFIG[0]), .PAR_TYP(UART_CONFIG[1]), .Prescale(
        UART_CONFIG[7:2]) );
  PULSE_GEN RD_INC_UNIT ( .CLK(TX_CLK), .RST(n8), .LVL_SIG(TX_Busy), 
        .PULSE_SIG(RD_INC) );
  DATA_SYNC_NUM_STAGES2_BUS_WIDTH8 DATA_SYNC_UNIT ( .CLK(REF_CLK), .RST(n10), 
        .bus_enable(RX_Data_Valid), .unsync_bus(RX_P_DATA), .sync_bus(
        SYNC_RX_P_DATA), .enable_pulse(SYNC_RX_Data_Valid) );
  FIFO_TOP_DATA_WIDTH8_ADDR_SIZE3 FIFO_UNIT ( .wclk(REF_CLK), .wrst_n(n10), 
        .winc(WR_INC), .wdata(WR_DATA), .wfull(FIFO_FULL), .rclk(TX_CLK), 
        .rrst_n(n8), .rinc(RD_INC), .rdata(TX_P_DATA), .rempty(F_EMPTY) );
  CLK_GATE CLK_GATE_UNIT ( .CLK_EN(CLK_EN), .CLK(REF_CLK), .GATED_CLK(ALU_CLK)
         );
  ALU_OPERAND_WIDTH8_OUT_WIDTH16 ALU_UNIT ( .A({OP_A[7:6], n7, OP_A[4], n6, 
        OP_A[2:0]}), .B({OP_B[7:5], n5, OP_B[3], n4, n3, OP_B[0]}), .EN(ALU_EN), .ALU_FUN(ALU_FUN), .CLK(ALU_CLK), .RST(n10), .ALU_OUT(ALU_OUT), .OUT_VALID(
        ALU_OUT_VALID) );
  Register_File_DEPTH16_DATA_WIDTH8_ADDRESS_WIDTH4 REG_FILE_UNIT ( .WrData(
        Wr_D), .Address(MEM_Addr), .WrEn(WrEn), .RdEn(RdEn), .CLK(REF_CLK), 
        .RST(n10), .RdData(Rd_D), .RdData_Valid(Rd_D_Vld), .REG0(OP_A), .REG1(
        OP_B), .REG2(UART_CONFIG), .REG3(TX_DIV_RATIO) );
  SYS_CTRL_OP_WIDTH8_ALU_OUT_WIDTH16_REG_WIDTH8_REG_DEPTH16_ADDRESS_WIDTH4_UART_DATA_WIDTH8 SYS_CTRL_UNIT ( 
        .CLK(REF_CLK), .RST(n10), .ALU_OUT(ALU_OUT), .OUT_Valid(ALU_OUT_VALID), 
        .ALU_FUN(ALU_FUN), .EN(ALU_EN), .CLK_EN(CLK_EN), .RdData(Rd_D), 
        .RdData_Valid(Rd_D_Vld), .Address(MEM_Addr), .WrEn(WrEn), .RdEn(RdEn), 
        .WrData(Wr_D), .RX_P_DATA(SYNC_RX_P_DATA), .RX_D_VLD(
        SYNC_RX_Data_Valid), .TX_P_DATA(WR_DATA), .TX_D_VLD(WR_INC), 
        .FIFO_FULL(FIFO_FULL) );
  BUFX2M U3 ( .A(OP_B[2]), .Y(n4) );
  BUFX2M U4 ( .A(OP_B[1]), .Y(n3) );
  BUFX2M U5 ( .A(OP_B[4]), .Y(n5) );
  BUFX2M U6 ( .A(OP_A[5]), .Y(n7) );
  BUFX2M U7 ( .A(OP_A[3]), .Y(n6) );
  BUFX2M U8 ( .A(UART_RX_IN), .Y(n2) );
  INVX2M U9 ( .A(F_EMPTY), .Y(n1) );
  INVX4M U10 ( .A(n9), .Y(n8) );
  INVX2M U11 ( .A(SYNC_UART_RST), .Y(n9) );
  INVX4M U12 ( .A(n11), .Y(n10) );
  INVX2M U13 ( .A(SYNC_REF_RST), .Y(n11) );
endmodule

