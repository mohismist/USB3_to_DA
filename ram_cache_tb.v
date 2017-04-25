`timescale 1 ps/ 1 ps
module ram_cache_tb();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
wire rdclock;//10M
reg wrclock;
reg [31:0] data;
reg [8:0]dcount=9'd0;
reg rst_n=1'b1;
wire [31:0] q;
reg [3:0] usb_rd_state=4'd0;
reg USB3_FLAGA=1'b0;

reg[3:0] data_state=4'd0;


localparam DATA_WIDTH_DELAY = 10;

	reg [DATA_WIDTH_DELAY-1:0] delay_ca0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca1;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca2;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca3;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca4;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca5;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca6;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca7;


	wire [15:0] wren;

	wire [7:0] data_ca;
	wire [7:0] data_msg;
  wire [7:0] clk_1023k;
  
  assign clk_1023k[0]=rdclock;
  assign clk_1023k[1]=rdclock;
  assign clk_1023k[2]=rdclock;
  assign clk_1023k[3]=rdclock;
  assign clk_1023k[4]=rdclock;
  assign clk_1023k[5]=rdclock;
  assign clk_1023k[6]=rdclock;
  assign clk_1023k[7]=rdclock;
      
ram_cache_bb cache(
    .wrclock(wrclock),
    .rdclock(rdclock),
    .data(data),
    .q(q),
    .usb_rd_state(usb_rd_state),
    .rst_n(rst_n),
    .USB3_FLAGA(USB3_FLAGA),
    .wren_for_ram(wren)
);

ram_bb ram_inst(
	.clk(wrclock),
	.rst_n(rst_n),
	.data(q),
	
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
wrclock<=1'b0;
forever
# 10 wrclock=~wrclock;
// --> end                                                                   
end 


assign rdclock=wrclock;

always@(posedge wrclock) begin
    case (data_state)
        4'd0:begin
            usb_rd_state<=4'd0;
            USB3_FLAGA<=1'b0;
            dcount<=dcount+1;
            if(dcount==9'd300) begin
              dcount<=9'b0;
              data_state<=4'd3;
            end
        end
        4'd3,4'd4:begin
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd0;
            data_state<=data_state+1;
        end
        4'd5:begin
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            data_state<=data_state+1;
        end
        4'd6:begin
            data<={24'b0,dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            dcount<=dcount+1;
            if(dcount==252) begin
                data_state<=data_state+1;
            end
        end
        4'd7:begin
            data<={24'b0,dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd0;
            dcount<=dcount+1;
            if(dcount==255) begin
                data_state<=data_state+1;
            end
        end
        default:begin
            USB3_FLAGA<=1'b0;
            usb_rd_state<=4'd0;
            data_state<=4'd0;
            dcount<=9'd1;
        end
    endcase
end
endmodule

