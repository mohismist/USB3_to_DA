`timescale 1 ps/ 1 ps
module ram_cache_tb();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg rdclock=0;//10M
reg wrclock=0;
reg [31:0] data;
reg [19:0]dcount=20'd0;
reg rst_n=1'b1;
wire [31:0] q;
reg [3:0] usb_rd_state=4'd0;
reg USB3_FLAGA=1'b0;

reg[6:0] data_state=7'd0;


localparam DATA_WIDTH_DELAY = 10;


wire [23:0] wren;

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

wire	[31:0]  clk_carrier0;
wire	[31:0]  clk_carrier1;
wire	[31:0]  clk_carrier2;
wire	[31:0]  clk_carrier3;
wire	[31:0]  clk_carrier4;
wire	[31:0]  clk_carrier5;
wire	[31:0]  clk_carrier6;
wire	[31:0]  clk_carrier7;

wire	[31:0] delay_ca0; 
wire	[31:0] delay_ca1; 
wire	[31:0] delay_ca2; 
wire	[31:0] delay_ca3; 
wire	[31:0] delay_ca4; 
wire	[31:0] delay_ca5; 
wire	[31:0] delay_ca6; 
wire	[31:0] delay_ca7; 


ram_cache_bb cache(
    .wrclock(wrclock),
    .rdclock(wrclock),
    .data(data),
    .q(q),
    .usb_rd_state(usb_rd_state),
    .rst_n(rst_n),
    .USB3_FLAGA(USB3_FLAGA),
    .wren_out(wren)
);

ram_bb ram_inst(
    .clk(wrclock),
    .rst_n(rst_n),
    .data(q),


    .clk_1023k(wrclock),
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
    .pha_1023k7(pha_1023k7)
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
        7'd0:begin
            usb_rd_state<=4'd0;
            USB3_FLAGA<=1'b0;
            dcount<=dcount+1;
            if(dcount==20'd511) begin
                dcount<=20'b0;
                data_state<=7'd3;
            end
        end
        7'd3,4'd4:begin
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd0;
            data_state<=data_state+1;
        end
        7'd5:begin
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            data_state<=data_state+1;
        end
        7'd6:begin
            data<={24'b0,dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            dcount<=dcount+1;
            if(dcount==252) begin
                data_state<=data_state+1;
            end
        end
        7'd7:begin
            data<={24'b0,dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd0;
            dcount<=dcount+1;
            if(dcount==255) begin
                data<={8'hff,16'h00aa,8'haa};
                data_state<=data_state+1;
                dcount<=0;
            end
        end
        7'd8:begin
            USB3_FLAGA<=1'b0;
            usb_rd_state<=4'd0;
            dcount<=dcount+1;
            if(dcount==20'd1024) begin
                dcount<=20'b0;
                data_state<=7'd9;
            end
        end
        7'd9,7'd10:begin
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd0;
            data_state<=data_state+1;
        end
        7'd11:begin
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            data_state<=data_state+1;
        end
        7'd12:begin
            data<={24'b0,8'd255-dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd6;
            dcount<=dcount+1;
            if(dcount==252) begin
                data_state<=data_state+1;
            end
        end
        7'd13:begin
            data<={24'b0,8'd255-dcount[7:0]};
            USB3_FLAGA<=1'b1;
            usb_rd_state<=4'd0;
            dcount<=dcount+1;
            if(dcount==255) begin
                data<={24'b0,8'd255-dcount[7:0]};
                data_state<=data_state+1;
            end
        end
        default:begin
            USB3_FLAGA<=1'b0;
            usb_rd_state<=4'd0;
            data_state<=4'd14;
            dcount<=0;
        end

    endcase
end
endmodule

