`timescale 1ns / 1ps
module RST_SYNC_TB;

parameter CLK_PERIOD = 5;
parameter NUM_STAGES = 5;

reg  CLK_TB;
reg  RST_TB;
wire SYNC_RST_TB;

reg  posedge_flag;

// ---------------------------------------------------------------
// DUT instantiation
// ---------------------------------------------------------------
RST_SYNC #(.NUM_STAGES(NUM_STAGES)) DUT (
    .CLK      (CLK_TB),
    .RST      (RST_TB),
    .SYNC_RST (SYNC_RST_TB)
);

// ---------------------------------------------------------------
// Clock generation
// ---------------------------------------------------------------
always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB;

// ---------------------------------------------------------------
// Posedge marker (short pulse right after each CLK posedge)
// ---------------------------------------------------------------
always @(posedge CLK_TB) begin
    posedge_flag = 1'b1;
    #0.1 posedge_flag = 1'b0;
end

// ---------------------------------------------------------------
// Checker: RST assertion must be asynchronous (independent of CLK)
// ---------------------------------------------------------------
always @(negedge RST_TB) begin
    #0.1;
    if (SYNC_RST_TB !== 1'b0)
        $display("FAIL [ASYNC ASSERT] @%0t: SYNC_RST_TB did not drop immediately", $time);
    else
        $display("PASS [ASYNC ASSERT] @%0t: SYNC_RST_TB dropped immediately, independent of CLK", $time);
end

// ---------------------------------------------------------------
// Checker: SYNC_RST deassertion must be synchronous (aligned to CLK posedge)
// ---------------------------------------------------------------
always @(posedge SYNC_RST_TB) begin
    if (posedge_flag !== 1'b1)
        $display("FAIL [SYNC DEASSERT] @%0t: SYNC_RST_TB rose without a coincident CLK posedge", $time);
    else
        $display("PASS [SYNC DEASSERT] @%0t: SYNC_RST_TB rose exactly on a CLK posedge", $time);
end

// ---------------------------------------------------------------
// Stimulus
// ---------------------------------------------------------------
initial begin
    CLK_TB = 1'b0;
    RST_TB = 1'b0;
    posedge_flag = 1'b0;

    @(negedge CLK_TB);
    #1 RST_TB = 1'b1;
    repeat (NUM_STAGES + 2) @(posedge CLK_TB);

    @(posedge CLK_TB);
    #1 RST_TB = 1'b0;
    #1;                   
    #1 RST_TB = 1'b1;     

    repeat (NUM_STAGES + 2) @(posedge CLK_TB);

    $display("Testbench complete @%0t", $time);
    $stop;
end

// ---------------------------------------------------------------
// Waveform dump
// ---------------------------------------------------------------
initial begin
    $dumpfile("rst_sync_tb.vcd");
    $dumpvars(0, RST_SYNC_TB);
end

endmodule