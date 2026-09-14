`timescale 1ns / 100ps
module Register_File_TB;
    localparam CLK_PERIOD = 10; //  no timing spec given

    reg  [15:0] WrData_TB;
    reg  [2:0]  Address_TB;
    reg         WrEn_TB, RdEn_TB;
    reg         CLK_TB, RST_TB;

    wire [15:0] RdData_TB;

    //______________________________________________________________________
    // Clock generator 
    //______________________________________________________________________
    initial CLK_TB = 1'b0;
    always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB;

    //______________________________________________________________________
    // Design instantiation
    //______________________________________________________________________
    Register_File uut (
        .WrData(WrData_TB), .Address(Address_TB),
        .WrEn(WrEn_TB), .RdEn(RdEn_TB),
        .CLK(CLK_TB), .RST(RST_TB),
        .RdData(RdData_TB)
    );

    initial begin
        $dumpfile("register_file.vcd");
        $dumpvars;

        WrData_TB = 0; Address_TB = 0; WrEn_TB = 0; RdEn_TB = 0;

        //__________________________________________________________________
        $display("*** TEST CASE 0 -- Asynchronous Reset ***");
        RST_TB = 1'b0;
        #(CLK_PERIOD)
        RST_TB = 1'b1;
        Address_TB = 3'd0; WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h0000)
            $display("Test case 0 PASSED - regfile[0] cleared at time %0t, RdData = %h", $time, RdData_TB);
        else
            $display("Test case 0 FAILED at time %0t, RdData = %h", $time, RdData_TB);

        //__________________________________________________________________
        // WRITE / READ -- one pattern per register location
        //__________________________________________________________________
        $display("*** TEST CASE 1 -- Write/Read Address 0 ***");
        Address_TB = 3'd0; WrData_TB = 16'hA5A5; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'hA5A5)
            $display("Write/Read Addr 0 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 0 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 2 -- Write/Read Address 1 ***");
        Address_TB = 3'd1; WrData_TB = 16'h1234; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h1234)
            $display("Write/Read Addr 1 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 1 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 3 -- Write/Read Address 2 ***");
        Address_TB = 3'd2; WrData_TB = 16'hFFFF; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'hFFFF)
            $display("Write/Read Addr 2 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 2 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 4 -- Write/Read Address 3 ***");
        Address_TB = 3'd3; WrData_TB = 16'h0F0F; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h0F0F)
            $display("Write/Read Addr 3 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 3 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 5 -- Write/Read Address 4 ***");
        Address_TB = 3'd4; WrData_TB = 16'hDEAD; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'hDEAD)
            $display("Write/Read Addr 4 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 4 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 6 -- Write/Read Address 5 ***");
        Address_TB = 3'd5; WrData_TB = 16'hBEEF; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'hBEEF)
            $display("Write/Read Addr 5 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 5 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 7 -- Write/Read Address 6 ***");
        Address_TB = 3'd6; WrData_TB = 16'h0001; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h0001)
            $display("Write/Read Addr 6 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 6 FAILED = %h", RdData_TB);

        $display("*** TEST CASE 8 -- Write/Read Address 7 ***");
        Address_TB = 3'd7; WrData_TB = 16'h8000; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h8000)
            $display("Write/Read Addr 7 PASSED = %h", RdData_TB);
        else
            $display("Write/Read Addr 7 FAILED = %h", RdData_TB);

        //__________________________________________________________________
        // CONTROL -- simultaneous WrEn & RdEn should perform neither
        //__________________________________________________________________
        $display("*** TEST CASE 9 -- Simultaneous WrEn & RdEn (No Write) ***");
        Address_TB = 3'd3; WrData_TB = 16'hC0C0; WrEn_TB = 1'b1; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h0F0F)
            $display("Simultaneous WrEn&RdEn PASSED - Addr 3 unchanged = %h", RdData_TB);
        else
            $display("Simultaneous WrEn&RdEn FAILED - Addr 3 = %h", RdData_TB);

        //__________________________________________________________________
        // CONTROL -- WrEn = RdEn = 0 should hold RdData at its last value
        //__________________________________________________________________
        $display("*** TEST CASE 10 -- No Operation (WrEn=0, RdEn=0) ***");
        WrEn_TB = 1'b0; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h0F0F)
            $display("No Operation PASSED - RdData held = %h", RdData_TB);
        else
            $display("No Operation FAILED - RdData = %h", RdData_TB);

        //__________________________________________________________________
        // WRITING IN A REGISTER AND DISPLAYING ITS CONTENT
        //__________________________________________________________________
        $display("*** TEST CASE 11 -- Overwrite Address 0 ***");
        Address_TB = 3'd0; WrData_TB = 16'h5555; WrEn_TB = 1'b1; RdEn_TB = 1'b0;
        #(CLK_PERIOD)
        WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h5555)
            $display("Overwrite Addr 0 PASSED = %h", RdData_TB);
        else
            $display("Overwrite Addr 0 FAILED = %h", RdData_TB);

        //__________________________________________________________________
        // RESET -- confirm asynchronous reset clears a previously
        //____________________________________
        $display("*** TEST CASE 12 -- Reset Clears Written Data ***");
        RST_TB = 1'b0;
        #(CLK_PERIOD)
        RST_TB = 1'b1;
        Address_TB = 3'd0; WrEn_TB = 1'b0; RdEn_TB = 1'b1;
        #(CLK_PERIOD)
        if (RdData_TB == 16'h0000)
            $display("Reset Clears Data PASSED - Addr 0 = %h", RdData_TB);
        else
            $display("Reset Clears Data FAILED - Addr 0 = %h", RdData_TB);

        $finish;
    end

endmodule