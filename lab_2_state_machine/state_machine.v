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
    
    output reg txd = 0
    );

localparam STATE0=2'd0;
localparam STATE1=2'd1;
localparam STATE2=2'd2;
localparam STATE3=2'd3;

reg [1:0]state = STATE0;   
reg [7:0]tdata;


integer cnt = 7;
integer i;

reg send_prev = 0;

always @(posedge clk) 
begin
    send_prev <= send; 
    
    

    if(rst) state <= STATE0;
    else
    begin
        case(state)
        STATE0:
        begin

        if (!send_prev && send) begin
            state <= STATE1;
            tdata <= data;
        end

    end
        STATE1:
        begin 
            txd <= 1;
            state <= STATE2;
        
        end
        STATE2:
        begin
    //else if (state == 2'b10) begin
            if (cnt >= 0) begin
                txd <= tdata[cnt];
                cnt = cnt - 1;
                
            end 
            else begin
                
                cnt = 7;
                state <= 2'b11;
           end

        end
    
        STATE3:
        begin
    
            txd <= 0;
            state <= STATE0;
        end
    endcase
    
end
    
end
    



endmodule
