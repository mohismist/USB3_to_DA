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

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"
// CREATED		"Thu Dec 17 18:18:17 2015"

module FPGA(
	//CLK
	input CLK_IN,	//10M
	
	//reset signal
	//input RESET_N,
	
	//GPIF II
	input USB3_CTL4,	//FLAGA
	input USB3_CTL5,	//FLAGB
	inout [31:0] USB3_DQ,
	
	output USB3_CTL2,	//SLOE 杈撳嚭浣胯兘淇″彿锛屽叾鍞竴鍔熻兘鏄┍鍔ㄦ暟鎹€荤嚎
	output USB3_CTL3,	//SLRD
	output USB3_CTL1,	//SLWR
	output USB3_CTL0,	//SLCS
	output USB3_PCLK,	//100M
	output USB3_CTL11,
	output USB3_CTL12,
	output SCLK
	
	);
	
	
// clocks
wire	SYS_CLK;
wire	CLK_100M;
wire	CLK_166M;
wire	SIG_CLK;


// GPIF II
wire	USB3_SLWR;
wire	USB3_SLRD;
wire	USB3_SLOE;
wire	USB3_SLCS;
wire	USB3_A1;
wire	USB3_A0;
wire	USB3_FLAGA;
wire	USB3_FLAGB;

// USB Interface
wire	DATA_DIR = 1'b0;//1 for p2u	0 for u2p

wire	[8:0] usb_rd_cnt = 9'b0;
wire	[3:0] usb_rd_state = 3'b0;

wire	[31:0] usb_wr_cnt = 32'b0;
wire	[2:0] usb_wr_state = 3'b0;

wire	[31:0] data_u2p;
wire	[31:0] data_p2u;
wire	RESET_N;

pll_hnr pll_inst(
	.inclk0(CLK_IN),
	.c0(CLK_100M),
	.c1(SIG_CLK));
	
stream stream_inst(
	.clk(USB3_PCLK),
	.rst_n(RESET_N),
	.FLAGA(USB3_FLAGA),
	.FLAGB(USB3_FLAGB),
	.DATA_DIR(DATA_DIR),
	.SLCS(USB3_SLCS),
	.SLOE(USB3_SLOE),
	.SLRD(USB3_SLRD),
	.SLWR(USB3_SLWR),
	.A1(USB3_A1),
	.A0(USB3_A0),
	.usb_rd_cnt(usb_rd_cnt),
	.usb_rd_state(usb_rd_state),
	.usb_wr_cnt(usb_wr_cnt),
	.usb_wr_state(usb_wr_state));
	
assign	data_p2u = 32'haaaaaaaa;
assign	USB3_DQ = DATA_DIR? data_p2u:32'hzzzzzzzz;
assign	data_u2p = DATA_DIR? 32'hzzzzzzzz:USB3_DQ;

assign	USB3_CTL2 = USB3_SLOE;
assign	USB3_CTL3 = USB3_SLRD;
assign	USB3_CTL1 = USB3_SLWR;
assign	USB3_CTL0 = USB3_SLCS;
assign	USB3_CTL11 = USB3_A1;
assign	USB3_CTL12 = USB3_A0;
assign	USB3_PCLK = CLK_100M;
assign	SCLK = SIG_CLK;

assign	USB3_FLAGA = USB3_CTL4;
assign	USB3_FLAGB = USB3_CTL5; 


assign 	RESET_N=1;
endmodule