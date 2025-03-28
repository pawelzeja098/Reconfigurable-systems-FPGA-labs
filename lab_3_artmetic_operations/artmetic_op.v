`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 10:09:46
// Design Name: 
// Module Name: artmetic_op
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module artmetic_op(
    input clk,
    input ce,
    input [10:0] A,
    input [10:0] B,
    input [10:0] C,
    
    output [22:0] Y
    );
    
    wire signed [10:0] S;
    wire signed [22:0] P;
    reg signed [22:0] Y_reg = 23'sb000_00000000000000000000;
    
    
    
    //latency 2 mod add
    c_addsub_0 addsub_inst(
        .A(A),
        .B(B),
        .clk(clk),
        .ce(ce),
        .S(S)
        );
    
    mult_gen_0 mult_inst(
        .A(S),
        .B(C),
        .clk(clk),
        .ce(ce),
        .P(P)
    );
    
    always @(posedge clk) begin
        if (ce) begin
            Y_reg <= P;
        
        end
        
    
    end
    
    assign Y = Y_reg;
endmodule
