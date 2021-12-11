// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : fa.v
// Create : 2018-12-18 16:50:32
// Editor : Sublime Text3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//   1-bit Full Adder
// -----------------------------------------------------------------------------
// Note: Você deve usar apenas código Verilog estrutural.
// -----------------------------------------------------------------------------
`default_nettype none

module fa(
    input  logic ina, inb, cin,
    output logic sum, cout
);
   // Somente código Verilog estrutural!
   /******** SEU CÓDIGO AQUI ********/

 	logic a_xor_b, ab_and_cin, a_and_b;

 	xor (a_xor_b, ina, inb);
	xor (sum, a_xor_b, cin);
	and (ab_and_cin, a_xor_b, cin);
	and (a_and_b, ina, inb);
	or  (cout, ab_and_cin, a_and_b);

   /******** FIM DO SEU CÓDIGO ******/
endmodule

