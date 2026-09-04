# fedora43

A **Fedora 43** programming station.

Fedora ships newer compilers than Debian or Ubuntu LTS and applies its own
hardening flags through `redhat-rpm-config`, so it catches problems the LTS
distributions do not: warnings promoted by `_FORTIFY_SOURCE`, glibc changes
that reach Fedora first, and new GCC diagnostics.

Together with `fedora38`, `fedora39` and `fedora40`, these give you a ladder of
GCC releases to bisect a behaviour change against, with `fedorarawhide` at the
top for what is coming next.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 15.3.1 |
| clang | 21.1.8 |
| cmake | 3.31.11 |

Also: gdb, libasan, libubsan, git, vim, diffutils, redhat-rpm-config.

## Notes

Fedora 43 is a current, supported release.

## Usage

```bash
dps run --img fedora43 'gcc --version'
dps shell --img fedora43
```

or, equivalently, from the directory you want to work in:

```bash
fedora43/run-docker-station 'gcc --version'
```
