`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 14:35:10
// Design Name: 
// Module Name: D_R
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module D_R(
input clk_100MHz, 
    input Clk_Rx_Data_N, 
    input Clk_Rx_Data_P, 
    input [1:0]Rx_Data_N, 
    input [1:0]Rx_Data_P, 
    input Data_N, 
    input Data_P, 
    input [1:0]Key, 
    inout Camera_IIC_SDA, 
    output Camera_IIC_SCL, 
    output Camera_GPIO, 
    output TMDS_Tx_Clk_N, 
    output TMDS_Tx_Clk_P, 
    output [2:0]TMDS_Tx_Data_N, 
    output [2:0]TMDS_Tx_Data_P 
    ); 
    //ʱ�� 
    wire clk_100MHz_system; 
    wire clk_200MHz; 
    wire clk_50MHz; 
    wire clk_10MHz; 
    wire clk_100MHz_out; 
    wire clk_Serial_out; 
    //MIPI ����ͷ OV5647 
    wire [23:0]RGB_Data_Src; 
    wire RGB_HSync_Src; 
    wire RGB_VSync_Src; 
    wire RGB_VDE_Src; 
    //IIC ���� 
    wire IIC_Rst; 
    wire [7:0]Address;         //IIC ͨѶ�ӻ��豸��ַ 
    wire [7:0]Data;            //IIC д���� 
    wire [15:0]Reg_Addr;       //�Ĵ�����ַ 
    wire [7:0]IIC_Read_Data; 
    wire IIC_Busy;      
    wire Reg2Addr; 
    wire IIC_Write; 
    reg IIC_Read=0; 
    wire Camera_IIC_SDA_I; 
    wire Camera_IIC_SDA_O; 
    wire Camera_IIC_SDA_T; 
    //HDMI 
    wire [23:0]RGB_In; 
    wire [11:0]Set_X; 
    wire [11:0]Set_Y; 
    wire [23:0]RGB_Data; 
    wire RGB_HSync; 
    wire RGB_VSync; 
    wire RGB_VDE; 
    wire clk_system; 
    clk_wiz_0 
clk_10(.clk_out1(clk_100MHz_system),.clk_out2(clk_200MHz),.clk_out3(clk_50MHz),.clk_out4(clk_10MHz),.clk_in1
(clk_100MHz)); 
    //��̬�� 
    IOBUF Camera_IIC_SDA_IOBUF 
           (.I(Camera_IIC_SDA_O), 
            .IO(Camera_IIC_SDA), 
            .O(Camera_IIC_SDA_I), 
            .T(~Camera_IIC_SDA_T)); 
    //����ͷ���� 
    Driver_MIPI_0 Driver_MIPI0( 
        .clk_200MHz(clk_200MHz), 
        .Clk_Rx_Data_N(Clk_Rx_Data_N), 
        .Clk_Rx_Data_P(Clk_Rx_Data_P), 
        .Rx_Data_N(Rx_Data_N), 
        .Rx_Data_P(Rx_Data_P), 
        .Data_N(Data_N), 
        .Data_P(Data_P), 
        .Camera_GPIO(Camera_GPIO), 
        .RGB_Data(RGB_Data_Src), 
        .RGB_HSync(RGB_HSync_Src), 
        .RGB_VSync(RGB_VSync_Src), 
        .RGB_VDE(RGB_VDE_Src), 
        .clk_100MHz_out(clk_100MHz_out)
          ); 
    //ͼ���� 
    Image_Process Image_Process_Edge( 
        .clk_Image_Process(clk_100MHz_out), 
        .Rst(1), 
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_HSync_Src(RGB_HSync_Src), 
        .RGB_VSync_Src(RGB_VSync_Src), 
        .RGB_VDE_Src(RGB_VDE_Src), 
        .RGB_Data(RGB_Data), 
        .RGB_HSync(RGB_HSync), 
        .RGB_VSync(RGB_VSync), 
        .RGB_VDE(RGB_VDE) 
        ); 
    //RGBToDvi ʵ���� 
    rgb2dvi_0 rgb2dvi( 
        .TMDS_Clk_p(TMDS_Tx_Clk_P), 
        .TMDS_Clk_n(TMDS_Tx_Clk_N), 
        .TMDS_Data_p(TMDS_Tx_Data_P), 
        .TMDS_Data_n(TMDS_Tx_Data_N), 
        .aRst_n(1), 
        .vid_pData(RGB_Data), 
        .vid_pVDE(RGB_VDE), 
        .vid_pHSync(RGB_HSync), 
        .vid_pVSync(RGB_VSync), 
        .PixelClk(clk_100MHz_out) 
        ); 
    //IIC ���� 
    Driver_IIC_0 Driver_IIC0( 
        .clk(clk_100MHz_system), 
        .Rst(IIC_Rst), 
        // �������ͨ���ź� 
        .Addr(Address), 
        .Reg_Addr(Reg_Addr), 
        .Data(Data), 
        .IIC_Write(IIC_Write), 
        .IIC_Read(IIC_Read), 
        .IIC_Read_Data(IIC_Read_Data), 
        .IIC_Busy(IIC_Busy), 
        .Reg_2Addr(Reg2Addr), 
        // �ⲿ�ź� 
        .IIC_SCL(Camera_IIC_SCL), 
        .IIC_SDA_In(Camera_IIC_SDA_I), 
        .SDA_Dir(Camera_IIC_SDA_T),// �������ݷ���,�ߵ�ƽΪ������� 
          .SDA_Out(Camera_IIC_SDA_O)// ������� 
    ); 
    //OV5647 ����ͷ��ʼ�� 
    OV5647_Init_0 Diver_OV5647_Init( 
        .clk_10MHz(clk_10MHz), 
        .IIC_Busy(IIC_Busy), 
        .Addr(Address), 
        .Reg_Addr(Reg_Addr), 
        .Reg_Data(Data), 
        .IIC_Write(IIC_Write), 
        .Reg2Addr(Reg2Addr), 
        .Ctrl_IIC(IIC_Rst) 
        ); 
endmodule