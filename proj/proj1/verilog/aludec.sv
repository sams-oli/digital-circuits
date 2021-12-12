// Module Purpose:
//		Decodificar a operação a ser realizada na ALU
// -----------------------------------------------------------------------------
// Entradas: 
//    opcode: os 6 bits mais significativos da instrução
//    funct : a função, no caso de instruções do tipo-r
// -----------------------------------------------------------------------------
// Saidas:
// 	aluop: A função escolhida para ser mapeada na ALU
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none
`include "opcode.svh"
`include "aluop.svh"

module aludec(
   input  wire  [5:0] funct, opcode,
   output logic [3:0] aluop
);

  always_comb begin
	case(opcode) 
		`RTYPE: 
			case(funct)
				`ADD: aluop <= `ALU_ADDU;
				`ADDU: aluop <= `ALU_ADDU;
				`SUB: aluop <= `ALU_SUBU;
				`AND: aluop <= `ALU_AND;
				`OR: aluop <= `ALU_OR;
				`XOR: aluop <= `ALU_XOR;
				`NOR: aluop <= `ALU_NOR; 
				`SLT: aluop <= `ALU_SLT;
				`SLTU: aluop <= `ALU_SLTU;
				`SLL: aluop <= `ALU_SLL;
				`SLLV: aluop <= `ALU_SLL;
				`SRL: aluop <= `ALU_SRL;
				`SRA: aluop <= `ALU_SRA;
				`JR: aluop <= `ALU_XXX;
		endcase

				`LW: aluop <= `ALU_ADDU;
				`SW: aluop <= `ALU_ADDU;
				`ADDI: aluop <= `ALU_ADDU;
				`ADDIU: aluop <= `ALU_ADDU;
				`SLTI: aluop <= `ALU_SLT;
				`SLTIU: aluop <= `ALU_SLTU;
				`ANDI: aluop <=  `ALU_AND;
				`ORI: aluop <= `ALU_OR;
				`XORI: aluop <= `ALU_XOR;
				`LUI: aluop <= `ALU_LUI;
				`BEQ: aluop <= `ALU_SUBU;
				`BNE: aluop <= `ALU_SUBU;
				`J: aluop <= `ALU_XXX;
				`JAL: aluop <= `ALU_XXX;
		endcase

	end
	
endmodule
