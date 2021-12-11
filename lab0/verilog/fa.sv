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

