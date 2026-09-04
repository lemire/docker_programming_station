# riscv

A **RISC-V cross-compilation** station, based on **Ubuntu 24.04**.

Read the name carefully: this is *not* a RISC-V container. It is a normal
native container that carries a RISC-V cross-compiler and a RISC-V user-mode
emulator. You compile with `riscv64-linux-gnu-g++` and run the result under
`qemu-riscv64-static`. Because the compiler itself runs natively, this is much
faster than emulating a whole RISC-V userland.

## What is inside

| Tool | Version (at time of writing) |
|---|---|
| gcc / g++ (native) | 13.3.0 |
| g++-riscv64-linux-gnu | RISC-V cross-compiler |
| qemu-user-static | RISC-V user-mode emulation |
| cmake | 3.28.3 |

Also: ninja, valgrind, gdb, clang, clang-format, git, vim.

## Typical use

```bash
./run-docker-station 'riscv64-linux-gnu-g++ -O2 hello.cpp -o hello'
./run-docker-station 'qemu-riscv64-static -L /usr/riscv64-linux-gnu ./hello'
```

The `-L` flag points QEMU at the RISC-V sysroot so it can find the dynamic
loader and libraries. Add `-cpu` options to QEMU to select RISC-V extensions
(for example vector support) when you want to test them.

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
