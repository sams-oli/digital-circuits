// Module Purpose:
//    Single-port RAM
// -----------------------------------------------------------------------------
// Entradas: 
//      clock  : clock do sistema
//      wr     : write enable
//      addr   : endereço para especificar a posição da memória
//      din    : dado a ser escrito na memória (se wr == 1)
// -----------------------------------------------------------------------------
// Saidas:
//      dout   : dado lido da memória 
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps
`default_nettype none

module imem #(
   parameter Nloc = 64,                      // Quantidade de posições de memória
   parameter Dbits = 32,                      // Número de bits do dado
   parameter initfile = "C:/Users/Convidad/Desktop/mips/sim/test/full_imem.mem"          // Nome do arquivo contendo os valores iniciais
)(
   input wire [31:2] pc,
   output wire [31:0] instr
   );

   logic [Dbits-1 : 0] mem [Nloc-1 : 0];        // Unidade de armazenamento onde o dado será guardado
   initial $readmemh(initfile, mem, 0, Nloc-1); // Inicializa o conteúdo da memória a partir de um arquivo

   assign instr = mem[{2'b00, pc[31:2]}];

endmodule