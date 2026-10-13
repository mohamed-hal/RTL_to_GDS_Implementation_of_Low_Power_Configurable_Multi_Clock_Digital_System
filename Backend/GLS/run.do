vlib work
vmap work

# Compile Standard Cell Library
vlog -sv /home/ICer/Labs/Lab_GLS_1.0/std_cells/tsmc13_m.v

# Compile Gate-Level Netlist
vlog -sv /home/ICer/Labs/Lab_GLS_1.0_Ass/PnR/export/SYS_TOP.v

# Compile Testbench
vlog -sv tb.v

# Start Simulation
vsim -voptargs=+acc -sdfmax /tb/dut=/home/ICer/Labs/Lab_GLS_1.0_Ass/PnR/export/SYS_TOP.sdf -sdfnoerror +no_notifier work.tb

# Load waveform 
do wave.do

# Run
run -all
