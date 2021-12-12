// Module Purpose:
//		Unidade de controle para o processador MIPS231
// -----------------------------------------------------------------------------
// Entradas: 
// 	enable : sinal de controle de escrita
// 	op     : opcode da instrução
// 	func   : função para instruções R-type
//    Z      : flag zero vinda da ALU
// -----------------------------------------------------------------------------					
// Saidas:
// 	pcsel  : seletor do multiplexador de PC.
//    wasel  : seletor do multiplexador do endereço de escrita no register file
//    sext   : controle do sign extend (0 zero-extends, 1 sign-extends)
//    bsel   : seletor do multiplexador da entrada B da ALU
//    wdsel  : seletor do multiplexador de dados de escrita no register file
//    alufn  : função a ser executada pela ALU
//    wr     : write enable da memória de dados
//    werf   : write enable do register file
//    asel   : seletor do multiplexador da entrada A da ALU
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps
`default_nettype none
`include "opcode.svh"
`include "aluop.svh"

module controller(
   input  wire enable,
   input  wire [5:0] op, 
   input  wire [5:0] func,
   input  wire Z,
   output wire [1:0] pcsel,
   output wire [1:0] wasel, 
   output wire sext,
   output wire bsel,
   output wire [1:0] wdsel, 
   output logic [4:0] alufn, 			
   output wire wr,
   output wire werf, 
   output wire [1:0] asel
   ); 

  assign pcsel = ((op == 6'b0) & (func == `JR)) ? 2'b11   // controla o multiplexador de  4-entradas
               : ((op == 6'b000100) & (Z)) || ((op == 6'b000101) & (!Z)) ?
                2'b01 : ((op == 6'b000010) || (op == 6'b000011))  ?      // para beq/bne verifica a flag Z!
                2'b10 : 2'b00;

  logic [9:0] controls;
  wire _werf_, _wr_;
  assign werf = _werf_ & enable;       // desativa as escritas no registrador quando o processador está desativado
  assign wr = _wr_ & enable;           // destiva a escrita na memória quando o processador está desativado 
 
  assign {_werf_, wdsel[1:0], wasel[1:0], asel[1:0], bsel, sext, _wr_} = controls[9:0];

  always_comb
     case(op)                                       // instruções non-R-type 
        `LW: controls <= 10'b 1_11_00_00_1_0_0;     // LW
        `SW: controls <= 10'b 0_1X_0X_00_1_1_1;                      // SW
      `ADDI: controls <= 10'b 1_10_00_00_1_0_0;      // ADDI
     `ADDIU: controls <= 10'b 1_10_00_00_1_1_0;      // ADDIU

            `SLTI: controls <= 10'b 1_10_00_00_0_1_0;     // SLTI
            `SLTIU: controls <= 10'b 1_10_00_00_0_1_0; 
            `ORI: controls <= 10'b 1_10_00_00_1_0_0; 
            `LUI: controls <= 10'b 1_10_00_10_0_1_0;   
            `ANDI: controls <= 10'b 1_10_00_00_1_0_0;    
            `XORI: controls <= 10'b 1_10_00_00_1_0_0;  
            `BEQ: controls <= 10'b 0_0X_1X_00_0_1_0; 
            `BNE: controls <= 10'b 0_0X_1X_00_0_1_0; 
            `J: controls <= 10'b 0_XX_0X_XX_0_X_0; 
            `JAL: controls <= 10'b 1_00_01_XX_0_0_0; 
      6'b000000:                                    
         case(func)                                 // R-type
             `ADD: controls <= 10'b 1_00_00_00_0_1_0;
            `ADDU: controls <= 10'b 1_00_00_00_1_1_0; // ADD e ADDU
             `SUB: controls <= 10'b 1_00_00_00_1_1_0; // SUB
            `AND: controls <= 10'b 1_00_00_00_1_1_0;
            `OR: controls <= 10'b 1_00_00_00_1_1_0;
            `XOR: controls <= 10'b 1_00_00_00_1_1_0;
            `NOR: controls <= 10'b 1_00_00_00_1_1_0;
            `SLT: controls <= 10'b 1_00_00_00_1_1_0;
            `SLTU: controls <= 10'b 1_00_00_00_1_0_0;
            `SLLV: controls <= 10'b 1_00_00_00_1_0_0;
            `SLL: controls <= 10'b 1_00_00_01_1_0_0;
            `SRL: controls <= 10'b 1_00_00_01_1_1_0;
            `SRA: controls <= 10'b 1_00_00_01_1_0_0;
            `JR: controls <= 10'b 0_XX_1X_XX_1_0_0;
            default:   controls <= 10'b 0_xx_xx_xx_x_x_0; // instrução desconhecida, desative a escrita no registrador e na memória
         endcase
      default: controls <= 10'b 0_xx_xx_xx_x_x_0;         // instrução desconhecida, desative a escrita no registrador e na memória
    endcase
     
     always_comb
    case(op)                        // non-R-type
        `LW: alufn <= 5'b 00000;
        `SW: alufn <= 5'b x0000;
      `ADDI: alufn <= 5'b 10000;
     `ADDIU: alufn <= 5'b 10000;
      `SLTI: alufn <= 5'b 10010;
     `SLTIU: alufn <= 5'b 10011;
       `ORI: alufn <= 5'b 10101;
       `LUI: alufn <= 5'b 11000;
      `ANDI: alufn <= 5'b x0000;
      `XORI: alufn <= 5'b x1000;
       `BEQ: alufn <= 5'b x0001;
       `BNE: alufn <= 5'b x0001;
         `J: alufn <= 5'b xxxxx;
       `JAL: alufn <= 5'b xxxxx;
      6'b000000:                      
         case(func)                 // R-type
             `ADD,
            `ADDU: alufn <= 5'b 10000;
             `SUB: alufn <= 5'b 10001;
             `AND: alufn <= 5'b 10100;
              `OR: alufn <= 5'b 10101;
             `XOR: alufn <= 5'b 10110;
             `NOR: alufn <= 5'b 11011;
             `SLT: alufn <= 5'b 10010;
            `SLTU: alufn <= 5'b 10011;
             `SLL: alufn <= 5'b 11000;
            `SLLV: alufn <= 5'b 11000;
             `SRL: alufn <= 5'b 11001;
             `SRA: alufn <= 5'b 11010;
              `JR: alufn <= 5'b xxxxx; 
            default:   alufn <= 5'b xxxxx; 
         endcase
      default: alufn <= 5'b xxxxx; 
    endcase

   aludec alu_decoder (
      .funct(func),
      .opcode(op),
      .aluop(alufn)
   );
    
   
endmodule
