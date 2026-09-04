# gentoo

A **Gentoo Linux** programming station, built from `gentoo/stage3`.

Gentoo is a source-based distribution with its own toolchain layout and its own
ideas about default compiler flags. It is a useful outlier: code that assumes a
Debian-style filesystem, a particular `gcc` wrapper, or specific library
locations tends to trip here.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 15.3.0 |
| clang | from `llvm-core/clang` |
| cmake | 4.3.4 |

## Notes

Two Gentoo-specific details are worth knowing, because both have broken this
Dockerfile before.

The LLVM packages were **moved out of `sys-devel/`** into the `llvm-core/`
category, so the ebuild is `llvm-core/clang`, not `sys-devel/clang`.

Gentoo ships the `shadow` tools, so user creation uses `groupadd` and
`useradd`. It does **not** have Debian's `addgroup` / `adduser`.

The build runs `emerge --sync` and then installs **binary** packages (`emerge
-g`), which keeps it to a few minutes rather than the hours a full source build
would take. It is still the slowest of the distribution stations.

## Usage

From the directory holding the code you want to work on:

```bash
gentoo/run-docker-station 'gcc --version'
gentoo/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
