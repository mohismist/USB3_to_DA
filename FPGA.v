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
		
	//GPIF II
	input USB3_CTL4,	//FLAGA
	input USB3_CTL5,	//FLAGB
	input [31:0] USB3_DQ,
	
	output USB3_CTL2,	//SLOE 输出使能信号，其唯一功能是驱动数据总线
	output USB3_CTL3,	//SLRD
	output USB3_CTL1,	//SLWR
	output USB3_CTL0,	//SLCS
	output USB3_PCLK,	//100M
	output USB3_CTL11,
	output USB3_CTL12,
	
	output [13:0] DAC1,
	output [13:0] DAC2,
	output [13:0] DAC3,
	output [13:0] DAC4,
//	output [13:0] DAC5,
//	output [13:0] DAC6,
//	output [13:0] DAC7,
//	output [13:0] DAC8,
	
	output DAC_CLK
	
	);
	
wire [7:0] data_ca;	
wire [7:0] clk_1023k;
// clocks
wire	CLK_100M;
wire	SCLK;

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
wire	[13:0] usb_rd_cnt;
wire	[3:0] usb_rd_state;

wire	[31:0] data_u2p;
wire	[31:0] data_p2u;
wire	RESET_N;
// 8 channel NCO

wire	[31:0] fre_carrier0;
wire	[31:0] fre_carrier1;
wire	[31:0] fre_carrier2;
wire	[31:0] fre_carrier3;
wire	[31:0] fre_carrier4;
wire	[31:0] fre_carrier5;
wire	[31:0] fre_carrier6;
wire	[31:0] fre_carrier7;

wire	[31:0] fre_1023k0; 
wire	[31:0] fre_1023k1; 
wire	[31:0] fre_1023k2; 
wire	[31:0] fre_1023k3; 
wire	[31:0] fre_1023k4; 
wire	[31:0] fre_1023k5; 
wire	[31:0] fre_1023k6; 
wire	[31:0] fre_1023k7; 

wire	[31:0] pha_1023k0;
wire	[31:0] pha_1023k1;
wire	[31:0] pha_1023k2;
wire	[31:0] pha_1023k3;
wire	[31:0] pha_1023k4;
wire	[31:0] pha_1023k5;
wire	[31:0] pha_1023k6;
wire	[31:0] pha_1023k7;
wire clk_1k;

localparam DAC_WIDTH = 14;

wire	[DAC_WIDTH-1:0]  clk_carrier0;
wire	[DAC_WIDTH-1:0]  clk_carrier1;
wire	[DAC_WIDTH-1:0]  clk_carrier2;
wire	[DAC_WIDTH-1:0]  clk_carrier3;
wire	[DAC_WIDTH-1:0]  clk_carrier4;
wire	[DAC_WIDTH-1:0]  clk_carrier5;
wire	[DAC_WIDTH-1:0]  clk_carrier6;
wire	[DAC_WIDTH-1:0]  clk_carrier7;

wire	[23:0] wren;

wire	[7:0] data_msg;
wire  [31:0] data_cache;

// pll, 10MHz input, 100MHz output
hnr_pll pll_inst(
	.inclk0(CLK_IN),
	.c0(SCLK),
	.c1(CLK_100M),
	.locked(pll_lock));

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
	.usb_rd_state(usb_rd_state));

