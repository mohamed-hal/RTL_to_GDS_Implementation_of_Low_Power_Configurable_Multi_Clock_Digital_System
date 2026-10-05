# ======================================================================
# run.do - QuestaSim script for Final_System (main signals only)
#   GUI   : vsim -do run.do
#   Batch : vsim -c -do run.do
# ======================================================================
quietly set StdArithNoWarnings 1
catch {quit -sim}
if {[file exists work]} {
    vdel -lib work -all
}
vlib work
vmap work work

vlog -work work -f Source_file.txt
vsim -voptargs="+acc" -work work work.tb_Final_System

# ---------------- waveform: main signals only ----------------
delete wave *

add wave -divider "Clocks & Reset"
add wave -noupdate -label REF_CLK   /tb_Final_System/REF_CLK
add wave -noupdate -label UART_CLK  /tb_Final_System/UART_CLK
add wave -noupdate -label RST       /tb_Final_System/RST

add wave -divider "Command being executed"
add wave -noupdate -label COMMAND   -radix ascii /tb_Final_System/cmd_name
add wave -noupdate -label TEST_CASE -radix ascii /tb_Final_System/test_name

add wave -divider "Master side (Testbench)"
add wave -noupdate -label RX_IN         /tb_Final_System/RX_IN
add wave -noupdate -label TX_OUT        /tb_Final_System/TX_OUT
add wave -noupdate -label byte_sent     -radix hex /tb_Final_System/tx_byte
add wave -noupdate -label byte_received -radix hex /tb_Final_System/rx_byte
add wave -noupdate -label ALU_result_rx -radix hex /tb_Final_System/rx_word
add wave -noupdate -label ALU_expected  -radix hex /tb_Final_System/exp_word
add wave -noupdate -label Parity_Error  /tb_Final_System/Parity_Error
add wave -noupdate -label Stop_Error    /tb_Final_System/Stop_Error

add wave -divider "UART RX -> SYS_CTRL"
add wave -noupdate -label RX_P_DATA -radix hex /tb_Final_System/DUT/SYNC_RX_P_DATA
add wave -noupdate -label RX_D_VLD  /tb_Final_System/DUT/SYNC_RX_Data_Valid
add wave -noupdate -label FSM_state -radix unsigned /tb_Final_System/DUT/SYS_CTRL_UNIT/Current_State

add wave -divider "Register File (held = readable at any zoom)"
add wave -noupdate -label WrEn_held      /tb_Final_System/rf_wr_seen
add wave -noupdate -label RdEn_held      /tb_Final_System/rf_rd_seen
add wave -noupdate -label Address_held   -radix hex /tb_Final_System/rf_addr_held
add wave -noupdate -label WrData_held    -radix hex /tb_Final_System/rf_wrdata_held
add wave -noupdate -label RdData_held    -radix hex /tb_Final_System/rf_rddata_held

add wave -divider "Register File (raw, 1 clock pulses)"
add wave -noupdate -label Address       -radix hex /tb_Final_System/DUT/MEM_Addr
add wave -noupdate -label WrEn          /tb_Final_System/DUT/WrEn
add wave -noupdate -label WrData        -radix hex /tb_Final_System/DUT/Wr_D
add wave -noupdate -label RdEn          /tb_Final_System/DUT/RdEn
add wave -noupdate -label RdData        -radix hex /tb_Final_System/DUT/Rd_D
add wave -noupdate -label RdData_Valid  /tb_Final_System/DUT/Rd_D_Vld

add wave -divider "Register File contents"
add wave -noupdate -label REG0_OpA      -radix hex /tb_Final_System/DUT/OP_A
add wave -noupdate -label REG1_OpB      -radix hex /tb_Final_System/DUT/OP_B
add wave -noupdate -label REG2_UARTcfg  -radix hex /tb_Final_System/DUT/UART_CONFIG
add wave -noupdate -label REG3_DivRatio -radix hex /tb_Final_System/DUT/TX_DIV_RATIO

add wave -divider "ALU"
add wave -noupdate -label CLK_EN     /tb_Final_System/DUT/CLK_EN
add wave -noupdate -label ALU_EN     /tb_Final_System/DUT/ALU_EN
add wave -noupdate -label ALU_FUN    -radix hex /tb_Final_System/DUT/ALU_FUN
add wave -noupdate -label ALU_OUT    -radix hex /tb_Final_System/DUT/ALU_OUT
add wave -noupdate -label OUT_VALID  /tb_Final_System/DUT/ALU_OUT_VALID

add wave -divider "ASYNC FIFO -> UART TX"
add wave -noupdate -label WR_INC   /tb_Final_System/DUT/WR_INC
add wave -noupdate -label WR_DATA  -radix hex /tb_Final_System/DUT/WR_DATA
add wave -noupdate -label FIFO_FULL /tb_Final_System/DUT/FIFO_FULL
add wave -noupdate -label F_EMPTY  /tb_Final_System/DUT/F_EMPTY
add wave -noupdate -label RD_INC   /tb_Final_System/DUT/RD_INC
add wave -noupdate -label RD_DATA  -radix hex /tb_Final_System/DUT/TX_P_DATA

configure wave -namecolwidth 170
configure wave -valuecolwidth 70

run -all
wave zoom full
