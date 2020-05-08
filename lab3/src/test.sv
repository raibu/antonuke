`timescale 1ns/1ps

module test;
	reg [3:0] led_ctrl;
	wire [7:0] led_out;
	lab3_2 dut(led_ctrl, led_out);
	
	integer i;


	reg demux_in, demux_en;
	reg [2:0] demux_ctrl;
	wire [7:0] demux_out;

	lab3_1 demux(demux_in, demux_en, demux_ctrl, demux_out);

	initial begin 
		demux_in = 1'b0;
		demux_en = 1'b0;
		for (i = 0; i < 8; i=i+1) begin
			demux_ctrl <= i;
			#4;
		end
		demux_in = 1'b1;
		demux_en = 1'b0;
		for (i = 0; i < 8; i=i+1) begin
			demux_ctrl <= i;
			#4;
		end
		demux_in = 1'b0;
		demux_en = 1'b1;
		for (i = 0; i < 8; i=i+1) begin
			demux_ctrl <= i;
			#4;
		end
		demux_in = 1'b1;
		demux_en = 1'b1;
		for (i = 0; i < 8; i=i+1) begin
			demux_ctrl <= i;
			#4;
		end
		for (i = 0; i < 16; i=i+1) begin
			led_ctrl <= i;
			#4;
		end
		$finish;
	end


endmodule

