# fedora44

A **Fedora 44** programming station.

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
| gcc / g++ | 16.2.1 |
| clang | 22.1.8 |
| cmake | 4.3.0 |

Also: gdb, libasan, libubsan, git, vim, diffutils, redhat-rpm-config.

## Notes

Fedora 44 is a current, supported release, and carries GCC 16 and clang 22 - close to what Rawhide had not long before.

## Usage

```bash
dps run --img fedora44 'gcc --version'
dps shell --img fedora44
```

or, equivalently, from the directory you want to work in:

```bash
fedora44/run-docker-station 'gcc --version'
```
