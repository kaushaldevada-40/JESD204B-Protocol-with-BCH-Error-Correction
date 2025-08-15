`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2025 11:14:08 AM
// Design Name: 
// Module Name: RX_LMFC_CLK
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


module RX_LMFC_CLK(
    input clk,
    input rst,
    input sysref,
    //output reg lmfcx,
    output reg fcx,
    input serclk
    );
    
    //serclk 2.5GHz
    //FC 250MHz
    //LMFC 15.625 MHz
    //clk 500MHz
    
    reg fc,lmfc,flag;
    reg [5:0] cnt0,cntx;
    reg [2:0] cnflag;
    reg cnt1;
    
    //always@(*) begin
    //    if(sysref==1) sysflag<=1'b1;
    //end
    
    always@(posedge fc or negedge rst) begin
        if(!rst) begin
            cnflag<=3'b0;
            flag<=0;
            cntx<=6'b0;
        end else begin
        cnflag=cnflag+1;
        if(cnflag==3'b011) flag=1'b1;
        if(flag==1 ) begin
         //if(cnflag==2'b11)
            if(cntx == 31) begin
                cntx<=6'b0;
                lmfcx<=1'b1;
            end else begin
                cntx<=cntx+1;
                lmfcx<=1'b0;
            end
        end
       end
    end
    
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            //sysflag<=1'b0;
            cnt0<=6'b0;
            cnt1<=1'b0;
            lmfc<=1'b0;
            fc<=1'b0;
        end else begin
        if(sysref==1 ) begin
         //if(cnflag==2'b11)
            if(cnt0 == 32) begin
                cnt0<=5'b0;
                lmfc<=1'b1;
            end if(cnt1 == 1) begin 
                cnt1<=1'b0;
                fc<=1'b1;
            end else begin
                cnt0<=cnt0+1;
                cnt1<=cnt1+1;
                fc<=1'b0;
                lmfc<=1'b0;
            end
        end
       
       end  
    end

    always@(*) begin
        if(flag==1) begin
            fcx=fc;
        end
        
    end
    
endmodule