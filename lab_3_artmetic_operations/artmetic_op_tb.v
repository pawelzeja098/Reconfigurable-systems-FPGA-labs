`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 12:24:20
// Design Name: 
// Module Name: artmetic_op_tb
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


module artmetic_op_tb;

    reg clk;
    reg ce;
    //1.9
    wire signed [10:0] A, B, C, D;
    //3.18
    wire signed [22:0] Y;
    
    reg signed [10:0] A_reg,B_reg, C_reg, D_reg;
    


//    reg signed [9:0] C_delay;
    
    assign A = A_reg;
    assign B = B_reg;
    assign D = D_reg;
//    assign C = C_reg;
//     assign C = (C_delay == 10'sb0000000000) ? 10'sb0000000000 : C_delay;
    
//    assign C = (C_delay == 10'sb0000000000) ? 10'sb0000000000 : C_delay;
    
    
//    assign C = C_delay;  // U¿ywamy C_delay jako opóŸnionego sygna³u C
    
        delay_line delay_inst(
        .clk(clk),
        .d(D),
        .q(C)
    );
    
    artmetic_op artmetic_op_instance(
        .clk(clk),
        .ce(ce),
        .A(A),
        .B(B),
        .C(C),
        .Y(Y)
    
    );
    

    
    
    always #2 clk = ~clk;  
    
    initial begin
//        C_delay = 10'sb0000000000;
        clk = 0;
        ce = 1;
//      
        A_reg = 11'sb00_010100110;
        B_reg = 11'sb11_001101100;
        C_reg = 11'sb00_000000000;
        D_reg = 11'sb00_100100010;
        #4;
//        D_reg = 11'sb0_0010001010;
//        #4;
//        D_reg = 11'sb1_0010001010;
//        #4;
//        D_reg = 11'sb0_1000100010;
//        #10;
        
        #2000;
        $finish;
    
    end
    
    
endmodule
