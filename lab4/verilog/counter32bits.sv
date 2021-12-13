// Module Purpose:
//    Interface top level de uma placa FPGA DE2-115
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps

module counter32bits
	(
		input clock, 
		input reset,
		output reg [31:0] value= 32'b00000000000000000000000000000000);
	
	integer count;


	always @(posedge clock) begin
		if(count == (195312)) begin
			count <= 0;
			value <= value + 1'b1;
				if (value == 32'b11111111111111111111111111111111) begin
					value <= 32'b00000000000000000000000000000000;
				end
		end


		else begin
			count <= count + 1;
		end
	
	end

endmodule
