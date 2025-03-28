`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 14:18:53
// Design Name: 
// Module Name: delay_line
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


module delay_line #

(
    parameter N = 11,
    parameter DELAY = 2
    
)

(
    input wire clk,      
    input wire signed [N-1:0] d,       
    output wire signed [N-1:0] q 
);


wire signed [N-1:0] tdata [DELAY:0];

assign tdata[0] = d;


genvar i;

generate
for(i=0; i < DELAY; i = i + 1) begin
    
    delay_mod d_mod(
    
    .idata(tdata[i]),
    .odata(tdata[i+1]),
    .clk(clk)
    
    );

end
endgenerate 

assign q = tdata[DELAY];
endmodule