NCO_bb	nco_inst(
	.clk(CLK_100M),
	.rst_n(RESET_N),
	
	.fre_carrier0(fre_carrier0[27:0]),
	.fre_1023k0(fre_1023k0[27:0]),
	.pha_1023k0(pha_1023k0[27:0]),
	
	.fre_carrier1(fre_carrier1[27:0]),
	.fre_1023k1(fre_1023k1[27:0]),
	.pha_1023k1(pha_1023k1[27:0]),
	
	.fre_carrier2(fre_carrier2[27:0]),
	.fre_1023k2(fre_1023k2[27:0]),
	.pha_1023k2(pha_1023k2[27:0]),
	
	.fre_carrier3(fre_carrier3[27:0]),
	.fre_1023k3(fre_1023k3[27:0]),
	.pha_1023k3(pha_1023k3[27:0]),
	
	.fre_carrier4(fre_carrier4[27:0]),
	.fre_1023k4(fre_1023k4[27:0]),
	.pha_1023k4(pha_1023k4[27:0]),
	
	.fre_carrier5(fre_carrier5[27:0]),
	.fre_1023k5(fre_1023k5[27:0]),
	.pha_1023k5(pha_1023k5[27:0]),
	
	.fre_carrier6(fre_carrier6[27:0]),
	.fre_1023k6(fre_1023k6[27:0]),
	.pha_1023k6(pha_1023k6[27:0]),
	
	.fre_carrier7(fre_carrier7[27:0]),
	.fre_1023k7(fre_1023k7[27:0]),
	.pha_1023k7(pha_1023k7[27:0]),
	
	.clk_1023k(clk_1023k),
	
	.clk_carrier0(clk_carrier0),	
	.clk_carrier1(clk_carrier1),
	.clk_carrier2(clk_carrier2),
	.clk_carrier3(clk_carrier3),
	.clk_carrier4(clk_carrier4),
	.clk_carrier5(clk_carrier5),
	.clk_carrier6(clk_carrier6),
	.clk_carrier7(clk_carrier7)
	);

ram_bb	ram_inst(
	.clk(CLK_100M),
	.rst_n(RESET_N),
	.data(data_cache),
		
	.clk_1023k(clk_1023k),
	.wren(wren),
	.data_ca(data_ca),
	.data_msg(data_msg),
	.fre_carrier0(fre_carrier0),
	.fre_1023k0(fre_1023k0),
	.pha_1023k0(pha_1023k0),
	
	.fre_carrier1(fre_carrier1),
	.fre_1023k1(fre_1023k1),
	.pha_1023k1(pha_1023k1),
	
	.fre_carrier2(fre_carrier2),
	.fre_1023k2(fre_1023k2),
	.pha_1023k2(pha_1023k2),
	
	.fre_carrier3(fre_carrier3),
	.fre_1023k3(fre_1023k3),
	.pha_1023k3(pha_1023k3),
	
	.fre_carrier4(fre_carrier4),
	.fre_1023k4(fre_1023k4),
	.pha_1023k4(pha_1023k4),
	
	.fre_carrier5(fre_carrier5),
	.fre_1023k5(fre_1023k5),
	.pha_1023k5(pha_1023k5),
	
	.fre_carrier6(fre_carrier6),
	.fre_1023k6(fre_1023k6),
	.pha_1023k6(pha_1023k6),
	
	.fre_carrier7(fre_carrier7),
	.fre_1023k7(fre_1023k7),
	.pha_1023k7(pha_1023k7),
	.clk_1k(clk_1k)
	);
	
ram_cache_bb cache_inst(
    .wrclock(USB3_PCLK),
    .rdclock(CLK_100M),
    .data(USB3_DQ),
    .q(data_cache),
    .usb_rd_state(usb_rd_state),
	 .rst_n(RESET_N),
	 .USB3_FLAGA(USB3_FLAGA),
	 .wren_out(wren),
	 .clk_1k(clk_1k)
);

assign	data_p2u = 32'd15;
assign	data_u2p = DATA_DIR? 32'hzzzzzzzz:USB3_DQ;

assign	USB3_CTL2 = USB3_SLOE;
assign	USB3_CTL3 = USB3_SLRD;
assign	USB3_CTL1 = USB3_SLWR;
assign	USB3_CTL0 = USB3_SLCS;
assign	USB3_CTL11 = USB3_A1;
assign	USB3_CTL12 = USB3_A0;
assign	USB3_PCLK = CLK_100M;

assign	USB3_FLAGA = USB3_CTL4;
assign	USB3_FLAGB = USB3_CTL5; 

assign	DAC1 = (data_ca[0]^data_msg[0])? ~clk_carrier0:clk_carrier0;
assign	DAC2 = (data_ca[1]^data_msg[1])? ~clk_carrier1:clk_carrier1;
assign	DAC3 = (data_ca[2]^data_msg[2])? ~clk_carrier2:clk_carrier2;
assign	DAC4 = (data_ca[3]^data_msg[3])? ~clk_carrier3:clk_carrier3;
//assign	DAC5 = 14'd0;
//assign	DAC6 = 14'd0;
//assign	DAC7 = 14'd0;
//assign	DAC8 = 14'd0;

assign 	DAC_CLK = CLK_100M;
endmodule
