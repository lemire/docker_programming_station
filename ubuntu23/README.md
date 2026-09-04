# ubuntu23

An **Ubuntu 23.10** programming station.

The `ubuntuNN` directories exist so you can reproduce a build against the exact
toolchain a given Ubuntu release ships, without changing anything on your own
machine. They deliberately span more than a decade of GCC releases, from GCC 5
to GCC 15, which makes them useful for tracking down when a warning, an
optimisation, or a standard-library behaviour changed.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 13.2.0 |
| clang | 16.0.6 |
| cmake | 3.27.4 |

Also, depending on the release: ninja, valgrind, gdb, llvm, clang-format,
boost, libcurl, libicu, hyperfine, `linux-tools-generic` (for `perf`), python3,
git and vim.

## Notes

Ubuntu 23.10 (mantic) is an interim release that reached end of life in July
2024, and its packages have been removed from `archive.ubuntu.com` and
`ports.ubuntu.com`. The Dockerfile therefore rewrites the apt sources to
`old-releases.ubuntu.com` before the first `apt-get update`; without that
rewrite the build fails immediately.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntu23/run-docker-station 'gcc --version'
ubuntu23/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
