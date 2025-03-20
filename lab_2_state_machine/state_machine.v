`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2025 10:26:02 AM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input wire clk,
    input wire rst,
    input wire send,
    input wire [7:0]data,
    
    output reg txd
    );
    
reg [1:0]state = 0;   
reg [7:0]tdata;

integer cnt = 0;
integer i;

always @(posedge clk) 
begin

if (state == 2'b00) begin
    if (send == 1) begin
        state <= 2'b01;
        tdata <= data;
    end
end

else if (state == 2'b01) begin
    txd <= 0;
    state <= 2'b10;
    
end






else if (state == 2'b10) begin
    if (cnt < 8) begin
        txd <= tdata[cnt];
        cnt = cnt + 1;
        
    end   
    
    state <= 2'b11;
    for(i=0; i < 7;i = i + 1) begin
        txd <= tdata[i];
        
    end

end

else if (state == 2'b11) begin
    txd <= 0;
    state <= 2'b00;

end


end
    
    
end


endmodule
