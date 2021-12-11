// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : behavioral_adder.v
// Create : 2018-12-18 16:55:41
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Somador comportamental parametrizado
// -----------------------------------------------------------------------------
`default_nettype none

module behavioral_adder #(
  parameter WIDTH = 16
)
(
  input   wire [WIDTH-1:0] ina,
  input   wire [WIDTH-1:0] inb,
  output  wire [WIDTH-1:0] result,
  output  wire             cout
);
  
  assign {cout, result} = ina + inb;

endmodule
