DESTDIR ?= html

all: $(DESTDIR)/index.html

$(DESTDIR)/index.html: $(DESTDIR)/fonts
$(DESTDIR)/index.html: index ../README css/styles.css | $(DESTDIR)
	asciidoctor $< -o $@

$(DESTDIR)/fonts: fonts | $(DESTDIR)
	cp -R $< $@

$(DESTDIR):
	mkdir $@

clean:
	rm -rf $(DESTDIR)
