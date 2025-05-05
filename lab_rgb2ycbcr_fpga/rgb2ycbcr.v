`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2025 21:52:55
// Design Name: 
// Module Name: rgb2ycbcr
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


module rgb2ycbcr(
    input clk,
    input hsync_in,
    input vsync_in,
    input de_in,
    input [23:0] pixel_in,
    
    output hsync_out,
    output vsync_out,
    output de_out,
    output [23:0] pixel_out 
    );

//Rozdzielenie na kana³y
wire signed [23:0] R, G, B;

assign R = {10'd0,pixel_in[23:16]};
assign G = {10'd0,pixel_in[15:8]};
assign B = {10'd0,pixel_in[7:0]};

wire [17:0] TY1, TY2, TY3, TCb1, TCb2, TCb3, TCr1, TCr2, TCr3;

//Zdefiniowanie sta³ych do przekszta³ceñ 18, 17 bitów czesc dzies
assign TY1 = 18'b001001100100010111;
assign TY2 = 18'b010010110010001011;
assign TY3 = 18'b000011101001011110;

assign TCb1 = 18'b111010100110011011;
assign TCb2 = 18'b110101011001100101;
assign TCb3 = 18'b010000000000000000;

assign TCr1 = 18'b010000000000000000;
assign TCr2 = 18'b110010100110100010;
assign TCr3 = 18'b111101011001011110;

//Zmienne do mno¿enia
wire [35:0] YR, YG, YB, CbR, CbG, CbB, CrR, CrG, CrB;

//modu³y mno¿enia
mult_gen_0 YR_mult(
    .CLK(clk),
    .A(R),
    .B(TY1),
    .P(YR)
);

mult_gen_0 YG_mult(
    .CLK(clk),
    .A(G),
    .B(TY2),
    .P(YG)

);

mult_gen_0 YB_mult(
    .CLK(clk),
    .A(B),
    .B(TY3),
    .P(YB)

);

mult_gen_0 CbR_mult(
    .CLK(clk),
    .A(R),
    .B(TCb1),
    .P(CbR)

);

mult_gen_0 CbG_mult(
    .CLK(clk),
    .A(G),
    .B(TCb2),
    .P(CbG)
);

mult_gen_0 CbB_mult(
    .CLK(clk),
    .A(B),
    .B(TCb3),
    .P(CbB)
);

mult_gen_0 CrR_mult(
    .CLK(clk),
    .A(R),
    .B(TCr1),
    .P(CrR)
);

mult_gen_0 CrG_mult(
    .CLK(clk),
    .A(G),
    .B(TCr2),
    .P(CrG)
);

mult_gen_0 CrB_mult(
    .CLK(clk),
    .A(B),
    .B(TCr3),
    .P(CrB)
);

//assign Y = {YR,YG,YB};
//assign Cb = {CbR,CbG,CbB};
//assign Cr = {CrR,CrG,CrB};

//Wynikowe sumatorów
wire [8:0] Ys1, Y, Cb1,Cb2, Cb, Cr1,Cr2,Cr;
//Obciêcie wyników mno¿enia
wire [8:0] YR_trunc, YG_trunc, YB_trunc, CbR_trunc, CbG_trunc, CbB_trunc, CrR_trunc,CrG_trunc,CrB_trunc;

//assign YR_trunc = YR[28:20];
//assign YG_trunc = YG[28:20];
//assign YB_trunc = YB[28:20];
//assign CbR_trunc = CbR[28:20];
//assign CbG_trunc = CbG[28:20];
//assign CbB_trunc = CbB[28:20];
//assign CrR_trunc = CrR[28:20];
//assign CrG_trunc = CrG[28:20];
//assign CrB_trunc = CrB[28:20];

assign YR_trunc = YR[25:17];
assign YG_trunc = YG[25:17];
assign YB_trunc = YB[25:17];
assign CbR_trunc = CbR[25:17];
assign CbG_trunc = CbG[25:17];
assign CbB_trunc = CbB[25:17];
assign CrR_trunc = CrR[25:17];
assign CrG_trunc = CrG[25:17];
assign CrB_trunc = CrB[25:17];

//sumatory
c_addsub_0 Y1_add(
    .CLK(clk),
    .A(YR_trunc),
    .B(YG_trunc),
    .S(Ys1)
);

c_addsub_0 Y2_add(
    .CLK(clk),
    .A(YB_trunc),
    .B(Ys1),
    .S(Y)
    
);


c_addsub_0 Cb1_add(
    .CLK(clk),
    .A(CbR_trunc),
    .B(CbG_trunc),
    .S(Cb1)
);

c_addsub_0 Cb2_add(
    .CLK(clk),
    .A(CbB_trunc),
    .B(Cb1),
    .S(Cb2)
);

c_addsub_0 Cb3_add(
    .CLK(clk),
    .A(Cb2),
    .B(9'b010000000),
    .S(Cb)
);

c_addsub_0 Cr1_add(
    .CLK(clk),
    .A(CrR_trunc),
    .B(CrG_trunc),
    .S(Cr1)
);

c_addsub_0 Cr2_add(
    .CLK(clk),
    .A(CrB_trunc),
    .B(Cr1),
    .S(Cr2)
);

c_addsub_0 Cr3_add(
    .CLK(clk),
    .A(Cr2),
    .B(9'b010000000),
    .S(Cr)

);
wire [8:0] Y_delay;
//Delay Y
delayline #(.N(9), .DELAY(1)) delay_Y(
    .clk(clk),
    .d(Y),
    .q(Y_delay)

);

wire [2:0] concatenated_signals; 
wire [2:0] delayed_signals;
assign concatenated_signals = {de_in, hsync_in, vsync_in};

delayline #(.N(3), .DELAY(7)) delay_synchsigs(
    .clk(clk),
    .d(concatenated_signals),
    .q(delayed_signals)

);
assign de_out = delayed_signals[2];
assign hsync_out = delayed_signals[1];
assign vsync_out = delayed_signals[0];

assign pixel_out = {Y_delay[7:0],Cb[7:0],Cr[7:0]};


endmodule
