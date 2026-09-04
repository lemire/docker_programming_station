# fedora38

A **Fedora 38** programming station.

Fedora ships newer compilers than Debian or Ubuntu LTS and applies its own
hardening flags through `redhat-rpm-config`, so it catches a different class of
problem: warnings promoted by `_FORTIFY_SOURCE`, glibc changes that reach
Fedora first, and the odd GCC diagnostic that other distributions have not seen
yet. Keeping several Fedora versions side by side makes it easy to bisect which
compiler release changed a behaviour.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 13.2.1 |
| clang | 16.0.6 |
| cmake | 3.27.7 |

Also: git, vim, diffutils, libubsan, redhat-rpm-config.

## Notes

Fedora 38 reached end of life in May 2024. The container still builds, because Fedora keeps its released container
images and package repositories available, but it will not receive updates.
It is kept here on purpose, as a fixed point for comparing compiler versions.

## Usage

From the directory holding the code you want to work on:

```bash
fedora38/run-docker-station 'gcc --version'
fedora38/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
