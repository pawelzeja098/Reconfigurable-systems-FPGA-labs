`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2025 14:30:21
// Design Name: 
// Module Name: centroid
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


module centroid#
(
    parameter IMG_H = 64,
    parameter IMG_W = 64
)
(
    input clk,
    input ce,
    input rst,
    input de,
    input hsync,
    input vsync,
    input mask,
    
    
    output [10:0] x,
    output [10:0] y
    );

//wire [31:0] quotient;
wire qvx, qvy;

reg [31:0]res_x; 
reg [31:0]res_y;

reg do_divide_x = 0;
reg do_divide_y = 0;

wire [31:0] quotient_x, quotient_y;

reg [21:0] m00 = 0;  
reg [31:0] m10 = 0;  
reg [31:0] m01 = 0;

wire qvx, qvy;

divider_32_21_0 xsc(
    .clk(clk),
    .start(do_divide_x),
    .dividend(m10),
    .divisor(m00),
    .quotient(quotient_x),
    .qv(qvx)
);

divider_32_21_0 ysc(
    .clk(clk),
    .start(do_divide_y),
    .dividend(m01),
    .divisor(m00),
    .quotient(quotient_y),
    .qv(qvy)
);


reg [10:0] x_pos = 11'd0;
reg [10:0] y_pos = 11'd0;

reg prev_vsync = 0;
reg eof_flag = 0;

reg qvx_flag = 0;
reg qvy_flag = 0;





always @(posedge clk) begin
    if (eof == 1'b1) begin
        eof_flag <= 1;
        do_divide_x <= 1;
        do_divide_y <= 1;
    end
    
    if (qvx == 1'b1) begin
        qvx_flag <= 1;
    end
    
    if (qvy == 1'b1) begin
        qvy_flag <= 1;
    end
    
    if (vsync == 1)  begin
        x_pos <= 0;
        y_pos <= 0;
        
    end 
    else begin 
    if (de == 1) begin
    
        
        
    
        if (mask && de) begin
                
                m00 <= m00 + 1; 
                m10 <= m10 + x_pos; 
                m01 <= m01 + y_pos; 
            end
    
        x_pos <= x_pos + 1;
        if(x_pos == IMG_W - 1) begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
            
            if(y_pos == IMG_H - 1) begin
                y_pos <= 0;
            end
        end
        
        end if (eof_flag) begin
            
            
            if (qvx_flag && do_divide_x) begin
            
                res_x <= quotient_x;
                do_divide_x <= 0;
            
            end
            if (qvy_flag && do_divide_y) begin
                
                res_y <= quotient_y;
                do_divide_y <= 0;
                
            end 
            
            m00 <= 0;
            m10 <= 0;
            m01 <= 0;
            do_divide_x <= 1;
            do_divide_y <= 1;
            eof_flag <= 0;
            
            qvx_flag <= 0;
            qvy_flag <= 0;
            
        end
        
            
    end
    
    
    
    prev_vsync <= vsync;
    
    
    

end

assign eof = (prev_vsync == 1'b0 & vsync == 1'b1) ? 1'b1 : 1'b0;
assign x = res_x[10:0];
assign y = res_y[10:0];

endmodule
