# ubuntu18

An **Ubuntu 18.04** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 7.5.0 |
| cmake | 3.10.2 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

Ubuntu 18.04 is past end of life. GCC 7 was the first release with reasonable
C++17 support, which makes this a useful floor for C++17 code.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu18/run-docker-station 'gcc --version'
ubuntu18/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
