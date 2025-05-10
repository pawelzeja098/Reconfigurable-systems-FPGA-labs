`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2025 15:23:40
// Design Name: 
// Module Name: vision_system
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


module vision_system(
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0] pixel_in,
    input [3:0] sw,
    
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0] pixel_out
    );
    
//MULTIPLEXER
wire [23:0]rgb_mux[15:0];
wire de_mux[15:0];
wire hsync_mux[15:0];
wire vsync_mux[15:0];


assign rgb_mux[0] = pixel_in;

assign de_mux[0] = de_in;
assign hsync_mux[0] = hsync_in;
assign vsync_mux[0] = vsync_in;



//assign de_out = de_in;
//assign hsync_out = hsync_in;
//assign vsync_out = vsync_in;
//assign pixel_out = pixel_in;

//wire [7:0] r_in = pixel_in[23:16];
//wire [7:0] g_in = pixel_in[15:8];
//wire [7:0] b_in = pixel_in[7:0];

//wire [7:0] r_out;
//wire [7:0] g_out;
//wire [7:0] b_out;

//LUT lut_r (
//    .clk(clk),
//    .a   (r_in),
//    .qspo (r_out)
//);

//LUT lut_g (
//    .clk(clk),
//    .a   (g_in),
//    .qspo (g_out)
//);

//LUT lut_b (
//    .clk(clk),
//    .a   (b_in),
//    .qspo (b_out)
//);



rgb2ycbcr_3 rgb2ycbcr(
    .clk(clk),
    .de_in(de_mux[0]),
    .hsync_in(hsync_mux[0]),
    .vsync_in(vsync_mux[0]),
    .pixel_in(rgb_mux[0]),
    
    .de_out(de_mux[1]),
    .hsync_out(hsync_mux[1]),
    .vsync_out(vsync_mux[1]),
    .pixel_out(rgb_mux[1])


);

assign pixel_out = rgb_mux[sw];
assign de_out = de_mux[sw];
assign hsync_out = hsync_mux[sw];
assign vsync_out = vsync_mux[sw];


//assign rgb_mux[1] = pixel_out;

//assign de_mux[1] = de_out;
//assign hsync_mux[1] = hsync_out;
//assign vsync_mux[1] = vsync_out;




// wire and_result;


//wire [7:0] bin_value;
//assign bin_value = (r_out && g_out && b_out) ? 8'd255 : 8'd0;
////assign bin_value = (r_out && g_out && b_out);
//assign pixel_out = {bin_value, bin_value, bin_value}; // RGB = 255 lub 0

//assign pixel_out = {r_out, g_out, b_out};
//reg r_de = 0;
//reg r_hsync = 0;
//reg r_vsync = 0;
//always @(posedge clk)
//begin
//    r_de <= de_in;
//    r_hsync <= hsync_in;
//    r_vsync <= vsync_in;
//end

//assign de_out = r_de;
//assign hsync_out = r_hsync;
//assign vsync_out = r_vsync;


endmodule
