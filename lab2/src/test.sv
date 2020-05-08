`timescale 1ns/1ps

module test;
	reg [3:0] in;
	wire out, out2;
	lab2_2 dut(in[0], in[1], in[2], out, out2);
	
	integer i;
	initial begin 
		for (i = 0; i < 8; i=i+1) begin
			in <= i;
			#4;
		end
	$finish;
	end
endmodule

