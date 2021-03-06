// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Aug  1 15:33:42 2020
// Host        : DESKTOP-AL60MTO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               g:/X/Digital-Recognition/Digital-Recognition.srcs/sources_1/ip/Driver_IIC_0/Driver_IIC_0_stub.v
// Design      : Driver_IIC_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s15ftgb196-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Driver_IIC,Vivado 2018.3" *)
module Driver_IIC_0(clk, Rst, Addr, Reg_Addr, Data, IIC_Write, IIC_Read, 
  IIC_Read_Data, IIC_Busy, Reg_2Addr, IIC_SCL, IIC_SDA_In, SDA_Dir, SDA_Out)
/* synthesis syn_black_box black_box_pad_pin="clk,Rst,Addr[7:0],Reg_Addr[15:0],Data[7:0],IIC_Write,IIC_Read,IIC_Read_Data[7:0],IIC_Busy,Reg_2Addr,IIC_SCL,IIC_SDA_In,SDA_Dir,SDA_Out" */;
  input clk;
  input Rst;
  input [7:0]Addr;
  input [15:0]Reg_Addr;
  input [7:0]Data;
  input IIC_Write;
  input IIC_Read;
  output [7:0]IIC_Read_Data;
  output IIC_Busy;
  input Reg_2Addr;
  output IIC_SCL;
  input IIC_SDA_In;
  output SDA_Dir;
  output SDA_Out;
endmodule
