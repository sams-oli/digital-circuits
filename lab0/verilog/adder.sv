// Module Purpose:
//    Somador ripple-carry estrutural parametrizadoParametrized structural ripple-carry adder
// -----------------------------------------------------------------------------
`default_nettype none

module adder #(
   parameter WIDTH = 8
)
(
   input   wire [WIDTH-1:0] ina,
   input   wire [WIDTH-1:0] inb,
   output  wire [WIDTH-1:0] result,
   output  wire             cout
);

   // Algumas declarações já foram feitas para você
   
   // Wire usado para ligar o carry in ao carry out das células do full-adder
   logic [WIDTH:0]     carry;
   // Carru in do somador do bit menos significativo é zero
   assign carry[0] = 1'b0;
   // Carry out do somador do bit mais significativo é atribuído à saída do carry do somador
   assign cout = carry[WIDTH];

   genvar         i;
   
   generate for ( i = 0; i < WIDTH; i = i + 1)
      begin : fadder
      /******** SEU CÓDIGO AQUI ********/

		fa contador_completo(
			.ina(ina[i]),
			.inb(inb[i]),
			.cin(carry[i]),
			.sum(result[i]),
			.cout(carry[i+1]) );

      /******** FIM DO SEU CÓDIGO ******/
      end
   endgenerate

endmodule
