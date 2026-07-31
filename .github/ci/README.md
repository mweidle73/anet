# Anet GitHub CI environment

This repository is a GitHub mirror/fork of Anet from
[codelabs.ch](https://www.codelabs.ch/anet/). The GitHub-only `abuild-gh`
branch extends the Abuild integration branch with CI and Pages configuration.
The three long-lived branches have distinct roles:

- `master` mirrors the Codelabs upstream repository.
- `abuild` mirrors the branch consumed by Abuild.
- `abuild-gh` adds only files below `.github/` to `abuild`.

The `run` helper builds a minimal Debian Trixie image and starts it as the
invoking host user. Its root filesystem is read-only, its network is disabled
by default after the image build, and the repository is mounted read-write at
`/work`. GitHub Actions and local development use the same entry point.

Run the complete build and test sequence from the Anet repository root:

```sh
ANET_CI_NETWORK=host .github/ci/run /bin/sh -c '
  set -eu
  make clean
  make -j8 NUM_CPUS=8
  make -j8 NUM_CPUS=8 VERSION=
  make -j8 NUM_CPUS=8 build-tests
  ./obj/linux/tests/test_runner
'
```

The host network is required because the IPv6 multicast test needs a complete
IPv6 network stack. Limit this less-isolated mode to the test invocation. The
Linux test suite deliberately skips raw packet and other privileged tests when
run as a non-root user. Build the HTML documentation with:

```sh
.github/ci/run /bin/sh -c 'set -eu; make build-doc'
```

With no command, `run` opens an interactive shell in `/work`:

```sh
.github/ci/run
```

Set `ANET_CI_IMAGE` to override the local image name, `DOCKER_PLATFORM` to
override the default `linux/amd64` platform, and `ANET_CI_NETWORK` to override
the default `none` network mode.
