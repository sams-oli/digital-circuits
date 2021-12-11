====================================================
 Instruções para o Makefile IntelFPGA Quartus Prime
====================================================

Esse script pode ser usado para compilar seus projetos em linha de comando,
ou seja, sem a interface gráfica.

Estrutura de diretórios
~~~~~~~~~~~~~~~~~~~~~~~~

Como o Quartus Prime irá produzir um monte de lixo no diretório de projeto,
uma estrutura de diretórios foi escolhida:
  
  fpga/

  verilog/

Seu código HDL vai dentro de *verilog/*.
O diretório fpga irá conter todo o necessário para uso no Quartus Prime.

Uso
~~~~

Para usar o script para compilar seus projetos, adicione todo seu códig HDL em verilog.
Edite o arquivo *fpga/Makefile* para atender às suas necessidades. As variáveis
mais interessantes devem ser:

* SRCS (seu código HDL)
* PROJECT (o nome do seu projeto)
* TOP_LEVEL_ENTITY (a entidade top level do seu projeto)
* FAMILY, PART and BOARDFILE (para pin assignments, e seleção do dispositivo)

Agora você pode criar e sintetizar seu projeto executando::

  user$: make
 
Para programar seu dispositivo FPGA use::

  user$: make program

Problemas conhecidos
~~~~~~~~~~~~~~~~~~~~

* Se voc6e gerou algum componente usando o QSys, verifique os caminhos no arquivo _hw.tcl correspondente e certifique-se de que ele está *dentro* (por enquanto ...) do diretório *sys/*.
