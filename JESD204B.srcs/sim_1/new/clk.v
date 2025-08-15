`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2025 10:22:05 AM
// Design Name: 
// Module Name: clk
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


module clk(  );

reg clk;
reg serclk;
reg rst;
wire lmfc;
wire fc;
reg sysref;
wire sync;
reg [13:0] tr_data_in;
wire [7:0] tr_data_out;
reg [7:0] dl_data_in;
wire [9:0] dl_data_out;
reg cnt;
reg [7:0] rxtr_data_in;
wire [13:0] rxtr_data_out;
reg [9:0] rxdl_data_in;
wire [7:0] rxdl_data_out;
wire syncrx;

reg [9:0] ser_data_in;
wire ser_data_out;
reg deser_data_in;
wire [9:0] deser_data_out;

wire lmfcr;
wire fcr;

LMFC_CLK c1(clk,rst,sysref,lmfc,fc,serclk);
RX_LMFC_CLK rxc1(clk,rst,sysref,lmfcr,fcr,serclk);
TRANSPORT t1(tr_data_in,fc,rst,tr_data_out);
DATA_LINK d1(dl_data_in,sync,lmfc,rst,fc,dl_data_out);
SER s1(ser_data_in,serclk,rst,fc,ser_data_out);
DESER ds1(deser_data_in,serclk,rst,fcr,deser_data_out);
RX_DATA_LINK rxd1(fcr,rst,lmfcr,rxdl_data_in,rxdl_data_out,sync);
RX_TRANSPORT rxt1(fcr,rst,rxtr_data_in,rxtr_data_out);

initial
    begin
        clk=0;
        forever #50 clk=!clk;
    end
    
initial 
    begin
        serclk=0;
        forever #10 serclk=!serclk;
    end
    
//initial 
//    begin
//       #805.5 ser_data_in=10'h1cf;
//    end
    
initial 
    begin
            rst=1'b1;sysref=1'b0;tr_data_in=14'h34b;cnt=0;
         #20 rst=1'b0;
         #50 rst=1'b1;
         #40 sysref=1'b1;
         //#2 sync=1'b0;
         //#200 sync=1'b1;
         //#100 tr_data_in=14'h1be;
         //#100 tr_data_in=14'h0da;
         //#100 tr_data_in=14'h224;
         //#100 tr_data_in=14'h286;
         //#400 tr_data_in=14'h165;
    end

always@(*) begin
    dl_data_in<=tr_data_out;
    ser_data_in<=dl_data_out;
    deser_data_in<=ser_data_out;
    rxdl_data_in<=deser_data_out;
    rxtr_data_in<=rxdl_data_out;
end
always@(posedge fc) begin
    cnt=cnt+1;
    if(cnt==1) tr_data_in= $random & 14'h3FFF;
end
endmodule
