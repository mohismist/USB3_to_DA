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
module ram_tb();
// constants
// general purpose registers
reg eachvec;
// test vector input registers
reg clk;
reg rst_n;
reg [31:0] data;

localparam DATA_WIDTH_DELAY = 10;
reg [DATA_WIDTH_DELAY-1:0] delay_ca0;
reg [DATA_WIDTH_DELAY-1:0] delay_ca1;
reg [DATA_WIDTH_DELAY-1:0] delay_ca2;
reg [DATA_WIDTH_DELAY-1:0] delay_ca3;
reg [DATA_WIDTH_DELAY-1:0] delay_ca4;
reg [DATA_WIDTH_DELAY-1:0] delay_ca5;
reg [DATA_WIDTH_DELAY-1:0] delay_ca6;
reg [DATA_WIDTH_DELAY-1:0] delay_ca7;

reg [6:0] counter_c;       
reg [5:0]   counter_data;


reg [7:0] clk_1023k;
reg [15:0] wren;

// wires    
wire [7:0] data_ca;  
wire [7:0] data_msg;

initial                                                
begin                                                  
	delay_ca0 = 10'd3;
	delay_ca1 = 10'd13;
	delay_ca2 = 10'd11;
	delay_ca3 = 10'd14;
	delay_ca4 = 10'd2;
	delay_ca5 = 10'd5;
	delay_ca6 = 10'd8;
	delay_ca7 = 10'd0;
end


ram_bb ram_bb_inst(
	
	.clk(clk),
	.rst_n(rst_n),
	.data(data),
	
	.delay_ca0(delay_ca0),
	.delay_ca1(delay_ca1),
	.delay_ca2(delay_ca2),
	.delay_ca3(delay_ca3),
	.delay_ca4(delay_ca4),
	.delay_ca5(delay_ca5),
	.delay_ca6(delay_ca6),
	.delay_ca7(delay_ca7),
	
	.clk_1023k(clk_1023k),
	.wren(wren),
	
	.data_ca(data_ca), 
	.data_msg(data_msg)
);


initial                                                
begin                                                  
// code that executes only once 
	# 0 rst_n =1'b1;
	# 0 wren =16'b0;
	# 0 clk_1023k = 8'd0;
	# 0 data <= 32'h0000_0011;
	# 0 counter_c = 7'd0;
	# 0 counter_data = 10'd0;

	# 150000 rst_n=1'b0;
	# 10000 rst_n =1'b1;
	# 40000 wren = 16'd1;
// insert code here --> begin 
end

initial                         
begin
	clk = 0;
	forever
 	# 50000 clk=~clk;
// --> end                                             
$display("Running testbench");                       
end 
 
always @(posedge clk)
begin
	if (counter_c >=7'd48)
		counter_c <= 7'b0;
	else begin
		counter_c <= counter_c + 1'b1;
		case (counter_c)
			7'd2: clk_1023k[0] <= ~clk_1023k[0];
			7'd4: clk_1023k[1] <= ~clk_1023k[1];
			7'd16: clk_1023k[2] <= ~clk_1023k[2];
			7'd22: clk_1023k[3] <= ~clk_1023k[3];
			7'd35: clk_1023k[4] <= ~clk_1023k[4];
			7'd36: clk_1023k[5] <= ~clk_1023k[5];
			7'd42: clk_1023k[6] <= ~clk_1023k[6];
			7'd45: clk_1023k[7] <= ~clk_1023k[7];
		endcase
	end
end 

always @(posedge clk)                         
begin
	if (counter_data >=6'd31) begin
		wren <= {wren[14:0], wren[15]};
		counter_data <= 10'b0;
		data <= 32'h0000_0011;
	end 
	else begin
		if (|(wren)) begin
			counter_data <= counter_data + 1'b1;
			data <= data + 32'h0000_1000;
		end
	end
end 
                                       
endmodule

