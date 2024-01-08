# Makefile snippet intended for inclusion by ../Makefile.

DOCDIR = obj/html

$(DOCDIR):
	@mkdir -p $@

build-doc: doc/index | $(DOCDIR)
	asciidoctor doc/index -o $(DOCDIR)/index.html
