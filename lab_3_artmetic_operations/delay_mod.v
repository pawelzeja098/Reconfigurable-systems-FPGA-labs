`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 14:19:45
// Design Name: 
// Module Name: delay_mod
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


module delay_mod #
(
    parameter N = 11
)
(

    input clk,
    input [N-1:0] idata,
    output reg signed [N-1:0] odata
);

//reg signed [N-1:0] tdata;
initial begin
        odata = 0;
    end
   
   
always @(posedge clk)
begin
    
    odata <= idata;
    
    
end

//assign odata = tdata;

endmodule