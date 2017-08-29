# プロジェクトの生成
create_project Zynq7000 ./Zynq7000 -part xc7z010clg400-1
cd Zynq7000

# ブロックデザインの生成
source ../Zynq7000.tcl
make_wrapper -files [get_files ./Zynq7000.srcs/sources_1/bd/Zynq7000/Zynq7000.bd] -top
add_files -norecurse ./Zynq7000.srcs/sources_1/bd/Zynq7000/hdl/Zynq7000_wrapper.v
add_files -fileset constrs_1 ../Zynq7000.xdc

# シミュレーションファイルの読込み
add_files -fileset sim_1 -norecurse -scan_for_includes ../tb_Zynq7000.sv
set_property top tb_Zynq7000 [get_filesets sim_1]

# シミュレーション環境の生成
generate_target Simulation [get_files ./Zynq7000.srcs/sources_1/bd/Zynq7000/Zynq7000.bd]
export_ip_user_files -of_objects [get_files ./Zynq7000.srcs/sources_1/bd/Zynq7000/Zynq7000.bd] -no_script -force -quiet
export_simulation  -export_source_files -force -directory "../exportsim" -simulator xsim  -ip_user_files_dir "./Zynq7000.ip_user_files" -ipstatic_source_dir "./Zynq7000.ip_user_files/ipstatic" -use_ip_compiled_libs
launch_simulation

exit

export_simulation  -directory "/home/hidemi/SystemVerilog/exportsim" -simulator xsim  -ip_user_files_dir "/home/hidemi/SystemVerilog/Zynq7000/Zynq7000.ip_user_files" -ipstatic_source_dir "/home/hidemi/SystemVerilog/Zynq7000/Zynq7000.ip_user_files/ipstatic" -use_ip_compiled_libs

# シミュレーションの実行
#source tb_Zynq7000.tcl
#run all
#close_sim

cd Zynq7000/Zynq7000.sim/sim_1/behav/
xvlog -m64 --relax -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L xil_common_vip_v1_0_0 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xil_defaultlib -prj tb_Zynq7000_vlog.prj
xvhdl -m64 --relax -prj tb_Zynq7000_vhdl.prj

xelab -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L unisims_ver -L unimacro_ver -L secureip -L xpm  xil_defaultlib.tb_Zynq7000 -dpiheader dpi.h

#xelab xil_defaultlib.tb_Zynq7000 -dpiheader dpi.h

cp ../../../../function.c .
xsc function.c
#xelab TOP -sv_lib dpi -R

xelab -sv_lib dpi -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_Zynq7000 xil_defaultlib.tb_Zynq7000 xil_defaultlib.glbl -R

#
xvlog -m64 --relax -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L xil_common_vip_v1_0_0 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xil_defaultlib -prj tb_Zynq7000_vlog.prj
xvhdl -m64 --relax -prj tb_Zynq7000_vhdl.prj

xelab -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L unisims_ver -L unimacro_ver -L secureip -L xpm  xil_defaultlib.tb_Zynq7000 -dpiheader dpi.h
cp ../../../../function.c .
xsc function.c
xelab -sv_lib dpi -L axi_lite_ipif_v3_0_4 -L lib_cdc_v1_0_2 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L xil_defaultlib -L proc_sys_reset_v5_0_11 -L axi_infrastructure_v1_1_0 -L xil_common_vip_v1_0_0 -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_14 -L axi_vip_v1_0_2 -L axi_vip_v1_0_1 -L xlconstant_v1_1_3 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_Zynq7000 xil_defaultlib.tb_Zynq7000 xil_defaultlib.glbl -R
