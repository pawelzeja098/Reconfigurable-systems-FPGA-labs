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
    reg send;
    reg [7:0] data;
    wire txd;

    
    state_machine uut (
        .clk(clk),
        .rst(rst),
        .send(send),
        .data(data),
        .txd(txd)
    );

    
    always #10 clk = ~clk;

    initial begin
        
        clk = 0;
        rst = 1;
        send = 0;
        data = 8'b01100001;
        
        
        #20 rst = 0;

        
        #30 send = 1;
        #20 send = 0;

        
        #200 data = 8'b011011001;
  
        #30 send = 1;
        #20 send = 0;

        
        #400;
        $stop;
    end

endmodule


