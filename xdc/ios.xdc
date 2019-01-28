# Enable for switchers.
set_property PACKAGE_PIN E21 [get_ports {V_5V5P_SYNC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {V_5V5P_SYNC[0]}]
set_property PACKAGE_PIN D22 [get_ports {V_15VN_SYNC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {V_15VN_SYNC[0]}]
set_property PACKAGE_PIN E22 [get_ports {V_15VP_SYNC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {V_15VP_SYNC[0]}]
set_property PACKAGE_PIN D20 [get_ports {V_30VN_SYNC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {V_30VN_SYNC[0]}]
set_property PACKAGE_PIN C20 [get_ports {V_100VP_SYNC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {V_100VP_SYNC[0]}]

# Reset.
set_property PACKAGE_PIN U20 [get_ports CPU_RESET]
set_property IOSTANDARD LVCMOS33 [get_ports CPU_RESET]

# Clock.
set_property PACKAGE_PIN Y18 [get_ports USER_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports USER_CLK]

# Flash.
set_property PACKAGE_PIN T19 [get_ports FLASH_CS]
set_property IOSTANDARD LVCMOS33 [get_ports FLASH_CS]

set_property PACKAGE_PIN P22 [get_ports FLASH_D0]
set_property PACKAGE_PIN R22 [get_ports FLASH_D1]
set_property PACKAGE_PIN P21 [get_ports FLASH_D2]
set_property PACKAGE_PIN R21 [get_ports FLASH_D3]
set_property IOSTANDARD LVCMOS33 [get_ports FLASH_D0]
set_property IOSTANDARD LVCMOS33 [get_ports FLASH_D1]
set_property IOSTANDARD LVCMOS33 [get_ports FLASH_D2]
set_property IOSTANDARD LVCMOS33 [get_ports FLASH_D3]

# USB Uart.
set_property PACKAGE_PIN R19 [get_ports USB_UART_RX]
set_property IOSTANDARD LVCMOS33 [get_ports USB_UART_RX]
set_property PACKAGE_PIN P19 [get_ports USB_UART_TX]
set_property IOSTANDARD LVCMOS33 [get_ports USB_UART_TX]
