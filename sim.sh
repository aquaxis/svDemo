#!/bin/bash

source /opt/Xilinx/Vivado/2017.2/settings64.sh

cd Zynq7000/Zynq7000.sim/sim_1/behav/

xvlog -m64 --relax -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L xil_common_vip_v1_0_0 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xil_defaultlib -prj tb_Zynq7000_vlog.prj
xvhdl -m64 --relax -prj tb_Zynq7000_vhdl.prj
xelab -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L xlconcat_v2_1_1 -L unisims_ver -L unimacro_ver -L secureip -L xpm  xil_defaultlib.tb_Zynq7000 -dpiheader dpi.h
cp ../../../../function.c .
xsc function.c
xelab -sv_lib dpi -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L xlconcat_v2_1_1 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_Zynq7000 xil_defaultlib.tb_Zynq7000 xil_defaultlib.glbl -R

exit

xvlog -m64 --relax -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L xil_common_vip_v1_0_0 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xil_defaultlib -prj vlog.prj
xvhdl -m64 --relax -prj vhdl.prj
xelab -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L xlconcat_v2_1_1 -L unisims_ver -L unimacro_ver -L secureip -L xpm  xil_defaultlib.tb_Zynq7000 -dpiheader dpi.h
cp ../../function.c .
xsc function.c
xelab -sv_lib dpi -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L xlconcat_v2_1_1 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_Zynq7000 xil_defaultlib.tb_Zynq7000 xil_defaultlib.glbl -R
