# Makefile snippet intended for inclusion by ../Makefile.

build-doc:
	rm -rf doc/html
	mkdir doc/html

	asciidoctor doc/index -o doc/html/index.html

clean: clean-doc
clean-doc:
	rm -rf doc/html
