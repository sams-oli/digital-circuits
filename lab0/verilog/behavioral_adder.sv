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
