module ram_cache_bb(
    wrclock,
    rdclock,
    data,
    q,
    usb_rd_state,
    rst_n,
    USB3_FLAGA
);


input [31:0]data;
input	  rdclock;
input	  wrclock;
input [3:0]usb_rd_state;
input rst_n;
input USB3_FLAGA;
output	[31:0]  q;

reg wren=1'b0;
reg rden;
reg flag=1'b0;
reg [8:0]  rd_count=9'd0;
reg	[7:0]  rdaddress=8'd0;
reg	[7:0]  wraddress=8'd15;

reg   [3:0]wr_state=4'b0;
reg   [7:0]rd_state=8'd0;
ram_cache cache(
    .data(data),
    .rdaddress(rdaddress),
    .rdclock(rdclock),
    .wraddress(wraddress),
    .wrclock(wrclock),
    .wren(wren),
    .q(q));

always@(posedge wrclock or negedge rst_n)
begin
    if(~rst_n) begin
        wraddress <= 8'b0;
        wren <= 1'b0;
    end
    else begin
        case(wr_state)
            4'd0:begin
                wren <= 1'b0;
                if(usb_rd_state==4'd6) begin
                    wr_state <= wr_state + 1;
						  wren <= 1'b1;
                end
            end
            4'd1,4'd2:begin
                wren <= 1'b1;
                wraddress <= wraddress + 1;
                if(usb_rd_state!=4'd6) begin
                    wr_state <= wr_state+1;
                end
            end
            default:begin
                wren <= 1'b0;
                wr_state <= 4'd0;
            end
        endcase
    end
end

always@(posedge rdclock or negedge rst_n) begin
    if(~rst_n) begin
        rdaddress <=0;
    end
    else begin
        case(rd_state)
            4'd0:begin
                if(wraddress==7'd255)begin
                   rdaddress<=7'd0;
                end
                else begin
                   rdaddress<=wraddress+8'd1;
                end
					 if(rden==1'b1)begin
                    rd_state <= rd_state+1;
                end
            end
            4'd1:begin
                rdaddress<=rdaddress+1;
                if(rden==1'b0)begin
                    rd_state<=rd_state+1;
                end
            end
            default:begin
                rd_state<=4'd0;
            end
        endcase
    end
end

always@(negedge USB3_FLAGA or posedge flag) begin
    if(flag==1'b1) begin
        rden<=1'b0;
    end
    else begin
        rden<=1'b1;
    end
end

reg [3:0]flag_state=4'd0;
always@(posedge rdclock) begin
    case(flag_state)
        4'd0:begin
            flag<=1'b0;
            if(rden==1'b1) begin
                flag_state <= flag_state + 1;
            end
        end
        4'd1:begin
            rd_count <= rd_count + 1;
            if(rd_count > 8'd253) begin
                rd_count<= 8'd0;
                flag<=1'b1;
                flag_state<=flag_state+1;
            end
        end
        default:begin
            flag_state<=4'd0;
            rd_count<=8'd0;
        end
    endcase
end
endmodule
