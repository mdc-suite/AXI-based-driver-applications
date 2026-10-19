#*****************************************************************************************
# Vivado (TM) v2024.2 (64-bit)
# File Tcl corretto per portabilità totale (Zero percorsi assoluti)
#*****************************************************************************************

# Definisce la directory dello script come origine principale
set origin_dir [file normalize [file dirname [info script]]]

# Configura automaticamente i Board Files dallo store dell'utente corrente
# --- WITH THIS ---
if { [info exists ::env(USERPROFILE)] } {
    # Windows path
    set local_board_store [file normalize "$::env(USERPROFILE)/AppData/Roaming/Xilinx/Vivado/2024.2/xhub/board_store/xilinx_board_store/XilinxBoardStore/Vivado/2024.2/boards"]
} elseif { [info exists ::env(HOME)] } {
    # Linux path
    set local_board_store [file normalize "$::env(HOME)/.Xilinx/Vivado/2024.2/xhub/board_store/xilinx_board_store/XilinxBoardStore/Vivado/2024.2/boards"]
}

if { [info exists local_board_store] && [file isdirectory $local_board_store] } {
    set_param board.repoPaths [list $local_board_store]
}

# Imposta il nome del progetto
set _xil_proj_name_ "project_1"

# Crea il progetto nella cartella corrente
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7z020clg400-1 -force

# Imposta la Zedboard
set obj [current_project]
set_property -name "board_part" -value "digilentinc.com:pynq-z1:part0:1.0" -objects $obj

# Configura le impostazioni di base
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "Verilog" -objects $obj

# Crea il fileset delle sorgenti
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Aggiunge l'IP Repository usando il percorso RELATIVO alla cartella dello script
set obj [get_filesets sources_1]
if { $obj != {} } {
   set ip_custom_path [file normalize "$origin_dir/aes256_ip"]
   if { [file isdirectory $ip_custom_path] } {
      set_property "ip_repo_paths" $ip_custom_path $obj
      update_ip_catalog -rebuild
   } else {
      puts "WARNING: Custom IP repository not found at $ip_custom_path"
   }
}

# Inizializza i vincoli
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Inizializza la simulazione
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}
set_property "top" "design_1_wrapper" [get_filesets sim_1]

