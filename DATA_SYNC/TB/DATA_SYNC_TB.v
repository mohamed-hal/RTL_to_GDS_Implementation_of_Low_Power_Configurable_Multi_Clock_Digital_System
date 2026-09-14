`timescale 1us/1ps
module DATA_SYNC_TB();

parameter NUM_CASES  = 10;
parameter NUM_STAGES = 3;
parameter BUS_WIDTH  = 8;

reg                    bus_enable_TB;
reg  [BUS_WIDTH-1:0]   unsync_bus_TB;
reg                    CLK_TB, RST_TB;
wire [BUS_WIDTH-1:0]   sync_bus_TB;
wire                   enable_pulse_TB;

reg [BUS_WIDTH-1:0] Data_Sent;
reg [BUS_WIDTH-1:0] Actual_sync_bus;
integer   k;


// ---------------------------------------------------------------
// Stimulus
// ---------------------------------------------------------------
initial begin
    $dumpfile("DATA_SYNC_TB.vcd");
    $dumpvars(0, CLK_TB, RST_TB, bus_enable_TB, unsync_bus_TB, sync_bus_TB, enable_pulse_TB);
    initialize;

    for (k = 0; k < NUM_CASES; k = k + 1) begin
        Gen_Data(Data_Sent);
        Reset;
        Send_Data(Data_Sent);
        Read_Sync(Actual_sync_bus);

        if (Actual_sync_bus == Data_Sent)
            passed(k);
        else
            failed(k);
    end

    $stop;
end

// ---------------------------------------------------------------
// DUT instantiation
// ---------------------------------------------------------------
DATA_SYNC #(.NUM_STAGES(NUM_STAGES), .BUS_WIDTH(BUS_WIDTH)) DUT (
    .CLK          (CLK_TB),
    .RST          (RST_TB),
    .bus_enable   (bus_enable_TB),
    .unsync_bus   (unsync_bus_TB),
    .sync_bus     (sync_bus_TB),
    .enable_pulse (enable_pulse_TB)
);

// ---------------------------------------------------------------
// Tasks
// ---------------------------------------------------------------
task initialize;
begin
    bus_enable_TB = 0;
    unsync_bus_TB = 0;
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

// Generate a random data byte for this test case
task Gen_Data(output [BUS_WIDTH-1:0] Data_Out);
begin
    Data_Out = $random;
end
endtask


task Send_Data(input [BUS_WIDTH-1:0] Data_In);
begin
    unsync_bus_TB = Data_In;
    bus_enable_TB = 1'b1;
    @(negedge CLK_TB);
    bus_enable_TB = 1'b0;
end
endtask


task Read_Sync(output [BUS_WIDTH-1:0] Sync_out);
    integer j;
begin
    for (j = 0; j < NUM_STAGES + 2; j = j + 1) begin
        @(negedge CLK_TB);
    end
    Sync_out = sync_bus_TB;
end
endtask

task passed(input integer idx);
begin
    $display("PASSED  -> Case %0d : DATA=%0h | Expected_sync_bus=%0h Actual_sync_bus=%0h at t=%0t",
              idx, Data_Sent, Data_Sent, Actual_sync_bus, $time);
end
endtask

task failed(input integer idx);
begin
    $display("FAILED  -> Case %0d : DATA=%0h | Expected_sync_bus=%0h Actual_sync_bus=%0h at t=%0t",
              idx, Data_Sent, Data_Sent, Actual_sync_bus, $time);
end
endtask

// ---------------------------------------------------------------
// Clock GENERATING
// ---------------------------------------------------------------
always #0.05 CLK_TB = ~CLK_TB;


endmodule
