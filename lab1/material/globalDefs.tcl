

# path to vhdl files
set VHDL_SRC_PATH "../src"

# name of top entity in testbench
set TOP_ENTITY_NAME "tb_fir_top"

# simulation time
set SIMULATION_TIME_NS 10000000ns

# name of testbench 
set TB_FILE "tb_firFilter.sv"

# name of top module in testbench
set TB_MODULE "tb_fir_top"

# name of vhdl top entity of filter
set TOP_ENTITY "datapath"

# name of instance of vhdl top entity of filter
set TB_TOP_ENTITY_UUT "firFilter_tb"

# path to generated verilog netlist 
set NETLIST_PATH "../netlist"

# path to generated vcd
set VCD_PATH "../vcd"

# path to testbench
set TB_PATH "../tb"

# SYNOPSYS SECTION
set WORK_DIR "work"
set SRC_PATH "../src"
set TOP_ENTITY "datapath"
set TOP_ARCH "structural"
set CLK_NAME "MY_CLK"
# LOWEST CLOCK PERIOD FOUND: 3.96ns
set CLK_PERIOD 3.96
set CLK_PIN "clock"
set JITTER 0.07
set INPUT_DELAY 0.5
set OUTPUT_DELAY 0.5
set REPORT_PATH "report"
set SAIF_PATH "../saif"
set TB_UUT "firFilter_tb"
