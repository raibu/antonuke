`timescale 1ns/1ps







module test;

	localparam WIDTH = 16;
		
	typedef struct packed{
		bit signed [WIDTH-1:0] re, im;
	}comp;

	reg clk;   // Clock
	reg rst_n; // Asynchronous reset active low
	reg signed [WIDTH-1:0] a1, a2, b1, b2;
	reg op, is_complex, use_cop;
	wire signed [WIDTH-1:0] out1, out2;


	covergroup cg();
		option.per_instance = 1;
		option.at_least = 3;
	   	coverpoint op{
	   		bins addmul = {0};
	   		bins subdiv = {1};
	   	}
	   	coverpoint is_complex{
	   		bins complex = {1};
	   		bins coupled = {0};
	   	}
	   	coverpoint use_cop{
	   		bins addsub = {0};
	   		bins muldiv = {1};
	   	}
	   	coverpoint a1[WIDTH-1]{ bins plus = {0}; bins minus = {1}; }
	   	coverpoint b1[WIDTH-1]{ bins plus = {0}; bins minus = {1}; }
	   	coverpoint a2[WIDTH-1]{ bins plus = {0}; bins minus = {1}; }
	   	coverpoint b2[WIDTH-1]{ bins plus = {0}; bins minus = {1}; }
	endgroup : cg
	cg cov;

	mf_alu #(16) alu(clk, rst_n, a1, a2, b1, b2, op, is_complex, use_cop, out1, out2);
	

	initial begin 
		clk = 0;
		rst_n = 0;
		forever #1 clk = !clk;
	end

	initial begin 
		cov = new;
		a1 = 0;
		a2 = 0;
		b1 = 0;
		b2 = 0;
		op = 0;
		is_complex = 0;
		use_cop = 0;
		
		repeat(2) @(posedge clk);
		rst_n = 1;


		@(posedge clk);
		repeat(100) begin 
			a1 = $random(); 
			b1 = $random(); 
			a2 = $random(); 
			b2 = $random(); 
			op = $random();
			is_complex = $random();
			use_cop = $random();


			@(posedge clk);
			cov.sample();
			$display("a1 %d, b1 %d, a2 %d, b2 %d, complex %b, cop %b, op %b",a1, b1, a2, b2, is_complex, use_cop, op);


			//assertions for numbers
			if ({is_complex, use_cop, op} == 3'b000) assert ((out1 == a1+a2) && (out2 == b1+b2)) 
				else $display("+ failed, expected %0x, got %0x", {a1+a2, b1+b2}, {out1, out2});

			if ({is_complex, use_cop, op} == 3'b001) assert ((out1 == a1-a2) && (out2 == b1-b2)) 
				else $display("- failed, expected %0x, got %0x", {a1-a2, b1-b2}, {out1, out2});

			if ({is_complex, use_cop, op} == 3'b010) assert ((out1 == a1*a2) && (out2 == b1*b2)) 
				else $display("* failed, expected %0x, got %0x", {a1*a2, b1*b2}, {out1, out2});

			if ({is_complex, use_cop, op} == 3'b011) assert ((out1 == a1/a2) && (out2 == b1/b2)) 
				else $display("/ failed, expected %0x, got %0x", {a1/a2, b1/b2}, {out1, out2});


			//assertions for complex
			if ({is_complex, use_cop, op} == 3'b100) assert ({out1,out2} == cadd(a1, a2, b1, b2)) 
				else $display("c+ failed, expected %0x, got %0x", cadd(a1, a2, b1, b2), {out1, out2});

			if ({is_complex, use_cop, op} == 3'b101) assert ({out1,out2} == csub(a1, a2, b1, b2)) 
				else $display("c- failed, expected %0x, got %0x", csub(a1, a2, b1, b2), {out1, out2});

			if ({is_complex, use_cop, op} == 3'b110) assert ({out1,out2} == cmul(a1, a2, b1, b2)) 
				else $display("c* failed, expected %0x, got %0x", cmul(a1, a2, b1, b2), {out1, out2});

			if ({is_complex, use_cop, op} == 3'b111) assert ({out1,out2} == cdiv(a1, a2, b1, b2)) 
				else $display("c/ failed, expected %0x, got %0x", cdiv(a1, a2, b1, b2), {out1, out2});

		end

		$display("\033[31;1;4mCOVERAGE %f\033[0m",cov.get_coverage());
		$finish;
	end




	function comp cadd(input signed [WIDTH-1:0] re1, re2, im1, im2);
		comp c;
		c.re = re1+re2;
		c.im = im1+im2;
		return c;
	endfunction : cadd

	function comp csub(input signed [WIDTH-1:0] re1, re2, im1, im2);
		comp c;
		c.re = re1-re2;
		c.im = im1-im2;
		return c;
	endfunction : csub

	function comp cmul(input signed [WIDTH-1:0] re1, re2, im1, im2);
		comp c;
		c.re = re1*re2 - im1*im2;
		c.im = re1*im2 + im1*re2;
		return c;
	endfunction : cmul

	function comp cdiv(input signed [WIDTH-1:0] re1, re2, im1, im2);
		comp c;
		c.re = (re1*re2+im1*im2)/(re2*re2+im2*im2);
		c.im = (im1*re2-re1*im2)/(re2*re2+im2*im2);
		return c;
	endfunction : cdiv







endmodule

