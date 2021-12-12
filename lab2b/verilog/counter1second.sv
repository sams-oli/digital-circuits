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

module counter1second(
	input wire clock,
	input wire reset,
	output logic [3:0] value
);
	
	logic [31:0] cont;
	
	always_ff @ ( posedge clock ) begin : proc_value

		cont <= ~ reset ? 32'd0 : (cont + 1'b1);		
	end

	assign value = cont[29:26];

endmodule