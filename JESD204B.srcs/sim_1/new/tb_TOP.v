`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 09:28:29 AM
// Design Name: 
// Module Name: tb_TOP
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


module tb_TOP(  );

reg clk,serclk;
reg [13:0] data_in;
reg rst,sysref;
wire [13:0] data_out;

reg [1:0] cnt=0;


TOP tx1(data_in,rst,sync,serclk,clk,sysref,de_ser_data);
BOTTOM rx1(de_ser_data,clk,rst,sysref,serclk,data_out,sync);

initial
    begin
        clk=0;
        forever #5 clk=~clk;
    end

initial
    begin
    serclk=0;
    forever #1 serclk=~serclk;
    end
    
initial 
    begin
        rst=1'b1;sysref=1'b0;cnt=0;
         #20 rst=1'b0;
         #50 rst=1'b1;
         #40 sysref=1'b1;
    end
always@(posedge clk) begin
    cnt=cnt+1;
    if(cnt==0) data_in= $random & 14'h3FFF;
end

endmodule