# Procedura guidata per ricreare il Block Design da zero
proc cr_bd_design_1 { parentCell } {
  set design_name design_1
  create_bd_design $design_name

  # Verifica la presenza degli IP necessari nel catalogo
  set list_check_ips " \
    xilinx.com:user:aes256_accelerator_1t:1.0 \
    xilinx.com:ip:axi_dma:7.1 \
    xilinx.com:ip:smartconnect:1.0 \
    xilinx.com:ip:proc_sys_reset:5.0 \
    xilinx.com:ip:processing_system7:5.5 \
  "
  foreach ip_vlnv $list_check_ips {
     if { [get_ipdefs -all $ip_vlnv] eq "" } {
        puts "ERROR: IP $ip_vlnv missing from catalog!"
        return 3
     }
  }

  if { $parentCell eq "" } { set parentCell [get_bd_cells /] }
  set parentObj [get_bd_cells $parentCell]

  # Struttura del Block Design (Porte e Istanze)
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  set aes256_accelerator_1t_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:aes256_accelerator_1t:1.0 aes256_accelerator_1t_0 ]
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [list CONFIG.c_addr_width {64} CONFIG.c_include_s2mm {0} CONFIG.c_include_sg {0}] $axi_dma_0

  set axi_dma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_1 ]
  set_property -dict [list CONFIG.c_addr_width {64} CONFIG.c_include_s2mm {0} CONFIG.c_include_sg {0}] $axi_dma_1

  set axi_dma_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_2 ]
  set_property -dict [list CONFIG.c_addr_width {64} CONFIG.c_include_mm2s {0} CONFIG.c_include_s2mm {1} CONFIG.c_include_sg {0}] $axi_dma_2

  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property CONFIG.NUM_SI {3} $axi_smc

  set ps8_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps8_0_axi_periph ]
  set_property -dict [list CONFIG.NUM_MI {3} CONFIG.NUM_SI {2}] $ps8_0_axi_periph

  set rst_ps8_0_99M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M ]
  
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [list \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} \
    CONFIG.PCW_USE_M_AXI_GP1 {1} \
    CONFIG.PCW_USE_S_AXI_HP0 {1} \
  ] $processing_system7_0

  # Connessioni Inferfaccia AXI e segnali di Clock/Reset
  connect_bd_intf_net -intf_net aes256_accelerator_1t_0_m00_axis [get_bd_intf_pins aes256_accelerator_1t_0/m00_axis] [get_bd_intf_pins axi_dma_2/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins aes256_accelerator_1t_0/s00_axis] [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S [get_bd_intf_pins aes256_accelerator_1t_0/s01_axis] [get_bd_intf_pins axi_dma_1/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_MM2S [get_bd_intf_pins axi_dma_1/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_2_M_AXI_S2MM [get_bd_intf_pins axi_dma_2/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S02_AXI]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins ps8_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP1 [get_bd_intf_pins processing_system7_0/M_AXI_GP1] [get_bd_intf_pins ps8_0_axi_periph/S01_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M00_AXI [get_bd_intf_pins axi_dma_0/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M01_AXI [get_bd_intf_pins axi_dma_1/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M02_AXI [get_bd_intf_pins axi_dma_2/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M02_AXI]

  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps8_0_99M/ext_reset_in]
  connect_bd_net -net rst_ps8_0_99M_peripheral_aresetn [get_bd_pins rst_ps8_0_99M/peripheral_aresetn] \
    [get_bd_pins aes256_accelerator_1t_0/s00_axis_aresetn] [get_bd_pins aes256_accelerator_1t_0/s01_axis_aresetn] [get_bd_pins aes256_accelerator_1t_0/m00_axis_aresetn] \
    [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_dma_1/axi_resetn] [get_bd_pins axi_dma_2/axi_resetn] \
    [get_bd_pins axi_smc/aresetn] [get_bd_pins ps8_0_axi_periph/ARESETN] [get_bd_pins ps8_0_axi_periph/S00_ARESETN] \
    [get_bd_pins ps8_0_axi_periph/M00_ARESETN] [get_bd_pins ps8_0_axi_periph/M01_ARESETN] [get_bd_pins ps8_0_axi_periph/S01_ARESETN] [get_bd_pins ps8_0_axi_periph/M02_ARESETN]

  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins processing_system7_0/FCLK_CLK0] \
    [get_bd_pins aes256_accelerator_1t_0/s00_axis_aclk] [get_bd_pins aes256_accelerator_1t_0/s01_axis_aclk] [get_bd_pins aes256_accelerator_1t_0/m00_axis_aclk] \
    [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_1/s_axi_lite_aclk] [get_bd_pins axi_dma_1/m_axi_mm2s_aclk] \
    [get_bd_pins axi_dma_2/s_axi_lite_aclk] [get_bd_pins axi_dma_2/m_axi_s2mm_aclk] [get_bd_pins axi_smc/aclk] \
    [get_bd_pins ps8_0_axi_periph/ACLK] [get_bd_pins ps8_0_axi_periph/S00_ACLK] [get_bd_pins ps8_0_axi_periph/M00_ACLK] \
    [get_bd_pins ps8_0_axi_periph/M01_ACLK] [get_bd_pins ps8_0_axi_periph/S01_ACLK] [get_bd_pins ps8_0_axi_periph/M02_ACLK] \
    [get_bd_pins rst_ps8_0_99M/slowest_sync_clk] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/M_AXI_GP1_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK]

  # Mappatura degli indirizzi di memoria
  assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_2/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -with_name SEG_axi_dma_0_Reg_1 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0100000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0300000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dma_2/S_AXI_LITE/Reg] -force

  validate_bd_design
  save_bd_design
  close_bd_design $design_name
}

# Chiama la creazione del Block Design
cr_bd_design_1 ""

# Genera il file Wrapper HDL per il Block Design (lo fa in automatico)
set wrapper_path [make_wrapper -fileset sources_1 -files [get_files design_1.bd] -top]
add_files -norecurse -fileset sources_1 $wrapper_path
set_property top design_1_wrapper [get_filesets sources_1]

# Crea ed imposta i Run di sintesi ed implementazione standard
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7z020clg484-1 -flow {Vivado Synthesis 2024} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
}
current_run -synthesis [get_runs synth_1]

if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7z020clg484-1 -flow {Vivado Implementation 2024} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
}
set_property steps.write_bitstream.args.bin_file 1 [get_runs impl_1]
current_run -implementation [get_runs impl_1]

puts "INFO: Progetto replicato con successo ed indipendente dal PC!"
