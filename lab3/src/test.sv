`timescale 1ns/1ps

module test;
	reg in, en;
	reg [2:0] ctrl;
	wire [7:0] out;
	lab3_1 dut(in, ctrl, en, out);
	
	integer i;
	initial begin 
		in=0;
		en=1;
		for (i = 0; i < 8; i=i+1) begin
			ctrl <= i;
			#4;
		end

		in=0;
		en=0;
		for (i = 0; i < 8; i=i+1) begin
			ctrl <= i;
			#4;
		end

		in=1;
		en=1;
		for (i = 0; i < 8; i=i+1) begin
			ctrl <= i;
			#4;
		end

		in=1;
		en=0;
		for (i = 0; i < 8; i=i+1) begin
			ctrl <= i;
			#4;
		end

	$finish;
	end
endmodule

