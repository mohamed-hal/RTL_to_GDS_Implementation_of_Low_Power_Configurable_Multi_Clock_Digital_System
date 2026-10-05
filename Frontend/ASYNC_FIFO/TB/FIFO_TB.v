`timescale 1ns/1ps
module FIFO_TB();

parameter DATA_WIDTH = 8;
parameter ADDR_SIZE  = 3;
localparam DEPTH      = 1 << ADDR_SIZE;     // 8 words for ADDR_SIZE=3
localparam SB_DEPTH   = 4096;               // scoreboard queue depth (stress test size)

//---------------------------------------------------------------
// DUT signals
//---------------------------------------------------------------
reg                       WCLK_TB, WRST_N_TB, WINC_TB;
reg  [DATA_WIDTH - 1 : 0] WDATA_TB;
wire                      WFULL_TB;

reg                       RCLK_TB, RRST_N_TB, RINC_TB;
wire [DATA_WIDTH - 1 : 0] RDATA_TB;
wire                      REMPTY_TB;

//---------------------------------------------------------------
// Bookkeeping
//---------------------------------------------------------------
integer errors;
integer checks;

// Software reference queue (scoreboard) -- pushed by the write process
// on every *actual* accepted write, popped/compared by the read process
// on every *actual* accepted read.
reg [DATA_WIDTH - 1 : 0] sb_queue [0 : SB_DEPTH - 1];
integer sb_push_idx, sb_pop_idx;

// Cross-process handshake flags (polled with wait(), not tied to either clock)
reg b_empty_checked;      // read sets after CASE1b (reads-while-empty) finishes;
                           // gates write from starting CASE2 (must not write early!)
reg fifo_seen_full;       // set by write process once WFULL_TB observed high
reg go_drain_to_empty;
reg b_case6_drained;      // read sets after CASE6's drain loop fully catches up;
                           // gates write from starting CASE7 (must start from truly empty)
reg case6_write_done;     // write sets once its CASE6 write loop is finished
reg case7_write_done;     // write sets once its CASE7 write loop (incl. extra attempt) is finished
reg b_case7_drained;      // read sets once CASE7 is fully drained; gates write's CASE8 reset
                           // (must not reset the write domain while read is still catching up)
reg stress_run;           // gates the random stress loop on both sides
reg stress_done_w, stress_done_r;
integer stress_words;

initial begin
    errors = 0;
    checks = 0;
end

//---------------------------------------------------------------
// DUT instantiation
//---------------------------------------------------------------
FIFO_TOP #(DATA_WIDTH, ADDR_SIZE) DUT (
    .wclk   (WCLK_TB),
    .wrst_n (WRST_N_TB),
    .winc   (WINC_TB),
    .wdata  (WDATA_TB),
    .wfull  (WFULL_TB),

    .rclk   (RCLK_TB),
    .rrst_n (RRST_N_TB),
    .rinc   (RINC_TB),
    .rdata  (RDATA_TB),
    .rempty (REMPTY_TB)
);

//---------------------------------------------------------------
// Clock generation - independent, unrelated frequencies on purpose
//---------------------------------------------------------------
initial WCLK_TB = 1'b0;
always #5   WCLK_TB = ~WCLK_TB;     // 100 MHz write clock (10ns period)

initial RCLK_TB = 1'b0;
always #7   RCLK_TB = ~RCLK_TB;     // ~71 MHz read clock (14ns period), asynchronous to wclk

//---------------------------------------------------------------
// Write-domain tasks
//---------------------------------------------------------------
task w_reset;
begin
    WRST_N_TB = 1'b0;
    WINC_TB   = 1'b0;
    WDATA_TB  = {DATA_WIDTH{1'b0}};
    repeat (3) @(negedge WCLK_TB);
    WRST_N_TB = 1'b1;
    @(negedge WCLK_TB);
end
endtask

// Attempts one write. Pushes to scoreboard only if actually accepted
// (winc asserted while !wfull). Reports whether it was accepted.
task do_write(input [DATA_WIDTH-1:0] data, output accepted);
begin
    @(negedge WCLK_TB);
    WDATA_TB = data;
    WINC_TB  = 1'b1;
    accepted = !WFULL_TB;
    if (accepted) begin
        sb_queue[sb_push_idx] = data;
        sb_push_idx = sb_push_idx + 1;
    end
    @(negedge WCLK_TB);
    WINC_TB = 1'b0;
end
endtask

task w_idle_cycles(input integer n);
    integer ci;
begin
    for (ci = 0; ci < n; ci = ci + 1) @(negedge WCLK_TB);
end
endtask

//---------------------------------------------------------------
// Read-domain tasks
//---------------------------------------------------------------
task r_reset;
begin
    RRST_N_TB = 1'b0;
    RINC_TB   = 1'b0;
    repeat (3) @(negedge RCLK_TB);
    RRST_N_TB = 1'b1;
    @(negedge RCLK_TB);
end
endtask

// Attempts one read. If accepted (rinc asserted while !rempty), samples
// RDATA_TB (valid combinationally before the pointer advances) and checks
// it against the scoreboard's oldest pending word.
task do_read(output accepted);
    reg [DATA_WIDTH-1:0] got, expected;
begin
    @(negedge RCLK_TB);
    accepted = !REMPTY_TB;
    if (accepted) got = RDATA_TB;
    RINC_TB = 1'b1;
    @(negedge RCLK_TB);
    RINC_TB = 1'b0;

    if (accepted) begin
        checks = checks + 1;
        if (sb_pop_idx >= sb_push_idx) begin
            $display("FAILED  -> Read accepted but scoreboard is empty (underflow in model) at t=%0t", $time);
            errors = errors + 1;
        end else begin
            expected = sb_queue[sb_pop_idx];
            sb_pop_idx = sb_pop_idx + 1;
            if (got !== expected) begin
                $display("FAILED  -> Data mismatch: expected=%0h got=%0h at t=%0t", expected, got, $time);
                errors = errors + 1;
            end
        end
    end
end
endtask

task r_idle_cycles(input integer n);
    integer ci;
begin
    for (ci = 0; ci < n; ci = ci + 1) @(negedge RCLK_TB);
end
endtask

//---------------------------------------------------------------
// Common checker tasks (callable from either process, no clock wait)
//---------------------------------------------------------------
task check_flag(input flag_val, input exp_val, input [79*8-1:0] label);
begin
    checks = checks + 1;
    if (flag_val !== exp_val) begin
        $display("FAILED  -> %0s : expected=%0b actual=%0b at t=%0t", label, exp_val, flag_val, $time);
        errors = errors + 1;
    end else begin
        $display("PASSED  -> %0s : %0b at t=%0t", label, flag_val, $time);
    end
end
endtask

//=================================================================
// WRITE-SIDE PROCESS
//=================================================================
initial begin : WRITE_PROC
    integer i;
    reg accepted;
    reg [DATA_WIDTH-1:0] wval;

    sb_push_idx       = 0;
    b_empty_checked   = 1'b0;
    fifo_seen_full    = 1'b0;
    go_drain_to_empty = 1'b0;
    b_case6_drained   = 1'b0;
    case6_write_done  = 1'b0;
    case7_write_done  = 1'b0;
    b_case7_drained   = 1'b0;
    stress_done_w     = 1'b0;

    w_reset;

    //-------------------------------------------------------
    // CASE 1: reset value of wfull must be 0
    //-------------------------------------------------------
    check_flag(WFULL_TB, 1'b0, "CASE1  wfull deasserted out of reset");

    // IMPORTANT: do not start writing real data until the read side has
    // finished proving the empty/underflow behavior (CASE1b) - otherwise
    // real words show up on the read side mid-check and invalidate it.
    wait (b_empty_checked == 1'b1);

    //-------------------------------------------------------
    // CASE 2: fill the FIFO completely (DEPTH writes), confirm
    // wfull asserts exactly at the DEPTH-th write and not before.
    //-------------------------------------------------------
    $display("=========================================");
    $display(" CASE 2 : Fill FIFO to exactly full (DEPTH=%0d)", DEPTH);
    $display("=========================================");
    for (i = 0; i < DEPTH; i = i + 1) begin
        check_flag(WFULL_TB, 1'b0, "CASE2  wfull low before FIFO is full");
        do_write(i[DATA_WIDTH-1:0], accepted);
        if (!accepted) begin
            $display("FAILED  -> CASE2 write %0d unexpectedly rejected", i);
            errors = errors + 1;
        end
    end
    check_flag(WFULL_TB, 1'b1, "CASE2  wfull asserted after DEPTH writes");

    //-------------------------------------------------------
    // CASE 3: overflow protection - attempt extra writes while full,
    // confirm they are rejected (no corruption, no scoreboard push)
    //-------------------------------------------------------
    $display("=========================================");
    $display(" CASE 3 : Overflow protection (write while full)");
    $display("=========================================");
    for (i = 0; i < 3; i = i + 1) begin
        do_write(8'hEE, accepted);
        if (accepted) begin
            $display("FAILED  -> CASE3 write accepted while wfull was asserted (overflow!)");
            errors = errors + 1;
        end else begin
            $display("PASSED  -> CASE3 write correctly blocked while full (attempt %0d)", i);
        end
    end

    // hand off to read side to drain everything
    fifo_seen_full = 1'b1;
    wait (go_drain_to_empty == 1'b1);

    //-------------------------------------------------------
    // CASE 5 (write side): after read side has drained the FIFO,
    // confirm we can write again immediately (pointer wrap check #1)
    //-------------------------------------------------------
    w_idle_cycles(2);
    check_flag(WFULL_TB, 1'b0, "CASE5  wfull deasserted after full drain");

    //-------------------------------------------------------
    // CASE 6: multiple full fill/drain cycles to force the Gray
    // pointers around several wraps (the Fig.6 hazard in the paper)
    //-------------------------------------------------------
    $display("=========================================");
    $display(" CASE 6 : Repeated fill/drain cycles (pointer wrap stress)");
    $display("=========================================");
    for (i = 0; i < 3 * DEPTH; i = i + 1) begin
        wval = (8'hA0 + i[7:0]);
        do_write(wval, accepted);
        if (!accepted) begin
            $display("FAILED  -> CASE6 write %0d rejected unexpectedly (t=%0t)", i, $time);
            errors = errors + 1;
        end
        // trickle: leave gaps so the read side can keep draining concurrently
        w_idle_cycles(1);
    end
    case6_write_done = 1'b1;

    //-------------------------------------------------------
    // CASE 7: simultaneous write-to-full while a read also occurs
    // (pessimistic full assertion edge case, section 5.4.1 of the paper)
    //-------------------------------------------------------
    // Must not start refilling until the read side has genuinely drained
    // all of CASE6's backlog -- otherwise this "full fill" starts from a
    // FIFO that isn't actually empty yet (independent clock domains mean
    // the read side's drain loop can lag behind the write side finishing
    // its write loop).
    wait (b_case6_drained == 1'b1);
    w_idle_cycles(4);
    $display("=========================================");
    $display(" CASE 7 : Simultaneous write-to-full / read race");
    $display("=========================================");
    for (i = 0; i < DEPTH; i = i + 1) begin
        do_write(8'hC0 + i[7:0], accepted);
    end
    // one more write attempted right as the read side is draining -- it
    // may be accepted or rejected depending on exactly how far the
    // concurrent reader has gotten (that's the point of this race test).
    // No fixed expectation here; the read side drains based on the
    // scoreboard actually catching up, not a hardcoded word count.
    do_write(8'hFE, accepted);
    case7_write_done = 1'b1;

    // Must not reset this domain until the read side has fully drained
    // CASE7 -- resetting wbin/wptr mid-drain would invalidate the
    // in-flight pointer comparison the read side is still relying on.
    wait (b_case7_drained == 1'b1);

    //-------------------------------------------------------
    // CASE 8: mid-operation asynchronous reset on write domain only
    //-------------------------------------------------------
    $display("=========================================");
    $display(" CASE 8 : Async reset of write domain mid-operation");
    $display("=========================================");
    w_idle_cycles(3);
    w_reset;
    check_flag(WFULL_TB, 1'b0, "CASE8  wfull deasserted after write-domain reset");
    // Resync scoreboard: a wrst_n reset does not clear the memory contents
    // that the read side hasn't consumed yet, so we do NOT touch sb_push_idx
    // here; write pointer restarts at 0 which is fine since reads are still
    // draining older entries from the front of the queue.

    //-------------------------------------------------------
    // CASE 9: randomized stress - fast writer, backpressure-aware
    //-------------------------------------------------------
    wait (stress_run == 1'b1);
    $display("=========================================");
    $display(" CASE 9 : Randomized stress (write side), %0d words", stress_words);
    $display("=========================================");
    for (i = 0; i < stress_words; i = i + 1) begin
        do_write($random, accepted);
        // randomly insert idle cycles to vary the write/read rate ratio
        if ($random % 4 == 0) w_idle_cycles((($random % 3) < 0 ? -($random % 3) : ($random % 3)) + 1);
    end
    stress_done_w = 1'b1;

    // wait for read side to finish before declaring done
    wait (stress_done_r == 1'b1);

    $display("=========================================");
    $display(" TEST COMPLETE : %0d checks, %0d errors", checks, errors);
    $display("=========================================");
    $finish;
end

//=================================================================
// READ-SIDE PROCESS
//=================================================================
initial begin : READ_PROC
    integer i;
    reg accepted;

    sb_pop_idx        = 0;

    r_reset;

    //-------------------------------------------------------
    // CASE 1: reset value of rempty must be 1
    //-------------------------------------------------------
    check_flag(REMPTY_TB, 1'b1, "CASE1  rempty asserted out of reset");

    //-------------------------------------------------------
    // CASE 1b: underflow protection - attempt reads while empty,
    // confirm they are rejected before anything has been written
    //-------------------------------------------------------
    for (i = 0; i < 3; i = i + 1) begin
        do_read(accepted);
        if (accepted) begin
            $display("FAILED  -> CASE1b read accepted while FIFO was empty at reset (underflow!)");
            errors = errors + 1;
        end else begin
            $display("PASSED  -> CASE1b read correctly blocked while empty (attempt %0d)", i);
        end
    end
    b_empty_checked = 1'b1;   // release the write side to start CASE2

    //-------------------------------------------------------
    // CASE 2/3 (read side): wait for the write side to fill the FIFO
    // and prove overflow was rejected, then observe rempty stays low
    // through the CDC latency before we start draining.
    //-------------------------------------------------------
    wait (fifo_seen_full == 1'b1);
    r_idle_cycles(4);   // let the synchronized full status settle
    check_flag(REMPTY_TB, 1'b0, "CASE3  rempty low while FIFO is full");

    //-------------------------------------------------------
    // CASE 4: drain the FIFO completely, confirm every word matches
    // write order (FIFO ordering) and rempty asserts exactly at the
    // last read, not before.
    //-------------------------------------------------------
    $display("=========================================");
    $display(" CASE 4 : Drain FIFO to exactly empty (DEPTH=%0d)", DEPTH);
    $display("=========================================");
    for (i = 0; i < DEPTH; i = i + 1) begin
        check_flag(REMPTY_TB, 1'b0, "CASE4  rempty low before FIFO is empty");
        do_read(accepted);
        if (!accepted) begin
            $display("FAILED  -> CASE4 read %0d unexpectedly rejected", i);
            errors = errors + 1;
        end
    end
    check_flag(REMPTY_TB, 1'b1, "CASE4  rempty asserted after draining all words");

    // release the write side to continue CASE5/6
    go_drain_to_empty = 1'b1;

    //-------------------------------------------------------
    // CASE 6 (read side): keep draining concurrently with the write
    // side's wrap-around stress loop. Poll and read whenever data
    // is available; scoreboard compare happens inside do_read.
    //-------------------------------------------------------
    while (!(case6_write_done && (sb_pop_idx >= sb_push_idx))) begin
        if (!REMPTY_TB) begin
            do_read(accepted);
        end else begin
            @(negedge RCLK_TB);
        end
    end
    b_case6_drained = 1'b1;   // release the write side to start CASE7

    //-------------------------------------------------------
    // CASE 7 (read side): drain the race-condition burst from the
    // write side (however many words actually landed -- the extra
    // 9th write may or may not have been accepted depending on how
    // the concurrent reads and writes interleaved), then confirm
    // FIFO returns to empty cleanly.
    //-------------------------------------------------------
    while (!(case7_write_done && (sb_pop_idx >= sb_push_idx))) begin
        if (!REMPTY_TB) begin
            do_read(accepted);
        end else begin
            @(negedge RCLK_TB);
        end
    end
    r_idle_cycles(4);
    check_flag(REMPTY_TB, 1'b1, "CASE7  rempty asserted after draining race-condition burst");
    b_case7_drained = 1'b1;   // release the write side to start CASE8's reset

    //-------------------------------------------------------
    // CASE 8: mid-operation asynchronous reset on read domain only,
    // independent from (and offset from) the write-domain reset in
    // the write process, to prove each reset is truly local.
    //-------------------------------------------------------
    $display("=========================================");
    $display(" CASE 8 : Async reset of read domain mid-operation");
    $display("=========================================");
    r_idle_cycles(5);
    r_reset;
    check_flag(REMPTY_TB, 1'b1, "CASE8  rempty asserted after read-domain reset");
    // The read pointer restarts at 0 while the write pointer (already
    // reset earlier in CASE8 write-side) also restarts at 0, so the
    // scoreboard and DUT are back in lock-step; resync indices together.
    sb_pop_idx  = sb_push_idx;   // drop any stale in-flight entries from before the resets

    //-------------------------------------------------------
    // CASE 9: randomized stress (read side) - slower/faster reader,
    // draining whenever data is available, racing the writer's
    // random bursts across the two independent clock domains.
    //-------------------------------------------------------
    stress_words = 500;
    stress_run   = 1'b1;
    i = 0;
    while (!(stress_done_w && (sb_pop_idx >= sb_push_idx))) begin
        if (!REMPTY_TB) begin
            do_read(accepted);
        end else begin
            @(negedge RCLK_TB);
        end
    end
    stress_done_r = 1'b1;
end

//---------------------------------------------------------------
// Global watchdog in case any wait() never resolves
//---------------------------------------------------------------
initial begin
    #200000;
    $display("FAILED  -> WATCHDOG TIMEOUT: simulation did not complete, %0d errors so far", errors);
    $finish;
end

//Select Waveform signals
/*
initial begin
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0, FIFO_TB);
end
*/

endmodule