#
# Makefile.GNU.mk
# for GNU make
#

compiler ?= dmd
D = $(compiler) -I=. -release -color

MAIN = dhex
TOOLS = dhexd_tools
INFOS = dhexd_infos

OBJS = $(MAIN).o $(TOOLS).o $(INFOS).o

all: $(MAIN)

$(MAIN): $(OBJS)
	$(D) $(OBJS) -of=$@

$(MAIN).o: $(MAIN).d
	$(D) -D $< -Dd=doc
	$(D) -c  $* -of=$@

$(INFOS).o: $(INFOS).d
	$(D) -D $< -Dd=doc
	$(D) -c  $* -of=$@

$(TOOLS).o: $(TOOLS).d
	$(D) -D $< -Dd=doc
	$(D) -c  $* -of=$@

test: all
	./$(MAIN) -h
	./$(MAIN) -v
	./$(MAIN) --help
	./$(MAIN) --version
	./$(MAIN)  dhexd-tools.o README.md

hdtest: all
	hexdump -vC $(MAIN).o | tr -s ' ' > ref.log
	./$(MAIN) -q $(MAIN).o | tr -s ' '  > test.log
	diff ref.log test.log

clean:
	rm -fv $(MAIN) $(MAIN).o $(TOOLS).o $(INFOS).o

.PHONY: all clean test hdtest
