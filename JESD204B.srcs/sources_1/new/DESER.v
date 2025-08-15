`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2025 11:24:02 AM
// Design Name: 
// Module Name: DESER
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


module DESER(
    input deser_data_in,
    input serclk,
    input rst,
    input fc,
    output reg [9:0] deser_data_out
    );
    
    parameter length=10;
    
    reg [4:0] i;
    reg [30:0] data_buff1,data_buff2;
    reg [5:0] S [length-1:0];
    reg [30:0] datain;
    reg [30:0] dataout;
    reg [30:0] flipbit;
    reg [4:0] alpha [31:0];
    reg [4:0] alpha_1 [31:0];
    reg [4:0] index;
    reg [4:0] hold;
    
    integer j,k,n,test,test1,test2,u;
    integer b,m,L,d;
    
    integer lamda,counter;
    
    reg [15:0] C [5:0];
    reg [15:0] B [5:0]; 
    reg [15:0] A [5:0]; 
    
    

    initial 
        begin
alpha[0] = 5'b00001;  //(1)
alpha[1] = 5'b00010;  //(2)
alpha[2] = 5'b00100;  //(4)
alpha[3] = 5'b01000;  //(8)
alpha[4] = 5'b10000;  //(16)
alpha[5] = 5'b00101;  //(5)
alpha[6] = 5'b01010;  //(10)
alpha[7] = 5'b10100;  //(20)
alpha[8] = 5'b01101;  //(13)
alpha[9] = 5'b11010;  //(26)
alpha[10] = 5'b10001;  //(17)
alpha[11] = 5'b00111;  //(7)
alpha[12] = 5'b01110;  //(14)
alpha[13] = 5'b11100;  //(28)
alpha[14] = 5'b11101;  //(29)
alpha[15] = 5'b11111;  //(31)
alpha[16] = 5'b11011;  //(27)
alpha[17] = 5'b10011;  //(19)
alpha[18] = 5'b00011;  //(3)
alpha[19] = 5'b00110;  //(6)
alpha[20] = 5'b01100;  //(12)
alpha[21] = 5'b11000;  //(24)
alpha[22] = 5'b10101;  //(21)
alpha[23] = 5'b01111;  //(15)
alpha[24] = 5'b11110;  //(30)
alpha[25] = 5'b11001;  //(25)
alpha[26] = 5'b10111;  //(23)
alpha[27] = 5'b01011;  //(11)
alpha[28] = 5'b10110;  //(22)
alpha[29] = 5'b01001;  //(9)
alpha[30] = 5'b10010;  //(18)
alpha[31] = 5'b00001;  //(1)
        end
        
    initial
        begin
alpha_1[0] = 5'b00000;
alpha_1[1] = 5'b00000;
alpha_1[2] = 5'b00001;
alpha_1[3] = 5'b10010;
alpha_1[4] = 5'b00010;
alpha_1[5] = 5'b00101;
alpha_1[6] = 5'b10011;
alpha_1[7] = 5'b01011;
alpha_1[8] = 5'b00011;
alpha_1[9] = 5'b11101;
alpha_1[10] = 5'b00110;
alpha_1[11] = 5'b11011;
alpha_1[12] = 5'b10100;
alpha_1[13] = 5'b01000;
alpha_1[14] = 5'b01100;
alpha_1[15] = 5'b10111;
alpha_1[16] = 5'b00100;
alpha_1[17] = 5'b01010;
alpha_1[18] = 5'b11110;
alpha_1[19] = 5'b10001;
alpha_1[20] = 5'b00111;
alpha_1[21] = 5'b10110;
alpha_1[22] = 5'b11100;
alpha_1[23] = 5'b11010;
alpha_1[24] = 5'b10101;
alpha_1[25] = 5'b11001;
alpha_1[26] = 5'b01001;
alpha_1[27] = 5'b10000;
alpha_1[28] = 5'b01101;
alpha_1[29] = 5'b01110;
alpha_1[30] = 5'b11000;
alpha_1[31] = 5'b01111;
    end

  
    
    always @(posedge fc) begin
         deser_data_out=data_buff2;
         //datain=cw[counter];
         //counter=counter+1;
           //datain=31'h1f4780bd;
         datain=data_buff2;
         for(k=0;k<length;k=k+1) begin
            S[k]=5'b0;
            if(k==0 && ^datain) S[k]=1;
            for(j=0;j<31;j=j+1) begin
                if(datain[j] ==1) begin
                   index = (k * (j)) % 31;
                   S[k]=S[k]^alpha[index];
                end
            end 
         end
         
         dataout=datain;
         A[0]=16'h00;
         A[1]=16'b00;
         A[2]=16'b00;
         A[3]=16'b00;
         A[4]=16'b00;
         A[5]=16'b00;
         A[6]=16'b00;
         A[7]=16'b00;
         C[0]=16'h01;
         C[1]=16'b00;
         C[2]=16'b00;
         C[3]=16'b00;
         C[4]=16'b00;
         C[5]=16'b00;
         C[6]=16'b00;
         C[7]=16'b00;
         B[0]=C[0];
         B[1]=C[1];
         B[2]=C[2];
         B[3]=C[3];
         B[4]=C[4];
         B[5]=C[5];
         B[6]=C[6];
         B[7]=C[7];
         

         b=1;
         L=0;
         m=1;
         d=0;
         for(k=0;k<length;k=k+1) begin
            d=S[k];
            for(j=1;j<=length-1;j=j+1) begin
              if(j<=L)
                if(C[j]==0 | S[k-j]==0) 
                d=d;
                else
                d=d^alpha[(alpha_1[C[j]]+alpha_1[S[k-j]])%31];
            end
               // d=d^S[k];
                
             if(d!=0) begin
                A[0]=C[0];
                A[1]=C[1];
                A[2]=C[2];
                A[3]=C[3];
                A[4]=C[4];
                A[5]=C[5];
                A[6]=C[6];
                A[7]=C[7];
                test1=alpha_1[d];
                test2=alpha_1[b];
                test=(test1-test2)+5'd31;
                hold=alpha[test%31];
                for(u=0;u<length;u=u+1) begin
                   if(u>=m)
                    if(B[u-m]) C[u]=C[u]^alpha[(alpha_1[hold]+alpha_1[B[u-m]])%31];
                end
                
//                for(u=0;u<m;u=u+1) begin
  //                  A[0+u]=0;
    //                A[1+u]=B[0];
      //              A[2+u]=B[1];
        //            A[3+u]=B[2];
          //          A[4+u]=B[3];
            //        A[5+u]=B[4];
              //  end
//                for(u=0;u<6;u=u+1) begin
  //                  if(A[u]!=0)
    //                A[u]=alpha[(alpha_1[hold]+alpha_1[A[u]])%31];
      //          end 
                if(k>=2*L) begin
                L=k+1-L;
                B[0]=A[0];
                B[1]=A[1];
                B[2]=A[2];
                B[3]=A[3];
                B[4]=A[4];
                B[5]=A[5];
                B[6]=A[6];
                B[7]=A[7];
                b=d;
                m=1;
                end else begin
                m=m+1;
               end
//                for(n=0;n<6;n=n+1) begin
  //                  C[n]=A[n]^C[n];
    //                A[n]=0;
      //          end
             end 
             else m=m+1;
             
         end
         flipbit=31'b0;
         for(k=0;k<31;k=k+1) begin
            lamda=0;
            for(j=0;j<length;j=j+1) begin
                if(C[j]!=0) begin
                test1=alpha_1[C[j]];
                test2=alpha_1[alpha[(10*31-j*k)%31]];
                test=alpha[(alpha_1[C[j]]+alpha_1[alpha[(10*31-j*k)%31]])%31];
                lamda=lamda^test;
                end
            end
            if(lamda ==0) begin 
                flipbit[k]=1;
                dataout[k]=~dataout[k];
            end
         end 
         deser_data_out=dataout[30:21]; 
    end
    
    always@(posedge serclk or negedge rst) begin
        if(!rst) begin
            i<=5'b0001;
            data_buff2<=30'h00000;
            data_buff1<=30'h00000;
        end else begin
        data_buff1[i]=deser_data_in;
        i=i-1;
        if(i==5'b11111) i=5'b11110;
        if(i==5'b11110) data_buff2=data_buff1; //6 for #50  5 for #5
        end
    end
    
endmodule