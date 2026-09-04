# rocky10

A **Rocky Linux 10** programming station - a rebuild of Red Hat Enterprise
Linux 10.

This is the enterprise target. RHEL and its rebuilds are what a great deal of
production and HPC infrastructure actually runs, and they pin a compiler for
years at a time. If you ship software that others deploy on RHEL, building it
here is the closest you get to their machine without owning one.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 14.3.1 (Red Hat) |
| clang | 21.1.8 (RESF) |
| cmake | 3.31.8 |

Also: gdb, make, git, vim, diffutils, sudo.

## Notes

Two repositories beyond the defaults are enabled in the Dockerfile, because the
base RHEL package set is deliberately small: **EPEL** (Extra Packages for
Enterprise Linux) and **CRB** (CodeReady Builder), which is where many `-devel`
packages live. Without CRB you will find headers missing that every other
distribution here provides by default.

Note that RHEL-family 10 does **not** package `qemu-user-static`, which matters
if this is your host and you want to use the emulated stations - see the
[QEMU section of the top-level README](../README.md#qemu).

## Usage

```bash
dps run --img rocky10 'gcc --version'
dps shell --img rocky10
```

or, equivalently, from the directory you want to work in:

```bash
rocky10/run-docker-station 'gcc --version'
```
