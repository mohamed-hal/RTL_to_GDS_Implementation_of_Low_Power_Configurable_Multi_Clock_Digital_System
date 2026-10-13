# ======================================================================
# wave.do - gate-level (SYS_TOP netlist) waveform
#   Same signals, same ORDER and same labels as run.do, retargeted to the
#   scan-inserted SYS_TOP netlist and the updated tb_Final_System.
#   Use :  vsim ... ; do wave.do ; run -all ; wave zoom full
#   (or replace the "add wave" block in run.do with:  do wave.do)
#
#   Netlist-related changes
#     * TB signal names follow the new SYS_TOP ports:
#         RST_N, UART_RX_IN, UART_TX_O, parity_error, framing_error
#     * FSM_state now uses $TB/sysctrl_state (4 bits).  In the netlist the
#       SYS_CTRL state register is 4 flops, but bit 3 was renamed to the
#       scan-out port test_so2, so SYS_CTRL_UNIT/Current_State shows only
#       bits [2:0].  The TB concatenates {test_so2, Current_State}.
#     * New groups at the end: UART clocks / dividers, synchronised resets,
#       raw UART data, and the DFT pins (held in functional mode).
#
#   All paths were checked against the SYS_TOP.v netlist.  F_EMPTY is the
#   FIFO read-side empty flag (FIFO_UNIT/rempty, which is net n28 at the top
#   level).  A path that is missing is skipped with a transcript message
#   instead of aborting.
# ======================================================================
onerror {resume}
quietly WaveActivateNextPane {} 0

set TB  /tb
set DUT $TB/dut

# add one signal; extra paths are fallbacks tried in order
proc aw {label radix args} {
    foreach p $args {
        set cmd [list add wave -noupdate -label $label]
        if {$radix ne ""} { lappend cmd -radix $radix }
        lappend cmd $p
        if {![catch {eval $cmd} err]} { return 1 }
    }
    echo "** wave.do: '$label' not found in netlist - skipped (edit its path)"
    return 0
}

delete wave *

add wave -divider "Clocks & Reset"
aw REF_CLK   ""    $TB/REF_CLK
aw UART_CLK  ""    $TB/UART_CLK
aw RST       ""    $TB/RST_N

add wave -divider "Command being executed"
aw COMMAND   ascii $TB/cmd_name
aw TEST_CASE ascii $TB/test_name

add wave -divider "Master side (Testbench)"
aw RX_IN          ""    $TB/UART_RX_IN
aw TX_OUT         ""    $TB/UART_TX_O
aw byte_sent      hex   $TB/tx_byte
aw byte_received  hex   $TB/rx_byte
aw ALU_result_rx  hex   $TB/rx_word
aw ALU_expected   hex   $TB/exp_word
aw Parity_Error   ""    $TB/parity_error
aw Stop_Error     ""    $TB/framing_error

add wave -divider "UART RX -> SYS_CTRL"
aw RX_P_DATA  hex      $DUT/SYNC_RX_P_DATA
aw RX_D_VLD   ""       $DUT/SYNC_RX_Data_Valid
# SYS_CTRL FSM state: 4-bit bus built in the TB ({test_so2, Current_State[2:0]})
aw FSM_state  unsigned $TB/sysctrl_state $DUT/SYS_CTRL_UNIT/Current_State

add wave -divider "Register File (held = readable at any zoom)"
aw WrEn_held     ""  $TB/rf_wr_seen
aw RdEn_held     ""  $TB/rf_rd_seen
aw Address_held  hex $TB/rf_addr_held
aw WrData_held   hex $TB/rf_wrdata_held
aw RdData_held   hex $TB/rf_rddata_held

add wave -divider "Register File (raw, 1 clock pulses)"
aw Address       hex $DUT/MEM_Addr
aw WrEn          ""  $DUT/WrEn
aw WrData        hex $DUT/Wr_D
aw RdEn          ""  $DUT/RdEn
aw RdData        hex $DUT/Rd_D
aw RdData_Valid  ""  $DUT/Rd_D_Vld

add wave -divider "Register File contents"
aw REG0_OpA       hex $DUT/OP_A
aw REG1_OpB       hex $DUT/OP_B
aw REG2_UARTcfg   hex $DUT/UART_CONFIG
aw REG3_DivRatio  hex $DUT/TX_DIV_RATIO

add wave -divider "ALU"
aw CLK_EN     ""  $DUT/CLK_EN
aw ALU_EN     ""  $DUT/ALU_EN
aw ALU_FUN    hex $DUT/ALU_FUN
aw ALU_OUT    hex $DUT/ALU_OUT
aw OUT_VALID  ""  $DUT/ALU_OUT_VALID

add wave -divider "ASYNC FIFO -> UART TX"
aw WR_INC    ""  $DUT/WR_INC
aw WR_DATA   hex $DUT/WR_DATA
aw FIFO_FULL ""  $DUT/FIFO_FULL
aw F_EMPTY   ""  $DUT/FIFO_UNIT/rempty $DUT/n28
aw RD_INC    ""  $DUT/RD_INC
aw RD_DATA   hex $DUT/TX_P_DATA

# ---------------------------------------------------------------------
# Added for the netlist
# ---------------------------------------------------------------------
add wave -divider "UART clocks / dividers"
aw RX_DIV_RATIO  unsigned $DUT/RX_DIV_RATIO
aw TX_DIV_RATIO  unsigned $DUT/TX_DIV_RATIO
aw RX_CLK        ""       $DUT/RX_CLK_M
aw TX_CLK        ""       $DUT/TX_CLK_M
aw ALU_CLK       ""       $DUT/ALU_CLK

add wave -divider "Synchronised resets"
aw SYNC_REF_RST   ""  $DUT/SYNC_REF_RST
aw SYNC_UART_RST  ""  $DUT/SYNC_UART_RST

add wave -divider "UART raw (before data sync)"
aw RX_P_DATA_raw  hex $DUT/RX_P_DATA
aw RX_Data_Valid  ""  $DUT/RX_Data_Valid
aw TX_Busy        ""  $DUT/TX_Busy

add wave -divider "DFT pins (functional mode: test_mode=0, SE=0)"
aw test_mode  ""  $TB/test_mode
aw SE         ""  $TB/SE
aw scan_clk   ""  $TB/scan_clk
aw scan_rst   ""  $TB/scan_rst
aw SI         hex $TB/SI
aw SO         hex $TB/SO

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 170
configure wave -valuecolwidth 70
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -timelineunits us
update
