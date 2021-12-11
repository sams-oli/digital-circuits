// Module Purpose:
//    Módulo top level do Lab 1
// -----------------------------------------------------------------------------
`default_nettype none
module de2_115top (
   input  wire [3:0]  KEY,
   input  wire        CLOCK_50,   
   output wire [7:0]  LEDG
);

   parameter   WIDTH   = 8;
   localparam  CWIDTH = WIDTH*2;

   logic                clock;
   logic                reset;
   logic [CWIDTH-1:0]   count;

   logic [WIDTH-1:0]    dut_result;
   logic [WIDTH-1:0]    expected_result;
   logic                dut_cout;
   logic                expected_cout;


   assign clock = CLOCK_50;
   assign reset = KEY[3] | KEY[2] | KEY[1] | KEY[0];
 
   // Design Under Test
   adder #(.WIDTH(WIDTH)) DUT (
      .ina(count[CWIDTH-1:WIDTH]),
      .inb(count[WIDTH-1:0]),
      .result(dut_result),
      .cout(dut_cout)
   );
  
   behavioral_adder #(.WIDTH(WIDTH)) Solution (
      .ina(count[CWIDTH-1:WIDTH]),
      .inb(count[WIDTH-1:0]),
      .result(expected_result),
      .cout(expected_cout)
   );

   always_ff @(posedge clock) begin
      if(!reset) count <= {CWIDTH{1'b0}};
      else if ((count != {CWIDTH{1'b1}}) && LEDG[0]) count <= count + 1'b1;
   end

   assign LEDG[0] = dut_result == expected_result && dut_cout == expected_cout;
   assign LEDG[1] = ~LEDG[0];

   /* Os LEDs não utilizados foram desligados. Fique a vontade para implementar
    * sua própria lógica! */
   assign LEDG[7:2] = 6'b000000;

endmodule
