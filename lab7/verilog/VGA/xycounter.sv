// -----------------------------------------------------------------------------
// Module Purpose:
//		Contador X-Y parametrizado
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock do sistem
// 	reset: reset global 
// -----------------------------------------------------------------------------
// Saidas:
// 	value: valor de saída do contador
// -----------------------------------------------------------------------------
// Parameters:
//		WIDTH: largura do barramento para x
//		HEIGHT: largura do barramento para y
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module xycounter #(
	parameter WIDTH=2, 
	parameter HEIGHT=2
	)(
	input  wire clock,   
	input  wire enable,  
	output logic [$clog2(WIDTH)-1:0]  x = 0,
	output logic [$clog2(HEIGHT)-1:0] y = 0
	);

always_ff @(posedge clock) begin
	if (enable) begin
		x<= enable ? (x==(WIDTH-1)) ? 0 : (x<(WIDTH-1)) ? (x+1) : x: x;
		y<= enable ? (x==(WIDTH-1)) ? (y==(HEIGHT-1))? 0: (y+1): y: y;
	end	
end
endmodule