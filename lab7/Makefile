
.PHONY: all vlog

all: vlog 


vlog:
	irun src/*.sv -coverage functional -covoverwrite
	rm -rf cov_work INCA_libs $(wildcard irun.*)

