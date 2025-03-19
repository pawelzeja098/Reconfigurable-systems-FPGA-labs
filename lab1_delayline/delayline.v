`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 17:56:07
// Design Name: 
// Module Name: delayline
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


module delayline #

(
    parameter N = 3,
    parameter DELAY = 4
    
)

(
    input wire clk,      
    input wire [N-1:0] d,       
    output wire [N-1:0] q 
);


wire [N-1:0] tdata [DELAY:0];

assign tdata[0] = d;


genvar i;

generate
for(i=0; i < DELAY; i = i + 1) begin
    
    delaymod d_mod(
    
    .idata(tdata[i]),
    .odata(tdata[i+1]),
    .clk(clk)
    
    );

end
endgenerate 

assign q = tdata[DELAY];
endmodule

