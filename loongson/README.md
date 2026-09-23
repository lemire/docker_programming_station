# loongson

A **LoongArch** (loong64) programming station, based on **Debian 13**
(trixie).

LoongArch is the instruction set of Loongson's recent processors (3A5000 and
later). It has its own vector extensions (128-bit LSX and 256-bit LASX, rather
than SSE/AVX or NEON) and a weaker memory model than x86. Code with
hand-written SIMD, architecture detection in the build system, or lock-free
data structures is worth running here. The compiler defines `__loongarch64`.

Neither Ubuntu nor the official Debian image publishes a loong64 variant, so
the base image is `ghcr.io/loong64/debian:trixie`, maintained by the loong64
porting community.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 14.2.0 |
| cmake | 3.31.6 |

Also: git, vim, sudo, libicu.

## Requirements

On a non-LoongArch host this runs under QEMU and needs the binfmt handlers:

```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes        # Docker
sudo podman run --rm --privileged docker.io/multiarch/qemu-user-static --reset -p yes   # podman
```

Unlike the other emulated stations, loong64 is **not** covered by the
emulation Docker Desktop ships with on macOS. There, register just this one
architecture, without touching the others:

```bash
docker run --rm --privileged tonistiigi/binfmt --install loong64
```

`run-docker-station` checks for this before doing anything and names the right
command for your setup if it is missing. See the
[QEMU section of the top-level README](../README.md#qemu).

Emulated LoongArch is slow; expect builds to take several times longer than
native.

## Usage

From the directory holding the code you want to work on:

```bash
loongson/run-docker-station 'gcc --version'
loongson/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
