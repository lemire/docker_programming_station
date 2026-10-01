# riscv

A **RISC-V cross-compilation** station, based on **Ubuntu 26.04**.

Read the name carefully: this is *not* a RISC-V container. It is a normal
native container that carries a RISC-V cross-compiler and a RISC-V user-mode
emulator. You compile with `riscv64-linux-gnu-g++` and run the result under
`qemu-riscv64`. Because the compiler itself runs natively, this is much
faster than emulating a whole RISC-V userland.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ (native) | 15.2.0 |
| g++-riscv64-linux-gnu | RISC-V cross-compiler |
| qemu-user | RISC-V user-mode emulation (static `qemu-riscv64`) |
| cmake | 4.2.3 |

Also: ninja, valgrind, gdb, clang, clang-format, git, vim.

## Typical use

```bash
./run-docker-station 'riscv64-linux-gnu-g++ -O2 hello.cpp -o hello'
./run-docker-station 'qemu-riscv64 ./hello'
```

The image sets `QEMU_LD_PREFIX=/usr/riscv64-linux-gnu`, which points QEMU at
the RISC-V sysroot so it can find the dynamic loader and libraries (the same
as passing `-L /usr/riscv64-linux-gnu`).

## Choosing the emulated CPU (vector length)

Ubuntu 26.04 targets the **RVA23** profile: the cross-compiler defaults to
RVA23 (vectors, bit manipulation and more), and the sysroot's glibc and
libstdc++ are built for it. Every binary therefore needs an RVA23-capable
CPU, even one compiled with `-march=rv64gc`. QEMU's default CPU works.
**Do not** use the older `QEMU_CPU=rv64,v=on,...` recipe, found in many CI
scripts written for Ubuntu 24.04: every program, even hello world, dies with
`Illegal instruction`. Use an RVA23 model instead:

```bash
# test RVV code at several vector lengths
./run-docker-station 'QEMU_CPU=rva23u64,vlen=128,rvv_ta_all_1s=on,rvv_ma_all_1s=on qemu-riscv64 ./hello'
./run-docker-station 'QEMU_CPU=rva23u64,vlen=1024,rvv_ta_all_1s=on,rvv_ma_all_1s=on qemu-riscv64 ./hello'
```

`rvv_ta_all_1s` and `rvv_ma_all_1s` fill tail-agnostic and mask-agnostic
lanes with ones, which catches code that wrongly assumes those lanes keep
their old values.

## CMake projects

A minimal toolchain file:

```cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv64)
set(CMAKE_CROSSCOMPILING_EMULATOR qemu-riscv64)
```

```bash
CC=riscv64-linux-gnu-gcc CXX=riscv64-linux-gnu-g++ \
  cmake --toolchain=riscv64.cmake -B build
# or with clang:
CC=clang CXX=clang++ CFLAGS=--target=riscv64-linux-gnu CXXFLAGS=--target=riscv64-linux-gnu \
  cmake --toolchain=riscv64.cmake -B build
cmake --build build
QEMU_CPU=rva23u64,vlen=256 ctest --test-dir build
```

Emulated vector code is slow, especially at small vector lengths, so raise
ctest's `--timeout` for heavy tests.

## Notes

No host binfmt registration is needed, because QEMU is invoked explicitly
rather than through the kernel's binfmt handler.

## Usage

From the directory holding the code you want to work on:

```bash
riscv/run-docker-station 'gcc --version'
riscv/run-docker-station bash
```

The container sees only the current directory (mounted at the same path) and
files it creates are owned by you. Use `remove-docker-station` to drop the image
and force a rebuild.
