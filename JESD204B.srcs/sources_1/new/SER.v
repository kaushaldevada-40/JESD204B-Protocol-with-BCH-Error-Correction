`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2025 09:56:51 AM
// Design Name: 
// Module Name: SER
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


module SER(
    input [9:0] ser_data_in,
    input serclk,
    input rst,
    input fc,
    output reg ser_data_out
    );

    reg [4:0] i;
    reg [30:0] data_buff;
    reg load_data;
    reg [30:0] dataout;
    reg [19:0] remainder;
    reg [30:0] dat;
    reg [30:0] gen;
    integer k,iter;
    

    // Capture data on fc
    always @(posedge fc or negedge rst) begin
        if (!rst) begin
            data_buff <= 10'b0;
            load_data <= 1'b0;
        end else begin
            iter=30;
            //data_buff <= ser_data_in;
            gen={21'b101100010011011010101,10'b0};
            dat={ser_data_in,21'b0};
            for (k = 30; k >=0;k=k-1) begin
                if(iter >=20) begin
                    if (dat[30] == 1) begin  
                    dat = dat ^ gen;  
                end 
                    dat={dat[29:0],1'b0};
                    iter=iter-1;
                end
            end
            remainder=dat[30:11];
            dataout={ser_data_in,1'b0,remainder};
            data_buff=dataout;
            //i <= 4'd9;
            load_data <= 1'b1;
        end
    end

    // Shift out serial bits on serclk
    always @(posedge serclk or negedge rst) begin
        if (!rst) begin
            ser_data_out <= 1'b0;
            i <= 5'd30;
        end else if (load_data) begin
            ser_data_out <= data_buff[i];
            if (i == 0)
                i <= 5'd30;
            else
                i <= i - 1;
        end
    end

endmodule

