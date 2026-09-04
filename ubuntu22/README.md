# ubuntu22

An **Ubuntu 22.04** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 11.4.0 |
| clang | 14.0.0 |
| cmake | 3.22.1 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

Ubuntu 22.04 LTS is the **default** station: the Dockerfile at the top of this
repository is a copy of this one, and the `rds` script uses it. When in doubt,
start here.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu22/run-docker-station 'gcc --version'
ubuntu22/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
