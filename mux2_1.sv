// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : mux2_1.v
// Create : 2018-12-18 16:53:01
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		out = a*(~sel) + b*(sel)
// -----------------------------------------------------------------------------
`default_nettype none

module mux2_1 (
   input a,
   input b,
   input sel,
   output logic out
);
   // Você deve usar somente código Verilog estrutural! (i.e. wires e portas primitivas apenas)
   /******** SEU CÓDIGO AQUI ********/
 	logic n, a_and_n, b_and_sel;
   	not (n, sel);
   	and (a_and_n, a, n);
   	and (b_and_sel, b, sel);
   	or (out, a_and_n, b_and_sel);

   /******** FIM DO SEU CÓDIGO ******/
   
endmodule
