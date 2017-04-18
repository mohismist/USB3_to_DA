module ram_bb(
    wrclock,
    rdclock,
    data,
    q,
    rd,
    usb_rd_state
);


input [31:0]data;
input	  rdclock;
input	  wrclock;
input usb_rd_state;
input rd;
output	[31:0]  q;

wire wren;

reg	[7:0]  rdaddress;
reg	[7:0]  wraddress;

reg   [3:0]cache_state=4'b0;
ram_cache cache_inst(
    .data(data),
    .rdaddress(rdaddress),
    .rdclock(rdclock),
    .wraddress(wraddress),
    .wrclock(wrclock),
    .wren(wren),
    .q(q));

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n) begin
        rdaddress <= 8'b0;
        wraddress <= 8'b0;
        wren <= 1'b0;
        usb_rd_state <= 4'b0;
    end
    else begin
        wren <= 1'b0;
        case  (cache_state)
            4'd0: begin
                if(usb_rd_state==4'd6) begin
                    wren <= 1'b1;
                    cache_state <= 4'd1;
                end
                if(rd==1'd1) begin
                    cache_state<=4'd2;
                    if(wraddress == 8'd0) begin
                        rdaddress <= 8'd255;
                    end
                    else begin
                        rdaddress <= wraddress - 1;
                    end
                end
            end
            4'd1: begin
                wren <= 1'b1;
                if(wraddress == 8'd255) begin
                    wraddress <= 8'd0;
                end
                else begin
                    wraddress <= wraddress + 1;
                end
                if(usb_rd_state!=4'd6) begin
                    cache_state <= 4'd0;
                end
            end
            4'd2: begin
                if(rdaddress == 8'd255) begin
                    rdaddress <= 8'd0;
                end
                else begin
                    rdaddress <= rdaddress + 1;
                end
                if(rd !=1'd0) begin
                    cache_state <= 1'b0;
                end
            end
        endcase
    end
end
endmodule
