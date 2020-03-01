`timescale 1ns/1ps



module lab3_1(in, ctrl, en, out); //1to8 demux, en active low, hiz on idle
input wire in, en;
input wire [2:0] ctrl;
output reg [7:0] out;	

wire tmp;
assign tmp = (en)?1'bz:1'b0;

always @* begin
	out = {8{tmp}};
	if(!en) out[ctrl] = in;
end


endmodule



module lab3_2(bcd, seg);
    input [3:0] bcd;
    output reg [6:0] seg;

    always @(bcd)
    begin
        case (bcd)	   //pgfedcba
            0 : seg = 8'b11000000;
            1 : seg = 8'b11111001;
            2 : seg = 8'b10100100;
            3 : seg = 8'b10110000;
            4 : seg = 8'b10011001;
            5 : seg = 8'b10010010;
            6 : seg = 8'b10000010;
            7 : seg = 8'b11111000;
            8 : seg = 8'b10000000;
            9 : seg = 8'b10010000;
            10: seg = 8'b10001000;//a
            11: seg = 8'b10000011;//b
            12: seg = 8'b11000110;//c
            13: seg = 8'b10100001;//d
            14: seg = 8'b10000110;//e
            15: seg = 8'b10001110;//f
            default : seg = 8'bz; 
        endcase
    end

endmodule




