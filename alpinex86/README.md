# alpinex86

A **32-bit x86** programming station, based on **Alpine Linux 3.24** for i386.

This is the one to reach for when you want to know how your code behaves where
pointers are four bytes wide: `size_t` truncation, casts between pointers and
`int`, structure padding and alignment assumptions, 64-bit atomics that are no
longer lock-free, and overflow in code that silently assumed a 64-bit
`size_t`. It combines that with musl libc, so it is a genuinely different
target from the usual x86-64 glibc box.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 15.2.0 |
| cmake | 4.2.3 |

Also: git, bash, linux-headers, build-base, doas.

## Notes

The Dockerfile pins the platform explicitly:

```dockerfile
FROM --platform=linux/386 i386/alpine:3.24
```

This is required. `i386/alpine` publishes a manifest *list* that contains only a
386 entry, so on an ARM host a plain `docker pull` fails with
`no matching manifest for linux/arm64/v8`. Pinning the platform in the
Dockerfile makes `run-docker-station` work unmodified.

A 32-bit x86 container runs **natively** on an x86-64 host - no emulation is
needed, since x86-64 chips execute 32-bit code directly. On an ARM host it runs
under emulation, and Docker will print a harmless platform-mismatch warning.

Verify you really are 32-bit with `sizeof(void*)`, not with `uname -m`: on an
x86-64 kernel a 32-bit process may still be told `x86_64`.

## Usage

From the directory holding the code you want to work on:

```bash
alpinex86/run-docker-station 'gcc --version'
alpinex86/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
