# voidlinux

A **Void Linux** programming station.

Void is an independent rolling-release distribution - not a fork of anything -
with its own package manager (`xbps`), runit instead of systemd, and a small,
current package set. It is a genuine outlier in this collection: independent
lineage, different init, different package tooling.

This station uses the **glibc** flavour. Void also publishes a musl flavour; if
musl is what you are after, `alpine` already covers that.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 14.2.1 |
| clang | 21.1.7 |
| cmake | 4.2.2 |

Also: gdb, ninja, git, vim, sudo, base-devel.

## Notes

Packages are installed with `xbps-install`. Void is rolling, so the Dockerfile
refreshes `xbps` itself first - the package manager must be current before it
will install anything else, and skipping that step is the usual cause of a
confusing failure.

`base-devel` on Void does **not** include `shadow` (so no `useradd`/`groupadd`)
or `findutils`; both are installed explicitly.

## Usage

```bash
dps run --img voidlinux 'gcc --version'
dps shell --img voidlinux
```

or, equivalently, from the directory you want to work in:

```bash
voidlinux/run-docker-station 'gcc --version'
```
