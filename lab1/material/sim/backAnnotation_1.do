source ../globalDefs.tcl

# compiling stimulus
vcom -work ./work $SRC_PATH/clk_gen.vhd
vcom -work ./work $SRC_PATH/data_maker.vhd
vcom -work ./work $SRC_PATH/data_sink.vhd

# compiling verilog netllist
vlog -work ./work $NETLIST_PATH/$TOP_ENTITY.v

# compile testbench 
vlog -sv -work ./work $TB_PATH/$TB_FILE


# compiling verilog source
vsim -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /$TB_MODULE/$TB_TOP_ENTITY_UUT=$NETLIST_PATH/$TOP_ENTITY.sdf work.$TB_MODULE 

# creating vcd
vcd file $VCD_PATH/${TOP_ENTITY}_syn.vcd
vcd add /$TB_MODULE/$TB_TOP_ENTITY_UUT/*


# running simulation
run 2 us
