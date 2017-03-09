// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to  
// suit user's needs .Comments are provided in each section to help the user    
// fill out necessary details.                                                  
// *****************************************************************************
                                                                                
// Verilog Test Bench template for design : FPGA
// 
// Simulation tool : ModelSim-Altera (Verilog)
// 

`timescale 1 ps/ 1 ps
module FPGA_tb();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg CLK_IN;//10M
reg CLK_26M;

//reset signal

//GPIF II
reg USB3_CTL4;//FLAGA
reg USB3_CTL5;//FLAGB
wire [31:0] USB3_DQ;

wire [31:0] data_hnr;
wire USB3_CTL2;//SLOE ???????????????????
wire USB3_CTL3;//SLRD
wire USB3_CTL1;//SLWR
wire USB3_CTL0;//SLCS
wire USB3_PCLK;//100M
wire USB3_CTL11;
wire USB3_CTL12;
wire SCLK;

wire [13:0] DAC1;
wire [13:0] DAC2;
wire [13:0] DAC3;
wire [13:0] DAC4;
wire [13:0] DAC5;
wire [13:0] DAC6;
wire [13:0] DAC7;
wire [13:0] DAC8;

wire DAC_CLK;

// assign statements (if any)                          
FPGA FPGA0 (
// port map - connection between master ports and signals/registers  
.CLK_IN(CLK_IN),
.CLK_26M(CLK_26M),


.USB3_CTL4(USB3_CTL4),
.USB3_CTL5(USB3_CTL5),
.USB3_DQ(USB3_DQ),

.data_hnr(data_hnr),
.USB3_CTL2(USB3_CTL2),
.USB3_CTL3(USB3_CTL3),
.USB3_CTL1(USB3_CTL1),
.USB3_CTL0(USB3_CTL0),
.USB3_PCLK(USB3_PCLK),
.USB3_CTL11(USB3_CTL11),
.USB3_CTL12(USB3_CTL12),
.SCLK(SCLK),



.DAC1(DAC1),
.DAC2(DAC2),
.DAC3(DAC3),
.DAC4(DAC4),
.DAC5(DAC5),
.DAC6(DAC6),
.DAC7(DAC7),
.DAC8(DAC8),

.DAC_CLK(DAC_CLK)
);

     
initial 
begin 
   CLK_IN=0;
   forever
   # 50000 CLK_IN=~CLK_IN;
// --> end                                                                   
end 
                                                   
                                           
endmodule

