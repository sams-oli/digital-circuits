// Module Purpose:
//		Conversor de binário para display de 7 segmentos
// -----------------------------------------------------------------------------
// Entradas: 
// 	x: dígito binário
// -----------------------------------------------------------------------------
// Saidas:
// 	segments: codigo para exibição no display de 7 segmentos
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module hexto7seg(
   input  wire  [3:0] x,
   output logic [6:0] segments
);

   assign segments = ~(              // Observe a inversão
            x == 4'h0 ? 7'b0111111      
          : x == 4'h1 ? 7'b0000110
          : x == 4'h2 ? 7'b1011011
          : x == 4'h3 ? 7'b1001111
          : x == 4'h4 ? 7'b1100110 
          : x == 4'h5 ? 7'b1101101
          : x == 4'h6 ? 7'b1111101
          : x == 4'h7 ? 7'b0000111
          : x == 4'h8 ? 7'b1111111
          : x == 4'h9 ? 7'b1101111
          : x == 4'hA ? 7'b1110111
          : x == 4'hB ? 7'b1111100
          : x == 4'hC ? 7'b0111001
          : x == 4'hD ? 7'b1011110
          : x == 4'hE ? 7'b1111001       
          : x == 4'hF ? 7'b1110001       
          : 7'b0000000 );  // Para capturar um "x" que não coincide 
                           // com nenhuma das opções acima

endmodule
