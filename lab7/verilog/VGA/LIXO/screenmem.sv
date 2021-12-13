`timescale 1ns / 1ps
`default_nettype none

module screenmem #(
   parameter Nloc = 1200,                     
   parameter Dbits = 4,                       
   parameter initfile = "smem_screentest.men"
   )(
      input wire clock, 
      input wire wr,           
      input wire [$clog2(Nloc)-1 : 0] ReadAddr1, ReadAddr2, WriteAddr,
      input wire [Dbits-1 : 0] WriteData,  
      output logic [Dbits-1 : 0] ReadData1, ReadData2 
   );

   logic [Dbits-1 : 0] rf [Nloc-1 : 0];
   initial $readmemh(initfile, rf, 0, Nloc-1);     

   always_ff @(posedge clock)
      if(wr)
         rf[WriteAddr] <= WriteData;
   
   assign ReadData1 = rf[ReadAddr1];                 
   assign ReadData2 = rf[ReadAddr2];                  
   
endmodule