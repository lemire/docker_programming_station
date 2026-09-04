# clangp2996

A **C++26 static reflection** playground: Bloomberg's `clang-p2996` fork built
from source on top of **Debian 12**.

[P2996](https://wg21.link/p2996) is the static reflection proposal for C++26.
This fork implements it, so you can experiment with `^^` reflection operators,
`std::meta::info`, splicers and friends before they land in a released
compiler. If you want to write code against reflection today, this is the
container for it.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| clang / clang++ | 21.0.0git (bloomberg/clang-p2996) |
| gcc / g++ | 12.2.0 (Debian) |
| cmake | 3.25.1 |

The fork is built with libc++ as the default standard library
(`-DCLANG_DEFAULT_CXX_STDLIB=libc++`) and installed into `/usr/local`.

Compile with the reflection flag:

```bash
clang++ -std=c++26 -freflection -stdlib=libc++ example.cpp
```

## Notes

This image is unlike the others in two ways.

First, it is **expensive**: it clones LLVM and compiles it with Ninja, which
takes roughly an hour on a fast machine and needs a lot of RAM and disk. It is
built once and then cached, but the first run is a long wait.

Second, it follows the upstream LLVM Dockerfile layout - a two-stage build that
produces a minimal release image - so it does **not** create a matching user
account the way the other stations do. You run as root inside it.

## Usage

From the directory holding the code you want to work on:

```bash
clangp2996/run-docker-station 'gcc --version'
clangp2996/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
