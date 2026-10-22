#*****************************************************************************************
# Vivado (TM) v2024.2 (64-bit)
# Script Tcl corretto per portabilità totale e supporto PYNQ-Z1
#*****************************************************************************************

# Definisce la directory dello script come origine principale
set origin_dir [file normalize [file dirname [info script]]]

# Configura i percorsi dei Board Files (cerca nella home utente e nella cartella d'installazione globale)
set board_paths [list]

if { [info exists ::env(HOME)] } {
    lappend board_paths [file normalize "$::env(HOME)/.Xilinx/Vivado/2024.2/xhub/board_store/xilinx_board_store/XilinxBoardStore/Vivado/2024.2/boards"]
}
if { [info exists ::env(USERPROFILE)] } {
    lappend board_paths [file normalize "$::env(USERPROFILE)/AppData/Roaming/Xilinx/Vivado/2024.2/xhub/board_store/xilinx_board_store/XilinxBoardStore/Vivado/2024.2/boards"]
}

# Aggiunge la cartella locale globale /tools/Xilinx/...
lappend board_paths "/tools/Xilinx/Vivado/2024.2/data/boards/board_files"

set_param board.repoPaths $board_paths

# Imposta il nome del progetto
set _xil_proj_name_ "line_detector"

# Crea il progetto nella cartella corrente (sovrascrive se già esistente)
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7z020clg400-1 -force

set proj_dir [get_property directory [current_project]]

# Imposta la PYNQ-Z1
set obj [current_project]
set_property -name "board_part" -value "www.digilentinc.com:pynq-z1:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "target_simulator" -value "XSim" -objects $obj

# Crea il fileset delle sorgenti principale
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Aggiunge l'IP Custom usando il percorso relativo (cartella ip_repo)
set obj [get_filesets sources_1]
if { $obj != {} } {
   set ip_custom_path [file normalize "$origin_dir/ip_repo"]
   if { [file isdirectory $ip_custom_path] } {
      set_property "ip_repo_paths" $ip_custom_path $obj
      update_ip_catalog -rebuild
   } else {
      puts "WARNING: Custom IP repository not found at $ip_custom_path. Ensure it is placed inside an 'ip_repo' folder."
   }
}

set_property -name "top" -value "line_detector_bd_wrapper" -objects [get_filesets sources_1]

# Inizializza i vincoli
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Inizializza la simulazione e importa i file locali relativi
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

set sim_src_dir [file normalize "$origin_dir/simulation_sources"]
set files [list \
  "$sim_src_dir/zynq_tb.v" \
  "$sim_src_dir/tb_behav.wcfg" \
  "$sim_src_dir/input.txt" \
  "$sim_src_dir/input32.txt" \
]

set missing_sim_files 0
foreach f $files {
  if { ![file exists $f] } {
    puts "WARNING: Simulation source file missing at: $f"
    set missing_sim_files 1
  }
}

if { !$missing_sim_files } {
  import_files -fileset sim_1 $files
  set_property -name "top" -value "tb" -objects [get_filesets sim_1]
  set_property -name "top_auto_set" -value "0" -objects [get_filesets sim_1]
  set_property -name "xsim.simulate.runtime" -value "500us" -objects [get_filesets sim_1]
}

# Inizializza utils_1
if {[string equal [get_filesets -quiet utils_1] ""]} {
  create_fileset -utilsutils_1 utils_1
}

# Proc per creare il Block Design
proc cr_bd_line_detector_bd { parentCell } {
  set design_name line_detector_bd
  create_bd_design $design_name

  # Verifica la presenza degli IP necessari nel catalogo
  set list_check_ips " \
    xilinx.com:ip:axi_dma:7.1 \
    xilinx.com:ip:proc_sys_reset:5.0 \
    xilinx.com:ip:smartconnect:1.0 \
    xilinx.com:hls:VPA_IP:1.0 \
    xilinx.com:ip:processing_system7:5.5 \
  "
  foreach ip_vlnv $list_check_ips {
     if { [get_ipdefs -all $ip_vlnv] eq "" } {
        puts "ERROR: IP $ip_vlnv missing from catalog! Ensure your custom IP is inside the 'ip_repo' folder."
        return 3
     }
  }

  if { $parentCell eq "" } { set parentCell [get_bd_cells /] }
  set parentObj [get_bd_cells $parentCell]

  # Crea interfacce esterne della board
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Crea istanze IP e imposta configurazioni
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [list CONFIG.c_addr_width {64} CONFIG.c_include_s2mm {0} CONFIG.c_include_sg {0} CONFIG.c_mm2s_burst_size {16} CONFIG.c_sg_length_width {14}] $axi_dma_0

  set axi_dma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_1 ]
  set_property -dict [list CONFIG.c_addr_width {64} CONFIG.c_include_mm2s {0} CONFIG.c_include_sg {0}] $axi_dma_1

  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [list CONFIG.NUM_MI {2} CONFIG.NUM_SI {2}] $axi_interconnect_0

  set rst_ps8_0_229M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_229M ]
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set VPA_IP_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:VPA_IP:1.0 VPA_IP_0 ]

  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} CONFIG.PCW_USE_M_AXI_GP1 {1} CONFIG.PCW_USE_S_AXI_HP0 {1}] $processing_system7_0

  # Connessioni dei Bus e delle interfacce AXI Stream / Memory Mapped
  connect_bd_intf_net -intf_net VPA_IP_0_current_pos [get_bd_intf_pins VPA_IP_0/current_pos] [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins VPA_IP_0/im_axis_in]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_S2MM [get_bd_intf_pins axi_dma_1/M_AXI_S2MM] [get_bd_intf_pins smartconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_dma_0/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_dma_1/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP1 [get_bd_intf_pins processing_system7_0/M_AXI_GP1] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]

  # Segnali di Clock e Reset globali della rete
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins processing_system7_0/FCLK_CLK0] \
    [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_1/s_axi_lite_aclk] \
    [get_bd_pins axi_dma_1/m_axi_s2mm_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] \
    [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] \
    [get_bd_pins rst_ps8_0_229M/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins VPA_IP_0/ap_clk] \
    [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/M_AXI_GP1_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK]
    
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps8_0_229M/ext_reset_in]
  connect_bd_net -net rst_ps8_0_229M_peripheral_aresetn [get_bd_pins rst_ps8_0_229M/peripheral_aresetn] \
    [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_dma_1/axi_resetn] [get_bd_pins axi_interconnect_0/ARESETN] \
    [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] \
    [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins VPA_IP_0/ap_rst_n]

  # Indirizzamento dei segmenti di memoria AXI
  assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg] -force

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}

# Costruisce l'hardware grafico (Block Design)
cr_bd_line_detector_bd ""

# Crea automaticamente il Wrapper HDL del progetto in VHDL/Verilog
set wrapper_path [make_wrapper -fileset sources_1 -files [get_files line_detector_bd.bd] -top]
add_files -norecurse -fileset sources_1 $wrapper_path

# Configura i Run di Sintesi ed Implementazione con le impostazioni originali
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7z020clg400-1 -flow {Vivado Synthesis 2024} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
}
current_run -synthesis [get_runs synth_1]

if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7z020clg400-1 -flow {Vivado Implementation 2024} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
}
set_property -name "steps.phys_opt_design.args.more options" -value {-hold_fix} -objects [get_runs impl_1]
set_property -name "steps.write_bitstream.args.bin_file" -value "1" -objects [get_runs impl_1]
current_run -implementation [get_runs impl_1]

puts "INFO: Progetto 'line_detector' rigenerato con successo!"
