vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/blk_mem_gen_v8_4_2

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap blk_mem_gen_v8_4_2 questa_lib/msim/blk_mem_gen_v8_4_2

vlog -work xil_defaultlib -64 -sv \
"G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../ipstatic/hdl/csi2_parser.vhd" \
"../../../ipstatic/hdl/lane_align.vhd" \
"../../../ipstatic/hdl/lane_merge.vhd" \
"../../../ipstatic/hdl/csi_to_axis_v1_0.vhd" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/src/csi_to_axis_0/sim/csi_to_axis_0.vhd" \
"../../../ipstatic/hdl/phy_clock_system.vhd" \
"../../../ipstatic/hdl/line_if.vhd" \
"../../../ipstatic/hdl/csi2_d_phy_rx.vhd" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/src/csi2_d_phy_rx_0/sim/csi2_d_phy_rx_0.vhd" \

vlog -work blk_mem_gen_v8_4_2 -64 \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/src/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/src/blk_mem_gen_1/sim/blk_mem_gen_1.v" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/sim/Driver_Bayer_To_RGB.v" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/sim/Driver_Csi_To_Dvp.v" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/sim/Driver_MIPI.v" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_MIPI_0/sim/Driver_MIPI_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

