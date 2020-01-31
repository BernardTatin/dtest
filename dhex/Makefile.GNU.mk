#
# Makefile.GNU.mk
# for GNU make
#

compiler ?= dmd
D = $(compiler) -I=. -release -color

MAIN = dhex
TOOLS = dhexd_tools
INFOS = dhexd_infos


SRC = $(MAIN).d $(TOOLS).d $(INFOS).d
odir = obj
ddir = html-doc

EXE = $(MAIN).exe
OBJS = $(addprefix $(odir)/, $(patsubst %.d,%.o,$(notdir $(SRC))))
HTMLS = $(addprefix $(ddir)/, $(patsubst %.d,%.html,$(notdir $(SRC))))


all: $(odir) $(EXE)

doc: $(ddir) $(HTMLS)

$(odir):
	mkdir -p $(odir)

$(ddir):
	@echo "OBJS : $(OBJS)"
	@echo "HTMLS: $(HTMLS)"
	mkdir -p $(ddir)

$(EXE): $(OBJS)
	$(D) $(OBJS) -of=$@

$(odir)/%.o: %.d
	$(D) -c  $< -of=$@

$(ddir)/%.html: %.d
	$(D) -c -o- -D  $< -Df=$@


test: all
	./$(EXE) -h
	./$(EXE) -v
	./$(EXE) --help
	./$(EXE) --version
	./$(EXE)  dhexd-tools.o README.md

hdtest: all
	hexdump -vC $(odir)/$(MAIN).o | tr -s ' ' > ref.log
	./$(EXE) -q $(odir)/$(MAIN).o | tr -s ' '  > test.log
	diff ref.log test.log

clean:
	rm -fv $(EXE) $(OBJS) 
	rm -fv $(HTMLS)

.PHONY: all clean test hdtest doc
