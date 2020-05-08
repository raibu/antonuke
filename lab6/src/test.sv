`timescale 1ns/1ps

module test;
	reg clk, rst_n, w;
	wire out1;

	automat fsm(clk, rst_n, w, out1);

	reg[31:0] test_seq = 'b1010_1100_1110_0011_1100_0000_1111_1101;
	//expected 			 ABFBFB FGBC FGHB CDFG HIBC DEEE FGHI IIBF
	//out 				 000000 0000 0000 0000 0100 0111 0001 1100
	initial begin 
		clk = '0;
		forever #1 clk = !clk;
	end

	initial begin 
		rst_n = 1;
		w=0;
		#5 rst_n = 0;
		#3 rst_n = 1;
		repeat(32) #2 {w,test_seq} <= {test_seq, 1'b0};
		#2 $finish;
	end


endmodule

