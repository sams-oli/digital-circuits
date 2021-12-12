// Module Purpose:
//		Contador módulo 7
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock do sistem
// 	reset: reset global 
// -----------------------------------------------------------------------------	
// Saidas:
// 	value: valor de saída do contador
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module countermod7 (
	input  wire clock, 
	input  wire reset,
	output logic [2:0] value // Observe como esta linha é diferente da Parte I
	);

	always_ff @(posedge clock) begin

		value <= reset  ? 3'b000 : value == 3'b110 ? 3'b000 : (value +1'b1);
		
	end

endmodule
