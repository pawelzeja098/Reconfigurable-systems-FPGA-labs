`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2025 09:53:29 AM
// Design Name: 
// Module Name: lab2
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



module lab2 #
(
    parameter LENGTH = 8
)
(
    input wire [LENGTH - 1:0]a,
    output wire c
);



wire [LENGTH:0]chain;
assign chain[0] = 1'b1;

genvar i;
generate

    for(i=0;i<LENGTH;i=i+1)
    begin
    assign chain[i + 1] = a[i] & chain[i]; 
    
    
    

    end
    


endgenerate

assign c = chain[LENGTH];

endmodule


