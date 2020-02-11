#
# targets.mk
#

# directories
# object files
odir = obj-$(version)
# documentation drectories/subdirectories
ddir = html-doc

# the biary name
EXE = $(MAIN).exe
# the objs files
OBJS = $(addprefix $(odir)/, $(patsubst %.d,%.o,$(notdir $(SRC))))
# the documentation files
HTMLS = $(addprefix $(ddir)/, $(patsubst %.d,%.html,$(notdir $(SRC))))

# target all: biary and doc
all: $(EXE) doc

# target doc: all the html-files
doc: $(ddir) $(HTMLS)
	@echo "HTMLS: $(HTMLS)"

# creation of the objects directorie
$(odir):
	mkdir -p $(@)

#creation of the documentation directories
$(ddir):
	mkdir -p $(@)

# creation of the final binary
$(EXE): $(odir) $(OBJS)
	$(D) $(OBJS) -of=$@

# rules to build object files from source files
$(odir)/%.o: %.d
	$(D) -c  $< -of=$@

$(odir)/%.o: $(LIBDIR)/%.d
	$(D) -c  $< -of=$@

# rules to build html files from source files
$(ddir)/%.html: %.d
	$(D) -c -o- -D  $< -Df=$@

$(ddir)/%.html: $(LIBDIR)/%.d
	$(D) -c -o- -D  $< -Df=$@


# nettoyage des fichiers produits
clean:
	rm -fv $(EXE) $(OBJS)
	rm -fv $(HTMLS)

# targets which are not a file
.PHONY: all clean test hdtest doc
