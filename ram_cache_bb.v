module ram_cache_bb(
    wrclock,
    rdclock,
    data,
    q,
    usb_rd_state,
    rst_n,
    USB3_FLAGA,
    wren_out
);


input [31:0]data;
input	  rdclock;
input	  wrclock;
input [3:0]usb_rd_state;
input rst_n;
input USB3_FLAGA;
output	[31:0]  q;
output [23:0]wren_out;

reg [23:0]wren_for_ram;
reg wren=1'b0;
reg rden;
reg flag=1'b0;
reg [8:0]  rd_count=9'd0;
reg	[7:0]  rdaddress=8'd0;
reg	[7:0]  wraddress=8'd15;
reg [4:0]  pack_type=5'd0;
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
            4'd1:begin
                wren <= 1'b1;
                wraddress <= wraddress + 1;
                if(usb_rd_state!=4'd6) begin
                    wr_state <= wr_state+1;
                end
            end
				4'd2:begin
                wren <= 1'b0;
                if(usb_rd_state!=4'd6) begin
                    wr_state <= wr_state+1;
                end
            end
            4'd3:begin
                wren <=1'b0;
                wr_state <= 4'd0;
                if((data&32'hff0000ff)==32'hff0000aa) begin
                    case(data[23:8])
                        16'h0000: begin
                            pack_type<=5'd1;//下一个包为C/A码
                        end
                        16'h000a: begin
                            pack_type<=5'd2;
                        end
                        16'h00aa: begin
                            pack_type<=5'd5;
                        end
                        16'h0aaa: begin
                            pack_type<=5'd3;
                        end
                        16'haaaa: begin
                            pack_type<=5'd4;
                        end
                    endcase
                end
                else begin
                    case(pack_type)
                        5'd1,5'd2,5'd2,5'd4,5'd5:begin
                            pack_type<=pack_type+5'd5;
                        end
                        5'd6,5'd7,5'd8,5'd9:begin
                            pack_type<=5'd0;
                        end
                        5'd10,5'd11,5'd12,5'd13,5'd14,5'd15,5'd16:begin
                            pack_type<=pack_type+5'd1;
                        end
                        5'd17:begin
                            pack_type<=5'd0;
                        end
                        default:begin
                            pack_type<=5'd0;
                        end
                    endcase
                end
            end
            default:begin
                wren <= 1'b0;
                wr_state <= 4'd0;
            end
        endcase
    end
end

reg wren_flag=0;
always@(posedge rdclock or negedge rst_n) begin
    if(~rst_n) begin
        rdaddress <=0;
    end
    else begin
        case(rd_state)
            4'd0:begin
                wren_flag<=1'b0;
                if(rden==1'b1)begin
                    rd_state <= rd_state+1;           
                    rdaddress<=wraddress+8'd1;
                end
            end
            4'd1:begin
                //rdaddress<=rdaddress+1;
                wren_flag<=1'b1;
                //wren_flag置1比开始传出数据早一个周期，方便通信协议部分的时序同步
                rd_state<=rd_state+1;
            end
            4'd2:begin
                rdaddress<=rdaddress+1;
                wren_flag<=1'b1;
                if(rden==1'b0)begin
                    rd_state<=rd_state+1;
                end
            end
            4'd3:begin
                rd_state<=rd_state+1;
                //wren_flag置0比结束数据传出早一个周期
                wren_flag<=1'd0;
            end
            default:begin
                rd_state<=4'd0;
                wren_flag<=1'b0;
            end
        endcase
    end
end

//通信协议的具体实现
reg [9:0] com_state=10'b0;
reg [5:0] com_count=6'b0;
always@(posedge rdclock or negedge rst_n)begin
    if(!rst_n) begin
        wren_for_ram<=16'b0;
        com_state<=10'b0;
    end
    else begin
        case(com_state)
            10'd0:begin
                wren_for_ram<=16'b0;
                if(wren_flag==1'b1) begin
                    case(pack_type)
                        5'd6:begin
                            wren_for_ram<=24'h000001;
                            com_state<=10'd1;
                        end
                        5'd7:begin
                            wren_for_ram<=24'h000100;
                            com_state<=10'd9;
                        end
                        5'd10,5'd11,5'd12,5'd13,5'd14,5'd15,5'd16,5'd17:begin
                            com_state<=10'd18;
                            wren_for_ram<={8'b1<<(pack_type-10),16'h0};
                        end
                        default:begin
                            wren_for_ram<=16'b0;
                            com_state<=10'd0;
                        end
                    endcase
                end
            end
            10'd1,10'd2,10'd3,10'd4,10'd5,10'd6,10'd7:begin
                if(com_count==6'd31) begin
                    com_count<=6'b0;
                    wren_for_ram<={16'h00,8'b0000_0001<<com_state};
                    com_state<=com_state+10'b1;
                end
                else begin
                    wren_for_ram<={16'h00,8'b0000_0001<<(com_state-1)};
                    com_count<=com_count+6'b1;
                end
            end
            10'd8:begin
                if(com_count==6'd31) begin
                    com_count<=6'b0;
                    com_state<=10'd0;
                    wren_for_ram<=24'h0;
                end
                else begin
                    wren_for_ram<={16'h00,8'b1000_0000};
                    com_count<=com_count+6'd1;
                end
            end
            10'd9,10'd10,10'd11,10'd12,10'd13,10'd14,10'd15:begin
                if(com_count==6'd9) begin
                    com_count<=6'b0;
                    wren_for_ram<={8'h00,8'b0000_0001<<(com_state-8),8'h00};
                    com_state<=com_state+10'b1;
                end
                else begin
                    wren_for_ram<={8'h00,8'b0000_0001<<(com_state-9),8'h00};
                    com_count<=com_count+6'b1;
                end
            end
            10'd16:begin
                if(com_count==6'd9) begin
                    com_count<=6'b0;
                    com_state<=10'd17;
                    wren_for_ram<=24'h0;
                end
                else begin
                    wren_for_ram<={8'h00,8'b1000_0000,8'h00};
                    com_count<=com_count+6'b1;
                end
            end
            10'd17:begin
              wren_for_ram<=24'h0;
              com_count<=6'b0;
              if(wren_flag==1'b0)
                com_state<=6'b0;
            end
            10'd18:begin
                if(wren_flag==1'b1) begin
                    wren_for_ram<={8'b1<<(pack_type-10),16'h0};
                end
                else begin
                    wren_for_ram<=24'h0;
                    com_state<=10'd0;
                end
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


assign wren_out = wren_for_ram;

endmodule

