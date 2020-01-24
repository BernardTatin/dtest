#
# makefile
# with Digital Mars make
#

D = dmd -I=. -release

MAIN = dhex
TOOLS = dhexd_tools

all: $(MAIN).exe

$(MAIN).exe: $(MAIN).obj $(TOOLS).obj 
	$(D) $** -of=$@

$(MAIN).obj: $(MAIN).d 
	$(D) -c  $** -of=$@

$(TOOLS).obj: $(TOOLS).d 
	$(D) -c  $** -of=$@

test:
	make all
	./$(MAIN).exe  dhexd-tools.obj README.md

clean:
	rm -fv $(MAIN).exe $(MAIN).obj $(TOOLS).obj
