`timescale 1ns/1ps
module UART_TX_TB();

parameter NUM_CASES  = 8;
parameter CLK_PERIOD = 5;     

reg  [7:0] P_DATA_TB;
reg        Data_Valid_TB;
reg        PAR_EN_TB;
reg        PAR_TYP_TB;
reg        CLK_TB, RST_TB;
wire       TX_OUT_TB;
wire       Busy_TB;

reg [7:0] DATA_MEM    [0:NUM_CASES-1];
reg       PAR_EN_MEM  [0:NUM_CASES-1];
reg       PAR_TYP_MEM [0:NUM_CASES-1];

reg [7:0] Actual_Data;
reg       Actual_Parity;
reg       Actual_Stop;
reg       Exp_Parity;
integer   k;
integer   errors;

// ---------------------------------------------------------------
// DUT instantiation
// ---------------------------------------------------------------
UART_TX DUT (
    .P_DATA     (P_DATA_TB),
    .Data_Valid (Data_Valid_TB),
    .PAR_EN     (PAR_EN_TB),
    .PAR_TYP    (PAR_TYP_TB),
    .clk        (CLK_TB),
    .RST        (RST_TB),
    .TX_OUT     (TX_OUT_TB),
    .Busy       (Busy_TB)
);

wire ser_en_tb   = DUT.ser_en;
wire ser_done_tb = DUT.ser_done;

// ---------------------------------------------------------------
// Stimulus
// ---------------------------------------------------------------
initial begin
    initialize;
    load_test_vectors;
    Reset;

    errors = 0;
    for (k = 0; k < NUM_CASES; k = k + 1) begin
        PAR_EN_TB  = PAR_EN_MEM[k];
        PAR_TYP_TB = PAR_TYP_MEM[k];

        Send_Byte(DATA_MEM[k]);
        Receive_Frame(Actual_Data, Actual_Parity, Actual_Stop);

        Exp_Parity = PAR_TYP_MEM[k] ? ~(^DATA_MEM[k]) : (^DATA_MEM[k]);

        check_result(k);
    end

    $display("=========================================");
    $display(" TEST COMPLETE : %0d / %0d PASSED", NUM_CASES-errors, NUM_CASES);
    $display("=========================================");
    $stop;
end

// ---------------------------------------------------------------
// Tasks
// ---------------------------------------------------------------
task initialize;
begin
    P_DATA_TB     = 0;
    Data_Valid_TB = 0;
    PAR_EN_TB     = 0;
    PAR_TYP_TB    = 0;
    CLK_TB        = 0;
    RST_TB        = 0;
end
endtask

task Reset;
begin
    RST_TB = 0;
    @(negedge CLK_TB);
    RST_TB = 1;
end
endtask


task load_test_vectors;
begin
    DATA_MEM[0] = 8'h00;  PAR_EN_MEM[0] = 1'b0;  PAR_TYP_MEM[0] = 1'b0; // parity disabled
    DATA_MEM[1] = 8'hFF;  PAR_EN_MEM[1] = 1'b0;  PAR_TYP_MEM[1] = 1'b0; // parity disabled
    DATA_MEM[2] = 8'h00;  PAR_EN_MEM[2] = 1'b1;  PAR_TYP_MEM[2] = 1'b0; // even, 0 ones
    DATA_MEM[3] = 8'hFF;  PAR_EN_MEM[3] = 1'b1;  PAR_TYP_MEM[3] = 1'b0; // even, 8 ones
    DATA_MEM[4] = 8'h01;  PAR_EN_MEM[4] = 1'b1;  PAR_TYP_MEM[4] = 1'b0; // even, 1 one (odd count edge)
    DATA_MEM[5] = 8'h01;  PAR_EN_MEM[5] = 1'b1;  PAR_TYP_MEM[5] = 1'b1; // odd, 1 one
    DATA_MEM[6] = 8'hAA;  PAR_EN_MEM[6] = 1'b1;  PAR_TYP_MEM[6] = 1'b1; // odd, alternating
    DATA_MEM[7] = 8'h55;  PAR_EN_MEM[7] = 1'b1;  PAR_TYP_MEM[7] = 1'b0; // even, alternating
end
endtask

task Send_Byte(input [7:0] Data_In);
begin
    @(negedge CLK_TB);
    P_DATA_TB     = Data_In;
    Data_Valid_TB = 1'b1;
    @(negedge CLK_TB);
    Data_Valid_TB = 1'b0;
end
endtask


task Receive_Frame(output [7:0] Data_out, output Parity_out, output Stop_out);
    integer i;
    reg [7:0] shifted;
begin
    
    if (TX_OUT_TB !== 1'b0)
        $display("WARNING: start bit != 0 at t=%0t", $time);

    $display("  [t=%0t] start_bit=%0b | ser_en=%0b ser_done=%0b",
              $time, TX_OUT_TB, ser_en_tb, ser_done_tb);

    for (i = 0; i < 8; i = i + 1) begin
        @(negedge CLK_TB);
        shifted[i] = TX_OUT_TB;
        $display("  [t=%0t] data_bit[%0d]=%0b | ser_en=%0b ser_done=%0b",
                  $time, i, TX_OUT_TB, ser_en_tb, ser_done_tb);
    end

    if (PAR_EN_TB) begin
        @(negedge CLK_TB);
        Parity_out = TX_OUT_TB;
        $display("  [t=%0t] parity_bit=%0b | ser_en=%0b ser_done=%0b",
                  $time, Parity_out, ser_en_tb, ser_done_tb);
    end
    else begin
        Parity_out = 1'bx;
    end

    @(negedge CLK_TB);
    Stop_out = TX_OUT_TB;
    $display("  [t=%0t] stop_bit=%0b | ser_en=%0b ser_done=%0b",
              $time, Stop_out, ser_en_tb, ser_done_tb);

    Data_out = shifted;
end
endtask

task check_result(input integer idx);
begin
    if ((Actual_Data !== DATA_MEM[idx]) ||
        (PAR_EN_MEM[idx] && (Actual_Parity !== Exp_Parity)) ||
        (Actual_Stop !== 1'b1)) begin
        failed(idx);
        errors = errors + 1;
    end
    else begin
        passed(idx);
    end
end
endtask

task passed(input integer idx);
begin
    $display("PASSED  -> Case %0d : DATA=%0h PAR_EN=%0b PAR_TYP=%0b | Exp_Par=%0b Act_Par=%0b Act_Stop=%0b at t=%0t",
              idx, DATA_MEM[idx], PAR_EN_MEM[idx], PAR_TYP_MEM[idx], Exp_Parity, Actual_Parity, Actual_Stop, $time);
end
endtask

task failed(input integer idx);
begin
    $display("FAILED  -> Case %0d : DATA=%0h (got %0h) PAR_EN=%0b PAR_TYP=%0b | Exp_Par=%0b Act_Par=%0b Act_Stop=%0b at t=%0t",
              idx, DATA_MEM[idx], Actual_Data, PAR_EN_MEM[idx], PAR_TYP_MEM[idx], Exp_Parity, Actual_Parity, Actual_Stop, $time);
end
endtask

// ---------------------------------------------------------------
// Clock generation: 200 MHz
// ---------------------------------------------------------------
always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB;

endmodule