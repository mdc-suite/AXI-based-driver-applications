# ############################################################################################
# HLS-based IP Generation Flow
# ############################################################################################
# This script simulates, synthesizes, co-simulates and exports an IP by using Vitis HLS.
#
# Inputs (*** TO BE SET BY THE USER ***):
# - design and testbench files;
# - name of top-level function;
# - technology and clock reate.
#
# Author: 	Claudio Rubattu (University of Sassari)
# Date: 	10/20/2023
# Version: 	1.0
# ############################################################################################


# ############################################################################################
# IP Project
# ############################################################################################
# Set the path of the design files (*** TO BE SET BY THE USER ***)
set C_PRJ_PATH		"./src"
# Project Creation
open_project -reset prj_VPA_IP
# Add the design files (*** TO BE SET BY THE USER ***)
add_files $C_PRJ_PATH/accumulation_point.cpp
add_files $C_PRJ_PATH/config.h
add_files $C_PRJ_PATH/elaboration_data.cpp
add_files $C_PRJ_PATH/gaussian.cpp
add_files $C_PRJ_PATH/gradient.cpp
add_files $C_PRJ_PATH/hough_space.cpp
add_files $C_PRJ_PATH/hough_space_size.cpp
add_files $C_PRJ_PATH/line_buff1.cpp
add_files $C_PRJ_PATH/line_buff2.cpp
add_files $C_PRJ_PATH/line_buff3.cpp
add_files $C_PRJ_PATH/line_buff3_dir.cpp
add_files $C_PRJ_PATH/line_buff3_magn.cpp
add_files $C_PRJ_PATH/lineDet.cpp
add_files $C_PRJ_PATH/lineDet.h
add_files $C_PRJ_PATH/nMS_Hys.cpp
# Add the test bench & files (*** TO BE SET BY THE USER ***)
add_files -tb $C_PRJ_PATH/tb.cpp
# Set the top-level function (*** TO BE SET BY THE USER ***)
set_top top_module


# ############################################################################################
# IP Solution
# ############################################################################################
# Create a solution
open_solution -reset solution1 -flow_target vivado
# Define the technology and clock rate (*** TO BE SET BY THE USER ***)
set_part  {xck26-sfvc784-2LV-c}
create_clock -period "350MHz"
config_compile -enable_auto_rewind=0

source "directives.tcl"

# ############################################################################################
# HLS Flow
# ############################################################################################
# C Simulation
csim_design
# Run Synthesis
csynth_design
# RTL Simulation
#cosim_design
# IP Exporting
export_design -format ip_catalog -display_name VPA_IP --ipname VPA_IP


exit


