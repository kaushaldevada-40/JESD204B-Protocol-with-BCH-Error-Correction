
set_property PACKAGE_PIN E3 [get_ports clk]
# Example: set_property IOSTANDARD LVDS_25 [get_ports [list data_p* data_n*]]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Set max delay (latest arrival)
set_input_delay -clock clk -max -add_delay 0.300 [get_ports rst]

# Set min delay (earliest arrival)
set_input_delay -clock clk -min -add_delay 0.100 [get_ports rst]

set_property PACKAGE_PIN C12 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


set_property PACKAGE_PIN V10 [get_ports sysref]
set_property IOSTANDARD LVCMOS33 [get_ports sysref]


set_property PACKAGE_PIN J15 [get_ports {data_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[0]}]


set_property PACKAGE_PIN L16 [get_ports {data_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[1]}]


set_property PACKAGE_PIN M13 [get_ports {data_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[2]}]


set_property PACKAGE_PIN R15 [get_ports {data_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[3]}]


set_property PACKAGE_PIN R17 [get_ports {data_in[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[4]}]


set_property PACKAGE_PIN T18 [get_ports {data_in[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[5]}]


set_property PACKAGE_PIN U18 [get_ports {data_in[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[6]}]


set_property PACKAGE_PIN R13 [get_ports {data_in[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[7]}]


set_property PACKAGE_PIN T8 [get_ports {data_in[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[8]}]


set_property PACKAGE_PIN U8 [get_ports {data_in[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[9]}]


set_property PACKAGE_PIN R16 [get_ports {data_in[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[10]}]


set_property PACKAGE_PIN T13 [get_ports {data_in[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[11]}]


set_property PACKAGE_PIN H6 [get_ports {data_in[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[12]}]


set_property PACKAGE_PIN U12 [get_ports {data_in[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[13]}]


set_property PACKAGE_PIN H17 [get_ports {data_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[0]}]


set_property PACKAGE_PIN K15 [get_ports {data_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[1]}]


set_property PACKAGE_PIN J13 [get_ports {data_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[2]}]


set_property PACKAGE_PIN N14 [get_ports {data_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[3]}]


set_property PACKAGE_PIN R18 [get_ports {data_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[4]}]


set_property PACKAGE_PIN V17 [get_ports {data_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[5]}]


set_property PACKAGE_PIN U17 [get_ports {data_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[6]}]


set_property PACKAGE_PIN U16 [get_ports {data_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[7]}]


set_property PACKAGE_PIN V16 [get_ports {data_out[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[8]}]


set_property PACKAGE_PIN T15 [get_ports {data_out[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[9]}]


set_property PACKAGE_PIN U14 [get_ports {data_out[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[10]}]


set_property PACKAGE_PIN T16 [get_ports {data_out[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[11]}]


set_property PACKAGE_PIN V15 [get_ports {data_out[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[12]}]


set_property PACKAGE_PIN V14 [get_ports {data_out[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out[13]}]





set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]


