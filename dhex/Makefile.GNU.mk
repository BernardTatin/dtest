#
# Makefile.GNU.mk
# for GNU make
#

# choose the compiler (dmd | ldc2)
compiler ?= dmd
# choose the version  (debug | release)
version ?= debug

ifeq ($(compiler),dmd)
	_version = -$(version)
	_color = -color
else
	_version =
	_color = --enable-color=true
endif
# basic compiler command
D = $(compiler) -I=. $(_version) $(_color)

# file definitions
MAIN = dhex
TOOLS = dhexdlib/dhexd_tools
INFOS = dhexdlib/dhexd_infos


# source file definitions
# main entry point
MAINSRC = $(MAIN).d
# library sources
LIBSRC = $(TOOLS).d $(INFOS).d
# all sources
SRC = $(MAINSRC) $(LIBSRC)

# directories
# object files
odir = obj-$(version)
# documentation drectories/subdirectories
ddir = html-doc
ddirlib = $(ddir)/dhexdlib

# the biary name
EXE = $(MAIN).exe
# the objs files
OBJS = $(addprefix $(odir)/, $(patsubst %.d,%.o,$(notdir $(SRC))))
# the documentation files
HTMLS = $(addprefix $(ddir)/, $(patsubst %.d,%.html,$(notdir $(MAINSRC)))) $(addprefix $(ddirlib)/, $(patsubst %.d,%.html,$(notdir $(LIBSRC))))

# target all: biary and doc
all: $(odir) $(EXE) doc

# target doc: all the html-files
doc: $(ddir) $(ddirlib) $(HTMLS)
	@echo "HTMLS: $(HTMLS)"

# creation of the objects directorie
$(odir):
	mkdir -p $(@)

#creation of the documentation directories
$(ddir):
	mkdir -p $(@)

$(ddirlib):
	mkdir -p $(@)

# creation of the final binary
$(EXE): $(OBJS)
	$(D) $(OBJS) -of=$@

# rules to build object files from source files
$(odir)/%.o: %.d
	$(D) -c  $< -of=$@

$(odir)/%.o: dhexdlib/%.d
	$(D) -c  $< -of=$@

# rules to build html files from source files
$(ddir)/%.html: %.d
	$(D) -c -o- -D  $< -Df=$@

$(ddirlib)/%.html: dhexdlib/%.d
	$(D) -c -o- -D  $< -Df=$@


# a simple test of command-line parameters
test: all
	./$(EXE) -h
	./$(EXE) -v
	./$(EXE) --help
	./$(EXE) --version
	./$(EXE)  dhexd-tools.o README.md

# a test for Linux: compare the output of the binaey file with
# the output of the hexdump tool from linux
hdtest: all
	hexdump -vC $(odir)/$(MAIN).o | tr -s ' ' > ref.log
	./$(EXE) -q $(odir)/$(MAIN).o | tr -s ' '  > test.log
	diff ref.log test.log

# nettoyage des fichiers produits
clean:
	rm -fv $(EXE) $(OBJS) 
	rm -fv $(HTMLS)

# targets which are not a file
.PHONY: all clean test hdtest doc
