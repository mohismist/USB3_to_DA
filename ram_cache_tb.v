`timescale 1 ps/ 1 ps
module ram_cache_tb();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg rdclock=0;//10M
reg wrclock=0;
reg [31:0] data;
reg [8:0]dcount=9'd0;
reg rst_n=1'b1;
wire [31:0] q;
reg [3:0] usb_rd_state=4'd0;
reg USB3_FLAGA=1'b0;

reg[3:0] data_state=4'd0;


localparam DATA_WIDTH_DELAY = 10;

	reg [DATA_WIDTH_DELAY-1:0] delay_ca0=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca1=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca2=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca3=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca4=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca5=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca6=0;
	reg [DATA_WIDTH_DELAY-1:0] delay_ca7=0;


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
    .rdclock(wrclock),
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
	
	.clk_1023k(rdclock),
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

reg [4:0]count_t=5'd0;
always@(posedge wrclock) begin
  if(count_t==5'd10) begin
    count_t<=5'd0;
    rdclock<=~rdclock;
  end
  else begin
    count_t<=count_t+1;
  end     
end

always@(posedge wrclock) begin
    case (data_state)
        4'd0:begin
            usb_rd_state<=4'd0;
            USB3_FLAGA<=1'b0;
            dcount<=dcount+1;
            if(dcount==9'd511) begin
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
            data<=32'hAAAAAAAA;//{24'b0,dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            dcount<=dcount+1;
            if(dcount==252) begin
                data_state<=data_state+1;
            end
        end
        4'd7:begin
            data<=32'hAAAAAAAA;//{24'b0,dcount[7:0]};
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

