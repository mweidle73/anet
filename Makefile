PREFIX   ?= $(HOME)/libraries
TESTDIR   = tests
OBJDIR    = obj/$(OS)
COVDIR    = $(OBJDIR)/coverage
LIBDIR    = lib/$(OS)

MAJOR    = 0
MINOR    = 4
REVISION = 3
# Set VERSION to '' for a static library.
VERSION  = $(MAJOR).$(MINOR).$(REVISION)
ANET     = libanet-$(VERSION)
TARBALL  = $(ANET).tar.bz2

OS ?= linux

NUM_CPUS ?= $(shell nproc)

# GNAT_BUILDER_FLAGS may be overridden in the
# environment or on the command line.
GNAT_BUILDER_FLAGS ?= -R -j$(NUM_CPUS)
# GMAKE_OPTS should not be overridden because -p is essential.
GMAKE_OPTS = -p ${GNAT_BUILDER_FLAGS} \
  $(foreach v,ADAFLAGS LDFLAGS OS,'-X$(v)=$($(v))')

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

all: build-lib

build-lib:
	gprbuild $(GMAKE_OPTS) anet.gpr -XVERSION=$(VERSION)

build-tests:
	gprbuild $(GMAKE_OPTS) anet_tests.gpr -XVERSION= -XBUILD=tests

tests: build-tests
	$(OBJDIR)/$(TESTDIR)/test_runner

build-all: build-tests build-lib

cov:
	rm -f $(COVDIR)/*.gcda
	gprbuild $(GMAKE_OPTS) anet_tests.gpr -XVERSION= -XBUILD=coverage
	$(COVDIR)/test_runner || true
	lcov -c -d $(COVDIR) -o $(COVDIR)/cov.info
	lcov -e $(COVDIR)/cov.info "$(PWD)/src/*.adb" -o $(COVDIR)/cov.info
	genhtml --no-branch-coverage $(COVDIR)/cov.info -o $(COVDIR)

build-examples:
	gprbuild $(GMAKE_OPTS) anet_examples.gpr -XVERSION=

install: build-lib
	gprinstall -Panet.gpr -f -p $(GPRINSTALLFLAGS) \
	  -XVERSION=$(VERSION) -XOS=$(OS)

install-tests: build-tests
	gprinstall -Panet_tests.gpr -f -p $(GPRINSTALLFLAGS) \
	  -XVERSION= -XBUILD=tests -XOS=$(OS)
	cp -r data $(DESTDIR)$(PREFIX)/$(TESTDIR)

clean:
	rm -rf $(OBJDIR)
	rm -rf $(LIBDIR)

dist:
	@echo "Creating release tarball $(TARBALL) ... "
	git archive --format=tar HEAD --prefix $(ANET)/ | bzip2 > $(TARBALL)

.PHONY: tests

include doc/doc.mk
