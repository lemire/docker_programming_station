# debian12

A **Debian 12 (bookworm)** programming station.

Debian's stable release moves slowly and ships conservative compiler versions,
which makes it a good proxy for the toolchain your code will meet on a
long-lived server or in a distribution package. If something builds on the
newest Ubuntu but not here, you have probably used a very recent library or
compiler feature.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 12.2.0 (also g++-13) |
| clang | 14.0.6 (also clang-15) |
| cmake | 3.25.1 |

Also: ninja, valgrind, gdb, llvm, clang-format, boost, libcurl, libicu,
hyperfine, python3, git, vim.

## Usage

From the directory holding the code you want to work on:

```bash
debian12/run-docker-station 'gcc --version'
debian12/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
