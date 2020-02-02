#
# Makefile.GNU.mk
# for GNU make
#

compiler ?= dmd
D = $(compiler) -I=. -release -color

MAIN = dhex
TOOLS = dhexdlib/dhexd_tools
INFOS = dhexdlib/dhexd_infos


MAINSRC = $(MAIN).d
LIBSRC = $(TOOLS).d $(INFOS).d
SRC = $(MAINSRC) $(LIBSRC)
odir = obj
ddir = html-doc
ddirlib = $(ddir)/dhexdlib

EXE = $(MAIN).exe
OBJS = $(addprefix $(odir)/, $(patsubst %.d,%.o,$(notdir $(SRC))))
HTMLS = $(addprefix $(ddir)/, $(patsubst %.d,%.html,$(notdir $(MAINSRC)))) $(addprefix $(ddirlib)/, $(patsubst %.d,%.html,$(notdir $(LIBSRC))))


all: $(odir) $(EXE)

doc: $(ddir) $(ddirlib) $(HTMLS)
	@echo "HTMLS: $(HTMLS)"

$(odir):
	mkdir -p $(@)

$(ddir):
	mkdir -p $(@)

$(ddirlib):
	mkdir -p $(@)

$(EXE): $(OBJS)
	$(D) $(OBJS) -of=$@

$(odir)/%.o: %.d
	$(D) -c  $< -of=$@

$(odir)/%.o: dhexdlib/%.d
	$(D) -c  $< -of=$@

$(ddir)/%.html: %.d
	$(D) -c -o- -D  $< -Df=$@

$(ddirlib)/%.html: dhexdlib/%.d
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
