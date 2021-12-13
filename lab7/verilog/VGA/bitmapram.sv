`timescale 1ns / 1ps
`default_nettype none

module bitmapram #(
   parameter Nloc = 4096,
   parameter Dbits = 12,                       
   parameter initfile = "C:/Users/user/Desktop/lab7/verilog/VGA/bmem_screentest.mem"
   )(
   input wire [$clog2(Nloc)-1 : 0] bitmap_addr,
   output logic [Dbits-1 : 0] color_value
   );

   logic [Dbits-1 : 0] rf [Nloc-1 : 0];           
   initial $readmemh(initfile, rf, 0, Nloc-1);     
   
   assign color_value = rf[bitmap_addr];                  
   
endmodule