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
module NCO_tb();
// constants
// test vector input registers
reg clk;
reg rst_n;
reg [27:0] fre_chtr;
reg [27:0] pha_chtr;
// wires    
wire [13:0] sin;
wire [13:0] cos;

// assign statements (if any)           

NCO NCO0(
	.clk(clk),
	.rst_n(rst_n),
	.fre_chtr(fre_chtr),
	.pha_chtr(pha_chtr),
	.sin(sin),
	.cos(cos)
); 


initial                                                
begin                                                 
	# 0 rst_n =1'b1;
	# 0 rst_n =1'b1;
	fre_chtr = 28'd67108864;
	pha_chtr = 28'd0;
	# 150000 rst_n=1'b0;
	# 10000 rst_n =1'b1;
end

// clk 100M
initial                         
begin
	clk = 0;
	forever
 	# 50000 clk=~clk;
$display("Running testbench");                       
end 

//integer w_file;
//initial w_file = $fopen("data_out.txt");
//always @(clk)
//begin
//    $fdisplay(w_file,"%h",sin);
//end
                                                                                          
endmodule

