module Edge_Check( 
    input clk_Image_Process, 
    input Rst, 
    input RGB_DE, 
    input [7:0]Gray_Data, 
    input [7:0]Gray_Gate, 
    output [2:0]Delay_Num, 
    output [23:0]RGB_Data 
    ); 
    //边缘检测占用时钟 
    parameter Edge_Delay_Clk=2; 
    parameter Edge_Delay_Clk_De=3; 
    //移位寄存器中间数据 
    wire [7:0]D0; 
     wire [7:0]D1; 
    wire [7:0]D2; 
    wire [7:0]D3; 
    //定义边缘检测数据矩阵 3*3,每个 8 位,有 9*8=72 位 
    reg [71:0]Matrix_Edge_Check_Data=0; 
    wire [7:0]Matrix_00=Matrix_Edge_Check_Data[71:64]; 
    wire [7:0]Matrix_01=Matrix_Edge_Check_Data[63:56]; 
    wire [7:0]Matrix_02=Matrix_Edge_Check_Data[55:48]; 
    wire [7:0]Matrix_10=Matrix_Edge_Check_Data[47:40]; 
    wire [7:0]Matrix_11=Matrix_Edge_Check_Data[39:32]; 
    wire [7:0]Matrix_12=Matrix_Edge_Check_Data[31:24]; 
    wire [7:0]Matrix_20=Matrix_Edge_Check_Data[23:16]; 
    wire [7:0]Matrix_21=Matrix_Edge_Check_Data[15:8]; 
    wire [7:0]Matrix_22=Matrix_Edge_Check_Data[7:0]; 
    //定义边缘检测中间计算数据矩阵 
    wire [10:0]Matrix_Cal_X_0=Matrix_00+2*Matrix_01+Matrix_02; 
    wire [10:0]Matrix_Cal_X_1=Matrix_20+2*Matrix_21+Matrix_22; 
    wire [10:0]Matrix_Cal_Y_0=Matrix_00+2*Matrix_10+Matrix_20; 
    wire [10:0]Matrix_Cal_Y_1=Matrix_02+2*Matrix_12+Matrix_22; 
    //定义边缘检测计算结果,绝对值 
    wire [10:0]Matrix_Res_X=(Matrix_Cal_X_1>Matrix_Cal_X_0)?(Matrix_Cal_X_1-Matrix_Cal_X_0):(Matrix_Cal_X_0-Matrix_Cal_X_1); 
    wire [10:0]Matrix_Res_Y=(Matrix_Cal_Y_1>Matrix_Cal_Y_0)?(Matrix_Cal_Y_1-Matrix_Cal_Y_0):(Matrix_Cal_Y_0-Matrix_Cal_Y_1); 
    //定义阈值平方和 
    wire [15:0]Gate2=Gray_Gate*Gray_Gate; 
    //定义延时后的数据信号 
    wire De_Delay; 
    //定义二值化输出 
    wire Binary_Data_Out=(Matrix_Res_X*Matrix_Res_X+Matrix_Res_Y*Matrix_Res_Y>Gate2)?Rst&De_Delay:0; 
    //图像输出连线,二值化 
    assign RGB_Data=Binary_Data_Out?24'hffffff:0; 
    assign Delay_Num=Edge_Delay_Clk; 
    //边缘检测数据矩阵移动 
    always@(posedge clk_Image_Process or negedge Rst) 
        begin 
            //低电平复位 
            if(!Rst) 
                Matrix_Edge_Check_Data<=0; 
            else if(RGB_DE) 
                
Matrix_Edge_Check_Data<={Matrix_Edge_Check_Data[47:24],Matrix_Edge_Check_Data[23:0],D1,D3,Gray_Data}; 
        end 
    //数据有效信号延时 
     Delay_Signal Delay_De( 
        .clk_Signal(clk_Image_Process),       //信号单位时钟 
        .Rst(Rst),                            //复位信号,低电平复位 
        .Signal_In(RGB_DE),                   //需要延时的输入信号 
        .Delay_Num(Edge_Delay_Clk_De),        //需要延时的时钟个数,不超过 8,可级联 
        .Delay_Signal(De_Delay)               //延时后输出的信号 
        ); 
    //由于图像数据不能完全存储,存储空间不足的原因,采用移位寄存器,存两行,处理一行 
    //移位寄存器最大值为 1088,而我们一行图像为 1280，所以我们新建 640 单位的移位寄存器,例化 4 个使用即可 
    //移位寄存器链内部首尾信号相接,外部首尾信号分别为:输入为灰度数据,输出为移位数据 
    //第一行 
    Shift_Line Image_Line_Buffer00( 
      .D(Gray_Data),                        // input wire [7 : 0] D 
      .CLK(clk_Image_Process&RGB_DE),       // input wire CLK 
      .Q(D0)                                // output wire [7 : 0] Q 
    );   
    Shift_Line Image_Line_Buffer01( 
      .D(D0),                               // input wire [7 : 0] D 
      .CLK(clk_Image_Process&RGB_DE),       // input wire CLK 
      .Q(D1)                                // output wire [7 : 0] Q 
    );   
    //第二行 
    Shift_Line Image_Line_Buffer10( 
      .D(D1),                               // input wire [7 : 0] D 
      .CLK(clk_Image_Process&RGB_DE),       // input wire CLK 
      .Q(D2)                                // output wire [7 : 0] Q 
    );   
    Shift_Line Image_Line_Buffer11( 
      .D(D2),                               // input wire [7 : 0] D 
      .CLK(clk_Image_Process&RGB_DE),       // input wire CLK 
      .Q(D3)                                // output wire [7 : 0] Q 
    );   
endmodule 