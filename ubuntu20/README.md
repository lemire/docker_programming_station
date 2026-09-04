# ubuntu20

An **Ubuntu 20.04** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 9.4.0 |
| clang | 10.0.0 |
| cmake | 3.16.3 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

This is the **compiler zoo**: it installs g++-7 through g++-10 and clang 6
through clang 11 side by side, plus Go, Ruby, R (with `r-base-dev` and
`r-cran-remotes`), Python with ipython, and gnuplot. If you need to bisect a
behaviour across several compiler versions, or build an R package, this is the
station to use. It is correspondingly the largest of the Ubuntu images.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu20/run-docker-station 'gcc --version'
ubuntu20/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
