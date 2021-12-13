// Module Purpose:
//		Interface top lvel para a placa FPGA DE2-115
// -----------------------------------------------------------------------------

module de2_115top (
	////////////////////////	Clock Input	 	////////////////////////
	input  wire				CLOCK_50,						//	50 MHz
	////////////////////////	Push Button		////////////////////////
	input  wire	 [3:0]	KEY,								//	Pushbutton[3:0]
	////////////////////////	DIP Switch		////////////////////////
	input  wire	 [17:0]	SW,								//	Toggle Switch[3:0]
	////////////////////////	  LEDs		   ////////////////////////
	output logic [8:0] 	LEDG,								//	Green LEDs
	output logic [17:0]	LEDR								//	Red LEDs
);

	logic	[2:0]				state;
	logic	[2:0]				debug_state;
	
	logic						enter;
	logic						open;
	logic						fail;
	logic	[3:0]				digit;
	logic						lock_reset;

	assign lock_reset 	= KEY[0];
	assign digit 	 	= SW[3:0];
	
	//--------------------------------------------------------------------------
	//	Parsing das entradas com botões
	//--------------------------------------------------------------------------

	level2pulse	lock_enter_pulse	(	
						.clock(				CLOCK_50),
						.reset(				lock_reset),
						.level(				KEY[3]),
						.pulse(				enter));		

	//--------------------------------------------------------------------------
	//	Lab5Lock
	//--------------------------------------------------------------------------
	lab6lock		lab6lock_fsm (
						.clock(				CLOCK_50),
						.reset(				lock_reset),
						.enter(				enter),
						.digit(				digit),
						.state(				state),
						.open(				open),
						.fail(				fail));
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Lógica de Saída
	//--------------------------------------------------------------------------
   // Deputação dos estados da FSM através dos LEDs 8 até 6
   assign  LEDG[8:6]	 =	~state;

	// Os LEDs verdes 0 a 3 acendem quando a trava é aberta
	assign  LEDG[3:0]	 =	{open,open,open,open};
	// Os LEDs vermelhos 0 a 4 irão acender quando o destravamento falhar.
	assign  LEDR[3:0]  =	{fail,fail,fail,fail};
	//--------------------------------------------------------------------------	

endmodule
