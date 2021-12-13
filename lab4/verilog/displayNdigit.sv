// Descrição:
//    Controle de exibição de valores hexadecimais em displays de 7 segmentos
// -----------------------------------------------------------------------------
// Entradas: 
// 	  clock : clock do sistema
// 	  value : valor a ser exibido
// -----------------------------------------------------------------------------
// Saidas:
// 	  segments : packad array contendo os segmentos
// -----------------------------------------------------------------------------
// Parâmetros:
// 	  NDIG : quantidade de displays de 7 segmentos
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module displayNdigit #(
	parameter NDIG = 4
)(
	input  wire clock,
   	input  wire [(NDIG*4)-1:0] value,   
	output wire [6:0] segments [0:NDIG-1]
);

	logic [15:0] value16bit;

	counter1second cls(
		.clock(clock),
    	.value(value16bit)
    	);
	
	genvar i;

	generate 
		for ( i = 0; i < NDIG; i = i + 1)
      begin : hexencoder
      		hexto7seg dec7segDisplay0 (.x(value16bit[(3 + (i*4)) : (0 + (i*4))]), .segments(segments[i]));
      end
	endgenerate

endmodule
