# 50 MHz clock
set_property PACKAGE_PIN B6 [get_ports clk_50mhz]
create_clock -name clk_50mhz -period 20.000 [get_ports clk_50mhz]

# Active-high reset: DIP switch 1
set_property PACKAGE_PIN Y1 [get_ports rst_p]

# Piano keys: button 1 ~ 8
set_property PACKAGE_PIN K4 [get_ports {key[7]}]
set_property PACKAGE_PIN N8 [get_ports {key[6]}]
set_property PACKAGE_PIN N4 [get_ports {key[5]}]
set_property PACKAGE_PIN N1 [get_ports {key[4]}]
set_property PACKAGE_PIN P6 [get_ports {key[3]}]
set_property PACKAGE_PIN N6 [get_ports {key[2]}]
set_property PACKAGE_PIN L5 [get_ports {key[1]}]
set_property PACKAGE_PIN J2 [get_ports {key[0]}]

# Piezo output
set_property PACKAGE_PIN Y21 [get_ports piezo]

# I/O voltage standard
set_property IOSTANDARD LVCMOS33 [get_ports *]