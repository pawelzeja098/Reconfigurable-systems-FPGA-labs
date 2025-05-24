`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2025 18:48:37
// Design Name: 
// Module Name: median5x5
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


module median5x5 #(
    parameter H_SIZE = 83
)   
(
    input clk,
    input de,
    input hsync,
    input vsync,
    input mask,
    
    output de_out,
    output hsync_out,
    output vsync_out,
    output[23:0] pixel_out
    );
   
assign synch_sig = {mask, de, hsync, vsync};


reg [3:0] d11; reg [3:0] d12; reg [3:0] d13; reg [3:0] d14; reg [3:0] d15;


reg [3:0] d21; reg [3:0] d22; reg [3:0] d23; reg [3:0] d24; reg [3:0] d25;


reg [3:0] d31; reg [3:0] d32; reg [3:0] d33; reg [3:0] d34; reg [3:0] d35;


reg [3:0] d41; reg [3:0] d42; reg [3:0] d43; reg [3:0] d44; reg [3:0] d45;


reg [3:0] d51; reg [3:0] d52; reg [3:0] d53; reg [3:0] d54; reg [3:0] d55;

reg [15:0] long_line_input;
wire [15:0] long_line_output;
//assign xyz_in = {x,y,z};

//assign d11 <= {mask,de,hsync,vsync};

delayLineBRAM_WP #(.IMG_H(64), .IMG_W(64)) delaylineBram(
    .clk(clk),
    .rst(1'b0),
    .ce(1'b1),
    .din(long_line_input),
    .h_size(H_SIZE - 5),
    
    .dout(long_line_output)
    
);
wire [3:0] c_pixel_in;
assign c_pixel_in = d33;
wire [3:0] c_pixel_out;

delayline #(.N(4), .delay(2)) delay_short_line(
    .clk(clk),
    .d(c_pixel_in),
    .q(c_pixel_out)
);

assign de_out = c_pixel_out[2];
assign hsync_out = c_pixel_out[0];
assign vsync_out = c_pixel_out[1];



reg [2:0] sum_w1 = 0;
reg [2:0] sum_w2 = 0;
reg [2:0] sum_w3 = 0;
reg [2:0] sum_w4 = 0;
reg [2:0] sum_w5 = 0;
reg [4:0] sum = 0; 

reg contex_valid;
reg contex_w1 = 1'b0;
reg contex_w2 = 1'b0;
reg contex_w3 = 1'b0;
reg contex_w4 = 1'b0;
reg contex_w5 = 1'b0;

wire [7:0] mask_new;

always @(posedge(clk))
begin             
           
    long_line_input <= {d15,d25,d35,d45};
    d11 <= {mask,de,hsync,vsync};    
    d21 <= long_line_output[15:12];
    d31 <= long_line_output[11:8];
    d41 <= long_line_output[7:4];
    d51 <= long_line_output[3:0];
   
   
    d12 <= d11; d13 <= d12; d14 <= d13; d15 <= d14;
    d22 <= d21; d23 <= d22; d24 <= d23; d25 <= d24;
    d32 <= d31; d33 <= d32; d34 <= d33; d35 <= d34;
    d42 <= d41; d43 <= d42; d44 <= d43; d45 <= d44;
    d52 <= d51; d53 <= d52; d54 <= d53; d55 <= d54;

    
  
    
    sum_w1 <= d11[3] + d12[3] + d13[3] + d14[3] + d15[3];
    sum_w2 <= d21[3] + d22[3] + d23[3] + d24[3] + d25[3];
    sum_w3 <= d31[3] + d32[3] + d33[3] + d34[3] + d35[3];
    sum_w4 <= d41[3] + d42[3] + d43[3] + d44[3] + d45[3];
    sum_w5 <= d51[3] + d52[3] + d53[3] + d54[3] + d55[3];
    sum <= sum_w1 + sum_w2 + sum_w3 + sum_w4 + sum_w5;

    

    contex_w1 <= de & d12[2] & d13[2] & d14[2] & d15[2];
    contex_w2 <= d21[2] & d22[2] & d23[2] & d24[2] & d25[2];
    contex_w3 <= d31[2] & d32[2] & d33[2] & d34[2] & d35[2];    
    contex_w4 <= d41[2] & d42[2] & d43[2] & d44[2] & d45[2];    
    contex_w5 <= d51[2] & d52[2] & d53[2] & d54[2] & d55[2];
    contex_valid <= contex_w1 & contex_w2 & contex_w3 & contex_w4 &contex_w5;
end

assign mask_new = sum > 5'd12 ? 255 : 0;

assign pixel_out = contex_valid == 1'b1 ? {3{mask_new}} : 24'b0;

endmodule
