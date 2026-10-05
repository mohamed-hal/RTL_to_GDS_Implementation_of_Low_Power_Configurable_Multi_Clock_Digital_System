`timescale 1ns/1ps
module ClkDiv_TB();

parameter NUM_CASES  = 20;
parameter CLK_PERIOD = 10;  

reg         i_ref_clk_TB, i_rst_n_TB;
reg         i_clk_en_TB;
reg  [7:0]  i_div_ratio_TB;
wire        o_div_clk_TB;

reg  [7:0]  Ratio_Sent;
real        Measured_Period;
integer     k;


// ---------------------------------------------------------------
// Stimulus
// ---------------------------------------------------------------
initial begin
    $dumpfile("ClkDiv_TB.vcd");
    $dumpvars(0, i_ref_clk_TB, i_rst_n_TB, i_clk_en_TB, i_div_ratio_TB, o_div_clk_TB);
    initialize;

    Corner_Case_Check(8'd0, 1'b1);
    Corner_Case_Check(8'd1, 1'b1);

    Corner_Case_Check(8'd5, 1'b0);

    Check_Ratio(8'd2);  
    Check_Ratio(8'd3);   
    Check_Ratio(8'd4);
    Check_Ratio(8'd5);
    Check_Ratio(8'd16);
    Check_Ratio(8'd17);
    Check_Ratio(8'd254);
    Check_Ratio(8'd255);

    // -----------------------------------------------------------
    // Randomized ratios covering both odd and even divisors
    // -----------------------------------------------------------
    for (k = 0; k < NUM_CASES; k = k + 1) begin
        Gen_Ratio(Ratio_Sent);
        Check_Ratio(Ratio_Sent);
    end

    $stop;
end

// ---------------------------------------------------------------
// DUT instantiation
// ---------------------------------------------------------------
ClkDiv DUT (
    .i_ref_clk   (i_ref_clk_TB),
    .i_rst_n     (i_rst_n_TB),
    .i_clk_en    (i_clk_en_TB),
    .i_div_ratio (i_div_ratio_TB),
    .o_div_clk   (o_div_clk_TB)
);

// ---------------------------------------------------------------
// Tasks
// ---------------------------------------------------------------
task initialize;
begin
    i_ref_clk_TB   = 1'b0;
    i_rst_n_TB     = 1'b0;
    i_clk_en_TB    = 1'b0;
    i_div_ratio_TB = 8'd0;
end
endtask

task Reset;
begin
    i_rst_n_TB = 1'b0;
    @(negedge i_ref_clk_TB);
    i_rst_n_TB = 1'b1;
end
endtask


task Gen_Ratio(output [7:0] Ratio_Out);
begin
    Ratio_Out = ((($random % 254) + 254) % 254) + 2;
end
endtask

task Apply_Ratio(input [7:0] Ratio_In);
begin
    i_div_ratio_TB = Ratio_In;
    i_clk_en_TB    = 1'b1;
    @(negedge i_ref_clk_TB);
end
endtask


task Measure_Period(output real Period_Out);
    real t1, t2;
begin
    @(posedge o_div_clk_TB);
    t1 = $time;
    @(posedge o_div_clk_TB);
    t2 = $time;
    Period_Out = t2 - t1;
end
endtask


task Check_Ratio(input [7:0] Ratio_In);
    real Expected_Period;
begin
    Reset;
    Apply_Ratio(Ratio_In);
    Measure_Period(Measured_Period);
    Expected_Period = Ratio_In * CLK_PERIOD;

    if (Measured_Period == Expected_Period)
        passed(Ratio_In, Expected_Period, Measured_Period);
    else
        failed(Ratio_In, Expected_Period, Measured_Period);
end
endtask


task Corner_Case_Check(input [7:0] ratio_val, input clk_en_val);
    integer   m;
    reg       prev_val;
    reg       toggled;
begin
    Reset;
    i_div_ratio_TB = ratio_val;
    i_clk_en_TB    = clk_en_val;
    @(negedge i_ref_clk_TB);
    prev_val = o_div_clk_TB;
    toggled  = 1'b0;

    for (m = 0; m < 20; m = m + 1) begin
        @(negedge i_ref_clk_TB);
        if (o_div_clk_TB !== prev_val)
            toggled = 1'b1;
    end

    if (!toggled)
        passed_disable(ratio_val, clk_en_val);
    else
        failed_disable(ratio_val, clk_en_val);
end
endtask

task passed(input [7:0] idx, input real exp_p, input real act_p);
begin
    $display("PASSED  -> Ratio=%0d : Expected_Period=%0t Measured_Period=%0t at t=%0t",
              idx, exp_p, act_p, $time);
end
endtask

task failed(input [7:0] idx, input real exp_p, input real act_p);
begin
    $display("FAILED  -> Ratio=%0d : Expected_Period=%0t Measured_Period=%0t at t=%0t",
              idx, exp_p, act_p, $time);
end
endtask

task passed_disable(input [7:0] ratio_val, input clk_en_val);
begin
    $display("PASSED  -> Disable Check : i_div_ratio=%0d i_clk_en=%0b -> o_div_clk held steady at t=%0t",
              ratio_val, clk_en_val, $time);
end
endtask

task failed_disable(input [7:0] ratio_val, input clk_en_val);
begin
    $display("FAILED  -> Disable Check : i_div_ratio=%0d i_clk_en=%0b -> o_div_clk toggled unexpectedly at t=%0t",
              ratio_val, clk_en_val, $time);
end
endtask

// ---------------------------------------------------------------
// Clock GENERATING
// ---------------------------------------------------------------
always #(CLK_PERIOD/2) i_ref_clk_TB = ~i_ref_clk_TB;

endmodule
