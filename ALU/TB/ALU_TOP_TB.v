`timescale 1ns / 100ps
module ALU_TOP_TB;
    localparam LOW_TIME   = 4000;               // ns
    localparam HIGH_TIME  = 6000;               // ns
    localparam CLK_PERIOD = LOW_TIME+HIGH_TIME; // 10000 ns

    reg  signed [15:0] A_TB, B_TB;
    reg         [3:0]  ALU_FUNC_TB;
    reg                CLK_TB, RST_TB;

    wire signed [31:0] Arith_OUT_TB;
    wire        [15:0] Shift_OUT_TB;
    wire        [15:0] Logic_OUT_TB;
    wire        [1:0]  CMP_OUT_TB;
    wire               Arith_Flag_TB, Shift_Flag_TB, Logic_Flag_TB, CMP_Flag_TB;

    // Packed flags: {Arith,Logic,CMP,Shift} 
    wire [3:0] Flags_TB = {Arith_Flag_TB, Logic_Flag_TB, CMP_Flag_TB, Shift_Flag_TB};

    //______________________________________________________________________
    // Clock generator
    //______________________________________________________________________
    initial CLK_TB = 1'b0;
    always begin
        #LOW_TIME  CLK_TB = 1'b1;   // rising edge after the LOW phase
        #HIGH_TIME CLK_TB = 1'b0;   // falling edge after the HIGH phase
    end

    //______________________________________________________________________
    // Design instantiation
    //______________________________________________________________________
    ALU_TOP uut (
        .A(A_TB), .B(B_TB), .ALU_FUN(ALU_FUNC_TB),
        .CLK(CLK_TB), .RST(RST_TB),
        .Arith_OUT(Arith_OUT_TB), .Shift_OUT(Shift_OUT_TB),
        .Logic_OUT(Logic_OUT_TB), .CMP_OUT(CMP_OUT_TB),
        .Arith_Flag(Arith_Flag_TB), .Shift_Flag(Shift_Flag_TB),
        .Logic_Flag(Logic_Flag_TB), .CMP_Flag(CMP_Flag_TB)
    );

    initial begin
        $dumpfile("alu_top.vcd");
        $dumpvars;

        A_TB = 0; B_TB = 0; ALU_FUNC_TB = 4'b0000;

        //__________________________________________________________________
        $display("*** TEST CASE 0 -- Asynchronous Reset ***");
        RST_TB = 1'b0;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 0 && Logic_OUT_TB == 0 && CMP_OUT_TB == 0 &&
            Shift_OUT_TB == 0 && Flags_TB == 4'b0000)
            $display("Test case 0 PASSED - all outputs/flags cleared at time %0t", $time);
        else
            $display("Test case 0 FAILED at time %0t", $time);
        RST_TB = 1'b1;

        //__________________________________________________________________
        // ARITHMETIC -- Signed Addition
        //__________________________________________________________________
        $display("*** TEST CASE 1 -- Addition -- NEG + NEG ***");
        A_TB = -16'sd4; B_TB = -16'sd10; ALU_FUNC_TB = 4'b0000;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd14 && Flags_TB == 4'd8)
            $display("Addition %0d + %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Addition %0d + %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 2 -- Addition -- POS + NEG ***");
        A_TB = 16'sd15; B_TB = -16'sd7; ALU_FUNC_TB = 4'b0000;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd8 && Flags_TB == 4'd8)
            $display("Addition %0d + %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Addition %0d + %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 3 -- Addition -- NEG + POS ***");
        A_TB = -16'sd15; B_TB = 16'sd7; ALU_FUNC_TB = 4'b0000;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd8 && Flags_TB == 4'd8)
            $display("Addition %0d + %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Addition %0d + %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 4 -- Addition -- POS + POS ***");
        A_TB = 16'sd10; B_TB = 16'sd5; ALU_FUNC_TB = 4'b0000;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd15 && Flags_TB == 4'd8)
            $display("Addition %0d + %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Addition %0d + %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        //__________________________________________________________________
        // ARITHMETIC -- Signed Subtraction
        //__________________________________________________________________
        $display("*** TEST CASE 5 -- Subtraction -- NEG - NEG ***");
        A_TB = -16'sd4; B_TB = -16'sd10; ALU_FUNC_TB = 4'b0001;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd6 && Flags_TB == 4'd8)
            $display("Subtraction %0d - %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Subtraction %0d - %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 6 -- Subtraction -- POS - NEG ***");
        A_TB = 16'sd15; B_TB = -16'sd5; ALU_FUNC_TB = 4'b0001;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd20 && Flags_TB == 4'd8)
            $display("Subtraction %0d - %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Subtraction %0d - %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 7 -- Subtraction -- NEG - POS ***");
        A_TB = -16'sd15; B_TB = 16'sd5; ALU_FUNC_TB = 4'b0001;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd20 && Flags_TB == 4'd8)
            $display("Subtraction %0d - %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Subtraction %0d - %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 8 -- Subtraction -- POS - POS ***");
        A_TB = 16'sd20; B_TB = 16'sd5; ALU_FUNC_TB = 4'b0001;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd15 && Flags_TB == 4'd8)
            $display("Subtraction %0d - %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Subtraction %0d - %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        //__________________________________________________________________
        // ARITHMETIC -- Signed Multiplication
        //__________________________________________________________________
        $display("*** TEST CASE 9 -- Multiplication -- NEG * NEG ***");
        A_TB = -16'sd4; B_TB = -16'sd5; ALU_FUNC_TB = 4'b0010;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd20 && Flags_TB == 4'd8)
            $display("Multiplication %0d * %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Multiplication %0d * %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 10 -- Multiplication -- POS * NEG ***");
        A_TB = 16'sd6; B_TB = -16'sd3; ALU_FUNC_TB = 4'b0010;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd18 && Flags_TB == 4'd8)
            $display("Multiplication %0d * %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Multiplication %0d * %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 11 -- Multiplication -- NEG * POS ***");
        A_TB = -16'sd6; B_TB = 16'sd3; ALU_FUNC_TB = 4'b0010;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd18 && Flags_TB == 4'd8)
            $display("Multiplication %0d * %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Multiplication %0d * %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 12 -- Multiplication -- POS * POS ***");
        A_TB = 16'sd4; B_TB = 16'sd5; ALU_FUNC_TB = 4'b0010;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd20 && Flags_TB == 4'd8)
            $display("Multiplication %0d * %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Multiplication %0d * %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        //__________________________________________________________________
        // ARITHMETIC -- Signed Division
        //__________________________________________________________________
        $display("*** TEST CASE 13 -- Division -- NEG / NEG ***");
        A_TB = -16'sd20; B_TB = -16'sd4; ALU_FUNC_TB = 4'b0011;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd5 && Flags_TB == 4'd8)
            $display("Division %0d / %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Division %0d / %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 14 -- Division -- POS / NEG ***");
        A_TB = 16'sd20; B_TB = -16'sd4; ALU_FUNC_TB = 4'b0011;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd5 && Flags_TB == 4'd8)
            $display("Division %0d / %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Division %0d / %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 15 -- Division -- NEG / POS ***");
        A_TB = -16'sd20; B_TB = 16'sd4; ALU_FUNC_TB = 4'b0011;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == -32'sd5 && Flags_TB == 4'd8)
            $display("Division %0d / %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Division %0d / %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        $display("*** TEST CASE 16 -- Division -- POS / POS ***");
        A_TB = 16'sd20; B_TB = 16'sd4; ALU_FUNC_TB = 4'b0011;
        #(CLK_PERIOD)
        if (Arith_OUT_TB == 32'sd5 && Flags_TB == 4'd8)
            $display("Division %0d / %0d PASSED = %0d", A_TB, B_TB, Arith_OUT_TB);
        else
            $display("Division %0d / %0d FAILED = %0d", A_TB, B_TB, Arith_OUT_TB);

        //__________________________________________________________________
        // LOGIC
        //__________________________________________________________________
        $display("*** TEST CASE 17 -- Logic AND ***");
        A_TB = 16'hF0F0; B_TB = 16'hFF00; ALU_FUNC_TB = 4'b0100;
        #(CLK_PERIOD)
        if (Logic_OUT_TB == 16'hF000 && Flags_TB == 4'd4)
            $display("AND %h & %h PASSED = %h", A_TB, B_TB, Logic_OUT_TB);
        else
            $display("AND %h & %h FAILED = %h", A_TB, B_TB, Logic_OUT_TB);

        $display("*** TEST CASE 18 -- Logic OR ***");
        A_TB = 16'hF0F0; B_TB = 16'h0F0F; ALU_FUNC_TB = 4'b0101;
        #(CLK_PERIOD)
        if (Logic_OUT_TB == 16'hFFFF && Flags_TB == 4'd4)
            $display("OR %h | %h PASSED = %h", A_TB, B_TB, Logic_OUT_TB);
        else
            $display("OR %h | %h FAILED = %h", A_TB, B_TB, Logic_OUT_TB);

        $display("*** TEST CASE 19 -- Logic NAND ***");
        A_TB = 16'hFFFF; B_TB = 16'hFFFF; ALU_FUNC_TB = 4'b0110;
        #(CLK_PERIOD)
        if (Logic_OUT_TB == 16'h0000 && Flags_TB == 4'd4)
            $display("NAND %h ~& %h PASSED = %h", A_TB, B_TB, Logic_OUT_TB);
        else
            $display("NAND %h ~& %h FAILED = %h", A_TB, B_TB, Logic_OUT_TB);

        $display("*** TEST CASE 20 -- Logic NOR ***");
        A_TB = 16'h0000; B_TB = 16'h0000; ALU_FUNC_TB = 4'b0111;
        #(CLK_PERIOD)
        if (Logic_OUT_TB == 16'hFFFF && Flags_TB == 4'd4)
            $display("NOR %h ~| %h PASSED = %h", A_TB, B_TB, Logic_OUT_TB);
        else
            $display("NOR %h ~| %h FAILED = %h", A_TB, B_TB, Logic_OUT_TB);

        //__________________________________________________________________
        // COMPARE -- signed comparisons deliberately mix +/- to catch
        // an unsigned-comparison bug (see CMP_UNIT discussion)
        //__________________________________________________________________
        $display("*** TEST CASE 21 -- Compare Equal ***");
        A_TB = -16'sd7; B_TB = -16'sd7; ALU_FUNC_TB = 4'b1001;
        #(CLK_PERIOD)
        if (CMP_OUT_TB == 2'd1 && Flags_TB == 4'd2)
            $display("CMP EQUAL %0d == %0d PASSED = %0d", A_TB, B_TB, CMP_OUT_TB);
        else
            $display("CMP EQUAL %0d == %0d FAILED = %0d", A_TB, B_TB, CMP_OUT_TB);

        $display("*** TEST CASE 22 -- Compare Greater ***");
        A_TB = 16'sd3; B_TB = -16'sd5; ALU_FUNC_TB = 4'b1010;
        #(CLK_PERIOD)
        if (CMP_OUT_TB == 2'd2 && Flags_TB == 4'd2)
            $display("CMP GREATER %0d > %0d PASSED = %0d", A_TB, B_TB, CMP_OUT_TB);
        else
            $display("CMP GREATER %0d > %0d FAILED = %0d", A_TB, B_TB, CMP_OUT_TB);

        $display("*** TEST CASE 23 -- Compare Less ***");
        A_TB = -16'sd5; B_TB = 16'sd3; ALU_FUNC_TB = 4'b1011;
        #(CLK_PERIOD)
        if (CMP_OUT_TB == 2'd3 && Flags_TB == 4'd2)
            $display("CMP LESS %0d < %0d PASSED = %0d", A_TB, B_TB, CMP_OUT_TB);
        else
            $display("CMP LESS %0d < %0d FAILED = %0d", A_TB, B_TB, CMP_OUT_TB);

        //__________________________________________________________________
        // SHIFT -- pattern chosen to confirm LOGICAL (zero-fill) shifting,
        // not arithmetic (sign-extended) shifting
        //__________________________________________________________________
        $display("*** TEST CASE 24 -- Shift A >> 1 ***");
        A_TB = 16'hF000; B_TB = 16'h0000; ALU_FUNC_TB = 4'b1100;
        #(CLK_PERIOD)
        if (Shift_OUT_TB == 16'h7800 && Flags_TB == 4'd1)
            $display("SHIFT A>>1 of %h PASSED = %h", A_TB, Shift_OUT_TB);
        else
            $display("SHIFT A>>1 of %h FAILED = %h", A_TB, Shift_OUT_TB);

        $display("*** TEST CASE 25 -- Shift A << 1 ***");
        A_TB = 16'h00FF; B_TB = 16'h0000; ALU_FUNC_TB = 4'b1101;
        #(CLK_PERIOD)
        if (Shift_OUT_TB == 16'h01FE && Flags_TB == 4'd1)
            $display("SHIFT A<<1 of %h PASSED = %h", A_TB, Shift_OUT_TB);
        else
            $display("SHIFT A<<1 of %h FAILED = %h", A_TB, Shift_OUT_TB);

        $display("*** TEST CASE 26 -- Shift B >> 1 ***");
        A_TB = 16'h0000; B_TB = 16'hF000; ALU_FUNC_TB = 4'b1110;
        #(CLK_PERIOD)
        if (Shift_OUT_TB == 16'h7800 && Flags_TB == 4'd1)
            $display("SHIFT B>>1 of %h PASSED = %h", B_TB, Shift_OUT_TB);
        else
            $display("SHIFT B>>1 of %h FAILED = %h", B_TB, Shift_OUT_TB);

        $display("*** TEST CASE 27 -- Shift B << 1 ***");
        A_TB = 16'h0000; B_TB = 16'h00FF; ALU_FUNC_TB = 4'b1111;
        #(CLK_PERIOD)
        if (Shift_OUT_TB == 16'h01FE && Flags_TB == 4'd1)
            $display("SHIFT B<<1 of %h PASSED = %h", B_TB, Shift_OUT_TB);
        else
            $display("SHIFT B<<1 of %h FAILED = %h", B_TB, Shift_OUT_TB);

        //__________________________________________________________________
        // NOP -- CMP_Flag high, CMP_OUT forced to 0, per spec
        //__________________________________________________________________
        $display("*** TEST CASE 28 -- NOP ***");
        A_TB = 16'sd9; B_TB = 16'sd9; ALU_FUNC_TB = 4'b1000;
        #(CLK_PERIOD)
        if (CMP_OUT_TB == 2'd0 && Flags_TB == 4'd2)
            $display("NOP PASSED - CMP_OUT = %0d, Flags = %b", CMP_OUT_TB, Flags_TB);
        else
            $display("NOP FAILED - CMP_OUT = %0d, Flags = %b", CMP_OUT_TB, Flags_TB);

        $finish;
    end

endmodule