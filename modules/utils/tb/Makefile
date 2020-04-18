
# Name of the testbench without extenstion
#TESTBENCH = clock_divider_tb
#TESTBENCH = fractional_clock_divider_tb
#TESTBENCH = fractional_clock_divider_variable_tb
#TESTBENCH = utils_tb
#TESTBENCH = event_hold_stage_tb
TESTBENCH ?= edge_detect_tb

FILES =  \
	../hdl/utils_pkg.vhd

# VHDL files
ifeq ($(TESTBENCH),clock_divider_tb)
FILES +=  \
	../hdl/clock_divider.vhd
GHDL_SIM_OPT = --stop-time=10us
else ifeq ($(TESTBENCH),fractional_clock_divider_tb)
FILES += \
	../hdl/fractional_clock_divider.vhd
GHDL_SIM_OPT = --stop-time=10ms
else ifeq ($(TESTBENCH),fractional_clock_divider_variable_tb)
FILES += \
	../hdl/fractional_clock_divider_variable.vhd
GHDL_SIM_OPT = --stop-time=10ms
else ifeq ($(TESTBENCH),event_hold_stage_tb)
FILES += \
	../hdl/event_hold_stage.vhd
GHDL_SIM_OPT = --stop-time=1us
else ifeq ($(TESTBENCH),utils_tb)
FILES += \
	../hdl/text_pkg.vhd
GHDL_SIM_OPT = --stop-time=1us
else ifeq ($(TESTBENCH),edge_detect_tb)
FILES += \
	../hdl/edge_detect.vhd
GHDL_SIM_OPT = --stop-time=10us
endif

# Default settings for gtkwave (visable signal etc.)
#  use gtkwave > File > Write Save File (Strg + S) to generate the file
WAVEFORM_SETTINGS = $(TESTBENCH).sav

# Load default options for GHDL.
# Defines make [all|compile|run|view|clean]
include ../../makefile.ghdl.mk

