`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 12:19:21 AM
// Design Name: 
// Module Name: TOP
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


module TOP( 
    input [13:0] data_in,
    input rst,
    input sync,
    input serclk,
    //input clk,
    //input sysref,
    input fc,
    output de_ser_data   );
    
    //wire lmfc;
    wire [7:0] trdl_data;
    wire [9:0] dlser_data;
    
//LMFC_CLK c1(clk,rst,sysref,lmfc,serclk);
TRANSPORT t1(data_in,fc,rst,trdl_data);
DATA_LINK d1(trdl_data,sync,rst,fc,dlser_data);
SER s1(dlser_data,serclk,rst,~fc,de_ser_data);



endmodule
