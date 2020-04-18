
# Name of the testbench without extenstion
TESTBENCH = dds_module_tb

# VHDL files
FILES =  \
	../../core/hdl/reset_pkg.vhd \
	../../core/hdl/bus_pkg.vhd \
	../../peripheral_register/hdl/reg_file_pkg.vhd \
	../../peripheral_register/hdl/peripheral_register.vhd \
	../../peripheral_register/hdl/reg_file_bram.vhd \
	../../ram/hdl/xilinx_block_ram_pkg.vhd \
	../../ram/hdl/xilinx_block_ram.vhd \
	../../utils/hdl/utils_pkg.vhd \
	../hdl/dds_module_pkg.vhd \
	../hdl/dds_module.vhd \
	../hdl/nco_pkg.vhd \
	../hdl/nco.vhd

# Default settings for gtkwave (visable signal etc.)
#  use gtkwave > File > Write Save File (Strg + S) to generate the file
WAVEFORM_SETTINGS = $(TESTBENCH).sav

# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=1000us

# Load default options for GHDL.
# Defines make [all|compile|run|view|clean]
include ../../makefile.ghdl.mk

