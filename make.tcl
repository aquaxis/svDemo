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
