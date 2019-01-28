
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a200tfbg484-2
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_quad_spi:3.2\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:10.0\
fnal.gov:user:my_iobuf:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CPU_RESET [ create_bd_port -dir I -type rst CPU_RESET ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $CPU_RESET
  set FLASH_CS [ create_bd_port -dir O -from 0 -to 0 FLASH_CS ]
  set FLASH_D0 [ create_bd_port -dir IO FLASH_D0 ]
  set FLASH_D1 [ create_bd_port -dir IO FLASH_D1 ]
  set FLASH_D2 [ create_bd_port -dir IO FLASH_D2 ]
  set FLASH_D3 [ create_bd_port -dir IO FLASH_D3 ]
  set USB_UART_RX [ create_bd_port -dir O USB_UART_RX ]
  set USB_UART_TX [ create_bd_port -dir I USB_UART_TX ]
  set USER_CLK [ create_bd_port -dir I -type clk USER_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
 ] $USER_CLK
  set V_100VP_SYNC [ create_bd_port -dir O -from 0 -to 0 V_100VP_SYNC ]
  set V_15VN_SYNC [ create_bd_port -dir O -from 0 -to 0 V_15VN_SYNC ]
  set V_15VP_SYNC [ create_bd_port -dir O -from 0 -to 0 V_15VP_SYNC ]
  set V_30VN_SYNC [ create_bd_port -dir O -from 0 -to 0 V_30VN_SYNC ]
  set V_5V5P_SYNC [ create_bd_port -dir O -from 0 -to 0 V_5V5P_SYNC ]

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
   CONFIG.C_SCK_RATIO {2} \
   CONFIG.C_SPI_MEMORY {2} \
   CONFIG.C_SPI_MODE {2} \
   CONFIG.C_TYPE_OF_AXI4_INTERFACE {1} \
   CONFIG.C_USE_STARTUP {1} \
   CONFIG.C_USE_STARTUP_INT {1} \
 ] $axi_quad_spi_0

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT2_JITTER {209.588} \
   CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {10} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.MMCM_CLKIN1_PERIOD {10.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {100} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_SOURCE {Global_buffer} \
 ] $clk_wiz_0

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:10.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_ICACHE_BASEADDR {0x0000000000000000} \
   CONFIG.C_ICACHE_HIGHADDR {0x000000003FFFFFFF} \
   CONFIG.C_I_LMB {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.SYNCHRONIZATION_STAGES {2} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: my_iobuf_0, and set properties
  set my_iobuf_0 [ create_bd_cell -type ip -vlnv fnal.gov:user:my_iobuf:1.0 my_iobuf_0 ]

  # Create instance: my_iobuf_1, and set properties
  set my_iobuf_1 [ create_bd_cell -type ip -vlnv fnal.gov:user:my_iobuf:1.0 my_iobuf_1 ]

  # Create instance: my_iobuf_2, and set properties
  set my_iobuf_2 [ create_bd_cell -type ip -vlnv fnal.gov:user:my_iobuf:1.0 my_iobuf_2 ]

  # Create instance: my_iobuf_3, and set properties
  set my_iobuf_3 [ create_bd_cell -type ip -vlnv fnal.gov:user:my_iobuf:1.0 my_iobuf_3 ]

  # Create instance: rst_clk_wiz_1_100M, and set properties
  set rst_clk_wiz_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_1_100M ]

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {BUFG} \
 ] $util_ds_buf_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins axi_quad_spi_0/AXI_FULL] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]

  # Create port connections
  connect_bd_net -net Net [get_bd_ports FLASH_D0] [get_bd_pins my_iobuf_0/IO]
  connect_bd_net -net Net1 [get_bd_ports FLASH_D1] [get_bd_pins my_iobuf_1/IO]
  connect_bd_net -net Net2 [get_bd_ports FLASH_D3] [get_bd_pins my_iobuf_3/IO]
  connect_bd_net -net Net3 [get_bd_ports FLASH_D2] [get_bd_pins my_iobuf_2/IO]
  connect_bd_net -net SPARE_SW4_1 [get_bd_ports CPU_RESET] [get_bd_pins clk_wiz_0/reset] [get_bd_pins rst_clk_wiz_1_100M/ext_reset_in]
  connect_bd_net -net USB_UART_TX_1 [get_bd_ports USB_UART_TX] [get_bd_pins axi_uartlite_0/rx]
  connect_bd_net -net USER_CLK_1 [get_bd_ports USER_CLK] [get_bd_pins util_ds_buf_0/BUFG_I]
  connect_bd_net -net axi_quad_spi_0_io0_o [get_bd_pins axi_quad_spi_0/io0_o] [get_bd_pins my_iobuf_0/I]
  connect_bd_net -net axi_quad_spi_0_io0_t [get_bd_pins axi_quad_spi_0/io0_t] [get_bd_pins my_iobuf_0/T]
  connect_bd_net -net axi_quad_spi_0_io1_o [get_bd_pins axi_quad_spi_0/io1_o] [get_bd_pins my_iobuf_1/I]
  connect_bd_net -net axi_quad_spi_0_io1_t [get_bd_pins axi_quad_spi_0/io1_t] [get_bd_pins my_iobuf_1/T]
  connect_bd_net -net axi_quad_spi_0_io2_o [get_bd_pins axi_quad_spi_0/io2_o] [get_bd_pins my_iobuf_2/I]
  connect_bd_net -net axi_quad_spi_0_io2_t [get_bd_pins axi_quad_spi_0/io2_t] [get_bd_pins my_iobuf_2/T]
  connect_bd_net -net axi_quad_spi_0_io3_o [get_bd_pins axi_quad_spi_0/io3_o] [get_bd_pins my_iobuf_3/I]
  connect_bd_net -net axi_quad_spi_0_io3_t [get_bd_pins axi_quad_spi_0/io3_t] [get_bd_pins my_iobuf_3/T]
  connect_bd_net -net axi_quad_spi_0_ss_o [get_bd_ports FLASH_CS] [get_bd_pins axi_quad_spi_0/ss_o]
  connect_bd_net -net axi_uartlite_0_tx [get_bd_ports USB_UART_RX] [get_bd_pins axi_uartlite_0/tx]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_1_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_quad_spi_0/s_axi4_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_1_100M/slowest_sync_clk]
  connect_bd_net -net my_iobuf_0_O [get_bd_pins axi_quad_spi_0/io0_i] [get_bd_pins my_iobuf_0/O]
  connect_bd_net -net my_iobuf_1_O [get_bd_pins axi_quad_spi_0/io1_i] [get_bd_pins my_iobuf_1/O]
  connect_bd_net -net my_iobuf_2_O [get_bd_pins axi_quad_spi_0/io2_i] [get_bd_pins my_iobuf_2/O]
  connect_bd_net -net my_iobuf_3_O [get_bd_pins axi_quad_spi_0/io3_i] [get_bd_pins my_iobuf_3/O]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_1_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_clk_wiz_1_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_clk_wiz_1_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins axi_quad_spi_0/s_axi4_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_clk_wiz_1_100M/peripheral_aresetn]
  connect_bd_net -net util_ds_buf_0_BUFG_O [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins util_ds_buf_0/BUFG_O]
  connect_bd_net -net xlconstant_0_dout [get_bd_ports V_100VP_SYNC] [get_bd_ports V_15VN_SYNC] [get_bd_ports V_15VP_SYNC] [get_bd_ports V_30VN_SYNC] [get_bd_ports V_5V5P_SYNC] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_quad_spi_0/aximm/MEM0] SEG_axi_quad_spi_0_MEM0
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   ExpandedHierarchyInLayout: "",
   guistr: "# # String gsaved with Nlview 6.8.5  2018-01-30 bk=1.4354 VDI=40 GEI=35 GUI=JA:1.6 non-TLS
