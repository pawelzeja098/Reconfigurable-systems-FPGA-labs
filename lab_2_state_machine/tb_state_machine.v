`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 14:24:45
// Design Name: 
// Module Name: tb_state_machine
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


module tb_state_machine;

    reg clk;
    reg rst;
    wire send;
    wire [7:0] data;
    wire txd;

    
    state_machine uut (
        .clk(clk),
        .rst(rst),
        .send(send),
        .data(data),
        .txd(txd)
    );

   
    load_file load_file_inst (
        .send(send),
        .data(data)  
    );
    
    save_file save_file_inst (
        .txd(txd),
        .send(send)
    );
    
    
    always #2 clk = ~clk;  

    initial begin
        
        clk = 0;
        rst = 0;
        

        #20000
         
        $finish;
    end
endmodule

