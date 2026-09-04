# ubuntulatestllvm

The **newest packaged LLVM**, on **Ubuntu 26.04**, installed from the official
`apt.llvm.org` repository.

Ubuntu's own archive lags LLVM by a release or two. This station adds the LLVM
project's apt repository so you get the current LLVM - today that is **LLVM
23** - with the full set of tools rather than just the compiler.

Compare with the neighbouring stations: `ubuntu26` gives you whatever clang
Ubuntu packages, this one gives you the newest LLVM *release*, and
`llvmlatest` gives you LLVM *trunk*.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| clang / clang++ | 23.1.1 |
| gcc / g++ | 15.2.0 (Ubuntu) |
| cmake | 4.2.3 |

Plus the rest of the LLVM toolchain at the same version: `clangd`,
`clang-format`, `clang-tidy`, `clang-tools`, `lld`, `lldb`, `llvm-dev`,
`libclang-dev`, `libomp-dev`, `libc++-dev`, `libc++abi-dev` and
`python3-clang`.

`update-alternatives` points the unversioned `clang` and `clang++` at the
versioned binaries, so plain `clang++` is the new compiler.

## Notes

The repository is registered with a `signed-by` keyring under
`/etc/apt/keyrings/`. The older `apt-key adv` approach no longer works: `apt-key`
has been removed from current Ubuntu releases.

Both the Ubuntu release and the LLVM version are written into the Dockerfile
(the apt.llvm.org path is keyed to the release codename, `resolute` for 26.04).
Bump both together when a newer LLVM appears.

## Usage

From the directory holding the code you want to work on:

```bash
ubuntulatestllvm/run-docker-station 'gcc --version'
ubuntulatestllvm/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
