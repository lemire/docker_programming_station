# alpine

A musl libc programming station, based on **Alpine Linux 3.24**.

Alpine uses **musl** rather than glibc and **busybox** rather than the GNU
coreutils. That makes it the cheapest way to find out whether your code has
quietly grown a glibc dependency: missing `__builtin` fallbacks, glibc-only
functions such as `qsort_r` or `strerror_r` semantics, locale assumptions, and
stack-size differences (musl's default thread stack is much smaller) all tend to
surface here and nowhere else. The image is also small, so it builds quickly.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 15.2.0 |
| cmake | 4.2.3 |
| ninja | 1.13.2 |
| python3 | 3.14.7 |

Also: git, bash, linux-headers, build-base, sudo and doas. Your account is in
the `wheel` group and your password is your user name.

Runs natively on both x86-64 and ARM hosts.

## Notes

The group-creation step tolerates a host GID that already exists inside the
image (GID 20 is `dialout` on Alpine but `staff` on macOS), and resolves the
real group name with `getent` rather than assuming one was created.

## Usage

From the directory holding the code you want to work on:

```bash
alpine/run-docker-station 'gcc --version'
alpine/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
