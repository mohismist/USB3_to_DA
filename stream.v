module stream(
	input clk,
	input rst_n,
	input FLAGA,
	input FLAGB,
	input DATA_DIR,
	
	output reg SLCS,
	output reg SLOE,
	output reg SLRD,
	output reg SLWR,
	output reg A1,
	output reg A0,
	
	output reg [8:0] usb_rd_cnt = 4'b0,
	output reg [3:0] usb_rd_state = 4'b0,
	
	output reg [31:0] usb_wr_cnt = 32'b0,
	output reg [2:0] usb_wr_state = 3'b0
);

reg FLAGB1 = 1'b1;
reg FLAGB2 = 1'b1;

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n) begin
	//usb interface
		SLCS <= 1'b1;
		SLOE <= 1'b1;
		SLRD <= 1'b1;
		SLWR <= 1'b1;
		A0 <= 1'b1;
		A1 <= 1'b1;
		
	//status
		usb_rd_state <= 3'b000;
		usb_rd_cnt <= 9'd0;
		
		usb_wr_state <= 3'b000;
		usb_wr_cnt <= 32'd0;
		
	end
	else begin
		SLCS <= 1'b1;
		SLOE <= 1'b1;
		SLRD <= 1'b1;
		SLWR <= 1'b1;
		if (DATA_DIR==1'b0) begin
			A0 <= 1'b1;
			A1 <= 1'b1;
			FLAGB1 <= FLAGB;
			FLAGB2 <= FLAGB1;
			case (usb_rd_state)
				4'd0,4'd1,4'd2: begin
					usb_rd_cnt <= 9'd0;
					SLCS <= 1'b0;
					usb_rd_state <= usb_rd_state + 4'b1;
				end
				4'd3:	begin
					SLCS <= 1'b0;
					if(FLAGA==1'b1) begin
						usb_rd_state <= usb_rd_state + 4'b1;
						SLOE <= 1'b0;
					end
				end
				4'd4,4'd5: begin
					SLCS <= 1'b0;
					SLOE <= 1'b0;
					usb_rd_state <= usb_rd_state + 4'b1;
				end
				4'd6: begin
					SLCS <= 1'b0;
					SLOE <= 1'b0;
					if(FLAGB1==1'b1) begin
							SLRD <= 1'b0;
							usb_rd_cnt <= usb_rd_cnt + 9'b1;
					end
					else begin
						usb_rd_state <= usb_rd_state + 4'b1;
					end
				end
				4'd12: begin
					usb_rd_state <= 4'd0;
				end
				default:	begin
					usb_rd_state <= usb_rd_state + 4'b1;
				end
			endcase
		end
		else begin
			A0 <= 1'b0;
			A1 <= 1'b0;
		end
	end
end

endmodule
