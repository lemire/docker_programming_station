# gcc16

A **GCC 16** programming station, based on the official `gcc:16` image
(Debian 13 trixie).

The official GCC images carry a compiler built from the GCC project's own
release rather than a distribution package, so this is the cleanest way to try
the newest GCC without waiting for it to appear in a distribution. Handy for
checking new warnings, new optimisations, and C++26 support.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 16.2.0 |
| cmake | 3.31.6 |
| go | from Debian |
| python3 + ipython | from Debian |
| ruby | from Debian |

Also: ninja, valgrind, gnuplot, curl, wget, git, vim.

The extra languages and gnuplot make this a reasonable general-purpose station
for benchmarking work, not just a compiler test bed.

## Usage

From the directory holding the code you want to work on:

```bash
gcc16/run-docker-station 'gcc --version'
gcc16/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
