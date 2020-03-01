`timescale 1ns/1ps



module lab4_1(clk, we, addr, wd, rd);
	input wire clk, we;
	input wire [7:0] addr, wd;
	output wire [7:0] rd;

	parameter capacity = 16;
	localparam addr_width = $clog2(capacity);

	wire [addr_width-1:0] addr_stripped = addr[0+:addr_width];
	logic [7:0] RAM [capacity-1:0];

	integer i;
	initial begin 
		for (i = 0; i < capacity; i=i+1) begin
			RAM[i]='0;
		end
	end
	
	always @(posedge clk)
		if (we) RAM[addr_stripped] <= wd;
		

	assign rd = RAM[addr_stripped];

endmodule



module lab4_2(clk, en, rst, dc, out);

input           clk;
input   		en, rst;
input   [3:0] 	dc;
output   		out;

reg     [3:0]   cnt_ff;

always @(posedge clk, negedge rst) begin 
	if(!rst) cnt_ff<=0;
	else if(en) cnt_ff <= cnt_ff + 1'b1;
end



assign out = (cnt_ff < dc);

endmodule




