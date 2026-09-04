# slackware

A **Slackware 15.0** programming station.

Slackware is the oldest surviving Linux distribution, and it is deliberately
unlike everything else here. There is **no dependency resolution**: packages are
installed as whole *series* (`a` base, `l` libraries, `n` network, `ap`
applications, `d` development), and if you install a program without the
library series it needs, it simply fails to start.

It also carries an older, very stable toolchain - GCC 11 - which makes it a
useful floor for C++20 support, and a good check that your build does not
silently rely on a recent compiler or a recent CMake.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 11.2.0 |
| cmake | 3.21.4 |
| git | 2.46.4 |

Also: make, gdb, vim, and the rest of the `d` development series.

## Notes

The Dockerfile installs **series rather than individual packages**, which is the
Slackware way and the only sane approach in a container: naming packages one by
one means discovering each missing shared library at run time and chasing it by
hand. Building this station taught that lesson twice - first `libarchive.so.13`
from the `l` series, then `libnghttp2.so.14` from `n`, both needed by `cmake`.

Upstream also publishes a `15.0-full` tag with a complete Slackware install,
which needs no `slackpkg` steps at all. It is not used here because it is about
**14.8 GB**, against roughly a quarter of that for the series this station
installs.

The image is pinned to `linux/amd64`: upstream publishes 386, amd64 and arm/v7,
but no arm64, and x86-64 is Slackware's flagship target. On an ARM host it runs
under emulation.

## Usage

```bash
dps run --img slackware 'gcc --version'
dps shell --img slackware
```

or, equivalently, from the directory you want to work in:

```bash
slackware/run-docker-station 'gcc --version'
```
