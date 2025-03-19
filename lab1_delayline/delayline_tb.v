`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 20:22:53
// Design Name: 
// Module Name: delayline_tb
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


module delayline_tb(
    
    );
    
reg clk = 0;     
reg [2:0] d = 3'b000;       
wire [2:0] q;         
    
delayline dline (
    .clk(clk),
    .d(d),
    .q(q)
);

always begin
        #5 clk = ~clk; 
end

always @(posedge clk) begin
      
    d <= d + 1; 
end
    
    

endmodule
