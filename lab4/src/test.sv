`timescale 1ns/1ps

module test;
	reg [3:0] pwm_dc;
	reg clk, pwm_en, pwm_rst;
	wire pwm_out;

	reg ram_we;
	reg [7:0] ram_addr, ram_wd;
	wire [7:0] ram_rd;

	lab4_2 pwm(clk, pwm_en, pwm_rst, pwm_dc, pwm_out);


	lab4_1 mem(clk, ram_we, ram_addr, ram_wd, ram_rd);

	initial begin
		clk <= 0;
		forever #1 clk <= ~clk;
	end


	initial begin 
		ram_we = 1'b0
		ram_addr = '0;
		ram_wd = '0;
		//pwm test
		pwm_en = 0;
		pwm_dc = 4'b0;
		pwm_rst = 0;
		#5;
		pwm_rst = 1;
		#20;
		pwm_en = 1;
		#100;
		pwm_dc = 4'd8;
		#100;
		pwm_dc = 4'd15;
		#100;

		//mem test
		ram_addr = 'h14;
		#5;
		ram_wd = 'h21;
		ram_we = 1'b1;
		#5;
		ram_we = 1'b0;
		#5;
		ram_addr = 'h16;
		#5;
		$finish;
	end



endmodule

