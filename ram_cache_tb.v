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

ram_cache_bb cache(
    .wrclock(wrclock),
    .rdclock(rdclock),
    .data(data),
    .q(q),
    .usb_rd_state(usb_rd_state),
    .rst_n(rst_n),
    .USB3_FLAGA(USB3_FLAGA)
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

