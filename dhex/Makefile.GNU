#
# makefile
# with Digital Mars make
#

D = ldc2 -I=. -release

MAIN = dhex
TOOLS = dhexd_tools
INFOS = dhexd_infos

OBJS = $(MAIN).o $(TOOLS).o $(INFOS).o

all: $(MAIN)

$(MAIN): $(OBJS)
	$(D) $(OBJS) -of=$@

$(MAIN).o: $(MAIN).d 
	$(D) -c  $** -of=$@

$(INFOS).o: $(INFOS).d 
	$(D) -c  $** -of=$@

$(TOOLS).o: $(TOOLS).d 
	$(D) -c  $** -of=$@

test: all
	./$(MAIN) -h
	./$(MAIN) -v
	./$(MAIN) --help
	./$(MAIN) --version
	./$(MAIN)  dhexd-tools.o README.md

clean:
	rm -fv $(MAIN) $(MAIN).o $(TOOLS).o $(INFOS).o

.PHONY: all clean test
