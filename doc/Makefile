DESTDIR ?= html

all: $(DESTDIR)/index.html

$(DESTDIR)/index.html: $(DESTDIR)/fonts $(DESTDIR)/css/font-awesome.css
$(DESTDIR)/index.html: index ../README css/styles.css | $(DESTDIR)
	asciidoctor $< -o $@

$(DESTDIR)/css/font-awesome.css: css/font-awesome.css | $(DESTDIR)
	mkdir -p $(DESTDIR)/css
	cp $< $@

$(DESTDIR)/fonts: fonts | $(DESTDIR)
	cp -R $< $@

$(DESTDIR):
	mkdir $@

clean:
	rm -rf $(DESTDIR)
