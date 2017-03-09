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
reg CLK_IN;
reg USB3_CTL4;
reg USB3_CTL5;
reg [31:0] USB3_DQ;

// wires    
wire [31:0] USB3_DQ2;  
wire USB3_CTL2;
wire USB3_CTL3;
wire USB3_CTL1;                                         
wire USB3_PCLK;

// assign statements (if any)                          
FPGA FPGA0 (
// port map - connection between master ports and signals/registers  
	
	.CLK_IN(CLK_IN),
	.USB3_CTL4(USB3_CTL4),
	.USB3_CTL5(USB3_CTL5),
	
	.USB3_DQ(USB3_DQ),
	.USB3_DQ2(USB3_DQ2),
	
	.USB3_CTL2(USB3_CTL2),
	.USB3_CTL3(USB3_CTL3),
	.USB3_CTL1(USB3_CTL1),
	.USB3_PCLK(USB3_PCLK)
);

initial                                                
begin                                                  
// code that executes only once 
	# 0 USB3_CTL4=1'b0;
	# 10 USB3_CTL5=1'b1;
	# 500000 USB3_DQ=32'h0000_0007;
	# 0 USB3_CTL4=1'b1;
	# 100000 USB3_DQ=32'h0000_000f;
	# 100000 USB3_DQ=32'h0000_007f;
	# 100000 USB3_DQ=32'h0000_00ff;
	# 100000 USB3_DQ=32'h0000_07ff;
	# 50000 USB3_CTL4=1'b0;
	# 50000 USB3_DQ=32'h0000_fff7;
// insert code here --> begin 
end

initial                         
begin
CLK_IN = 0;
	forever
   # 50000 CLK_IN=~CLK_IN;
// --> end                                             
$display("Running testbench");                       
end 
                                                   
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
                                                       
@eachvec;                                              
// --> end                                             
end                                                    
endmodule

