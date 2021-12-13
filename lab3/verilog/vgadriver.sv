// Module Purpose:
//		Driver do controlador VGA
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock do sistem
// -----------------------------------------------------------------------------		
// Saidas:
// 	hsync: sinal de sincronismo horizontal
// 	vsync: sinal de sincronismo vertical
// 	avideo: sinal de exibição na tela
// 	red: sinal codificado em 4-bits para a cor vermelha
// 	green: sinal codificado em 4-bits para a cor verde
// 	blue: sinal codificado em 4-bits para a cor azul
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none
`include "Display640x480.svh"

module vgadriver(
    input  wire clock,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync, avideo
    );

   wire [`xbits-1:0] x;
   wire [`ybits-1:0] y;
   wire activevideo;

   assign avideo = activevideo;

   vgasynctimer my_vgatimer (clock, hsync, vsync, activevideo, x, y);
	
   
   assign red[3:0]   = (activevideo == 1) ? x/4 : 4'b0;
   assign green[3:0] = (activevideo == 1) ? y/4 : 4'b0;
   assign blue[3:0]  = (activevideo == 1) ? x/4 + y/4 : 4'b0;

endmodule