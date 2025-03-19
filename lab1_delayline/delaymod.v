`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 17:50:35
// Design Name: 
// Module Name: delaymod
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


module delaymod #
(
    parameter N = 3  
)
(

    input clk,
    input [N-1:0] idata,
    output reg [N-1:0] odata
);


always @(posedge clk)
begin
    
    odata <= idata;
    
end


endmodule
