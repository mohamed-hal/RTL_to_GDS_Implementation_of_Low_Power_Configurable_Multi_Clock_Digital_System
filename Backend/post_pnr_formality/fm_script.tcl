
###################################################################
########################### Variables #############################
###################################################################

set SSLIB "/home/ICer/Assignments/FINAL_SYSTEM/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/ICer/Assignments/FINAL_SYSTEM/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/ICer/Assignments/FINAL_SYSTEM/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

###################################################################
############################ Guidance #############################
###################################################################

# Synopsys setup variable
set synopsys_auto_setup true

# Formality Setup File

set_svf /home/ICer/Assignments/FINAL_SYSTEM/DFT/SYS_TOP.svf

###################################################################
###################### Reference Container ########################
###################################################################

# Read Reference Design Verilog Files

read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/ALU.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/ClkDiv.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/CLK_GATE.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Data_Sampling.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/DATA_SYNC.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/deserializer.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/edge_bit_counter.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/FIFO_MEM.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/FIFO_rptr_empty.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/FIFO_TOP.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/FIFO_wptr_full.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/SYS_TOP.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/FSM.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/FSM_RX.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/MUX.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/mux2X1.v  
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Parity_Calc.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Parity_Check.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Prescale_MUX.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/PULSE_GEN.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Register_File.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/RST_SYNC.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/serializer.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Start_Check.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/Stop_Check.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/sync_r2w.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/sync_w2r.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/SYS_CTRL.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/UART.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/UART_RX.v
read_verilog -container Ref /home/ICer/Assignments/FINAL_SYSTEM/RTL/UART_TX.v





# Read Reference technology libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]


# set the top Reference Design 
set_reference_design SYS_TOP
set_top SYS_TOP


###################################################################
#################### Implementation Container #####################
###################################################################

# Read Implementation Design Files

read_verilog -container Imp /home/ICer/Assignments/FINAL_SYSTEM/pnr/netlist/SYS_TOP.v



# Read Implementation technology libraries
read_db -container Imp [list $SSLIB $TTLIB $FFLIB]


# set the top Implementation Design
set_implementation_design SYS_TOP
set_top SYS_TOP

########################## Don't verify ###########################
#scan_in
set_dont_verify_points -type port Ref:/WORK/*/SI[*]
set_dont_verify_points -type port Imp:/WORK/*/SI[*]

#scan_out
set_dont_verify_points -type port Ref:/WORK/*/SO[*]
set_dont_verify_points -type port Imp:/WORK/*/SO[*]


############################### contants #####################################

# all atpg enable (test_mode, scan_enable) are zero during formal compare

#test_mode
set_constant Ref:/WORK/*/test_mode 0
set_constant Imp:/WORK/*/test_mode 0

#scan_enable

set_constant Ref:/WORK/*/SE 0
set_constant Imp:/WORK/*/SE 0



###################### Matching Compare points ####################

match


######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui

