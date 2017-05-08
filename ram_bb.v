module ram_bb(
	
	clk,
	rst_n,
	data,
	
	delay_ca0,
	delay_ca1,
	delay_ca2,
	delay_ca3,
	delay_ca4,
	delay_ca5,
	delay_ca6,
	delay_ca7,
	
	clk_1023k,
	wren,
	
	data_ca,
	data_msg
);


	localparam DATA_WIDTH_DELAY = 10;
	
	input clk;
	input rst_n;
	input [31:0] data;

	input [DATA_WIDTH_DELAY-1:0] delay_ca0;
	input [DATA_WIDTH_DELAY-1:0] delay_ca1;
	input [DATA_WIDTH_DELAY-1:0] delay_ca2;
	input [DATA_WIDTH_DELAY-1:0] delay_ca3;
	input [DATA_WIDTH_DELAY-1:0] delay_ca4;
	input [DATA_WIDTH_DELAY-1:0] delay_ca5;
	input [DATA_WIDTH_DELAY-1:0] delay_ca6;
	input [DATA_WIDTH_DELAY-1:0] delay_ca7;

	input [7:0] clk_1023k;
	input [15:0] wren;

	output [7:0] data_ca;
	output [7:0] data_msg;
		
	reg	[4:0] wraddress_ca;
	reg	[5:0] wraddress_msg;
	wire	[9:0] rdaddress_ca [7:0];
	reg	[10:0] rdaddress_msg [7:0];

	reg	[9:0] counter_ca [7:0];

  initial
  begin
	 wraddress_ca= 4'd0;
	 wraddress_msg= 6'd0;

	 rdaddress_msg[0] = 11'd0;
	 rdaddress_msg[1] = 11'd0;
	 rdaddress_msg[2] = 11'd0;
	 rdaddress_msg[3] = 11'd0;
	 rdaddress_msg[4] = 11'd0;
	 rdaddress_msg[5] = 11'd0;
	 rdaddress_msg[6] = 11'd0;
	 rdaddress_msg[7] = 11'd0;

	 counter_ca[0] = 10'd0;
	 counter_ca[1] = 10'd0;
	 counter_ca[2] = 10'd0;
	 counter_ca[3] = 10'd0;
	 counter_ca[4] = 10'd0;
	 counter_ca[5] = 10'd0;
	 counter_ca[6] = 10'd0;
	 counter_ca[7] = 10'd0;
  end 

ram_ca ram_ca0(
	.data(data),
	.rdaddress(rdaddress_ca[0]),
	.rdclock(clk_1023k[0]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[0]),
	.q(data_ca[0]));
	
ram_ca ram_ca1(
	.data(data),
	.rdaddress(rdaddress_ca[1]),
	.rdclock(clk_1023k[1]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[1]),
	.q(data_ca[1]));
	
ram_ca ram_ca2(
	.data(data),
	.rdaddress(rdaddress_ca[2]),
	.rdclock(clk_1023k[2]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[2]),
	.q(data_ca[2]));
	
ram_ca ram_ca3(
	.data(data),
	.rdaddress(rdaddress_ca[3]),
	.rdclock(clk_1023k[3]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[3]),
	.q(data_ca[3]));
	
ram_ca ram_ca4(
	.data(data),
	.rdaddress(rdaddress_ca[4]),
	.rdclock(clk_1023k[4]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[4]),
	.q(data_ca[4]));
	
ram_ca ram_ca5(
	.data(data),
	.rdaddress(rdaddress_ca[5]),
	.rdclock(clk_1023k[5]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[5]),
	.q(data_ca[5]));
	
ram_ca ram_ca6(
	.data(data),
	.rdaddress(rdaddress_ca[6]),
	.rdclock(clk_1023k[6]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[6]),
	.q(data_ca[6]));
	
ram_ca ram_ca7(
	.data(data),
	.rdaddress(rdaddress_ca[7]),
	.rdclock(clk_1023k[7]),
	.wraddress(wraddress_ca),
	.wrclock(clk),
	.wren(wren[7]),
	.q(data_ca[7]));

	
	
ram_msg ram_msg0(
	.data(data),
	.rdaddress(rdaddress_msg[0]),
	.rdclock(clk_1023k[0]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[8]),
	.q(data_msg[0]));
	
ram_msg ram_msg1(
	.data(data),
	.rdaddress(rdaddress_msg[1]),
	.rdclock(clk_1023k[1]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[9]),
	.q(data_msg[1]));
	
ram_msg ram_msg2(
	.data(data),
	.rdaddress(rdaddress_msg[2]),
	.rdclock(clk_1023k[2]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[10]),
	.q(data_msg[2]));
	
ram_msg ram_msg3(
	.data(data),
	.rdaddress(rdaddress_msg[3]),
	.rdclock(clk_1023k[3]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[11]),
	.q(data_msg[3]));
	
ram_msg ram_msg4(
	.data(data),
	.rdaddress(rdaddress_msg[4]),
	.rdclock(clk_1023k[4]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[12]),
	.q(data_msg[4]));
	
ram_msg ram_msg5(
	.data(data),
	.rdaddress(rdaddress_msg[5]),
	.rdclock(clk_1023k[5]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[13]),
	.q(data_msg[5]));
	
ram_msg ram_msg6(
	.data(data),
	.rdaddress(rdaddress_msg[6]),
	.rdclock(clk_1023k[6]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[14]),
	.q(data_msg[6]));
	
ram_msg ram_msg7(
	.data(data),
	.rdaddress(rdaddress_msg[7]),
	.rdclock(clk_1023k[7]),
	.wraddress(wraddress_msg),
	.wrclock(clk),
	.wren(wren[15]),
	.q(data_msg[7]));
	
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		wraddress_ca <= 5'd0;
		wraddress_msg <= 6'd0;
	end
	else if(wren!=16'b0) begin
		if (wraddress_ca >= 5'd31)
			wraddress_ca <= 5'd0;
		else
			wraddress_ca <= wraddress_ca + 1'b1;
		if (wraddress_msg >= 6'd46)
			wraddress_msg <= 6'd0;
		else
			wraddress_msg <= wraddress_msg + 1'b1;
	end
end

always @(posedge clk_1023k[0] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[0] <= 10'd1;
		rdaddress_msg[0] <= 10'd0;
	end
	else begin
		if (counter_ca[0] == 10'd1023)
			counter_ca[0] <= 10'd1;
		else
			counter_ca[0] <= counter_ca[0] + 1'b1;
		if (rdaddress_ca[0] == 10'd1023) begin
			if (rdaddress_msg[0] >= 11'd1499)
				rdaddress_msg[0] <= 11'd0;
			else
				rdaddress_msg[0] <= rdaddress_msg[0] + 1'b1;
		end
	end
end

always @(posedge clk_1023k[1] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[1] <= 10'd1;
		rdaddress_msg[1] <= 10'd0;
	end
	else begin
		if (counter_ca[1] == 10'd1023)
			counter_ca[1] <= 10'd1;
		else
			counter_ca[1] <= counter_ca[1] + 1'b1;
		if (rdaddress_ca[1] == 10'd1023) begin
			if (rdaddress_msg[1] >= 11'd1499)
				rdaddress_msg[1] <= 11'd0;
			else
				rdaddress_msg[1] <= rdaddress_msg[1] + 1'b1;
		end
	end
end 

always @(posedge clk_1023k[2] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[2] <= 10'd1;
		rdaddress_msg[2] <= 10'd0;
	end
	else begin
		if (counter_ca[2] == 10'd1023)
			counter_ca[2] <= 10'd0;
		else
			counter_ca[2] <= counter_ca[2] + 1'b1;
		if (rdaddress_ca[2] == 10'd1022) begin
			if (rdaddress_msg[2] >= 11'd1499)
				rdaddress_msg[2] <= 11'd0;
			else
				rdaddress_msg[2] <= rdaddress_msg[2] + 1'b1;
		end
	end
end 

always @(posedge clk_1023k[3] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[3] <= 10'd1;
		rdaddress_msg[3] <= 10'd0;
	end
	else begin
		if (counter_ca[3] == 10'd1023)
			counter_ca[3] <= 10'd0;
		else
			counter_ca[3] <= counter_ca[3] + 1'b1;
		if (rdaddress_ca[3] == 10'd1023) begin
			if (rdaddress_msg[3] >= 11'd1499)
				rdaddress_msg[3] <= 11'd0;
			else
				rdaddress_msg[3] <= rdaddress_msg[3] + 1'b1;
		end
	end
end 

always @(posedge clk_1023k[4] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[4] <= 10'd1;
		rdaddress_msg[4] <= 10'd0;
	end
	else begin
		if (counter_ca[4] == 10'd1023)
			counter_ca[4] <= 10'd0;
		else
			counter_ca[4] <= counter_ca[4] + 1'b1;
		if (rdaddress_ca[4] == 10'd1023) begin
			if (rdaddress_msg[4] >= 11'd1499)
				rdaddress_msg[4] <= 11'd0;
			else
				rdaddress_msg[4] <= rdaddress_msg[4] + 1'b1;
		end
	end
end 

always @(posedge clk_1023k[5] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[5] <= 10'd1;
		rdaddress_msg[5] <= 10'd0;
	end
	else begin
		if (counter_ca[5] == 10'd1023)
			counter_ca[5] <= 10'd0;
		else
			counter_ca[5] <= counter_ca[5] + 1'b1;
		if (rdaddress_ca[5] == 10'd1023) begin
			if (rdaddress_msg[5] >= 11'd1499)
				rdaddress_msg[5] <= 11'd0;
			else
				rdaddress_msg[5] <= rdaddress_msg[5] + 1'b1;
		end
	end
end 

always @(posedge clk_1023k[6] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[6] <= 10'd1;
		rdaddress_msg[6] <= 10'd0;
	end
	else begin
		if (counter_ca[6] == 10'd1023)
			counter_ca[6] <= 10'd0;
		else
			counter_ca[6] <= counter_ca[6] + 1'b1;
		if (rdaddress_ca[6] == 10'd1023) begin
			if (rdaddress_msg[6] >= 11'd1499)
				rdaddress_msg[6] <= 11'd0;
			else
				rdaddress_msg[6] <= rdaddress_msg[6] + 1'b1;
		end
	end
end 

always @(posedge clk_1023k[7] or negedge rst_n) begin
	if(~rst_n) begin
		counter_ca[7] <= 10'd1;
		rdaddress_msg[7] <= 10'd0;
	end
	else begin
		if (counter_ca[7] == 10'd1023)
			counter_ca[7] <= 10'd0;
		else
			counter_ca[7] <= counter_ca[7] + 1'b1;
		if (rdaddress_ca[7] == 10'd1023) begin
			if (rdaddress_msg[7] >= 11'd1499)
				rdaddress_msg[7] <= 11'd0;
			else
				rdaddress_msg[7] <= rdaddress_msg[7] + 1'b1;
		end
	end
end 

assign	rdaddress_ca[0] = (counter_ca[0] >=(delay_ca0+1))?(counter_ca[0]-delay_ca0):(10'd1024-delay_ca0+counter_ca[0]);
assign	rdaddress_ca[1] = (counter_ca[1] >=(delay_ca1+1))?(counter_ca[1]-delay_ca1):(10'd1024-delay_ca1+counter_ca[1]);
assign	rdaddress_ca[2] = (counter_ca[2] >=(delay_ca2+1))?(counter_ca[2]-delay_ca2):(10'd1024-delay_ca2+counter_ca[2]);
assign	rdaddress_ca[3] = (counter_ca[3] >=(delay_ca3+1))?(counter_ca[3]-delay_ca3):(10'd1024-delay_ca3+counter_ca[3]);
assign	rdaddress_ca[4] = (counter_ca[4] >=(delay_ca4+1))?(counter_ca[4]-delay_ca4):(10'd1024-delay_ca4+counter_ca[4]);
assign	rdaddress_ca[5] = (counter_ca[5] >=(delay_ca5+1))?(counter_ca[5]-delay_ca5):(10'd1024-delay_ca5+counter_ca[5]);
assign	rdaddress_ca[6] = (counter_ca[6] >=(delay_ca6+1))?(counter_ca[6]-delay_ca6):(10'd1024-delay_ca6+counter_ca[6]);
assign	rdaddress_ca[7] = (counter_ca[7] >=(delay_ca7+1))?(counter_ca[7]-delay_ca7):(10'd1024-delay_ca7+counter_ca[7]);


endmodule
