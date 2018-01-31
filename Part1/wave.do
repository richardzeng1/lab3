# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns Part1.v

# Load simulation using mux as the top level simulation module.
vsim Part1

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[0]} 0 0, 1 5 -r 10
force {SW[1]} 0 0, 1 10 -r 20
force {SW[2]} 0 0, 1 20 -r 40
force {SW[3]} 0 0, 1 40 -r 80
force {SW[4]} 0 0, 1 80 -r 160
force {SW[5]} 0 0, 1 160 -r 320
force {SW[6]} 0 0, 1 320 -r 640
force {SW[7]} 0 0, 1 640 -r 1280
force {SW[8]} 0 0, 1 1280 -r 2560
force {SW[9]} 0 0, 1 2560 -r 5120
run 5500ns

