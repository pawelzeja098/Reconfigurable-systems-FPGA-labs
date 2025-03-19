`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2025 10:59:45 AM
// Design Name: 
// Module Name: tb_lab2
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



module tb_lab2;

    parameter LENGTH = 8; 
    reg [LENGTH-1:0] a;  
    wire c;               
    reg clk = 0;          

    
    lab2 uut (
        .a(a),
        .c(c)
    );

    
    always begin
        #5 clk = ~clk; 
    end

    initial begin
        a = 0; 

        
        repeat (2**LENGTH) begin
            #10 a = a + 1; 
        end

        #10 $finish;
        
        end

endmodule
