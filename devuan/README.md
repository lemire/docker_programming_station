# devuan

A **Devuan 6 (excalibur)** programming station - Debian without systemd.

Devuan is a fork of Debian whose reason for existing is init: it ships sysvinit
(and offers runit and OpenRC) in place of systemd. The compilers and libraries
are Debian's, so as a *build* environment it is very close to `debian13`; what
differs is everything around PID 1.

That makes it a useful check for code that has quietly grown a systemd
dependency - `libsystemd`, `sd_notify`, journald logging, socket activation, or
a build system that probes for `systemctl`. If it builds on `debian13` but not
here, that is what you have found.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 14.2.0 (Debian) |
| clang | 19.1.7 (Debian) |
| cmake | 3.31.6 |

Also: ninja, valgrind, gdb, llvm, clang-format, boost, libcurl, libicu,
hyperfine, python3, git, vim.

## Notes

Devuan 6 (excalibur) is the current stable release, tracking Debian 13. The
older `daedalus` (Devuan 5, tracking Debian 12) is tagged `oldstable`.

The published image is **x86-64 only**, so on an ARM host it runs under
emulation.

## Usage

```bash
dps run --img devuan 'gcc --version'
dps shell --img devuan
```

or, equivalently, from the directory you want to work in:

```bash
devuan/run-docker-station 'gcc --version'
```
