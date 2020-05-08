`timescale 1ns/1ps


//switched to system verilog//
module mac #(parameter D_WD = 32) (
	input clk,    // Clock
	input en,
	input rst_n,  // Asynchronous reset active low
	input [D_WD-1:0] A, B,
	output [D_WD*2-1:0] out
);

reg [D_WD*2-1:0] acc;

always_ff @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		acc <= 0;
	end else begin
		if (en) begin
			acc <= acc + ({{D_WD{1'b0}},A})*({{D_WD{1'b0}},B});
		end else begin 
			acc <= acc;
		end
	end
end

assign out = acc;

endmodule



