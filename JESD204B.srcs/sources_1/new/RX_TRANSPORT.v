`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2025 12:55:06 PM
// Design Name: 
// Module Name: RX_TRANSPORT
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


module RX_TRANSPORT(
    input fc,
    input rst,
    input [7:0] rxtr_data_in,
    output reg [13:0] rxtr_data_out
    );
    
    reg oct;
    reg [7:0] oct1,oct2;
    
    always@(posedge fc or negedge rst) begin
        if(!rst) begin
            oct<=0;
        end else begin
            oct<=oct+1;
            case(oct) 
                1'b0: oct1<=rxtr_data_in;
                1'b1: oct2<=rxtr_data_in;
            endcase
            rxtr_data_out <= (oct == 1'b0) ? {oct1, oct2[7:2]} : rxtr_data_out;
        end
    end
    
endmodule
