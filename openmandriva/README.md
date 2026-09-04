# openmandriva

An **OpenMandriva Cooker** programming station.

OpenMandriva is interesting for one specific reason: it is the mainstream Linux
distribution that builds **itself with clang** rather than GCC. Almost
everything else in this repository is a GCC-built userland, so this is the one
place where you meet a system whose libraries, and whose default expectations,
came out of LLVM.

That makes it a good place to catch code which unknowingly depends on GCC
specifics - `__GNUC__` version checks that assume real GCC, GNU extensions,
inline-asm phrasing clang parses differently, or libstdc++ details.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| clang | 23.1.0 (OpenMandriva) |
| gcc / g++ | 16.2.0 |
| cmake | 4.4.2 |

Also: gdb, ninja, make, git, vim. Packages come from `dnf`, as on Fedora.

## Notes

`cooker` is OpenMandriva's **rolling development branch** - the equivalent of
Fedora Rawhide - because that is what upstream keeps current as a container
image. Expect it to move, and to break occasionally; rebuild with
`dps rebuild --img openmandriva` to pick up the current state.

The clang here is often ahead of everything else in this repository, which is
a large part of the point.

## Usage

```bash
dps run --img openmandriva 'gcc --version'
dps shell --img openmandriva
```

or, equivalently, from the directory you want to work in:

```bash
openmandriva/run-docker-station 'gcc --version'
```
