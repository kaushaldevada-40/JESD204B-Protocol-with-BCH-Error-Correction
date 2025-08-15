`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2025 11:33:27 AM
// Design Name: 
// Module Name: TRANSPORT
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


module TRANSPORT(
    input [13:0] tr_data_in,
    input fc,
    input rst,
    output reg [7:0] tr_data_out
    );
    
    reg [7:0] oct0,oct1;
    reg oct;
    
    parameter TAIL=2'b00;
    
    always@(posedge fc or negedge rst) begin
        if(!rst) begin
            oct<=1'b0;
            oct1<=8'b0;
            oct0<=8'b0;
        end else begin
            oct1<=tr_data_in[13:6];
            oct0<={tr_data_in[5:0],TAIL};
            oct<=oct+1;
            case(oct)
                1'b0: tr_data_out<=oct1;
                1'b1: tr_data_out<=oct0;
            endcase
        end
    end
    
endmodule
