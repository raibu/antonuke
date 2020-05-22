`timescale 1ns/1ps


module mf_alu #(parameter WIDTH = 16) (
    input clk,    // Clock
    input rst_n,  // Asynchronous reset active low
    input signed [WIDTH-1:0] a1, a2, b1, b2,
    input op, is_complex, use_cop,
    output logic signed [WIDTH-1:0] out1, out2
);

    wire signed [WIDTH-1:0] res1_add, res2_add;  
    wire signed [WIDTH-1:0] res1_cop, res2_cop;  

    arithm #(WIDTH) ar1(clk, rst_n, a1, a2, b1, b2, op, res1_add, res2_add);
    coproc #(WIDTH) cop(clk, rst_n, a1, a2, b1, b2, op, is_complex, res1_cop, res2_cop);

    assign out1 = use_cop ? res1_cop : res1_add;
    assign out2 = use_cop ? res2_cop : res2_add;



endmodule



module arithm #(parameter WIDTH = 16) (
    input clk,    // Clock
    input rst_n,  // Asynchronous reset active low
    input signed [WIDTH-1:0] a1, a2, b1, b2,
    input addsub,
    output logic signed [WIDTH-1:0] out1, out2
);
    reg signed [WIDTH-1:0] res1, res2; 

    assign res1 = addsub ? (a1-a2) : (a1+a2);
    assign res2 = addsub ? (b1-b2) : (b1+b2);
    
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            {out2, out1} <= '0;
        end else begin
            out1 <= res1;
            out2 <= res2;
        end
    end

endmodule

module coproc #(parameter WIDTH = 16) (
    input clk,    // Clock
    input rst_n,  // Asynchronous reset active low
    input signed [WIDTH-1:0] a1, a2, b1, b2,
    input muldiv, is_complex,
    output logic signed [WIDTH-1:0] out1, out2
);
    reg signed [WIDTH-1:0] res1, res2; 

    always_comb begin 
        case (is_complex)
            0:  case (muldiv)
                    0:  begin   
                            res1 = a1*a2;
                            res2 = b1*b2;
                        end
                    1:  begin
                            res1 = a1/a2;
                            res2 = b1/b2;
                        end
                endcase

            1:  case (muldiv)
                    0:  begin
                            res1 = (a1*a2) - (b1*b2); //re
                            res2 = (a1*b2) + (b1*a2);
                        end
                    1:  begin
                            res1 = ((a1*a2) + (b1*b2))/((a2*a2)+(b2*b2));
                            res2 = ((a2*b1) - (b2*a1))/((a2*a2)+(b2*b2));
                        end
                endcase
        endcase
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            {out2, out1} <= '0;
        end else begin
            out1 <= res1;
            out2 <= res2;
        end
    end


endmodule
