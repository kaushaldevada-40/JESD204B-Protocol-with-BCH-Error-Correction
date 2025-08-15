`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 03:14:47 PM
// Design Name: 
// Module Name: TEST
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


module TEST(
    input clk,
    input sysref,
    input rst,
    input [13:0] data_in,
    output [13:0] data_out
    );
    
    
    wire sync;
    
//clk_wiz_0 clk1(.clk_100(clk_100),.clk_5(fc),.clk_in1(clk));
clk_wiz_0 clk1(.clk_100(clk_100),.clk_5(fc),.resetn(sysref),.clk_in1(clk));
//clk_wiz_0 clk1(.clk_100(clk_100),.clk_10(clk_10),.clk_in1(clk));
//clk_wiz_0 clk1(.clk_200(clk_200),.clk_20(clk_20),.clk_10(fc),.clk_in1(clk));
TOP tx1(data_in,rst,sync,clk_100,fc,de_ser_data);
BOTTOM rx1(de_ser_data,rst,clk_100,fc,data_out,sync);
    
endmodule
