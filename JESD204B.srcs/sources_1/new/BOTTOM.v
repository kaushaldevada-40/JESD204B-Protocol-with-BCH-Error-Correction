`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 11:27:24 AM
// Design Name: 
// Module Name: BOTTOM
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


module BOTTOM(
    input de_ser_data,
   // input clk,
    input rst,
    //input sysref,
    input serclk,
    input fcr,
    output [13:0] data_out,
    output sync
);

wire [9:0] deser_rxdl_data;
wire [7:0] rxdl_tr_data;


//RX_LMFC_CLK rxc1(clk,rst,sysref,fcrx,serclk);
DESER ds1(de_ser_data,serclk,rst,fcr,deser_rxdl_data);
Data_Link_RX rxd1(fcr,rst,deser_rxdl_data,rxdl_tr_data,sync);
RX_TRANSPORT rxt1(fcr,rst,rxdl_tr_data,data_out);


endmodule
