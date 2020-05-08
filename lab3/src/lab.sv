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
    output reg [7:0] seg;
    
    parameter   dig0 = 8'b11000000,
                dig1 = 8'b11111001,
                dig2 = 8'b10100100,
                dig3 = 8'b10110000,
                dig4 = 8'b10011001,
                dig5 = 8'b10010010,
                dig6 = 8'b10000010,
                dig7 = 8'b11111000,
                dig8 = 8'b10000000,
                dig9 = 8'b10010000,
                diga = 8'b10001000,
                digb = 8'b10000011,
                digc = 8'b11000110,
                digd = 8'b10100001,
                dige = 8'b10000110,
                digf = 8'b10001110;

    always @(bcd)
    begin
        case (bcd)	   //pgfedcba
            0 : seg = dig0;
            1 : seg = dig1;
            2 : seg = dig2;
            3 : seg = dig3;
            4 : seg = dig4;
            5 : seg = dig5;
            6 : seg = dig6;
            7 : seg = dig7;
            8 : seg = dig8;
            9 : seg = dig9;
            10: seg = diga;//a
            11: seg = digb;//b
            12: seg = digc;//c
            13: seg = digd;//d
            14: seg = dige;//e
            15: seg = digf;//f
            default : seg = 8'bz; 
        endcase
    end

endmodule




