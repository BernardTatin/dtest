#
# makefile
# with Digital Mars make
#

D = dmd -I=. -release

MAIN = dhex
TOOLS = dhexd_tools
INFOS = dhexd_infos

all: $(MAIN).exe

$(MAIN).exe: $(MAIN).obj $(TOOLS).obj $(INFOS).obj
	$(D) $** -of=$@

$(MAIN).obj: $(MAIN).d
	$(D) -c  $** -of=$@

$(INFOS).obj: $(INFOS).d
	$(D) -c  $** -of=$@

$(TOOLS).obj: $(TOOLS).d
	$(D) -c  $** -of=$@

test:
	make all
	./$(MAIN).exe -h
	./$(MAIN).exe -v
	./$(MAIN).exe --help
	./$(MAIN).exe --version
	./$(MAIN).exe  dhexd-tools.obj README.md

clean:
	rm -fv $(MAIN).exe $(MAIN).obj $(TOOLS).obj $(INFOS).obj

# Digital Mars make needs some lines
