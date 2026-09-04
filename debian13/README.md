# debian13

A **Debian 13 (trixie)** programming station.

Debian's current stable release. Where `debian12` shows you the conservative
toolchain still running on long-lived servers, this one shows where Debian
stable has moved to: GCC 14 and clang 19. Useful for checking that code builds
on both sides of a Debian upgrade.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 14.2.0 |
| clang | 19.1.7 |
| cmake | 3.31.6 |

Also: ninja, valgrind, gdb, llvm, clang-format, boost, libcurl, libicu,
hyperfine, python3, git, vim.

## Usage

```bash
dps run --img debian13 'gcc --version'
dps shell --img debian13
```

or, equivalently, from the directory you want to work in:

```bash
debian13/run-docker-station 'gcc --version'
```
