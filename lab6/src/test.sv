`timescale 1ns/1ps

module test;
	reg clk, frst_n, w;
	wire out1;

	automat fsm(clk, frst_n, w, out1);

	reg[31:0] test_seq = 'b1010_1100_1110_0011_1100_0000_1111_1101;
	//expected 			 ABFBFB FGBC FGHB CDFG HIBC DEEE FGHI IIBF
	//out 				 000000 0000 0000 0000 0100 0111 0001 1100

	reg mrst_n;
	reg [1:0] x;
	wire [3:0] y;
	microprog mp(clk, mrst_n, x, y);

	initial begin 
		clk = '0;
		forever #1 clk = !clk;
	end

	initial begin 
		mrst_n=0;
		x=0;
		frst_n = 1;
		w=0;
		#5 frst_n = 0;
		#3 frst_n = 1;
		repeat(32) #2 {w,test_seq} <= {test_seq, 1'b0};
		frst_n=0;
		#2 mrst_n = 1;
		#10 x[0]=1;
		#20 x[1]=1;
		#20 x[0]=0;
		#10 $finish;

	end


endmodule

