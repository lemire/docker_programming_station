# ubuntu25

An **Ubuntu 25.04** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 14.2.0 |
| clang | 20.1.2 |
| cmake | 3.31.6 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

Ubuntu 25.04 (plucky) is an interim release. It is still served from
`ports.ubuntu.com` / `archive.ubuntu.com` today, but as an interim release it
will eventually move to `old-releases.ubuntu.com` and will then need the same
sources rewrite that `ubuntu23` uses.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu25/run-docker-station 'gcc --version'
ubuntu25/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
