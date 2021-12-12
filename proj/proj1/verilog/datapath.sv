`timescale 1ns / 1ps
`include "alu.sv"
`include "aludec.sv"
`include "register_file.sv"
`include "sext.sv"

module datapath #(parameter Dbits = 32, parameter Nloc = 32 )(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [1:0] pcsel,
    input wire [1:0] wasel,
    input wire bsel,
    input wire [1:0] wdsel,
    input wire [4:0] alufn,
    input wire sext,
    input wire werf,
    input wire [31:0] instr,
    input wire [1:0] asel,
    input wire [31:0] mem_readdata,
    output reg [31:0] pc,
    output wire Z,
    output wire [31:0] mem_addr,
    output wire [31:0] mem_writedata,
    output wire [Dbits-1:0] ReadData1,
    output wire [Dbits-1:0] ReadData2,
    output wire [Dbits-1:0] alu_result
);

    wire [31:0] pcPlus4;
    wire [31:0] signImm;
    wire [31:0] J, JT, BT;
    wire [4:0] Rs, Rt, Rd;
    wire [31:0] reg_writeaddr, reg_writedata;
    wire [4:0] aluop;
    wire [Dbits-1:0] aluA,aluB;
    wire  [5:0] funct, opcode;
       
 
    // Branching/Jumping

    assign JT = ReadData1;
    assign J = instr[25:0];
    assign BT = pcPlus4 + (signImm << 2);
    
   
    // Register File
    
    assign Rs = instr[25:21];
    assign Rt = instr[20:16];
    assign Rd = instr[15:11];
    assign reg_writeaddr = (wasel == 2'b00) ? Rd : (wasel == 2'b01) ? Rt : 31;
    assign reg_writedata = (wdsel == 2'b00) ? pcPlus4 : (wdsel == 2'b01) ? alu_result : mem_readdata;
   
    register_file #(Nloc, Dbits) REG(
        clk, werf, Rs, Rt, reg_writeaddr, 
        reg_writedata, ReadData1, ReadData2
        );
     
    // sext
    
    sext signExt(sext, instr[15:0], signImm);
    
    // alu e aludec

    aludec ALUDEC(funct, opcode, aluop);

    alu ALU(aluA, aluB, aluop, alu_result, Z);

    assign ReadData1 = aluA;
    assign ReadData2 = aluB;
    assign Z = (alu_result == 0) ? 1'b1 : 1'b0;
    
endmodule
