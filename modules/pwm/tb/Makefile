
# Name of the testbench without extenstion
#TESTBENCH = pwm_tb
TESTBENCH ?= pwm_module_tb

FILES = ../hdl/pwm.vhd \
	../hdl/pwm_pkg.vhd

# VHDL files
ifeq ($(TESTBENCH),pwm_tb)
# pass
else
FILES +=  \
	../../core/hdl/bus_pkg.vhd \
	../../utils/hdl/utils_pkg.vhd \
	../../utils/hdl/clock_divider.vhd \
	../hdl/pwm_module.vhd \
	../hdl/pwm_module_pkg.vhd
endif

# Default settings for gtkwave (visable signal etc.)
#  use gtkwave > File > Write Save File (Strg + S) to generate the file
WAVEFORM_SETTINGS = $(TESTBENCH).sav

# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=1000us

# Load default options for GHDL.
# Defines make [all|compile|run|view|clean]
include ../../makefile.ghdl.mk

