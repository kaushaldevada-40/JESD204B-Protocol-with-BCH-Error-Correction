`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2025 12:23:06 PM
// Design Name: 
// Module Name: RX_DATA_LINK
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


module RX_DATA_LINK(
    input fc,
    input rst,
    input [9:0] rxdl_data_in,
    output reg [7:0] rxdl_data_out,
    output reg sync
    );
    
    `define R 8'h1c
    `define A 8'h7c
    `define Q 8'h9c
    `define K 8'hbc
    `define F 8'hfc
    
    parameter WAIT=2'b00;
    parameter CGS=2'b01;
    parameter ILAS=2'b10;
    parameter DATA=2'b11;
    
    // Configuration registers
    parameter DID=8'h00;
    parameter ADJCNT=4'b1111;
    parameter BID=4'b0000;
    parameter ADJDIR=1'b0;
    parameter PHADJ=1'b0;
    parameter LID=5'b00000;
    parameter SCR=1'b0;
    parameter L=5'b10111;
    parameter F=8'b11011111;
    parameter K=5'b11001;
    parameter M=8'b11001100;
    parameter CS=2'b00;
    parameter N=5'b00000;
    parameter SUBCLASS=3'b000;
    parameter JESDV=3'b000;
    parameter S=5'b10101;
    parameter HD=1'b0;
    parameter CF=5'b00000;
    parameter FCHK=8'b00000;
    
    reg comma;
    
    function [7:0] decode_10b8b;
    input [9:0] encoded;
    reg [4:0] data5b;
    reg [2:0] data3b;
    begin
    if(encoded[5:0]==6'b001111) comma=1'b1;
    else comma=1'b0;
        // Decode 6b -> 5b
        case (encoded[5:0])
            6'b100111: data5b = 5'b00000;
            6'b011101: data5b = 5'b00001;
            6'b101101: data5b = 5'b00010;
            6'b110001: data5b = 5'b00011;
            6'b110101: data5b = 5'b00100;
            6'b101001: data5b = 5'b00101;
            6'b011001: data5b = 5'b00110;
            6'b111000: data5b = 5'b00111;
            6'b111001: data5b = 5'b01000;
            6'b100101: data5b = 5'b01001;
            6'b010101: data5b = 5'b01010;
            6'b110100: data5b = 5'b01011;
            6'b001101: data5b = 5'b01100;
            6'b101100: data5b = 5'b01101;
            6'b011100: data5b = 5'b01110;
            6'b010111: data5b = 5'b01111;
            6'b011011: data5b = 5'b10000;
            6'b100011: data5b = 5'b10001;
            6'b010011: data5b = 5'b10010;
            6'b110010: data5b = 5'b10011;
            6'b001011: data5b = 5'b10100;
            6'b101010: data5b = 5'b10101;
            6'b011010: data5b = 5'b10110;
            6'b111010: data5b = 5'b10111;
            6'b110011: data5b = 5'b11000;
            6'b100110: data5b = 5'b11001;
            6'b010110: data5b = 5'b11010;
            6'b110110: data5b = 5'b11011;
            6'b001110,6'b001111: data5b = 5'b11100;
            6'b101110: data5b = 5'b11101;
            6'b011110: data5b = 5'b11110;
            6'b101011: data5b = 5'b11111; // special case (overlap)
            default:   data5b = 5'b00000; // optionally signal error
        endcase

        // Decode 4b -> 3b
        case (encoded[9:6])
            4'b1011: data3b = 3'b000;
            4'b1001: data3b = (comma)? 3'b110:3'b001;
            4'b0101: data3b = (comma)? 3'b101:3'b010;
            4'b1100: data3b = 3'b011;
            4'b1101: data3b = 3'b100;
            4'b1010: data3b = (comma)? 3'b010:3'b101;
            4'b0110: data3b = (comma)? 3'b001:3'b110;
            4'b1110: data3b = 3'b111;
            4'b0111: data3b = 3'b111;
            default: data3b = 3'b000; // optionally signal error
        endcase

        decode_10b8b = {data3b, data5b}; // Recombine to 8-bit
    end
endfunction

    
    reg rx_valid,Rflag,kflag;
    reg [1:0] state,next_state,octcnt;
    reg [7:0] kcnt;
    reg [2:0] ila_frame;
    reg [5:0] oct;
    reg [4:0] octstate;
    reg oct1,ind,indicator,nextflag;
    reg [9:0] octet2,octet4;
    
    always@(*) begin
        case(state)
            WAIT: next_state=(rxdl_data_in == 10'h000) ? CGS : WAIT;
            CGS:  next_state=( nextflag && rx_valid) ? ILAS : CGS;
            ILAS: next_state=(ila_frame==3'b100 && rx_valid) ? DATA : ILAS;
            DATA: next_state=rx_valid ? DATA: CGS;
        endcase
    end
    
    //always@(posedge lmfc) begin
    //    state=next_state;
    //end
    
    always@(posedge fc or negedge rst) begin
        if(!rst) begin
            sync<=1'b0;
            state<=CGS;
            oct<=6'h00;
            octstate<=5'd0;
            ila_frame<=3'b00;
            kcnt<=2'b00;
            rx_valid<=1'b0;
            Rflag<=1'b0;
            kflag<=1'b0;
            oct1<=1'b0;
            octcnt<=2'b0;
            ind<=1'b0;
            nextflag<=0;
            indicator<=0;
        end else begin
        octstate<=octstate+kflag;
        if(octstate == 31) state=next_state;
            case(state)
                WAIT: begin
                        rx_valid=(rxdl_data_in == 8'h00)?1'b1:1'b0;
                        sync=1'b0; 
                      end
                CGS:  begin 
                        rxdl_data_out<=8'hxx;
                       //if(kcnt!=2'b11 )
                         if(rxdl_data_in == 10'b0101001111) begin 
                            kcnt=kcnt+1; 
                            kflag=1;
                            if(kcnt==2'b11 )nextflag<=1'b1;
                            end
                         else begin 
                         rx_valid=1'b1;
                         sync=1'b0;
                         end
                       if(nextflag & rx_valid) 
                         sync=1'b1;  
                      end
                         
                ILAS:  begin 
                        case(ila_frame)
                         2'b00,
                         2'b10,
                         2'b11: begin
                                case(oct)
                                    5'd0,5'd1: rx_valid=(rxdl_data_in == 10'b1011001111); //R
                                    5'd31: rx_valid=(rxdl_data_in == 10'b1100001111); //A
                                    5'd30: begin 
                                            kcnt=0;
                                            rx_valid=(rxdl_data_in == 10'b1100001111);  //A
                                           end
                                endcase
                               end
                         2'b01:begin
                                case(oct)
                                    5'd0,5'd1: rx_valid=(rxdl_data_in == 10'b1011001111); //R
                                    5'd2,5'd3: rx_valid=(rxdl_data_in == 10'b1101001111); //Q
                                    5'd4: rx_valid=(DID==decode_10b8b(rxdl_data_in));
                                    5'd5: rx_valid=({ADJCNT,BID}==decode_10b8b(rxdl_data_in));
                                    5'd6: rx_valid=({ADJDIR,PHADJ,LID}==decode_10b8b(rxdl_data_in));
                                    5'd7: rx_valid=({SCR,L}==decode_10b8b(rxdl_data_in));
                                    5'd8: rx_valid=(F==decode_10b8b(rxdl_data_in));
                                    5'd9: rx_valid=(K==decode_10b8b(rxdl_data_in));
                                    5'd10: rx_valid=(M==decode_10b8b(rxdl_data_in));
                                    5'd11: rx_valid=({CS,N}==decode_10b8b(rxdl_data_in));
                                    5'd12: rx_valid=({SUBCLASS,N}==decode_10b8b(rxdl_data_in));
                                    5'd13: rx_valid=({JESDV,S}==decode_10b8b(rxdl_data_in));
                                    5'd14: rx_valid=({HD,CF}==decode_10b8b(rxdl_data_in));
                                    5'd17: rx_valid=(FCHK==decode_10b8b(rxdl_data_in));
                                    5'd31: rx_valid=(rxdl_data_in == 10'b1100001111); //A
                                    5'd30: begin 
                                            rx_valid=(rxdl_data_in == 10'b1100001111);  //A
                                           end
                                endcase
                               end
                        endcase
                        if(rxdl_data_in == 10'h2cf) Rflag=1;
                        if(Rflag==1) oct<=oct+1;
                        if(rxdl_data_in == 10'h30f) begin
                            octcnt<=octcnt+1;
                            if(octcnt==2'd1) begin
                            ila_frame<=ila_frame+1; 
                            oct<=6'd0;
                            octcnt<=0;
                         end
                        end
                       end
                DATA: begin 
                        ila_frame=0;
                        oct1<=oct1+1;
                        if(oct==8'h1f) oct<=oct+1;
                        else begin 
                        if(rx_valid==1) begin
                        if(oct1==1 && (rxdl_data_in != 10'h1cf)) octet2<=rxdl_data_in;
                         if(rxdl_data_in[5:0] ==6'b001111) 
                            case(rxdl_data_in[9:6])
                                4'b0111: begin rxdl_data_out=decode_10b8b(octet2);ind=~ind; end
                                4'b1100: begin rxdl_data_out=decode_10b8b(octet4);indicator=~indicator; end
                            endcase
                            else begin
                                if(octstate == 5'h1e) octet4<=rxdl_data_in;
                                rxdl_data_out=decode_10b8b(rxdl_data_in);  // 
                                end
                         
                        end else rxdl_data_out<=8'hxx;
                       end
                       
                      end   
            endcase
        end
    end
    
endmodule
