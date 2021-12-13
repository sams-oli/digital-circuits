`timescale 1ns / 1ps
`include "display640x480.svh"
`include "vgasynctimer.sv"
`include "xycounter.sv"
`include "bitmapram.sv"

module main;
    
    logic clock;
    logic [10:0] screen_addr;
    logic hsync, vsync;
    logic character_code = 0;

    wire [11:0] color_value,bitmap_addr;
    wire active_video;
    wire [`xbits-1:0] x;
    wire [`ybits-1:0] y;
    wire [`xbits-1:0] j = x[`xbits-1:4];
    wire [`ybits-1:0] k = y[`xbits-1:4];

    assign bitmap_addr = {character_code, y[3:0], x[3:0]};
    integer i;
    
    vgasynctimer myvgatimer(clock, hsync, vsync, active_video, x, y);

   parameter halfcycle = 5; // meio período equivale a 5ns
   localparam cycle = 2*halfcycle;

    bitmapram #() bitmap(
        .bitmap_addr(bitmap_addr),
        .color_value(color_value)
    );

  initial clock = 0;
   always #(halfcycle) clock = ~clock;

   initial begin
    for(i=0;i<100000000;i=i+1)
    begin
    screen_addr = ((j) + (40 * k));
    #1;
     end
     $finish;
   end

endmodule