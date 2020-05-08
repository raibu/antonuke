`timescale 1ns/1ps



module lab2_1(in1, in2, in3, in4, out);
input wire in1, in2, in3, in4;
output wire out;	

assign out =  ~( 							//nor3
				(~( 						//nand2
					(~(in1 & !in2)) & in3) 	//nand2
				)|
				(~(!in1 | in2 | !in3))| 	//nor3
				(~(in1 | in4)) 				//nor2
				);

endmodule



module lab2_2(x, y, z, out, out2);
input wire x, y, z;
output wire out, out2;	

assign out =  (x & !y) | (y & z) | (x & !z);
assign out2 = x | (y & z);

endmodule




