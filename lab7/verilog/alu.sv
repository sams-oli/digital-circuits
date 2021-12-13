// Module Purpose:
//		ALU de 32-bits para o processador MIPS231
// -----------------------------------------------------------------------------
// Entradas: 
// 	A: a 32-bit value
// 	B: a 32-bit value
// 	aluop: Selects the ALU's operation 
// -----------------------------------------------------------------------------					
// Saidas:
// 	out: The chosen function mapped to A and B.
// ----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none
`include "opcode.svh"
`include "aluop.svh"

module alu(
   input  wire  [31:0] RD1,RD2,
   input  wire  [3:0] aluop,
   output logic [31:0] out
);

always_comb begin
	case(aluop)
		`ALU_ADDU: 	out = RD1 + RD2;
		`ALU_SUBU: 	out = RD1 - RD2;
		`ALU_AND: 	out = RD1 & RD2;
		`ALU_OR: 	out = RD1 | RD2;
		`ALU_XOR: 	out = RD1 ^ RD2;
		`ALU_NOR: 	out = ~RD1 & ~RD2;
		`ALU_LUI: 	out = {RD2[15:0],16'd0};
		`ALU_SLL: 	out = RD2 << RD1;	
		`ALU_SRL: 	out = RD2 >> RD1;	
		`ALU_SRA: 	out = $signed(RD2) >>> RD1;
		`ALU_SLT: 	out = $signed(RD1) < $signed(RD2);
		`ALU_SLTU:	out = RD1 < RD2;
		`ALU_XXX: 	out = 32'd0;
	endcase
end

endmodule
