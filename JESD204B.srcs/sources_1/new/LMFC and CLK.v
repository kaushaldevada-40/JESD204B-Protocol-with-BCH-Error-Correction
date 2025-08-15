`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2025 10:04:34 AM
// Design Name: 
// Module Name: LMFC and CLK
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


module LMFC_CLK(
    input clk,
    input rst,
    input sysref,
    output reg lmfc,
    input serclk
    );
    
    //serclk 2.5GHz
    //FC 250MHz
    //LMFC 15.625 MHz
    //clk 500MHz
    
    reg [5:0] cnt0;
    reg cnt1,sysflag;
    
    always@(*) begin
        
    end
    
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            sysflag<=1'b0;
            cnt0<=6'b0;
            cnt1<=1'b0;
            lmfc<=1'b0;
           // fc<=1'b0;
        end else begin
          if(sysref==1) sysflag<=1'b1;
          if(sysflag==1) begin
            if(cnt0 == 32) begin
                cnt0<=5'b0;
                lmfc<=1'b1;
            end if(cnt1 == 1) begin 
                cnt1<=1'b0;
               // fc<=1'b1;
            end else begin
                cnt0<=cnt0+1;
                cnt1<=cnt1+1;
               // fc<=1'b0;
                lmfc<=1'b0;
            end
          end
        end  
    end
    
endmodule
