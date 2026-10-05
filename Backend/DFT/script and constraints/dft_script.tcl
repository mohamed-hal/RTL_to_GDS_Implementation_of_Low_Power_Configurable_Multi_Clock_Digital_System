
########################### Define Top Module ############################
                                                   
set top_module SYS_TOP

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

############################# Formality Setup File ##########################
                                                   
set_svf $top_module.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path /home/ICer/Assignments/FINAL_SYSTEM/std_cells
lappend search_path /home/ICer/Assignments/FINAL_SYSTEM/RTL

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

set file_format verilog

analyze -format $file_format ALU.v
analyze -format $file_format ClkDiv.v
analyze -format $file_format CLK_GATE.v
analyze -format $file_format Data_Sampling.v
analyze -format $file_format DATA_SYNC.v
analyze -format $file_format deserializer.v
analyze -format $file_format edge_bit_counter.v
analyze -format $file_format FIFO_MEM.v
analyze -format $file_format FIFO_rptr_empty.v
analyze -format $file_format FIFO_TOP.v
analyze -format $file_format FIFO_wptr_full.v
analyze -format $file_format SYS_TOP.v
analyze -format $file_format FSM.v
analyze -format $file_format FSM_RX.v
analyze -format $file_format MUX.v
analyze -format $file_format mux2X1.v
analyze -format $file_format Parity_Calc.v
analyze -format $file_format Parity_Check.v
analyze -format $file_format Prescale_MUX.v
analyze -format $file_format PULSE_GEN.v
analyze -format $file_format Register_File.v
analyze -format $file_format RST_SYNC.v
analyze -format $file_format serializer.v
analyze -format $file_format Start_Check.v
analyze -format $file_format Stop_Check.v
analyze -format $file_format sync_r2w.v
analyze -format $file_format sync_w2r.v
analyze -format $file_format SYS_CTRL.v
analyze -format $file_format UART.v
analyze -format $file_format UART_RX.v
analyze -format $file_format UART_TX.v

elaborate -lib work SYS_TOP

###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

#link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source ./cons.tcl

#################### Archirecture Scan Chains #########################
puts "###############################################"
puts "############ Configure scan chains ############"
puts "###############################################"

set_scan_configuration -clock_mixing no_mix  \
                       -style multiplexed_flip_flop \
                       -replace true -max_length 100  

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

#test_ready compile
compile -scan

################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

########################## Define DFT Signals ##########################

set_dft_signal -port [get_ports scan_clk]  -type ScanClock   -view existing_dft  -timing {30 60}
set_dft_signal -port [get_ports scan_rst]  -type Reset       -view existing_dft  -active_state 0
set_dft_signal -port [get_ports test_mode] -type Constant    -view existing_dft  -active_state 1 
set_dft_signal -port [get_ports test_mode] -type TestMode    -view spec          -active_state 1 
set_dft_signal -port [get_ports SE]        -type ScanEnable  -view spec          -active_state 1   -usage scan
set_dft_signal -port [get_ports SI]        -type ScanDataIn  -view spec 
set_dft_signal -port [get_ports SO]        -type ScanDataOut -view spec  

############################# Create Test Protocol #######################
                                           
create_test_protocol

###################### Pre-DFT Design Rule Checking #######################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary

############################# Insert DFT ##############################

insert_dft
compile -scan -incremental

###################### Design Rule Checking #######################

dft_drc -verbose -coverage_estimate

#############################################################################
# Write out files
#############################################################################
set_svf -off
write_file -format verilog -hierarchy -output $top_module.v
write_file -format ddc -hierarchy -output $top_module.ddc
write_sdc  -nosplit $top_module.sdc
write_sdf           $top_module.sdf

####################### reporting ##########################################

report_area -hierarchy > area_dft.rpt
report_power -hierarchy > power_dft.rpt
report_timing -max_paths 100 -delay_type min > hold_dft.rpt
report_timing -max_paths 100 -delay_type max > setup_dft.rpt
report_clock -attributes > clocks_dft.rpt
report_constraint -all_violators > constraints_dft.rpt

################# starting graphical user interface #######################

#gui_start

#exit
