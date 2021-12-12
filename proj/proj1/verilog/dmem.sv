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

module dmem #(
   parameter Nloc = 64,                      // Quantidade de posições de memória
   parameter Dbits = 32,                      // Número de bits do dado
   parameter initfile = "C:/Users/Convidad/Desktop/mips/sim/test/full_dmem.mem"          // Nome do arquivo contendo os valores iniciais
)(
   input wire clk,
   input wire mem_wr, 
   input wire [31:2] mem_addr, 
   input wire [31:0] mem_writedata, 
   output wire [31:0] mem_readdata
   );

   logic [Dbits-1 : 0] mem [Nloc-1 : 0];        // Unidade de armazenamento onde o dado será guardado
   initial $readmemh(initfile, mem, 0, Nloc-1); // Inicializa o conteúdo da memória a partir de um arquivo

   always_ff @(posedge clk)
        if(mem_wr)
            mem[{2'b00, mem_addr[31:2]}] <= mem_writedata;

    assign mem_readdata = mem[{2'b00, mem_addr[31:2]}];


endmodule