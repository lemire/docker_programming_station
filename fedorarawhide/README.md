# fedorarawhide

A **Fedora Rawhide** programming station - Fedora's rolling development branch.

This is the earliest warning system in the repository. Rawhide carries GCC and
LLVM snapshots months before they reach any release, so it is where you find
out that next year's compiler rejects your code, changes an optimisation, or
adds a warning. It is also the container most likely to break on any given day,
which is the price of being first.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ | 16.2.1 (Fedora 46 prerelease) |
| clang | 22.1.8 |
| cmake | 4.3.0 |

Also: gdb, perf, libasan, libubsan, git, vim, diffutils.

Unlike the pinned `fedora38` / `fedora39` / `fedora40` stations, this one is a
**moving target**: rebuild it (via `remove-docker-station`) whenever you want
the current snapshot.

## Usage

From the directory holding the code you want to work on:

```bash
fedorarawhide/run-docker-station 'gcc --version'
fedorarawhide/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
