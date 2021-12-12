`timescale 1ns / 1ps

module sext(
    input wire sext,
    input wire [15:0] instr,
    output logic [31:0] signImm
    );
    
    assign signImm = sext ? {{16{instr[15]}}, instr} : {{16{32'h00}}, instr};
    
endmodule