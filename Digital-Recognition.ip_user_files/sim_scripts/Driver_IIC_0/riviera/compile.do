vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_IIC_0/sim/Driver_IIC.v" \
"../../../../Digital-Recognition.srcs/sources_1/ip/Driver_IIC_0/sim/Driver_IIC_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

