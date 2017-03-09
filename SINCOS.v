`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:37:30 12/02/2016 
// Design Name: 
// Module Name:    SINCOS 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SINCOS(clk,rst_n,phase_in,sin,cos);

parameter DATA_WIDTH=28;
parameter PIPELINE=28;

input                     clk,rst_n;
input   [DATA_WIDTH-1:0]  phase_in;

//reg  [DATA_WIDTH-1:0]  sin,cos;

reg    [DATA_WIDTH-1:0]  sin_out,cos_out,eps;
output    [13:0]  sin,cos;
reg     [DATA_WIDTH-1:0]  phase_in_reg;

reg     [DATA_WIDTH-1:0]  x[PIPELINE:0];
reg     [DATA_WIDTH-1:0]  y[PIPELINE:0];
reg     [DATA_WIDTH-1:0]  z[PIPELINE:0];

reg     [1:0]             quadrant[PIPELINE:0];

integer i;

//get real quadrant and map to first_n quadrant
assign sin=sin_out[27:14]+14'd8192;
assign cos=cos_out[27:14]+14'd8192;

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        phase_in_reg<=28'd0;
     else
           begin
               case(phase_in[27:26])
                   2'b00:phase_in_reg<=phase_in;
                   2'b01:phase_in_reg<=phase_in-28'd67108864; //-pi/2
                   2'b10:phase_in_reg<=phase_in-28'd134217728;
                   2'b11:phase_in_reg<=phase_in-28'd201326592;
                   default: ;
               endcase
           end
end

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[0]<=28'd0;
             y[0]<=28'd0;
             z[0]<=28'd0;
         end
     else
            begin
                x[0]<=28'd81503715;// 0.60725*2^27
                y[0]<=28'd0;
                z[0]<=phase_in_reg;
            end
end

//level1-level26
//level1
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[1]<=28'd0;
             y[1]<=28'd0;
             z[1]<=28'd0;
         end
     else
            begin
                if(z[0][27]==1'b0)
                   begin
                       x[1]<=x[0]-y[0];
                       y[1]<=y[0]+x[0];
                       z[1]<=z[0]-28'd33554432; //45deg
                   end
                 else
                   begin
                       x[1]<=x[0]+y[0];
                       y[1]<=y[0]-x[0];
                       z[1]<=z[0]+28'd33554432; //45deg
                   end
            end
end
//level2
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[2]<=28'd0;
             y[2]<=28'd0;
             z[2]<=28'd0;
         end
     else
            begin
                if(z[1][27]==1'b0)
                   begin
                       x[2]<=x[1]-{y[1][DATA_WIDTH-1],y[1][DATA_WIDTH-1:1]};
                       y[2]<=y[1]+{x[1][DATA_WIDTH-1],x[1][DATA_WIDTH-1:1]};
                       z[2]<=z[1]-28'd19808338; //26deg
                   end
                 else
                   begin
                       x[2]<=x[1]+{y[1][DATA_WIDTH-1],y[1][DATA_WIDTH-1:1]};
                       y[2]<=y[1]-{x[1][DATA_WIDTH-1],x[1][DATA_WIDTH-1:1]};
                       z[2]<=z[1]+28'd19808338; 
                   end
            end
end
//level3
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[3]<=28'd0;
             y[3]<=28'd0;
             z[3]<=28'd0;
         end
     else
            begin
                if(z[2][27]==1'b0)
                   begin
                       x[3]<=x[2]-{{2{y[2][DATA_WIDTH-1]}},y[2][DATA_WIDTH-1:2]};
                       y[3]<=y[2]+{{2{x[2][DATA_WIDTH-1]}},x[2][DATA_WIDTH-1:2]};
                       z[3]<=z[2]-28'd10466181; //14deg
                   end
                 else
                   begin
                       x[3]<=x[2]+{{2{y[2][DATA_WIDTH-1]}},y[2][DATA_WIDTH-1:2]};
                       y[3]<=y[2]-{{2{x[2][DATA_WIDTH-1]}},x[2][DATA_WIDTH-1:2]};
                       z[3]<=z[2]+28'd10466181; 
                   end
            end
end
//level4

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[4]<=28'd0;
             y[4]<=28'd0;
             z[4]<=28'd0;
         end
     else
            begin
                if(z[3][27]==1'b0)
                   begin
                       x[4]<=x[3]-{{3{y[3][DATA_WIDTH-1]}},y[3][DATA_WIDTH-1:3]};
                       y[4]<=y[3]+{{3{x[3][DATA_WIDTH-1]}},x[3][DATA_WIDTH-1:3]};
                       z[4]<=z[3]-28'd5312797; //7deg
                   end
                 else
                   begin
                       x[4]<=x[3]+{{3{y[3][DATA_WIDTH-1]}},y[3][DATA_WIDTH-1:3]};
                       y[4]<=y[3]-{{3{x[3][DATA_WIDTH-1]}},x[3][DATA_WIDTH-1:3]};
                       z[4]<=z[3]+28'd5312797; 
                   end
            end
end
//level5
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[5]<=28'd0;
             y[5]<=28'd0;
             z[5]<=28'd0;
         end
     else
            begin
                if(z[4][27]==1'b0)
                   begin
                       x[5]<=x[4]-{{4{y[4][DATA_WIDTH-1]}},y[4][DATA_WIDTH-1:4]};
                       y[5]<=y[4]+{{4{x[4][DATA_WIDTH-1]}},x[4][DATA_WIDTH-1:4]};
                       z[5]<=z[4]-28'd2666708; //4deg
                   end
                 else
                   begin
                       x[5]<=x[4]+{{4{y[4][DATA_WIDTH-1]}},y[4][DATA_WIDTH-1:4]};
                       y[5]<=y[4]-{{4{x[4][DATA_WIDTH-1]}},x[4][DATA_WIDTH-1:4]};
                       z[5]<=z[4]+28'd2666708; 
                   end
            end
end
//level6

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[6]<=28'd0;
             y[6]<=28'd0;
             z[6]<=28'd0;
         end
     else
            begin
                if(z[5][27]==1'b0)
                   begin
                       x[6]<=x[5]-{{5{y[5][DATA_WIDTH-1]}},y[5][DATA_WIDTH-1:5]};
                       y[6]<=y[5]+{{5{x[5][DATA_WIDTH-1]}},x[5][DATA_WIDTH-1:5]};
                       z[6]<=z[5]-28'd1334654; //2deg
                   end
                 else
                   begin
                       x[6]<=x[5]+{{5{y[5][DATA_WIDTH-1]}},y[5][DATA_WIDTH-1:5]};
                       y[6]<=y[5]-{{5{x[5][DATA_WIDTH-1]}},x[5][DATA_WIDTH-1:5]};
                       z[6]<=z[5]+28'd1334654;
                   end
            end
end
//level7
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[7]<=28'd0;
             y[7]<=28'd0;
             z[7]<=28'd0;
         end
     else
            begin
                if(z[6][27]==1'b0)
                   begin
                       x[7]<=x[6]-{{6{y[6][DATA_WIDTH-1]}},y[6][DATA_WIDTH-1:6]};
                       y[7]<=y[6]+{{6{x[6][DATA_WIDTH-1]}},x[6][DATA_WIDTH-1:6]};
                       z[7]<=z[6]-28'd667489; //1deg
                   end
                 else
                   begin
                       x[7]<=x[6]+{{6{y[6][DATA_WIDTH-1]}},y[6][DATA_WIDTH-1:6]};
                       y[7]<=y[6]-{{6{x[6][DATA_WIDTH-1]}},x[6][DATA_WIDTH-1:6]};
                       z[7]<=z[6]+28'd667489; 
                   end
            end
end
//level8 

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[8]<=28'd0;
             y[8]<=28'd0;
             z[8]<=28'd0;
         end
     else
            begin
                if(z[7][27]==1'b0)
                   begin
                       x[8]<=x[7]-{{7{y[7][DATA_WIDTH-1]}},y[7][DATA_WIDTH-1:7]};
                       y[8]<=y[7]+{{7{x[7][DATA_WIDTH-1]}},x[7][DATA_WIDTH-1:7]};
                       z[8]<=z[7]-28'd333765; //1deg
                   end
                 else
                   begin
                       x[8]<=x[7]+{{7{y[7][DATA_WIDTH-1]}},y[7][DATA_WIDTH-1:7]};
                       y[8]<=y[7]-{{7{x[7][DATA_WIDTH-1]}},x[7][DATA_WIDTH-1:7]};
                       z[8]<=z[7]+28'd333765; //1deg
                   end
            end
end
//level9
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[9]<=28'd0;
             y[9]<=28'd0;
             z[9]<=28'd0;
         end
     else
            begin
                if(z[8][27]==1'b0)
                   begin
                       x[9]<=x[8]-{{8{y[8][DATA_WIDTH-1]}},y[8][DATA_WIDTH-1:8]};
                       y[9]<=y[8]+{{8{x[8][DATA_WIDTH-1]}},x[8][DATA_WIDTH-1:8]};
                       z[9]<=z[8]-28'd166885; //1deg
                   end
                 else
                   begin
                       x[9]<=x[8]+{{8{y[8][DATA_WIDTH-1]}},y[8][DATA_WIDTH-1:8]};
                       y[9]<=y[8]-{{8{x[8][DATA_WIDTH-1]}},x[8][DATA_WIDTH-1:8]};
                       z[9]<=z[8]+28'd166885; //1deg
                   end
            end
end
//level10
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[10]<=28'd0;
             y[10]<=28'd0;
             z[10]<=28'd0;
         end
     else
            begin
                if(z[9][27]==1'b0)
                   begin
                       x[10]<=x[9]-{{9{y[9][DATA_WIDTH-1]}},y[9][DATA_WIDTH-1:9]};
                       y[10]<=y[9]+{{9{x[9][DATA_WIDTH-1]}},x[9][DATA_WIDTH-1:9]};
                       z[10]<=z[9]-28'd83442; //1deg
                   end
                 else
                   begin
                       x[10]<=x[9]+{{9{y[9][DATA_WIDTH-1]}},y[9][DATA_WIDTH-1:9]};
                       y[10]<=y[9]-{{9{x[9][DATA_WIDTH-1]}},x[9][DATA_WIDTH-1:9]};
                       z[10]<=z[9]+28'd83442; //1deg
                   end
            end
end
//level11
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[11]<=28'd0;
             y[11]<=28'd0;
             z[11]<=28'd0;
         end
     else
            begin
                if(z[10][27]==1'b0)
                   begin
                       x[11]<=x[10]-{{10{y[10][DATA_WIDTH-1]}},y[10][DATA_WIDTH-1:10]};
                       y[11]<=y[10]+{{10{x[10][DATA_WIDTH-1]}},x[10][DATA_WIDTH-1:10]};
                       z[11]<=z[10]-28'd41721; //1deg
                   end
                 else
                   begin
                       x[11]<=x[10]+{{10{y[10][DATA_WIDTH-1]}},y[10][DATA_WIDTH-1:10]};
                       y[11]<=y[10]-{{10{x[10][DATA_WIDTH-1]}},x[10][DATA_WIDTH-1:10]};
                       z[11]<=z[10]+28'd41721; //1deg
                   end
            end
end
//level12
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[12]<=28'd0;
             y[12]<=28'd0;
             z[12]<=28'd0;
         end
     else
            begin
                if(z[11][27]==1'b0)
                   begin
                       x[12]<=x[11]-{{11{y[11][DATA_WIDTH-1]}},y[11][DATA_WIDTH-1:11]};
                       y[12]<=y[11]+{{11{x[11][DATA_WIDTH-1]}},x[11][DATA_WIDTH-1:11]};
                       z[12]<=z[11]-28'd20860; //1deg
                   end
                 else
                   begin
                       x[12]<=x[11]+{{11{y[11][DATA_WIDTH-1]}},y[11][DATA_WIDTH-1:11]};
                       y[12]<=y[11]-{{11{x[11][DATA_WIDTH-1]}},x[11][DATA_WIDTH-1:11]};
                       z[12]<=z[11]+28'd20860; //1deg
                   end
            end
end
//level13
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[13]<=28'd0;
             y[13]<=28'd0;
             z[13]<=28'd0;
         end
     else
            begin
                if(z[12][27]==1'b0)
                   begin
                       x[13]<=x[12]-{{12{y[12][DATA_WIDTH-1]}},y[12][DATA_WIDTH-1:12]};
                       y[13]<=y[12]+{{12{x[12][DATA_WIDTH-1]}},x[12][DATA_WIDTH-1:12]};
                       z[13]<=z[12]-28'd10430; //1deg
                   end
                 else
                   begin
                       x[13]<=x[12]+{{12{y[12][DATA_WIDTH-1]}},y[12][DATA_WIDTH-1:12]};
                       y[13]<=y[12]-{{12{x[12][DATA_WIDTH-1]}},x[12][DATA_WIDTH-1:12]};
                       z[13]<=z[12]+28'd10430; //1deg
                   end
            end
end
//level14
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[14]<=28'd0;
             y[14]<=28'd0;
             z[14]<=28'd0;
         end
     else
            begin
                if(z[13][27]==1'b0)
                   begin
                       x[14]<=x[13]-{{13{y[13][DATA_WIDTH-1]}},y[13][DATA_WIDTH-1:13]};
                       y[14]<=y[13]+{{13{x[13][DATA_WIDTH-1]}},x[13][DATA_WIDTH-1:13]};
                       z[14]<=z[13]-28'd5215; //1deg
                   end
                 else
                   begin
                       x[14]<=x[13]+{{13{y[13][DATA_WIDTH-1]}},y[13][DATA_WIDTH-1:13]};
                       y[14]<=y[13]-{{13{x[13][DATA_WIDTH-1]}},x[13][DATA_WIDTH-1:13]};
                       z[14]<=z[13]+28'd5215; //1deg
                   end
            end
end
//level15
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[15]<=28'd0;
             y[15]<=28'd0;
             z[15]<=28'd0;
         end
     else
            begin
                if(z[14][27]==1'b0)
                   begin
                       x[15]<=x[14]-{{14{y[14][DATA_WIDTH-1]}},y[14][DATA_WIDTH-1:14]};
                       y[15]<=y[14]+{{14{x[14][DATA_WIDTH-1]}},x[14][DATA_WIDTH-1:14]};
                       z[15]<=z[14]-28'd2607; //1deg
                   end
                 else
                   begin
                       x[15]<=x[14]+{{14{y[14][DATA_WIDTH-1]}},y[14][DATA_WIDTH-1:14]};
                       y[15]<=y[14]-{{14{x[14][DATA_WIDTH-1]}},x[14][DATA_WIDTH-1:14]};
                       z[15]<=z[14]+28'd2607; //1deg
                   end
            end
end
//level16
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[16]<=28'd0;
             y[16]<=28'd0;
             z[16]<=28'd0;
         end
     else
            begin
                if(z[15][27]==1'b0)
                   begin
                       x[16]<=x[15]-{{15{y[15][DATA_WIDTH-1]}},y[15][DATA_WIDTH-1:15]};
                       y[16]<=y[15]+{{15{x[15][DATA_WIDTH-1]}},x[15][DATA_WIDTH-1:15]};
                       z[16]<=z[15]-28'd1303; //1deg
                   end
                 else
                   begin
                       x[16]<=x[15]+{{15{y[15][DATA_WIDTH-1]}},y[15][DATA_WIDTH-1:15]};
                       y[16]<=y[15]-{{15{x[15][DATA_WIDTH-1]}},x[15][DATA_WIDTH-1:15]};
                       z[16]<=z[15]+28'd1303; //1deg
                   end
            end
end
//level17
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[17]<=28'd0;
             y[17]<=28'd0;
             z[17]<=28'd0;
         end
     else
            begin
                if(z[16][27]==1'b0)
                   begin
                       x[17]<=x[16]-{{16{y[16][DATA_WIDTH-1]}},y[16][DATA_WIDTH-1:16]};
                       y[17]<=y[16]+{{16{x[16][DATA_WIDTH-1]}},x[16][DATA_WIDTH-1:16]};
                       z[17]<=z[16]-28'd651; //1deg
                   end
                 else
                   begin
                       x[17]<=x[16]+{{16{y[16][DATA_WIDTH-1]}},y[16][DATA_WIDTH-1:16]};
                       y[17]<=y[16]-{{16{x[16][DATA_WIDTH-1]}},x[16][DATA_WIDTH-1:16]};
                       z[17]<=z[16]+28'd651; //1deg
                   end
            end
end
//level18
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[18]<=28'd0;
             y[18]<=28'd0;
             z[18]<=28'd0;
         end
     else
            begin
                if(z[17][27]==1'b0)
                   begin
                       x[18]<=x[17]-{{17{y[17][DATA_WIDTH-1]}},y[17][DATA_WIDTH-1:17]};
                       y[18]<=y[17]+{{17{x[17][DATA_WIDTH-1]}},x[17][DATA_WIDTH-1:17]};
                       z[18]<=z[17]-28'd325; //1deg
                   end
                 else
                   begin
                       x[18]<=x[17]+{{17{y[17][DATA_WIDTH-1]}},y[17][DATA_WIDTH-1:17]};
                       y[18]<=y[17]-{{17{x[17][DATA_WIDTH-1]}},x[17][DATA_WIDTH-1:17]};
                       z[18]<=z[17]+28'd325; //1deg
                   end
            end
end
//level19
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[19]<=28'd0;
             y[19]<=28'd0;
             z[19]<=28'd0;
         end
     else
            begin
                if(z[18][27]==1'b0)
                   begin
                       x[19]<=x[18]-{{18{y[18][DATA_WIDTH-1]}},y[18][DATA_WIDTH-1:18]};
                       y[19]<=y[18]+{{18{x[18][DATA_WIDTH-1]}},x[18][DATA_WIDTH-1:18]};
                       z[19]<=z[18]-28'd162; //1deg
                   end
                 else
                   begin
                       x[19]<=x[18]+{{18{y[18][DATA_WIDTH-1]}},y[18][DATA_WIDTH-1:18]};
                       y[19]<=y[18]-{{18{x[18][DATA_WIDTH-1]}},x[18][DATA_WIDTH-1:18]};
                       z[19]<=z[18]+28'd162; //1deg
                   end
            end
end
//level20
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[20]<=28'd0;
             y[20]<=28'd0;
             z[20]<=28'd0;
         end
     else
            begin
                if(z[19][27]==1'b0)
                   begin
                       x[20]<=x[19]-{{19{y[19][DATA_WIDTH-1]}},y[19][DATA_WIDTH-1:19]};
                       y[20]<=y[19]+{{19{x[19][DATA_WIDTH-1]}},x[19][DATA_WIDTH-1:19]};
                       z[20]<=z[19]-28'd81; //1deg
                   end
                 else
                   begin
                       x[20]<=x[19]+{{19{y[19][DATA_WIDTH-1]}},y[19][DATA_WIDTH-1:19]};
                       y[20]<=y[19]-{{19{x[19][DATA_WIDTH-1]}},x[19][DATA_WIDTH-1:19]};
                       z[20]<=z[19]+28'd81; //1deg
                   end
            end
end
//level21
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[21]<=28'd0;
             y[21]<=28'd0;
             z[21]<=28'd0;
         end
     else
            begin
                if(z[20][27]==1'b0)
                   begin
                       x[21]<=x[20]-{{20{y[20][DATA_WIDTH-1]}},y[20][DATA_WIDTH-1:20]};
                       y[21]<=y[20]+{{20{x[20][DATA_WIDTH-1]}},x[20][DATA_WIDTH-1:20]};
                       z[21]<=z[20]-28'd40; //1deg
                   end
                 else
                   begin
                       x[21]<=x[20]+{{20{y[20][DATA_WIDTH-1]}},y[20][DATA_WIDTH-1:20]};
                       y[21]<=y[20]-{{20{x[20][DATA_WIDTH-1]}},x[20][DATA_WIDTH-1:20]};
                       z[21]<=z[20]+28'd40; //1deg
                   end
            end
end
//level22
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[22]<=28'd0;
             y[22]<=28'd0;
             z[22]<=28'd0;
         end
     else
            begin
                if(z[21][27]==1'b0)
                   begin
                       x[22]<=x[21]-{{21{y[21][DATA_WIDTH-1]}},y[21][DATA_WIDTH-1:21]};
                       y[22]<=y[21]+{{21{x[21][DATA_WIDTH-1]}},x[21][DATA_WIDTH-1:21]};
                       z[22]<=z[21]-28'd20; //1deg
                   end
                 else
                   begin
                       x[22]<=x[21]+{{21{y[21][DATA_WIDTH-1]}},y[21][DATA_WIDTH-1:21]};
                       y[22]<=y[21]-{{21{x[21][DATA_WIDTH-1]}},x[21][DATA_WIDTH-1:21]};
                       z[22]<=z[21]+28'd20; //1deg
                   end
            end
end
//level23
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[23]<=28'd0;
             y[23]<=28'd0;
             z[23]<=28'd0;
         end
     else
            begin
                if(z[22][27]==1'b0)
                   begin
                       x[23]<=x[22]-{{22{y[22][DATA_WIDTH-1]}},y[22][DATA_WIDTH-1:22]};
                       y[23]<=y[22]+{{22{x[22][DATA_WIDTH-1]}},x[22][DATA_WIDTH-1:22]};
                       z[23]<=z[22]-28'd10; //1deg
                   end
                 else
                   begin
                       x[23]<=x[22]+{{22{y[22][DATA_WIDTH-1]}},y[22][DATA_WIDTH-1:22]};
                       y[23]<=y[22]-{{22{x[22][DATA_WIDTH-1]}},x[22][DATA_WIDTH-1:22]};
                       z[23]<=z[22]+28'd10; //1deg
                   end
            end
end
//level24
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[24]<=28'd0;
             y[24]<=28'd0;
             z[24]<=28'd0;
         end
     else
            begin
                if(z[23][27]==1'b0)
                   begin
                       x[24]<=x[23]-{{23{y[23][DATA_WIDTH-1]}},y[23][DATA_WIDTH-1:23]};
                       y[24]<=y[23]+{{23{x[23][DATA_WIDTH-1]}},x[23][DATA_WIDTH-1:23]};
                       z[24]<=z[23]-28'd5; //1deg
                   end
                 else
                   begin
                       x[24]<=x[23]+{{23{y[23][DATA_WIDTH-1]}},y[23][DATA_WIDTH-1:23]};
                       y[24]<=y[23]-{{23{x[23][DATA_WIDTH-1]}},x[23][DATA_WIDTH-1:23]};
                       z[24]<=z[23]+28'd5; //1deg
                   end
            end
end

//level25
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[25]<=28'd0;
             y[25]<=28'd0;
             z[25]<=28'd0;
         end
     else
            begin
                if(z[24][27]==1'b0)
                   begin
                       x[25]<=x[24]-{{24{y[24][DATA_WIDTH-1]}},y[24][DATA_WIDTH-1:24]};
                       y[25]<=y[24]+{{24{x[24][DATA_WIDTH-1]}},x[24][DATA_WIDTH-1:24]};
                       z[25]<=z[24]-28'd2; //1deg
                   end
                 else
                   begin
                       x[25]<=x[24]+{{24{y[24][DATA_WIDTH-1]}},y[24][DATA_WIDTH-1:24]};
                       y[25]<=y[24]-{{24{x[24][DATA_WIDTH-1]}},x[24][DATA_WIDTH-1:24]};
                       z[25]<=z[24]+28'd2; //1deg
                   end
            end
end
//level26
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
         begin
             x[26]<=28'd0;
             y[26]<=28'd0;
             z[26]<=28'd0;
         end
     else
            begin
                if(z[25][27]==1'b0)
                   begin
                       x[26]<=x[25]-{{25{y[25][DATA_WIDTH-1]}},y[25][DATA_WIDTH-1:25]};
                       y[26]<=y[25]+{{25{x[25][DATA_WIDTH-1]}},x[25][DATA_WIDTH-1:25]};
                       z[26]<=z[25]-28'd1; //1deg
                   end
                 else
                   begin
                       x[26]<=x[25]+{{25{y[25][DATA_WIDTH-1]}},y[25][DATA_WIDTH-1:25]};
                       y[26]<=y[25]-{{25{x[25][DATA_WIDTH-1]}},x[25][DATA_WIDTH-1:25]};
                       z[26]<=z[25]+28'd1; //1deg
                   end
            end
end


always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        for(i=0;i<PIPELINE;i=i+1)
           quadrant[i]<=2'b00;
     else
           begin
              for(i=0;i<PIPELINE;i=i+1)
                 quadrant[i+1]<=quadrant[i];
           quadrant[0]<=phase_in[27:26];
           end
        
end


always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        begin
            sin_out<=28'd0;
            cos_out<=28'd0;
            eps<=28'd0;
        end
     else
           case(quadrant[27])
              2'b00:begin
                    sin_out<=y[26];
                    cos_out<=x[26];
                    eps<=z[26];
                    end
              2'b01:begin
                    sin_out<=x[26];
                    cos_out<=~y[26]+1'b1;
                    eps<=z[26];
                    end  
              2'b10:begin
                    sin_out<=~y[26]+1'b1;
                    cos_out<=~x[26]+1'b1;
                    eps<=z[26];
                    end   
              2'b11:begin
                    sin_out<=~x[26]+1'b1;
                    cos_out<=y[26];
                    eps<=z[26];
                    end  
           endcase                       
end
endmodule 