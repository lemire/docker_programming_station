# ubuntu24

An **Ubuntu 24.04** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 13.3.0 |
| clang | 18.1.3 |
| cmake | 3.28.3 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

Ubuntu 24.04 LTS, supported until 2029. Note that this directory previously
tracked 24.10 (oracular), an interim release that has since gone end of life and
been delisted; it now pins the 24.04 LTS release so that it keeps building.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu24/run-docker-station 'gcc --version'
ubuntu24/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
