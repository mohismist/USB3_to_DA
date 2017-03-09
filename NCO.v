`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:38:16 12/02/2016 
// Design Name: 
// Module Name:    NCO 
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
module NCO(clk,rst_n,fre_chtr,pha_chtr,sin,cos);
  
  parameter  DATA_WIDTH=28;
  input  clk;
  input  rst_n;
  input  [27:0] fre_chtr; //fre_chtr 频率控制字 28'd67108864 = 1/4 clk
  input  [27:0] pha_chtr; //pha_chtr 相位控制字 28'd67108864 = 90°相位
  output [15:0] sin;
  output [15:0] cos;

  
  //reg  [27:0] fre_chtr=28'd199372381;
  //reg  [DATA_WIDTH-1:0] pha_chtr=28'd0;
  reg [DATA_WIDTH-1:0] phase_in;
  reg [DATA_WIDTH-1:0] fre_chtr_reg;
  initial
  begin
	 phase_in= 0;
	 fre_chtr_reg= 0;
  end 
  
  always@(posedge clk or negedge rst_n)
  begin
       if(!rst_n) begin
         fre_chtr_reg <= 28'd0;
         phase_in <= 28'd0;
       end
       else begin
         fre_chtr_reg <= fre_chtr + fre_chtr_reg;
         phase_in <= pha_chtr + fre_chtr_reg;
       end
  end 

  SINCOS u(.clk(clk),.rst_n(rst_n),.phase_in(phase_in),.sin(sin),.cos(cos));
endmodule 
