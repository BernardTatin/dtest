#
# Makefile.GNU.mk
# for GNU make
#
# Usage:
#		$ make -f Makefile.GNU.mk \
#			compiler=dmd version=debug -I../mk clean hdtest
#


# lib directory
LIBDIR = dhexdlib

# file definitions
MAIN = dhex
TOOLS = $(LIBDIR)/dhexd_tools
INFOS = $(LIBDIR)/dhexd_infos


# source file definitions
# main entry point
MAINSRC = $(MAIN).d
# library sources
LIBSRC = $(TOOLS).d $(INFOS).d
# all sources
SRC = $(MAINSRC) $(LIBSRC)

include compiler.mk
include targets.mk

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

# targets which are not a file
.PHONY:  test hdtest
