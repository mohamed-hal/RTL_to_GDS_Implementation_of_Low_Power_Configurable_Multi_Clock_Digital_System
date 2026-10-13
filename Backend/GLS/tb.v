// =====================================================================
// tb.v  -  functional testbench for the SYS_TOP gate-level
//                       netlist (post-synthesis, scan-inserted)
//
// The testbench plays the "Master": it sends command frames on UART_RX_IN
// and reads the replies from UART_TX_O.
//
//   RF write   : 0xAA, Addr, Data            (no reply)
//   RF read    : 0xBB, Addr                  (reply: 1 byte)
//   ALU w/ op  : 0xCC, A, B, FUN             (reply: 2 bytes, LSB first)
//   ALU no op  : 0xDD, FUN                   (reply: 2 bytes, LSB first)
//
// WHAT CHANGED FOR THE NETLIST (vs. the RTL testbench)
//   * DUT is SYS_TOP.  Port names changed:
//        RST -> RST_N,  RX_IN -> UART_RX_IN,  TX_OUT -> UART_TX_O,
//        Parity_Error -> parity_error,  Stop_Error -> framing_error
//   * The netlist has DFT ports.  They are tied to their functional-mode
//     values:  test_mode = 0, SE = 0, SI = 0, scan_clk = 0, scan_rst = 1
//     (test_mode = 0 selects REF_CLK / UART_CLK / RST_N through the
//     scan muxes, and keeps the ALU clock gate under CLK_EN control).
//   * No backdoor write.  The register file is now 128 flip-flops
//     (\regfile_reg[n][b]) - there is no regfile[] array to assign to.
//     REG2 is therefore configured through the UART itself, using the
//     reset-default configuration for the first command (see below).
//
// CONFIGURATION
//   Reset defaults : REG2 = 0x81  -> PAR_EN = 1, PAR_TYP = 0 (even),
//                                    Prescale = 32 -> RX div ratio = 1
//                    REG3 = 0x20  -> TX_CLK = UART_CLK/32
//   With ratio = 1 the ClkDiv in the netlist passes UART_CLK straight
//   through, so RX samples 32 UART_CLK per bit = BIT_PERIOD, and the first
//   frames only need an even-parity bit.  REG2 is then rewritten to 0x20
//   (parity off, Prescale = 8, RX_CLK = UART_CLK/4) which is the same
//   bit time, so the rest of the test runs without a parity bit.
//   -> RX and TX both run at 32 UART_CLK cycles per bit (115200 baud).
// =====================================================================
`timescale 1ns/1ps

module tb;

    // ---------------- clocks / reset / DUT pins ----------------
    localparam REF_PERIOD  = 20.0;            // 50 MHz
    localparam UART_PERIOD = 1000.0/3.6864;   // 3.6864 MHz
    localparam BIT_PERIOD  = 32 * UART_PERIOD;

    reg  REF_CLK;
    reg  UART_CLK;
    reg  RST_N;
    reg  UART_RX_IN;
    wire UART_TX_O;
    wire parity_error;
    wire framing_error;

    // DFT pins - held in functional mode
    reg  [3:0] SI;
    reg        SE;
    reg        test_mode;
    reg        scan_clk;
    reg        scan_rst;
    wire [3:0] SO;

    SYS_TOP dut (
        .REF_CLK      (REF_CLK),
        .UART_CLK     (UART_CLK),
        .RST_N        (RST_N),
        .UART_RX_IN   (UART_RX_IN),
        .SI           (SI),
        .SE           (SE),
        .test_mode    (test_mode),
        .scan_clk     (scan_clk),
        .scan_rst     (scan_rst),
        .SO           (SO),
        .UART_TX_O    (UART_TX_O),
        .parity_error (parity_error),
        .framing_error(framing_error)
    );

    initial begin
        SI        = 4'b0000;
        SE        = 1'b0;
        test_mode = 1'b0;
        scan_clk  = 1'b0;
        scan_rst  = 1'b1;       // scan reset inactive (active low)
    end

    initial REF_CLK  = 1'b0;
    initial UART_CLK = 1'b0;
    always #(REF_PERIOD/2)  REF_CLK  = ~REF_CLK;
    always #(UART_PERIOD/2) UART_CLK = ~UART_CLK;

    // ---------------- signals shown in the waveform ----------------
    reg  [7:0]  tx_byte;      // byte the master is sending on UART_RX_IN
    reg  [7:0]  rx_byte;      // byte the master received from UART_TX_O
    reg  [15:0] rx_word;      // 16-bit ALU result received
    reg  [7:0]  exp_byte;     // expected byte
    reg  [15:0] exp_word;     // expected ALU result
    reg  [8*20:1] cmd_name;   // command being executed (ASCII, shown in waveform)
    reg  [8*24:1] test_name;  // test case being executed (ASCII, shown in waveform)

    // Master's view of the UART frame format (mirrors REG2[1:0] in the DUT)
    reg         par_en_m;     // 1 = frames carry a parity bit
    reg         par_typ_m;    // 0 = even, 1 = odd

    // SYS_CTRL FSM state.  The netlist state register is 4 bits wide, but
    // synthesis renamed bit 3 to the scan-out port test_so2, so the
    // Current_State net inside SYS_CTRL_UNIT only shows bits [2:0].
    wire [3:0] sysctrl_state = {dut.SYS_CTRL_UNIT.test_so2,
                                dut.SYS_CTRL_UNIT.Current_State};

    // ---------------- register-file monitor (for waveform screenshots) ----------------
    // Address / WrEn / RdEn inside the DUT are only valid for ONE REF_CLK cycle
    // (20 ns), which is invisible when the whole run is on screen. These copies
    // hold the last value / stretch the pulses so they can be seen at any zoom.
    reg  [3:0] rf_addr_held;
    reg  [7:0] rf_wrdata_held;
    reg  [7:0] rf_rddata_held;
    reg  [7:0] wr_stretch;
    reg  [7:0] rd_stretch;
    wire       rf_wr_seen = (wr_stretch != 0);
    wire       rf_rd_seen = (rd_stretch != 0);

    initial begin
        rf_addr_held = 0; rf_wrdata_held = 0; rf_rddata_held = 0;
        wr_stretch = 0;   rd_stretch = 0;
    end

    always @(posedge REF_CLK) begin
        if (dut.WrEn) begin
            rf_addr_held   <= dut.MEM_Addr;
            rf_wrdata_held <= dut.Wr_D;
            wr_stretch     <= 8'd200;            // ~4 us
        end else if (wr_stretch != 0)
            wr_stretch <= wr_stretch - 1'b1;

        if (dut.RdEn) begin
            rf_addr_held   <= dut.MEM_Addr;
            rd_stretch     <= 8'd200;
        end else if (rd_stretch != 0)
            rd_stretch <= rd_stretch - 1'b1;

        if (dut.Rd_D_Vld)
            rf_rddata_held <= dut.Rd_D;
    end

    // ---------------- ALU codes ----------------
    localparam [3:0] ADD=0, SUB=1, MUL=2, DIV=3, AND=4, OR=5, NAND=6, NOR=7,
                     XOR=8, XNOR=9, EQL=10, GT=11, LT=12, SHR=13, SHL=14;

    integer pass_cnt = 0;
    integer fail_cnt = 0;

    // ---------------- master -> DUT : one UART frame ----------------
    task send_byte(input [7:0] data);
        integer i;
        begin
            tx_byte = data;
            UART_RX_IN = 1'b0;                   // start
            #(BIT_PERIOD);
            for (i = 0; i < 8; i = i + 1) begin  // data, LSB first
                UART_RX_IN = data[i];
                #(BIT_PERIOD);
            end
            if (par_en_m) begin                  // parity (even: ^data, odd: ~^data)
                UART_RX_IN = par_typ_m ? ~(^data) : (^data);
                #(BIT_PERIOD);
            end
            UART_RX_IN = 1'b1;                   // stop
            #(BIT_PERIOD);
        end
    endtask

    // ---------------- DUT -> master : one UART frame ----------------
    task recv_byte(output [7:0] data);
        integer i;
        begin
            @(negedge UART_TX_O);                // start bit
            #(BIT_PERIOD/2);                     // middle of start bit
            for (i = 0; i < 8; i = i + 1) begin
                #(BIT_PERIOD);
                data[i] = UART_TX_O;
            end
            if (par_en_m)
                #(BIT_PERIOD);                   // parity bit (not checked here)
            #(BIT_PERIOD);                       // stop bit
        end
    endtask

    // ---------------- checkers ----------------
    task check_byte(input [8*24:1] name);
        begin
            if (rx_byte === exp_byte) begin
                pass_cnt = pass_cnt + 1;
                $display("PASS  %0s  got 0x%02h", name, rx_byte);
            end else begin
                fail_cnt = fail_cnt + 1;
                $display("FAIL  %0s  got 0x%02h expected 0x%02h", name, rx_byte, exp_byte);
            end
        end
    endtask

    task check_word(input [8*24:1] name);
        begin
            if (rx_word === exp_word) begin
                pass_cnt = pass_cnt + 1;
                $display("PASS  %0s  got 0x%04h", name, rx_word);
            end else begin
                fail_cnt = fail_cnt + 1;
                $display("FAIL  %0s  got 0x%04h expected 0x%04h", name, rx_word, exp_word);
            end
        end
    endtask

    // ---------------- command tasks ----------------
    task rf_write(input [7:0] addr, input [7:0] data);
        begin
            cmd_name = "RF_Wr_CMD";
            test_name = "RF write";
            send_byte(8'hAA);
            send_byte(addr);
            send_byte(data);
            #(2*BIT_PERIOD);
            cmd_name = "IDLE";
        end
    endtask

    task rf_read(input [7:0] addr, input [7:0] expected, input [8*24:1] name);
        begin
            exp_byte = expected;
            cmd_name = "RF_Rd_CMD";
            test_name = name;
            send_byte(8'hBB);
            send_byte(addr);
            recv_byte(rx_byte);
            check_byte(name);
            #(2*BIT_PERIOD);
            cmd_name = "IDLE";
        end
    endtask

    task alu_with_operands(input [7:0] a, input [7:0] b, input [3:0] fun,
                           input [15:0] expected, input [8*24:1] name);
        reg [7:0] lsb, msb;
        begin
            exp_word = expected;
            cmd_name = "ALU_OPER_W_OP_CMD";
            test_name = name;
            send_byte(8'hCC);
            send_byte(a);
            send_byte(b);
            send_byte({4'b0, fun});
            recv_byte(lsb);
            recv_byte(msb);
            rx_word = {msb, lsb};
            check_word(name);
            #(2*BIT_PERIOD);
            cmd_name = "IDLE";
        end
    endtask

    task alu_no_operands(input [3:0] fun, input [15:0] expected, input [8*24:1] name);
        reg [7:0] lsb, msb;
        begin
            exp_word = expected;
            cmd_name = "ALU_OPER_W_NOP_CMD";
            test_name = name;
            send_byte(8'hDD);
            send_byte({4'b0, fun});
            recv_byte(lsb);
            recv_byte(msb);
            rx_word = {msb, lsb};
            check_word(name);
            #(2*BIT_PERIOD);
            cmd_name = "IDLE";
        end
    endtask

    // ---------------- test sequence ----------------
    initial begin
    $dumpfile("VCD/SYS.vcd");
    $dumpvars(0, tb);
        UART_RX_IN = 1'b1;
        RST_N = 1'b0;
        tx_byte = 0; rx_byte = 0; rx_word = 0; exp_byte = 0; exp_word = 0;
        par_en_m = 1'b1; par_typ_m = 1'b0;       // reset-default frame format (REG2 = 0x81)
        cmd_name = "IDLE"; test_name = "RESET";

        #200;
        RST_N = 1'b1;                            // release reset
        // let both reset synchronisers release (2 stages each) and the
        // clock dividers settle before the first frame
        #(20*UART_PERIOD);

        // ---- 1) configuration (REG2 / REG3) ----
        $display("--- 1) Configuration ---");
        // First command goes out in the reset-default format (even parity).
        rf_write(8'h02, 8'h20);                  // REG2 = 0x20 : parity off, Prescale = 8
        par_en_m = 1'b0;                         // DUT now expects frames without parity
        test_name = "REG2 configured";
        rf_write(8'h03, 8'h20);                  // REG3 = 0x20 (same as reset value)
        rf_read (8'h02, 8'h20, "Read REG2");
        rf_read (8'h03, 8'h20, "Read REG3");

        // ---- 2) Register file write / read ----
        $display("--- 2) Register File write/read ---");
        rf_write(8'h04, 8'hA5);
        rf_read (8'h04, 8'hA5, "RF[0x4] = A5");
        rf_write(8'h08, 8'h3C);
        rf_read (8'h08, 8'h3C, "RF[0x8] = 3C");

        // ---- 3) ALU with operands (0xCC) ----
        $display("--- 3) ALU operations with operands ---");
        alu_with_operands(8'd12, 8'd5,  ADD,  16'd17,   "ADD 12+5");
        alu_with_operands(8'd12, 8'd5,  SUB,  16'd7,    "SUB 12-5");
        alu_with_operands(8'd13, 8'd11, MUL,  16'd143,  "MUL 13*11");
        alu_with_operands(8'd20, 8'd4,  DIV,  16'd5,    "DIV 20/4");
        alu_with_operands(8'hF0, 8'h3C, AND,  16'h0030, "AND F0&3C");
        alu_with_operands(8'hF0, 8'h0F, OR,   16'h00FF, "OR  F0|0F");
        alu_with_operands(8'hAA, 8'h55, XOR,  16'h00FF, "XOR AA^55");
        alu_with_operands(8'd7,  8'd7,  EQL,  16'd1,    "CMP A=B  7==7");
        alu_with_operands(8'd9,  8'd3,  GT,   16'd2,    "CMP A>B  9>3");
        alu_with_operands(8'h81, 8'h00, SHR,  16'h0040, "SHIFT A>>1");
        alu_with_operands(8'h81, 8'h00, SHL,  16'h0102, "SHIFT A<<1");

        // ---- 4) ALU without operands (0xDD): uses REG0 / REG1 ----
        $display("--- 4) ALU operations without operands ---");
        rf_write(8'h00, 8'd50);                  // REG0 = operand A
        rf_write(8'h01, 8'd8);                   // REG1 = operand B
        alu_no_operands(ADD, 16'd58,  "NOP ADD 50+8");
        alu_no_operands(MUL, 16'd400, "NOP MUL 50*8");

        // ---- 5) error flags ----
        $display("--- 5) Error flags ---");
        if (!parity_error && !framing_error) begin
            pass_cnt = pass_cnt + 1;
            $display("PASS  no parity / stop error");
        end else begin
            fail_cnt = fail_cnt + 1;
            $display("FAIL  parity_error=%b framing_error=%b", parity_error, framing_error);
        end

        $display("=============================================");
        $display(" %0d PASSED, %0d FAILED", pass_cnt, fail_cnt);
        $display(" %0s", (fail_cnt == 0) ? "ALL TESTS PASSED" : "SOME TESTS FAILED");
        $display("=============================================");
        #(10*BIT_PERIOD);
        $finish;
    end

    // watchdog
    initial begin
        #50_000_000;
        $display("FAIL  watchdog timeout");
        $finish;
    end

endmodule
