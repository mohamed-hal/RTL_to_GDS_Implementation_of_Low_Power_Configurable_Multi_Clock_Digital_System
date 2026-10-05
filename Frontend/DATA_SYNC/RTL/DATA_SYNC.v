module DATA_SYNC #(parameter NUM_STAGES = 3 , BUS_WIDTH = 8) (
    input   wire                     CLK,
    input   wire                     RST,
    input   wire                     bus_enable,
    input   wire [BUS_WIDTH - 1 : 0] unsync_bus,
    output  reg  [BUS_WIDTH - 1 : 0] sync_bus,
    output  reg                      enable_pulse
    );

    reg [NUM_STAGES - 1 :0] enable_reg;
    reg pulse_gen_reg;
    wire pulse_gen_comb;

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            enable_reg <= 'b0;
        end else begin
            enable_reg <= {enable_reg[NUM_STAGES - 2 :0] , bus_enable};

        end
    end

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            pulse_gen_reg <= 'b0;
            enable_pulse  <= 'b0;
        end else begin
            pulse_gen_reg <= enable_reg[NUM_STAGES - 1];
            enable_pulse  <= pulse_gen_comb;
        end
    end

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            sync_bus <= 'b0;
        end else if (pulse_gen_comb) begin
            sync_bus <= unsync_bus;
        end
    end

    assign pulse_gen_comb = (~pulse_gen_reg) & enable_reg[NUM_STAGES - 1];
endmodule

