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

module counter1second (
	input clock, 
	input reset,
	output reg [31:0] value= 32'b00000000000000000000000000000000
	);
	
	integer count;

	always @(posedge clock) begin
		if(count == (50000000 / 2048 )) begin
			count <= 0;
			value <= value + 1'b1;
				if (value == 32'b00000000000000001111111111111111) begin
					value <= 32'b00000000000000000000000000000000;
				end
		end

		else begin
			count <= count + 1;
		end
	
	end

endmodule