`timescale 1ns / 1ps
`default_nettype none

module screenmem #(
   parameter Nloc = 1200,                     
   parameter Dbits = 4,                       
   parameter initfile = "C:/Users/user/Desktop/lab7/verilog/VGA/smem_screentest.mem"
   )(
      input wire clock, 
      input wire wr,           
      input wire [$clog2(Nloc)-1 : 0] screen_addr, WriteAddr,
      input wire [Dbits-1 : 0] WriteData,  
      output logic [Dbits-1 : 0] character_code 
   );

   logic [Dbits-1 : 0] rf [Nloc-1 : 0];
   initial $readmemh(initfile, rf, 0, Nloc-1);     

   always_ff @(posedge clock)
      if(wr)
         rf[WriteAddr] <= WriteData;
   
   assign character_code = rf[screen_addr];                                 
   
endmodule