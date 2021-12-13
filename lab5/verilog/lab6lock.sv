// Module Purpose:
//		Este módulo implementa a funcionalidade de uma trava combinacional simples.
// 	A trava usa a combinação de 2 dígitos de 4-bits.
// 	Leia o documento do laboratório para obter uma sugestão de combinação.
// -----------------------------------------------------------------------------
//	Params:		Este módulo não é parametrizado.
//	Inputs:		Ver documento do laboratório.
//	Outputs:		Ver documento do laboratório.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module lab6lock (
	//--------------------------------------------------------------------------
	//	Clock & Reset Inputs
	//--------------------------------------------------------------------------
	input	wire				clock,	// System clock
	input	wire				reset,	// System reset
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Inputs
	//--------------------------------------------------------------------------
	input	wire				enter,
	input	wire	[3:0]		digit,
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Outputs
	//--------------------------------------------------------------------------
	output logic 	[2:0]		state,
	output logic				open,
	output logic				fail
	//--------------------------------------------------------------------------
	);

	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	localparam			DIGIT_1	=	4'h2,
					DIGIT_2	=	4'h3;
										
	//--------------------------------------------------------------------------
	

	//--------------------------------------------------------------------------
	//	Codificação dos estados
	//--------------------------------------------------------------------------
	parameter [3:0] 	LOCKED  = 4'b0000,
							BAD1 = 4'b0001,
							BAD2 = 4'b0010,
							OPEN = 4'b0011,
							OK1 = 4'b0100;
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Declaração dos wires
	//--------------------------------------------------------------------------
		
	reg [3:0] prox;
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Lógica
	//--------------------------------------------------------------------------
	always @(posedge clock or negedge reset)
   		if (!reset) state <= LOCKED;
   		else        state <= prox;


	always @(digit) begin
   		prox = 4'bx;
    	fail = 1'b0;
    	open = 1'b0;

    case (state)

      LOCKED : begin
		if (enter) begin
		if (digit == DIGIT_1)       prox = OK1;
		else           prox = BAD1;
			end
		else begin
			prox = LOCKED;
			end
	end

      BAD1: begin
      	if (enter) begin
      		prox = BAD2;
		end
		else begin
           	prox = BAD1;
        end
	end

      BAD2: begin
			fail = 1'b1;
			prox = BAD2;
		end

      OK1: begin
		if (enter) begin
  		if (digit == DIGIT_2)       prox = OPEN;
               else           prox = BAD2;
           end
           else begin
           	prox = OK1;
           end
       end

      OPEN: begin
			open = 1'b1;
			prox = OPEN;
		end

    endcase
  end
	//--------------------------------------------------------------------------
endmodule // lab6lock
