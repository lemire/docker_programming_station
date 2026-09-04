# ubuntu26

An **Ubuntu 26.04** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 15.2.0 |
| clang | 21.1.8 |
| cmake | 4.2.3 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

Ubuntu 26.04 LTS (resolute) is the newest LTS and the most current of the
plain Ubuntu stations. It carries GCC 15 and clang 21, and is the base used by
`ubuntulatestllvm`.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu26/run-docker-station 'gcc --version'
ubuntu26/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
