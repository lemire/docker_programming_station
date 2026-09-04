# sve2

An **ARM SVE / SVE2** station, based on **Ubuntu 26.04** for arm64.

SVE (Scalable Vector Extension) is unusual because the vector length is not
fixed by the instruction set: the same binary runs with 128-bit, 256-bit or
512-bit vectors depending on the hardware. That is exactly the property that
makes SVE code hard to test, since almost no developer machine implements more
than one width - and Apple Silicon implements no SVE at all.

This container solves that with QEMU: it compiles with a real aarch64 GCC and
then runs the result at whichever vector length you ask for.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 16 (Ubuntu snapshot) |
| aarch64-linux-gnu-gcc / g++ | 16 (cross) |
| clang | 21.1.8 |
| cmake | 4.2.3 |
| qemu-user | user-mode emulation |
| gdb-multiarch | debugging |

## Vector-length wrappers

The image installs four convenience wrappers:

| Command | Vector length |
|---|---|
| `run-sve128 ./a.out` | 128-bit |
| `run-sve256 ./a.out` | 256-bit |
| `run-sve512 ./a.out` | 512-bit |
| `run-sve2 ./a.out` | QEMU `-cpu max` default |

So a typical session is:

```bash
./run-docker-station 'g++ -O2 -march=armv9-a+sve2 kernel.cpp -o kernel'
./run-docker-station 'run-sve128 ./kernel && run-sve256 ./kernel && run-sve512 ./kernel'
```

If your results differ between those three, you have a vector-length assumption
in your code - which is the whole point of this station.

## Notes

The Dockerfile pins `FROM --platform=linux/arm64`, so on an x86-64 host the
whole container runs under emulation and needs binfmt handlers registered:

```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes        # Docker
sudo podman run --rm --privileged docker.io/multiarch/qemu-user-static --reset -p yes   # podman
```

`run-docker-station` checks for this first and names the right command if it is
missing. The `sudo` in the podman form is not optional: run rootless, that
command reports success while registering nothing at all. See the
[QEMU section of the top-level README](../README.md#qemu).

On an ARM host (including Apple Silicon) the container itself is native and
only the SVE wrappers use QEMU, which is much faster.

`gcc-16` and the aarch64 cross compilers now come from the Ubuntu 26.04 archive
directly, so no external PPA is required.

## Usage

From the directory holding the code you want to work on:

```bash
sve2/run-docker-station 'gcc --version'
sve2/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
