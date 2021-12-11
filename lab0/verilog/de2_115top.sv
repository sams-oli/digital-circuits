// Module Purpose:
//    Módulo top level do Lab 0
// -----------------------------------------------------------------------------
`default_nettype none

module de2_115top ( 	input  wire  [17:0] 	SW,
                   	input  wire  [3:0] 	KEY,
                   	input  wire		 	   CLOCK_50,
                   	output logic [17:0] 	LEDR,
                   	output logic [7:0]  	LEDG
                  );

// Exemplo de porta AND (LEDG0 exibe (SW0)*(SW1)):
and (LEDG[0], SW[0], SW[1]);



/* Esse código apresenta um exemplo de instanciação de módulo (você
 *  precisará implementar o mux2_1 para que ele funcione). Se você
 *  implementou corretamente o módulo mux2_1, deverá ser capaz de usar
 *  a chave 'SW4' para selecionar entre os valores da chave 'SW2' e
 *  'SW3', o qual será exibido no LEDG1. */
mux2_1 gpio_mux2_1 (
	.a(SW[2]),
	.b(SW[3]),
	.sel(SW[4]),
	.out(LEDG[1])
);



/*
 *  Agora, implemente um somador completo em fa.v. Depois instancie o módulo
 *  fa no local destacado abaixo de modo que as entradas para o somador sejam
 *  as chaves GPIO DIP switches 5-7. A soma será exibida no LEDG2 e o carry
 *  de saída é exibido no LED3. Por fim, apague a linha especificada abaixo.
 */

/******** SEU CÓDIGO AQUI ********/

fa gpio_fa (
	.ina(SW[5]),
	.inb(SW[6]),
	.cin(SW[7]),
	.sum(LEDG[2]),
	.cout(LEDG[3])
);

/******** FIM DO SEU CÓDIGO ******/

/* O módulo Adder já foi instanciado para você.
 *  Uma solução correta irá acender o LEDG4.
 *  Uma solução incorreta irá acender os LEDs vermelhos.
 */

parameter 	WIDTH   = 8;
localparam 	CWIDTH = WIDTH*2;

logic                clock;
logic                reset;
logic [CWIDTH-1:0]   count;
logic [WIDTH-1:0]    dut_result;
logic [WIDTH-1:0]    expected_result;
logic                dut_cout;
logic                expected_cout;

assign clock = CLOCK_50;
assign reset = KEY[3] | KEY[2] | KEY[1] | KEY[0];

// Circuit Under Test
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
   if (!reset) count <= {CWIDTH{1'b0}};
   else if ((count != {CWIDTH{1'b1}}) && LEDG[4]) count <= count + 1'b1;
end

// Somente o LEDG4 irá acender se o seu adder.v funcionar corretamente
assign LEDG[4] = dut_result == expected_result && dut_cout == expected_cout;

// Todos os LEDR irão acender se o seu somador estiver incorreto
assign LEDR = {~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4],
               ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4],
               ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4], ~LEDG[4]};
endmodule
