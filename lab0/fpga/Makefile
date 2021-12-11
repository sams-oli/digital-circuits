###################################################################
# Project Configuration: 
# 
# Specify the name of the design (project) and the Quartus II
# Settings File (.qsf)
###################################################################

PROJECT = de2_115top
TOP = de2_115top
ASSIGNMENT_FILES = $(PROJECT).qpf $(PROJECT).qsf

###################################################################
# Part, Family, Boardfile DE1 or DE2
FAMILY = "Cyclone IV E"
PART = EP4CE115F29C7
BOARDFILE = de2_115_default.qsf
###################################################################

###################################################################
# Setup your sources here
SRCS = $(shell find ../verilog -name *.sv)
# SRCS = ../fpga/top_level.v \
#        ../fpga/nios.qsys

###################################################################
# Main Targets
#
# all: build everything
# clean: remove output files and database
# purge: cleanup all files inside fpga folder
# program: program your device with the compiled design
###################################################################

all: smart.log $(PROJECT).asm.rpt $(PROJECT).sta.rpt 

clean:
	rm -rf $(PROJECT).qsf *.rpt *.chg smart.log *.htm *.eqn *.pin *.sof *.pof db incremental_db

purge: 
	rm -rf $(PROJECT).qpf $(PROJECT).qsf *.rpt *.chg smart.log *.htm *.eqn *.pin *.sof *.pof db output_files simulation incremental_db *.summary *.qws *.smsg *.jdi *.sld

map: smart.log $(PROJECT).map.rpt
fit: smart.log $(PROJECT).fit.rpt
asm: smart.log $(PROJECT).asm.rpt
sta: smart.log $(PROJECT).sta.rpt
smart: smart.log

###################################################################
# Executable Configuration
###################################################################

MAP_ARGS = --read_settings_files=on $(addprefix --source=,$(SRCS))
FIT_ARGS = --part=$(PART) --read_settings_files=on
ASM_ARGS =
STA_ARGS =

###################################################################
# Target implementations
###################################################################

STAMP = echo done >

$(PROJECT).map.rpt: map.chg $(SRCS) 
	quartus_map $(MAP_ARGS) $(PROJECT)
	$(STAMP) fit.chg

$(PROJECT).fit.rpt: fit.chg $(PROJECT).map.rpt
	quartus_fit $(FIT_ARGS) $(PROJECT)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(PROJECT).asm.rpt: asm.chg $(PROJECT).fit.rpt
	quartus_asm $(ASM_ARGS) $(PROJECT)

$(PROJECT).sta.rpt: sta.chg $(PROJECT).fit.rpt
	quartus_sta $(STA_ARGS) $(PROJECT) 

smart.log: $(ASSIGNMENT_FILES)
	quartus_sh --determine_smart_action $(PROJECT) > smart.log

###################################################################
# Project initialization
###################################################################

$(ASSIGNMENT_FILES):
	quartus_sh --prepare -f $(FAMILY) -t $(TOP) $(PROJECT) 
	-cat $(BOARDFILE) >> $(PROJECT).qsf

map.chg:
	$(STAMP) map.chg
fit.chg:
	$(STAMP) fit.chg
sta.chg:
	$(STAMP) sta.chg
asm.chg:
	$(STAMP) asm.chg

###################################################################
# Programming the device
###################################################################

program: output_files/$(PROJECT).sof
	quartus_pgm --no_banner --mode=jtag -o "P;output_files/$(PROJECT).sof"

