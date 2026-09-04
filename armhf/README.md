# armhf

A **32-bit ARM** (armv7l, hard-float) programming station, based on
**Ubuntu 20.04**.

Useful for testing 32-bit ARM code paths: NEON intrinsics under AArch32,
unaligned access behaviour, `long` being 32 bits, and the ABI differences
between AArch32 and AArch64. Together with `alpinex86` it covers the two
32-bit targets people still ship to.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 9.4.0 |
| cmake | 3.16.3 |

Also: git, vim, sudo.

## Requirements

On any host that is not itself 32-bit ARM, this image runs under QEMU and you
must have the binfmt handlers registered:

```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes        # Docker
sudo podman run --rm --privileged docker.io/multiarch/qemu-user-static --reset -p yes   # podman
```

`run-docker-station` checks for this before doing anything and names the right
command for your setup if it is missing. The `sudo` in the podman form is not
optional: run rootless, that command reports success while registering nothing
at all. See the [QEMU section of the top-level README](../README.md#qemu),
which also notes that RHEL-family 10 has no `qemu-user-static` package.

Expect emulated builds to be several times slower than native ones.

## Usage

From the directory holding the code you want to work on:

```bash
armhf/run-docker-station 'gcc --version'
armhf/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
