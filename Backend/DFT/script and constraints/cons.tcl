
####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. #set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

#################################### FUNC Clocks ###################################

#1. Master Clocks
set REF_CLK_PERIOD 20
set UART_CLK_PERIOD [expr {1e9 / (3.686 * 1e6)}]
set RX_CLK_PERIOD [expr $UART_CLK_PERIOD/1]
set TX_CLK_PERIOD [expr $UART_CLK_PERIOD/32]
set CLK_SETUP_SKEW 0.2
set CLK_HOLD_SKEW 0.1
set CLK_RISE 0.05
set CLK_FALL 0.05

#1. Master Clocks
create_clock -name REF_CLK -period $REF_CLK_PERIOD -waveform "0 [expr $REF_CLK_PERIOD/2]" [get_ports REF_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks REF_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks REF_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks REF_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks REF_CLK]



create_clock -name UART_CLK -period $UART_CLK_PERIOD -waveform "0 [expr $UART_CLK_PERIOD/2]" [get_ports UART_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks UART_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks UART_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks UART_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks UART_CLK]

#2. Generated clocks

create_generated_clock -master_clock REF_CLK -source [get_ports REF_CLK] -name "ALU_CLK" [get_port CLK_GATE_UNIT/GATED_CLK] -divide_by 1
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks ALU_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks ALU_CLK]

create_generated_clock -master_clock UART_CLK -source [get_ports UART_CLK] -name "RX_CLK" [get_port RX_CLK_GEN/o_div_clk] -divide_by 1
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks RX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks RX_CLK]

create_generated_clock -master_clock UART_CLK -source [get_ports UART_CLK] -name "TX_CLK" [get_port TX_CLK_GEN/o_div_clk] -divide_by 32
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks TX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks TX_CLK]


 

#################################### SCAN Clocks ###################################
set DFT_CLK_NAME DFTCLK
set DFT_CLK_PER 100
set DFT_CLK_SETUP_SKEW 0.2
set DFT_CLK_HOLD_SKEW 0.1
set DFT_CLK_RISE 0.05
set DFT_CLK_FALL 0.05

create_clock -name $DFT_CLK_NAME -period $DFT_CLK_PER -waveform "0 [expr $DFT_CLK_PER/2]" [get_ports scan_clk]
set_clock_uncertainty -setup $DFT_CLK_SETUP_SKEW [get_clocks $DFT_CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks $DFT_CLK_NAME]
set_clock_transition -rise $DFT_CLK_RISE  [get_clocks $DFT_CLK_NAME]
set_clock_transition -fall $DFT_CLK_FALL  [get_clocks $DFT_CLK_NAME]

set_dont_touch_network [get_clocks {REF_CLK UART_CLK ALU_CLK RX_CLK TX_CLK scan_clk }]

####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################
set_clock_groups -asynchronous -group [get_clocks "REF_CLK ALU_CLK"] -group [get_clocks "UART_CLK RX_CLK TX_CLK"] 

set_clock_groups -logically_exclusive -group [get_clocks "REF_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

set_clock_groups -logically_exclusive -group [get_clocks "UART_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

set_clock_groups -logically_exclusive -group [get_clocks "ALU_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

set_clock_groups -logically_exclusive -group [get_clocks "RX_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

set_clock_groups -logically_exclusive -group [get_clocks "TX_CLK"]     \
                                      -group [get_clocks "$DFT_CLK_NAME"] 

####################################################################################
           #########################################################
             #### Section 3 : #set input/output delay on ports ####
           #########################################################
####################################################################################

set in1_delay  [expr 0.2* $TX_CLK_PERIOD]
set out1_delay [expr 0.2* $TX_CLK_PERIOD]

set in2_delay  [expr 0.2* $RX_CLK_PERIOD]
set out2_delay [expr 0.2* $RX_CLK_PERIOD]

set in3_delay  [expr 0.2* $DFT_CLK_PER]
set out3_delay [expr 0.2* $DFT_CLK_PER]

#Constrain Input Paths
set_input_delay $in2_delay -clock UART_CLK [get_port UART_RX_IN]

#Constrain Output Paths
set_output_delay $out1_delay -clock UART_CLK [get_port UART_TX_O]
set_output_delay $out2_delay -clock UART_CLK [get_port parity_error]
set_output_delay $out2_delay -clock UART_CLK [get_port framing_error]

#Constrain Scan Input Paths
set_input_delay $in3_delay -clock $DFT_CLK_NAME [get_port test_mode]
set_input_delay $in3_delay -clock $DFT_CLK_NAME [get_port SI]
set_input_delay $in3_delay -clock $DFT_CLK_NAME [get_port SE]

#Constrain Scan Output Paths
set_output_delay $out3_delay -clock $DFT_CLK_NAME [get_port SO]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port UART_RX_IN]

#scan ports
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port test_mode]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SI]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SE]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.1 [get_port UART_TX_O]
set_load 0.1 [get_port parity_error]
set_load 0.1 [get_port framing_error]

#scan ports
set_load 0.5  [get_port SO]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################
           #########################################################
                  #### Section 8 : Case Analysis ####
           #########################################################
####################################################################################

set_case_analysis 0 [get_port test_mode]

####################################################################################

