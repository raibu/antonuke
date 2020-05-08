`timescale 1ns/1ps



module automat (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input w,
	output logic out1
);

	enum {A, B, C, D, E, F, G, H, I} state, next_state;

	always_ff @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		case (state)
		 	A: next_state = w?F:B;
		 	B: next_state = w?F:C;
		 	C: next_state = w?F:D;
		 	D: next_state = w?F:E;
		 	E: next_state = w?F:E;
		 	F: next_state = w?G:B;
		 	G: next_state = w?H:B;
		 	H: next_state = w?I:B;
		 	I: next_state = w?I:B;
			//implicit default x
		endcase
	end

	always_comb begin
		case (state)
		 	A: out1 = 1'b0;
		 	B: out1 = 1'b0;
		 	C: out1 = 1'b0;
		 	D: out1 = 1'b0;
		 	E: out1 = 1'b1;
		 	F: out1 = 1'b0;
		 	G: out1 = 1'b0;
		 	H: out1 = 1'b0;
		 	I: out1 = 1'b1;
		 	default: out1 = 1'bx;
		endcase
	end

endmodule




module microprog (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input [1:0] x,
	output reg [3:0] y
);

	enum {Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9} state, next_state;

	always_ff @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			state <= Y1;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		case (state)
			Y0: next_state = Y1;
		 	Y1: next_state = Y2;
		 	Y2: next_state = Y3;
		 	Y3: next_state = x[0]?Y4:Y3;
		 	Y4: next_state = Y5;
		 	Y5: next_state = x[1]?Y8:Y6;
		 	Y6: next_state = Y7;
		 	Y7: next_state = Y9;
		 	Y8: next_state = Y9;
		 	Y9: next_state = Y0;
			//implicit default x
		endcase
	end

	always_comb begin
		case (state)
		 	Y0: y = 0;
		 	Y1: y = 1;
		 	Y2: y = 2;
		 	Y3: y = 3;
		 	Y4: y = 4;
		 	Y5: y = 5;
		 	Y6: y = 6;
		 	Y7: y = 7;
		 	Y8: y = 8;
		 	Y9: y = 9;
		 	default: y = 'bx;
		endcase
	end

endmodule






