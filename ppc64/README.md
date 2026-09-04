# ppc64

A **POWER** (ppc64le, little-endian) programming station, based on
**Ubuntu 20.04**.

POWER is a genuinely different architecture: different vector unit (VSX rather
than SSE/AVX or NEON), 128-byte cache lines on recent chips, and a weaker
memory model than x86. Code with hand-written SIMD, lock-free data structures,
or assumptions about cache-line size is worth running here.

Note that this is **little-endian** POWER, which is what modern POWER Linux
distributions use. For big-endian testing, use the `s390` station instead.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 9.4.0 |
| cmake | 3.16.3 |

Also: git, vim, sudo, libicu.

## Requirements

On a non-POWER host this runs under QEMU and needs the binfmt handlers:

```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes        # Docker
sudo podman run --rm --privileged docker.io/multiarch/qemu-user-static --reset -p yes   # podman
```

`run-docker-station` checks for this before doing anything and names the right
command for your setup if it is missing. The `sudo` in the podman form is not
optional: run rootless, that command reports success while registering nothing
at all. See the [QEMU section of the top-level README](../README.md#qemu),
which also notes that RHEL-family 10 has no `qemu-user-static` package.

Emulated POWER is slow; expect builds to take several times longer than native.

## Usage

From the directory holding the code you want to work on:

```bash
ppc64/run-docker-station 'gcc --version'
ppc64/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
