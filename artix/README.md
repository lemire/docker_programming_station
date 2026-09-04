# artix

An **Artix Linux** programming station - Arch without systemd.

Artix gives you Arch's rolling, aggressively current package set (it is one of
the fastest distributions here to get a new GCC or clang) while running
OpenRC, runit, s6 or dinit instead of systemd. As a build environment it is
essentially Arch; the difference is init, which makes it a companion to
`devuan` for finding accidental systemd dependencies.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 16.2.1 |
| clang | 22.1.8 |
| cmake | 4.4.3 |

Also: gdb, ninja, git, vim, sudo, base-devel.

## Notes

Packages come from `pacman`. Because Artix is rolling, the Dockerfile runs a
full `pacman -Syu` first: on a rolling distribution you cannot install a new
package against a stale index without risking a partial upgrade.

The published image is **x86-64 only**, so on an ARM host it runs under
emulation. Upstream publishes one image per init system (`base-openrc`,
`base-runit`, `base-s6`, `base-dinit`); this station uses `base`, and any of the
others would work equally well for compiling.

## Usage

```bash
dps run --img artix 'gcc --version'
dps shell --img artix
```

or, equivalently, from the directory you want to work in:

```bash
artix/run-docker-station 'gcc --version'
```
