`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 23:46:47
// Design Name: 
// Module Name: Shape_Judge
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


module Shape_Judge
 #(parameter HANG220 = 219, HANG360 = 359, HANG500 = 499, HANG550 = 549, HANG740 = 739, TURE = 1, LIE550=539, LIE1080 = 1079,
SMALL1 = 120, SMALL2 = 40, MIDDLES = 120, MIDDLEY = 240, BIG = 320) 
(
                    input rst_n, 
                    input vid_clk, 
                    input vid_hsync, 
                    input vid_vsync, 
                    input vid_active_video, 
                    input data_in, 
 
                    input [10:0] hdata, 
                    input [9:0] vdata, 
                     
                    output reg vid_hsync_out,// 
                    output reg vid_vsync_out,// 
                    output reg vid_active_video_out,// 
                     
                    output [2:0] shape
    );
     reg [10:0] addhang1, addhang2, addhang3; 
     reg [10:0] addlie1;
    reg concrast12, concrast23; 
    reg [10:0] subtract12, subtract23; 
    reg vid_hsync_out_1, vid_vsync_out_1, vid_active_video_out_1; 
     
    wire sanjiao, yuan, fang; 
     
    parameter AAA = 219; 
 
    always@(posedge vid_clk)//vid 信号真题延迟两个阈值判断时钟周期 
    begin 
        if(!rst_n) 
            begin 
                vid_hsync_out <= 0; 
                vid_vsync_out <= 0; 
                vid_active_video_out <= 0; 
            end 
        else 
            begin 
            vid_hsync_out_1 <= vid_hsync; 
                vid_vsync_out_1 <= vid_vsync; 
                vid_active_video_out_1 <= vid_active_video; 
                 
                vid_hsync_out <= vid_hsync_out_1; 
                vid_vsync_out <= vid_vsync_out_1; 
                vid_active_video_out <= vid_active_video_out_1; 
            end 
    end 
     
    always@(posedge vid_clk)//检测第 220 行；vdata == 219。 
    begin 
        if(!rst_n) 
            begin 
                addhang1 <= 0; 
            end 
        else 
            begin  
                if(vdata == HANG740)  
                    begin 
                        addhang1 <= 0; 
                    end 
                else if(vdata == HANG220)  
                    begin 
                        addhang1 <= addhang1 + data_in; 
                    end 
                else 
                   begin 
                       addhang1 <= addhang1; 
                   end 
            end    
    end 
     
     
   /* always@(posedge vid_clk)//检测第 360 行；vdata == 359。 
    begin 
        if(!rst_n) 
            begin 
                addhang2 <= 11'd15; 
            end 
        else 
            begin  
                if(vdata == HANG740)  
                    begin 
                     addhang2 <= 11'd15; 
                    end 
                else if(vdata == HANG360) 
                    begin 
                        addhang2 <= addhang2 + data_in; 
                    end 
                else 
                   begin 
                       addhang2 <= addhang2; 
                   end 
            end    
    end          
 */
    always@(posedge vid_clk)//检测第 500 行；vdata == 499。 
    begin 
        if(!rst_n) 
            begin 
                addhang3 <=  11'd20; 
            end 
        else 
            begin  
                if(vdata == HANG740)  
                    begin 
                        addhang3 <= 11'd20; 
                    end 
                else if(vdata == HANG500) 
                    begin 
                        addhang3 <= addhang3 + data_in; 
                    end 
                else 
                   begin 
                       addhang3 <= addhang3; 
                   end 
            end    
    end 
     
    always@(posedge vid_clk)//220 行与 360 行长度大小判断 
    begin 
        if(!rst_n) 
            begin 
                concrast12 <= 0; 
            end 
        else 
            begin
            if(addhang1 > addhang2)  
                   begin 
                       concrast12 <= 1; 
                   end 
                else 
                   begin 
                       concrast12 <= 0; 
                   end 
            end    
    end 
     
    always@(posedge vid_clk)//360 行与 500 行长度大小判断 
    begin 
        if(!rst_n) 
            begin 
                concrast23 <= 0; 
            end 
        else 
            begin  
                if(addhang2 > addhang3)  
                   begin 
                       concrast23 <= 1; 
                   end 
                else 
                   begin 
                       concrast23 <= 0; 
                   end 
            end    
    end     
           
    always@(posedge vid_clk)//220 行与 360 行数值差 
    begin 
        if(!rst_n) 
            begin 
                subtract12 <= 0; 
            end 
        else 
            begin  
                if(concrast12)  
                   begin 
                       subtract12 <= addhang1 - addhang2; 
                   end 
                else 
                   begin 
                    subtract12 <= addhang2 - addhang1; 
                   end 
            end    
    end 
     
    always@(posedge vid_clk)//220 行与 360 行数值差 
    begin 
        if(!rst_n) 
            begin 
                subtract23 <= 0; 
            end 
        else 
            begin  
                if(concrast23)  
                   begin 
                       subtract23 <= addhang2 - addhang3; 
                   end 
                else 
                   begin 
                       subtract23 <= addhang3 - addhang2; 
                   end 
            end    
    end 
    
     always@(posedge vid_clk)//检测第 550列；hdata == 550。 
    begin 
        if(!rst_n) 
            begin 
                addlie1 <= 0; 
            end 
        else 
            begin  
                if(hdata == LIE1080)  
                    begin 
                        addlie1 <= 0; 
                    end 
                else if(hdata == LIE550)  
                    begin 
                        addlie1 <= addlie1 + data_in; 
                    end 
                else 
                   begin 
                       addlie1 <= addlie1; 
                   end 
            end    
    end 
    assign sanjiao = ((MIDDLES < subtract12 <= BIG) && (MIDDLES < subtract23 <= BIG)&& (!concrast12) && 
(!concrast23)) ? TURE : !TURE;//1  :  0    
    assign yuan =  ((SMALL2 < subtract12 <= MIDDLEY) && (SMALL2 < subtract23 <= MIDDLEY) && (!concrast12) && 
(concrast23)) ? TURE : !TURE;//1  :  0    
    assign fang =  ((subtract12 <= SMALL1) && (subtract23 <= AAA)) ? TURE : !TURE;//1  :  0    
     
    assign shape[0] = sanjiao; 
    assign shape[1] = yuan; 
    assign shape[2] = fang; 
endmodule