#  -string -flagsOSRD
preplace port FLASH_D0 -pg 1 -y -40 -defaultsOSRD
preplace port USER_CLK -pg 1 -y 390 -defaultsOSRD
preplace port FLASH_D1 -pg 1 -y 80 -defaultsOSRD
preplace port FLASH_D2 -pg 1 -y 200 -defaultsOSRD
preplace port CPU_RESET -pg 1 -y 300 -defaultsOSRD
preplace port USB_UART_TX -pg 1 -y 500 -defaultsOSRD -right
preplace port FLASH_D3 -pg 1 -y 320 -defaultsOSRD
preplace port USB_UART_RX -pg 1 -y 520 -defaultsOSRD
preplace portBus V_5V5P_SYNC -pg 1 -y -330 -defaultsOSRD
preplace portBus V_30VN_SYNC -pg 1 -y -270 -defaultsOSRD
preplace portBus FLASH_CS -pg 1 -y 420 -defaultsOSRD
preplace portBus V_100VP_SYNC -pg 1 -y -250 -defaultsOSRD
preplace portBus V_15VN_SYNC -pg 1 -y -310 -defaultsOSRD
preplace portBus V_15VP_SYNC -pg 1 -y -290 -defaultsOSRD
preplace inst my_iobuf_0 -pg 1 -lvl 7 -y -50 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 7 -y -330 -defaultsOSRD
preplace inst my_iobuf_1 -pg 1 -lvl 7 -y 70 -defaultsOSRD
preplace inst my_iobuf_2 -pg 1 -lvl 7 -y 190 -defaultsOSRD
preplace inst my_iobuf_3 -pg 1 -lvl 7 -y 310 -defaultsOSRD
preplace inst microblaze_0_axi_periph -pg 1 -lvl 5 -y 380 -defaultsOSRD
preplace inst mdm_1 -pg 1 -lvl 3 -y 130 -defaultsOSRD
preplace inst microblaze_0 -pg 1 -lvl 4 -y 130 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 6 -y 510 -defaultsOSRD
preplace inst rst_clk_wiz_1_100M -pg 1 -lvl 3 -y 320 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 2 -y 380 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 5 -y 140 -defaultsOSRD
preplace inst util_ds_buf_0 -pg 1 -lvl 1 -y 390 -defaultsOSRD
preplace inst axi_quad_spi_0 -pg 1 -lvl 6 -y 230 -defaultsOSRD
preplace netloc axi_quad_spi_0_io1_t 1 6 1 2000
preplace netloc USER_CLK_1 1 0 1 NJ
preplace netloc my_iobuf_3_O 1 6 2 1970J 390 2220
preplace netloc axi_quad_spi_0_ss_o 1 6 2 1960J 420 NJ
preplace netloc microblaze_0_Clk 1 2 4 450 210 830 230 1360 230 1680
preplace netloc axi_quad_spi_0_io2_t 1 6 1 2030
preplace netloc USB_UART_TX_1 1 6 2 N 500 N
preplace netloc my_iobuf_1_O 1 6 2 2010J 380 2230
preplace netloc microblaze_0_ilmb_1 1 4 1 N
preplace netloc microblaze_0_axi_periph_M00_AXI 1 5 1 1670
preplace netloc microblaze_0_M_AXI_DP 1 4 1 1350
preplace netloc axi_quad_spi_0_io3_o 1 6 1 N
preplace netloc axi_uartlite_0_tx 1 6 2 NJ 520 NJ
preplace netloc axi_quad_spi_0_io0_o 1 6 1 1970
preplace netloc xlconstant_0_dout 1 7 1 2240
preplace netloc rst_clk_wiz_1_100M_interconnect_aresetn 1 3 2 N 340 NJ
preplace netloc rst_clk_wiz_1_100M_bus_struct_reset 1 3 2 NJ 300 1330
preplace netloc my_iobuf_2_O 1 6 2 1990J 400 2240
preplace netloc SPARE_SW4_1 1 0 3 N 300 260 300 NJ
preplace netloc microblaze_0_axi_periph_M01_AXI 1 5 1 1670
preplace netloc rst_clk_wiz_1_100M_peripheral_aresetn 1 3 3 NJ 360 1340 240 1660
preplace netloc rst_clk_wiz_1_100M_mb_reset 1 3 1 840
preplace netloc my_iobuf_0_O 1 6 2 1960 -120 2240
preplace netloc axi_quad_spi_0_io1_o 1 6 1 1990
preplace netloc clk_wiz_0_clk_out2 1 2 4 460 220 NJ 220 NJ 220 NJ
preplace netloc microblaze_0_dlmb_1 1 4 1 N
preplace netloc axi_quad_spi_0_io3_t 1 6 1 N
preplace netloc Net1 1 7 1 NJ
preplace netloc Net 1 7 1 NJ
preplace netloc microblaze_0_debug 1 3 1 N
preplace netloc util_ds_buf_0_BUFG_O 1 1 1 NJ
preplace netloc mdm_1_debug_sys_rst 1 2 2 470 200 820
preplace netloc axi_quad_spi_0_io2_o 1 6 1 2020
preplace netloc axi_quad_spi_0_io0_t 1 6 1 1980
preplace netloc Net2 1 7 1 NJ
preplace netloc Net3 1 7 1 NJ
levelinfo -pg 1 0 140 360 650 1090 1510 1820 2140 2280 -top -390 -bot 670
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


