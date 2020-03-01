`timescale 1ns/1ps

module test;
	reg [3:0] dc;
	reg clk, en, rst;
	wire out;

	lab4_2 pwm(clk, en, rst, dc, out);

	initial begin
		clk <= 0;
		forever #1 clk <= ~clk;
	end


	initial begin 
		en = 0;
		dc = 4'b0;
		rst = 0;
		#5;
		rst = 1;
		#20;
		en = 1;
		#100;
		dc = 4'd8;
		#100;
		dc = 4'd15;
		#100;
		$finish;
	end



endmodule

