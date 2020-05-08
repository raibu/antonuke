`timescale 1ns/1ps

module test;
	localparam D_WD = 8;
	reg clk, en, rst_n;
	reg [D_WD-1:0] A, B;
	wire [D_WD*2-1:0] out;

	mac #(.D_WD(D_WD)) dut(clk, en, rst_n, A, B, out);

	initial begin 
		clk = 1'b0;
		forever #1 clk = ~clk;
	end 

	initial begin 
		rst_n = 1'b1;
		en=1'b0;
		A = 0;
		B = 0;
		#5 rst_n = 1'b0;
		#5 rst_n = 1'b1;
		A = 2;
		B = 14;
		#5 en = 1'b1;
		#5 B = 5;
		#10 $finish;
	end

endmodule

