// Module Purpose:
//    Top level interface from a DE2-115 FPGA board
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module de2_115top
	(
		////////////////////	Clock Input	 	////////////////////	 
		input 	wire 	CLOCK_50,			//	50 MHz
		////////////////////////	Push Button		////////////////////////
		input	wire	[3:0]	 KEY,					//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		input 	wire 	[17:0] SW,					//	Toggle Switch[17:0]
		////////////////////	7-SEG Display  ////////////////////
		output 	logic 	[6:0]  HEX0 				// 7-segment display
	);

	logic [3:0] digit;
	logic reset;

	//--------------------------------------------------------------------------
	assign reset = KEY[0];
	//--------------------------------------------------------------------------
	//	Output Logic
	//--------------------------------------------------------------------------
	hexto7seg hexto7seg_u0 (.x(digit), .segments(HEX0));
   //--------------------------------------------------------------------------

counter1second contador(
	.clock(CLOCK_50),
	.reset(reset), 
	.value(digit)
);


endmodule
