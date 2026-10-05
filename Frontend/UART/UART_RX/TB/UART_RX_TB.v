`timescale 1ns/1ps
module UART_RX_TB();

parameter NUM_CASES = 13;
parameter NCHAIN    = 5;          // frames in the multi-frame back-to-back burst
parameter TX_CLK_HZ = 115200;      // UART_TX bit rate per spec

//---------------------------------------------------------------
// DUT signals
//---------------------------------------------------------------
reg        CLK_TB, RST_TB;
reg        PAR_EN_TB, PAR_TYP_TB;
reg  [5:0] Prescale_TB;
reg        RX_IN_TB;
wire [7:0] P_DATA_TB;
wire       Data_valid_TB;
wire       Parity_Error_TB;
wire       Stop_Error_TB;

//---------------------------------------------------------------
// Internal numbers
//---------------------------------------------------------------
real    half_period;              // RX_CLK half-period, derived from TX_CLK_HZ * Prescale
integer current_prescale;
integer errors;
integer k;
integer bi;

localparam CHECK_STATE = 3'b111; 

//---------------------------------------------------------------
// Test vector memories
//---------------------------------------------------------------
reg [7:0] DATA_MEM           [0:NUM_CASES-1];
reg       PAR_EN_MEM         [0:NUM_CASES-1];
reg       PAR_TYP_MEM        [0:NUM_CASES-1];
reg       FORCE_PAR_ERR_MEM  [0:NUM_CASES-1];
reg       FORCE_STOP_ERR_MEM [0:NUM_CASES-1];
reg       CONSEC_MEM         [0:NUM_CASES-1];

// Multi-frame back-to-back check signals
reg [7:0] CHAIN_DATA      [0:NCHAIN-1];
reg       CHAIN_PAR_ERR   [0:NCHAIN-1];
reg       CHAIN_STOP_ERR  [0:NCHAIN-1];

//---------------------------------------------------------------
// DUT instantiation
//---------------------------------------------------------------
UART_RX DUT (
    .CLK          (CLK_TB),
    .RST          (RST_TB),
    .PAR_EN       (PAR_EN_TB),
    .PAR_TYP      (PAR_TYP_TB),
    .Prescale     (Prescale_TB),
    .RX_IN        (RX_IN_TB),
    .P_DATA       (P_DATA_TB),
    .Data_valid   (Data_valid_TB),
    .Parity_Error (Parity_Error_TB),
    .Stop_Error   (Stop_Error_TB)
);


// Some internal signals for debug visibility
wire [2:0] fsm_state_tb   = DUT.u_FSM_RX.Current_State;
wire       enable_tb      = DUT.enable;
wire       dat_samp_en_tb = DUT.dat_samp_en;
wire [5:0] edge_cnt_tb    = DUT.edge_cnt;
wire [3:0] bit_cnt_tb     = DUT.bit_cnt;
wire       sampled_bit_tb = DUT.sampled_bit;

//---------------------------------------------------------------
// Clock generation: RX_CLK period tracks TX_CLK * current_prescale (This is evaluated in task set_prescale)
//---------------------------------------------------------------
initial CLK_TB      = 1'b0;
initial half_period = 62.5;   
always #(half_period) CLK_TB = ~CLK_TB;


//---------------------------------------------------------------
// TX_CLK generation (for waveform visualization only)
//---------------------------------------------------------------
reg TX_CLK_TB;
real tx_half_period;

initial begin
    TX_CLK_TB      = 1'b0;
    tx_half_period = (1_000_000_000.0 / TX_CLK_HZ) / 2.0;   // fixed 115200 Hz baud clock
end
always #(tx_half_period) TX_CLK_TB = ~TX_CLK_TB;

//---------------------------------------------------------------
// Stimulus
//---------------------------------------------------------------
initial begin
    initialize;
    load_test_vectors;
    load_chain_vectors;
    errors = 0;

    // ---- sweep @ Prescale = 8 ----
    set_prescale(8);
    Reset;
    $display("=========================================");
    $display(" GROUP 1 : Prescale = 8  (oversample x8)");
    $display("=========================================");
    for (k = 0; k < NUM_CASES; k = k + 1) begin
        Run_Case(k);
    end

    //  Start-bit glitch 
    Start_Glitch_Test;

    //  Multi-frame back-to-back
    Reset;
    Multi_Frame_Test;

    //  Oversampling sweep: repeat afew test cases
    set_prescale(16);
    Reset;
    $display("=========================================");
    $display(" GROUP 2 : Prescale = 16 (oversample x16)");
    $display("=========================================");
    Run_Case(3);   // 0xFF, even parity
    Run_Case(6);   // 0xAA, odd parity
    Run_Case(10);  // parity error test

    set_prescale(32);
    Reset;
    $display("=========================================");
    $display(" GROUP 3 : Prescale = 32 (oversample x32)");
    $display("=========================================");
    Run_Case(3);
    Run_Case(6);
    Run_Case(11);  // stop error 

    //  Multi-frame 
    Reset;
    Multi_Frame_Test;

    $display("=========================================");
    $display(" TEST COMPLETE : %0d errors", errors);
    $display("=========================================");
    $stop;
end

//---------------------------------------------------------------
// Tasks
//---------------------------------------------------------------
task initialize;
begin
    CLK_TB      = 1'b0;
    RST_TB      = 1'b0;
    PAR_EN_TB   = 1'b0;
    PAR_TYP_TB  = 1'b0;
    Prescale_TB = 6'd8;
    RX_IN_TB    = 1'b1;
    current_prescale = 8;
end
endtask

task set_prescale(input integer prescale);
begin
    current_prescale = prescale;
    Prescale_TB       = prescale[5:0];
    half_period       = (1_000_000_000.0 / TX_CLK_HZ) / prescale / 2.0;
end
endtask

task Reset;
begin
    RST_TB   = 1'b0;
    RX_IN_TB = 1'b1;
    repeat (3) @(negedge CLK_TB);
    RST_TB = 1'b1;
    @(negedge CLK_TB);
end
endtask


task load_test_vectors;
begin
    DATA_MEM[0]=8'h00; PAR_EN_MEM[0]=0; PAR_TYP_MEM[0]=0; FORCE_PAR_ERR_MEM[0]=0; FORCE_STOP_ERR_MEM[0]=0; CONSEC_MEM[0]=0; // no parity, all zero
    DATA_MEM[1]=8'hFF; PAR_EN_MEM[1]=0; PAR_TYP_MEM[1]=0; FORCE_PAR_ERR_MEM[1]=0; FORCE_STOP_ERR_MEM[1]=0; CONSEC_MEM[1]=0; // no parity, all one
    DATA_MEM[2]=8'h00; PAR_EN_MEM[2]=1; PAR_TYP_MEM[2]=0; FORCE_PAR_ERR_MEM[2]=0; FORCE_STOP_ERR_MEM[2]=0; CONSEC_MEM[2]=0; // even, 0 ones
    DATA_MEM[3]=8'hFF; PAR_EN_MEM[3]=1; PAR_TYP_MEM[3]=0; FORCE_PAR_ERR_MEM[3]=0; FORCE_STOP_ERR_MEM[3]=0; CONSEC_MEM[3]=0; // even, 8 ones
    DATA_MEM[4]=8'h01; PAR_EN_MEM[4]=1; PAR_TYP_MEM[4]=0; FORCE_PAR_ERR_MEM[4]=0; FORCE_STOP_ERR_MEM[4]=0; CONSEC_MEM[4]=0; // even, 1 one (odd count edge)
    DATA_MEM[5]=8'h01; PAR_EN_MEM[5]=1; PAR_TYP_MEM[5]=1; FORCE_PAR_ERR_MEM[5]=0; FORCE_STOP_ERR_MEM[5]=0; CONSEC_MEM[5]=0; // odd, 1 one
    DATA_MEM[6]=8'hAA; PAR_EN_MEM[6]=1; PAR_TYP_MEM[6]=1; FORCE_PAR_ERR_MEM[6]=0; FORCE_STOP_ERR_MEM[6]=0; CONSEC_MEM[6]=0; // odd, alternating
    DATA_MEM[7]=8'h55; PAR_EN_MEM[7]=1; PAR_TYP_MEM[7]=0; FORCE_PAR_ERR_MEM[7]=0; FORCE_STOP_ERR_MEM[7]=0; CONSEC_MEM[7]=0; // even, alternating
    DATA_MEM[8]=8'hA5; PAR_EN_MEM[8]=1; PAR_TYP_MEM[8]=0; FORCE_PAR_ERR_MEM[8]=0; FORCE_STOP_ERR_MEM[8]=0; CONSEC_MEM[8]=1; // back-to-back frame 1 
    DATA_MEM[9]=8'hF3; PAR_EN_MEM[9]=1; PAR_TYP_MEM[9]=0; FORCE_PAR_ERR_MEM[9]=0; FORCE_STOP_ERR_MEM[9]=0; CONSEC_MEM[9]=0; // back-to-back frame 2
    DATA_MEM[10]=8'h3C; PAR_EN_MEM[10]=1; PAR_TYP_MEM[10]=0; FORCE_PAR_ERR_MEM[10]=1; FORCE_STOP_ERR_MEM[10]=0; CONSEC_MEM[10]=0; // parity error 
    DATA_MEM[11]=8'h5A; PAR_EN_MEM[11]=1; PAR_TYP_MEM[11]=0; FORCE_PAR_ERR_MEM[11]=0; FORCE_STOP_ERR_MEM[11]=1; CONSEC_MEM[11]=0; // stop error 
    DATA_MEM[12]=8'h69; PAR_EN_MEM[12]=1; PAR_TYP_MEM[12]=1; FORCE_PAR_ERR_MEM[12]=1; FORCE_STOP_ERR_MEM[12]=1; CONSEC_MEM[12]=0; // parity + stop error together
end
endtask


task load_chain_vectors;
begin
    CHAIN_DATA[0]=8'h11; CHAIN_PAR_ERR[0]=0; CHAIN_STOP_ERR[0]=0;
    CHAIN_DATA[1]=8'h22; CHAIN_PAR_ERR[1]=0; CHAIN_STOP_ERR[1]=0;
    CHAIN_DATA[2]=8'h33; CHAIN_PAR_ERR[2]=1; CHAIN_STOP_ERR[2]=0; 
    CHAIN_DATA[3]=8'h44; CHAIN_PAR_ERR[3]=0; CHAIN_STOP_ERR[3]=0; 
    CHAIN_DATA[4]=8'h55; CHAIN_PAR_ERR[4]=0; CHAIN_STOP_ERR[4]=1; 
end
endtask


task drive_bit(input value);
begin
    @(negedge CLK_TB);
    RX_IN_TB = value;
    repeat (current_prescale - 1) @(negedge CLK_TB);
end
endtask


task Send_Frame(input [7:0] data, input par_en, input par_typ,
                 input force_par_err, input force_stop_err, input consecutive);
    reg parity_bit;
begin
    PAR_EN_TB  = par_en;
    PAR_TYP_TB = par_typ;
    parity_bit = par_typ ? ~(^data) : (^data);
    if (force_par_err) parity_bit = ~parity_bit;

    drive_bit(1'b0);                               // start bit
    for (bi = 0; bi < 8; bi = bi + 1)
        drive_bit(data[bi]);                        // data bits, LSB first
    if (par_en)
        drive_bit(parity_bit);                       // parity bit
    drive_bit(force_stop_err ? 1'b0 : 1'b1);          // stop bit


    if (!consecutive) begin
        drive_bit(1'b1);
        drive_bit(1'b1);
    end
end
endtask


task Wait_For_Check(output [7:0] o_data, output o_dv, output o_perr,
                     output o_serr, output o_timeout, input integer max_cycles);
    integer cyc;
    reg     found;
begin
    found     = 1'b0;
    o_timeout = 1'b0;
    cyc       = 0;
    while (!found && (cyc < max_cycles)) begin
        @(posedge CLK_TB);
        if (fsm_state_tb == CHECK_STATE) begin
            o_data = P_DATA_TB;
            o_dv   = Data_valid_TB;
            o_perr = Parity_Error_TB;
            o_serr = Stop_Error_TB;
            found  = 1'b1;
        end
        cyc = cyc + 1;
    end

    if (!found) begin
        o_timeout = 1'b1;
        o_data    = 8'hxx;
        o_dv      = 1'bx;
        o_perr    = 1'bx;
        o_serr    = 1'bx;
    end
end
endtask

task Run_Case(input integer idx);
    reg [7:0] rdata;
    reg       rdv, rperr, rserr, rto;
    reg       exp_dv, exp_perr, exp_serr;
begin


    fork
        Send_Frame(DATA_MEM[idx], PAR_EN_MEM[idx], PAR_TYP_MEM[idx],
                   FORCE_PAR_ERR_MEM[idx], FORCE_STOP_ERR_MEM[idx], CONSEC_MEM[idx]);
        Wait_For_Check(rdata, rdv, rperr, rserr, rto, current_prescale * 20);
    join

    exp_perr = FORCE_PAR_ERR_MEM[idx] && PAR_EN_MEM[idx];
    exp_serr = FORCE_STOP_ERR_MEM[idx];
    exp_dv   = !(exp_perr || exp_serr);

    if (rto) begin
        $display("FAILED  -> Case %0d : TIMEOUT waiting for check state", idx);
        errors = errors + 1;
    end
    else if ( (exp_dv && (rdata !== DATA_MEM[idx])) ||
              (rdv   !== exp_dv)   ||
              (rperr !== exp_perr) ||
              (rserr !== exp_serr) ) begin
        $display("FAILED  -> Case %0d : DATA=%0h (got %0h) PAR_EN=%0b PAR_TYP=%0b | Exp(dv=%0b perr=%0b serr=%0b) Act(dv=%0b perr=%0b serr=%0b) Prescale=%0d at t=%0t",
                  idx, DATA_MEM[idx], rdata, PAR_EN_MEM[idx], PAR_TYP_MEM[idx],
                  exp_dv, exp_perr, exp_serr, rdv, rperr, rserr, current_prescale, $time);
        errors = errors + 1;
    end
    else begin
        $display("PASSED  -> Case %0d : DATA=%0h PAR_EN=%0b PAR_TYP=%0b | dv=%0b perr=%0b serr=%0b Prescale=%0d at t=%0t",
                  idx, DATA_MEM[idx], PAR_EN_MEM[idx], PAR_TYP_MEM[idx],
                  rdv, rperr, rserr, current_prescale, $time);
    end
end
endtask

task Multi_Frame_Test;
    integer   ci;
    reg       is_last;
    reg [7:0] rdata;
    reg       rdv, rperr, rserr, rto;
    reg       exp_dv, exp_perr, exp_serr;
begin
    $display("=========================================");
    $display(" Multi-frame back-to-back burst (%0d frames) @ Prescale=%0d", NCHAIN, current_prescale);
    $display("=========================================");

    for (ci = 0; ci < NCHAIN; ci = ci + 1) begin
        is_last = (ci == NCHAIN - 1);

        fork
            // par_en=1, par_typ=0 (even) held constant for the whole burst --
            // real UART framing config doesn't change mid-stream.
            Send_Frame(CHAIN_DATA[ci], 1'b1, 1'b0,
                       CHAIN_PAR_ERR[ci], CHAIN_STOP_ERR[ci], !is_last);
            Wait_For_Check(rdata, rdv, rperr, rserr, rto, current_prescale * 20);
        join

        exp_perr = CHAIN_PAR_ERR[ci];
        exp_serr = CHAIN_STOP_ERR[ci];
        exp_dv   = !(exp_perr || exp_serr);

        if (rto) begin
            $display("FAILED  -> Chain frame %0d : TIMEOUT waiting for check state", ci);
            errors = errors + 1;
        end
        else if ( (exp_dv && (rdata !== CHAIN_DATA[ci])) ||
                  (rdv   !== exp_dv)   ||
                  (rperr !== exp_perr) ||
                  (rserr !== exp_serr) ) begin
            $display("FAILED  -> Chain frame %0d : DATA=%0h (got %0h) | Exp(dv=%0b perr=%0b serr=%0b) Act(dv=%0b perr=%0b serr=%0b) at t=%0t",
                      ci, CHAIN_DATA[ci], rdata, exp_dv, exp_perr, exp_serr, rdv, rperr, rserr, $time);
            errors = errors + 1;
        end
        else begin
            $display("PASSED  -> Chain frame %0d : DATA=%0h dv=%0b perr=%0b serr=%0b at t=%0t",
                      ci, CHAIN_DATA[ci], rdv, rperr, rserr, $time);
        end
    end
end
endtask

task Start_Glitch_Test;
    reg [7:0] rdata;
    reg       rdv, rperr, rserr, rto;
begin
    $display("=========================================");
    $display(" Start-bit glitch rejection @ Prescale=%0d", current_prescale);
    $display("=========================================");

    @(negedge CLK_TB);
    RX_IN_TB = 1'b0;
    repeat (2) @(negedge CLK_TB);
    RX_IN_TB = 1'b1;
    repeat (current_prescale + 2) @(negedge CLK_TB);

    if (fsm_state_tb !== 3'b000) begin
        $display("FAILED  -> Start-glitch case : FSM stuck in state %0d instead of IDLE", fsm_state_tb);
        errors = errors + 1;
    end else begin
        $display("PASSED  -> Start-glitch case : FSM correctly rejected glitch, returned to IDLE");
    end

    // Confirm normal reception still works right after a rejected glitch
    fork
        Send_Frame(8'h3D, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0);
        Wait_For_Check(rdata, rdv, rperr, rserr, rto, current_prescale * 20);
    join
    if (rto || (rdv !== 1'b1) || (rdata !== 8'h3D) || (rperr !== 1'b0) || (rserr !== 1'b0)) begin
        $display("FAILED  -> Post-glitch recovery frame mismatch (data=%0h dv=%0b perr=%0b serr=%0b)",
                  rdata, rdv, rperr, rserr);
        errors = errors + 1;
    end else begin
        $display("PASSED  -> Post-glitch recovery frame received correctly");
    end
end
endtask

//Select Waveform signals
/*
initial begin
    $dumpfile("uart_rx_tb.vcd");
    $dumpvars(1, CLK_TB, TX_CLK_TB, RST_TB, RX_IN_TB, PAR_EN_TB, PAR_TYP_TB);
    $dumpvars(0, enable_tb, dat_samp_en_tb,
                 edge_cnt_tb, bit_cnt_tb, sampled_bit_tb);
    $dumpvars(0, P_DATA_TB, Data_valid_TB, Parity_Error_TB, Stop_Error_TB);
end
*/

endmodule
