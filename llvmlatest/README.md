# llvmlatest

A **bleeding-edge LLVM** programming station, based on `silkeh/clang:dev` -
a nightly snapshot of the LLVM development branch on Debian 12.

Where `ubuntulatestllvm` tracks the newest *packaged* LLVM release, this one
tracks LLVM trunk. Use it to check whether a miscompilation has already been
fixed upstream, to try a diagnostic that only exists in trunk, or to get early
warning that a future clang will reject your code.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| clang / clang++ | 22.0.0 (development snapshot) |
| gcc / g++ | 12.2.0 (Debian) |
| cmake | 3.25.1 |

Also: ninja, valgrind, gdb, boost, libcurl, libicu, hyperfine, python3, git.

## Notes

`silkeh/clang:dev` is published for **x86-64 only**. On an ARM host it runs
under emulation, which works but is noticeably slower - and `uname -m` inside
the container will report `x86_64` even on an ARM machine. That is expected.

Because the base image is a moving nightly, rebuild with
`remove-docker-station` when you want a fresher compiler.

## Usage

From the directory holding the code you want to work on:

```bash
llvmlatest/run-docker-station 'gcc --version'
llvmlatest/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
