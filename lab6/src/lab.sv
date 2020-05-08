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
	
);

endmodule






