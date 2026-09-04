# s390

A **big-endian** programming station: IBM z/Architecture (s390x) on
**Ubuntu 20.04**.

This is the most valuable container in the repository for correctness testing,
because s390x is the only widely available **big-endian** Linux target left.
Almost every other machine you touch - x86, ARM, POWER as shipped, RISC-V - is
little-endian, so endianness bugs can hide for years. Serialisation code, binary
file formats, network protocols, hash functions, and anything that reinterprets
bytes through a union or a `memcpy` into an integer will fail here if it makes
endianness assumptions.

It is also a strict-alignment, different-vector-unit target, which shakes out a
second class of portability bug.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 9.4.0 |
| cmake | 3.16.3 |

Also: git, vim, sudo, libicu.

## Requirements

On a non-s390x host this runs under QEMU and needs the binfmt handlers:

```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes        # Docker
sudo podman run --rm --privileged docker.io/multiarch/qemu-user-static --reset -p yes   # podman
```

`run-docker-station` checks for this before doing anything and names the right
command for your setup if it is missing. The `sudo` in the podman form is not
optional: run rootless, that command reports success while registering nothing
at all. See the [QEMU section of the top-level README](../README.md#qemu),
which also notes that RHEL-family 10 has no `qemu-user-static` package.

Emulation is slow, so keep the test programs here small and targeted.

## Usage

From the directory holding the code you want to work on:

```bash
s390/run-docker-station 'gcc --version'
s390/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
