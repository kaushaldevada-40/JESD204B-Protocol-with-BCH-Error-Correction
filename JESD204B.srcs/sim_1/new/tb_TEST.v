`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 03:17:46 PM
// Design Name: 
// Module Name: tb_TEST
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


module tb_TEST(  );

reg clk,rst,sysref;
reg [13:0] data_in;
wire [13:0] data_out;
reg [5:0] cnt=0;

TEST test1(clk,sysref,rst,data_in,data_out);

initial
    begin
        clk=0;
        forever #2.5 clk=~clk;
    end


    
initial 
    begin
        rst=1'b1;sysref=1'b0;cnt=0;
         #100 rst=1'b0;
         #50 rst=1'b1;
         #5850 sysref=1'b1;
    end
always@(posedge clk) begin
    cnt=cnt+1;
    if(cnt==6'd40) begin data_in= $random & 14'h3FFF;cnt=0; end
end
    

endmodule
