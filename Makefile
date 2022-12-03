PREFIX   ?= $(HOME)/libraries
TESTDIR   = tests
OBJDIR    = obj/$(OS)
COVDIR    = $(OBJDIR)/coverage
LIBDIR    = lib

MAJOR    = 0
MINOR    = 4
REVISION = 2
VERSION  = $(MAJOR).$(MINOR).$(REVISION)
ANET     = libanet-$(VERSION)
TARBALL  = $(ANET).tar.bz2

LIBRARY_KIND = dynamic

OS ?= linux

NUM_CPUS ?= 1

# GNAT_BUILDER_FLAGS may be overridden in the
# environment or on the command line.
GNAT_BUILDER_FLAGS ?= -R -j$(NUM_CPUS)
# GMAKE_OPTS should not be overridden because -p is essential.
GMAKE_OPTS = -p ${GNAT_BUILDER_FLAGS} \
  $(foreach v,ADAFLAGS LDFLAGS OS VERSION,'-X$(v)=$($(v))')

# This variable explicitly exists for override by people with a
# different directory hierarchy.
# exec is unrelated and currently only used by tests
GPRINSTALLFLAGS := \
  --prefix=$(DESTDIR)$(PREFIX) \
  --no-manifest \
  --exec-subdir=tests \
  --ali-subdir=lib/anet \
  --lib-subdir=lib \
  --project-subdir=lib/gnat \
  --sources-subdir=include/anet \
  # EOL

all: build_lib

build_lib:
	gprbuild $(GMAKE_OPTS) anet.gpr -XLIBRARY_KIND=$(LIBRARY_KIND)

build_tests:
	gprbuild $(GMAKE_OPTS) anet_tests.gpr -XLIBRARY_KIND=static -XBUILD=tests

tests: build_tests
	$(OBJDIR)/$(TESTDIR)/test_runner

build_all: build_tests build_lib

cov:
	rm -f $(COVDIR)/*.gcda
	gprbuild $(GMAKE_OPTS) anet_tests.gpr -XLIBRARY_KIND=static -XBUILD=coverage
	$(COVDIR)/test_runner || true
	lcov -c -d $(COVDIR) -o $(COVDIR)/cov.info
	lcov -e $(COVDIR)/cov.info "$(PWD)/src/*.adb" -o $(COVDIR)/cov.info
	genhtml --no-branch-coverage $(COVDIR)/cov.info -o $(COVDIR)

examples:
	gprbuild $(GMAKE_OPTS) anet_examples.gpr -XLIBRARY_KIND=static

install: build_lib
	gprinstall -Panet.gpr -f -p $(GPRINSTALLFLAGS) \
	  -XVERSION=$(VERSION) -XOS=$(OS) -XLIBRARY_KIND=$(LIBRARY_KIND)

install_tests: build_tests
	gprinstall -Panet_tests.gpr -f -p $(GPRINSTALLFLAGS) \
	  -XVERSION= -XBUILD=tests -XOS=$(OS) -XLIBRARY_KIND=static
	cp -r data $(DESTDIR)$(PREFIX)/$(TESTDIR)

doc:
	$(MAKE) -C doc

clean:
	rm -rf $(OBJDIR)
	rm -rf $(LIBDIR)
	$(MAKE) -C doc clean

dist:
	@echo "Creating release tarball $(TARBALL) ... "
	git archive --format=tar HEAD --prefix $(ANET)/ | bzip2 > $(TARBALL)

.PHONY: doc examples tests
