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
			`SRL: aluop = `ALU_SRL;
			`SRLV: aluop = `ALU_SRL;
			`SLLV: aluop = `ALU_SLL;
			`SLL: aluop = `ALU_SLL;
			`SRAV: aluop = `ALU_SRA;
			`SRA: aluop = `ALU_SRA;
			`SUBU: aluop = `ALU_SUBU; 
			`ADDU: aluop = `ALU_ADDU;
			`SLT: aluop = `ALU_SLT;
			`SLTU: aluop = `ALU_SLTU;
			`AND: aluop = `ALU_AND;
			`OR: aluop = `ALU_OR;
			`XOR: aluop = `ALU_XOR;
			`NOR: aluop = `ALU_NOR;
			`LUI: aluop =  `ALU_LUI;
			default:aluop = `ALU_XXX;  
		endcase
	
	`SLLV: aluop = `ALU_SLL;
	`ADDIU: aluop = `ALU_ADDU;
	`SLTI: aluop = `ALU_SLT;
	`SLTIU: aluop = `ALU_SLTU;
	`ANDI: aluop = `ALU_AND;
	`ORI: aluop = `ALU_OR;
	`XORI: aluop = `ALU_XOR;
	`LUI: aluop =  `ALU_LUI;
	`LB: aluop = `ALU_ADDU;
	`LBU: aluop = `ALU_ADDU;
	`LH: aluop = `ALU_ADDU;
	`LHU: aluop = `ALU_ADDU;
	`LW: aluop = `ALU_ADDU;
	`SB: aluop = `ALU_ADDU;
	`SH: aluop = `ALU_ADDU;
	`SW: aluop = `ALU_ADDU;
	default:aluop = `ALU_XXX;  

	endcase

end

endmodule
