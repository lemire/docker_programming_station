## Docker Programming Station


This project provides a simple bash script that one can use to do programming tasks in a
Docker environment capturing a standard Ubuntu distribution. 

The Dockerfile sets up an image (called by default programming_station-for-yourname). 
The image is built once when you first call the script. It contains the compilers
and build tools. It does not contain your code: your code is meant to go in 
the current directory. Importantly, the very same image can be used over
multiple projects.


Then it passes your command: your command runs in the current
directory but within the image. Docker does not copy your code to the image: everything
is read and stored in the current directory. You also have only access to the current
directory from within docker.

So you can do basic programming tasks:

```bash
./run-docker-station ' gcc --version  '
./run-docker-station ' git clone https://github.com/simdjson/simdjson.git '
./run-docker-station ' mkdir build '
./run-docker-station ' cd build && cmake ../simdjson '
./run-docker-station ' cd build && cmake --build . '
```

You can even run perf though you need to know where to find it:

```bash
./run-docker-station ' /usr/lib/linux-tools/5.4.0-26-generic/perf stat ls '
```

For convenience, configure you system so that `run-docker-station` is in your PATH. If you just want to enter in a bash shell with access to your current directory, you can do so:

```bash
run-docker-station bash
```

Be mindful that the shell will only have access to the current directory and its subdirectories. You should run the script from the directory of your choosing.

If you like, you can even call the script from a Makefile. It is just a regular bash
script.

You can put `run-docker-station` in your `PATH` by adding the `docker_programming_station` directory to it and
thus be able to call `run-docker-station` from everywhere. Your are not limited to one instance. However, each
instance will only have access to its directory. However, the first time the image is constructed,
you might want to run it in the `docker_programming_station` directory otherwise you may get
the error "The Dockerfile  must be within the build context".
You can simply copy the Dockerfile and the script in any repository if you prefer to avoid messing
with the `PATH` variable.

Features: 

- This works whether you have an ARM-based server or an Intel based mac.
- The files created in the directory will be owned by you (the user).
- I works on systems supporting Security-Enhanced Linux.
- You have sudo access from within the container. Your password is your user ID.

Caution:
- The first time you run the script, it builds the image which is an expensive process. It is done only once, however.
- You should map specific directories insider a user directory. Do not use this script to map system-owned  directories like `/home/` or `/usr/` as it would be unsafe.

Tricks:
- If you put the `run-docker-station` command in your PATH, you will be able to run it from everywhere.
- A handy command to run from time to time is `docker system prune`, as it can help you remove unneeded images. I recommend running `docker image prune -a` regularly.
- If something does not work, you can try deleting all containers and images `docker rm -vf $(docker ps -a -q) ; docker rmi -f $(docker images -a -q)`. Such a reset can solve a surprising number of otherwise mysterious problems.

## The dps command

`dps` drives every station from one place. Put it in your `PATH` and call it
from whatever directory you want to work in:

```bash
dps run --img devuan 'gcc --version'   # run a command in a station
dps devuan 'gcc --version'             # same thing, shorthand
dps shell --img fedora44               # interactive shell
dps list                               # every station, and whether it is built
dps info --img alpine                  # base image, size, what it is for
dps build --img rocky10                # build without running anything
dps rebuild --img fedorarawhide        # discard the image and build it again
dps delete --img devuan                # remove one station's image
dps clean                              # remove every station image
```

The image is built the first time you use a station and cached afterwards. As
with the individual scripts, the station sees only the directory you invoke it
from, and the files it creates belong to you.

The default station is `ubuntu22`; set `DPS_IMG` to change it. The per-station
`run-docker-station` scripts still work exactly as before, and `dps` defers to
them for the emulated stations so you get their QEMU diagnostics.

## The containers

Each subdirectory is a self-contained station with its own `Dockerfile` and its
own `run-docker-station` script, and its own `README.md` with more detail. The
top-level `Dockerfile` (used by `rds`) is a copy of `ubuntu22`.

### Ubuntu releases

| Directory | Base | Compilers | Why you would use it |
|---|---|---|---|
| [ubuntu16](ubuntu16) | Ubuntu 16.04 | GCC 5.5 (and 8) | Oldest toolchain here; C++11/14 baseline |
| [ubuntu18](ubuntu18) | Ubuntu 18.04 | GCC 7.5 | First reasonable C++17 support |
| [ubuntu20](ubuntu20) | Ubuntu 20.04 | GCC 7-10, clang 6-11 | The compiler zoo; also Go, Ruby, R, ipython |
| [ubuntu22](ubuntu22) | Ubuntu 22.04 LTS | GCC 11.4, clang 14 | **The default station** |
| [ubuntu23](ubuntu23) | Ubuntu 23.10 | GCC 13.2, clang 16 | EOL interim release, pinned to old-releases |
| [ubuntu24](ubuntu24) | Ubuntu 24.04 LTS | GCC 13.3, clang 18 | Current widely deployed LTS |
| [ubuntu25](ubuntu25) | Ubuntu 25.04 | GCC 14.2, clang 20 | Interim release |
| [ubuntu26](ubuntu26) | Ubuntu 26.04 LTS | GCC 15.2, clang 21 | Newest LTS |

### Other distributions

| Directory | Base | Compilers | Why you would use it |
|---|---|---|---|
| [debian12](debian12) | Debian 12 | GCC 12.2, clang 14 | Conservative, long-lived server toolchain |
| [debian13](debian13) | Debian 13 | GCC 14.2, clang 19 | Current Debian stable |
| [devuan](devuan) | Devuan 6 | GCC 14.2, clang 19 | **Debian without systemd** |
| [rocky10](rocky10) | Rocky Linux 10 | GCC 14.3, clang 21 | **RHEL 10 rebuild**: the enterprise target |
| [fedora38](fedora38) | Fedora 38 | GCC 13.2, clang 16 | Pinned Fedora, for bisecting compiler changes |
| [fedora39](fedora39) | Fedora 39 | GCC 13.3, clang 17 | Pinned Fedora |
| [fedora40](fedora40) | Fedora 40 | GCC 14.2, clang 18 | Pinned Fedora |
| [fedora43](fedora43) | Fedora 43 | GCC 15.3, clang 21 | Current Fedora |
| [fedora44](fedora44) | Fedora 44 | GCC 16.2, clang 22 | Current Fedora |
| [fedorarawhide](fedorarawhide) | Fedora Rawhide | GCC 16, clang 22 | Earliest warning of future compiler behaviour |
| [alpine](alpine) | Alpine 3.24 | GCC 15.2 | **musl libc** instead of glibc; busybox userland |
| [gentoo](gentoo) | Gentoo stage3 | GCC 15.3 | Source-based distribution, different layout |
| [voidlinux](voidlinux) | Void Linux | GCC 14.2, clang 21 | Independent lineage, xbps, runit |
| [artix](artix) | Artix Linux | GCC 16.2, clang 22 | **Arch without systemd**; very current packages |
| [openmandriva](openmandriva) | OpenMandriva Cooker | clang 23, GCC 16 | **A distribution built with clang** |
| [slackware](slackware) | Slackware 15.0 | GCC 11.2 | The oldest surviving distribution; no dependency resolution |

### Newest compilers

| Directory | Base | Compilers | Why you would use it |
|---|---|---|---|
| [gcc16](gcc16) | official `gcc:16` | GCC 16.2 | Newest GCC, straight from the GCC project |
| [ubuntulatestllvm](ubuntulatestllvm) | Ubuntu 26.04 + apt.llvm.org | clang 23 | Newest packaged LLVM **release** |
| [llvmlatest](llvmlatest) | `silkeh/clang:dev` | clang 22 dev | LLVM **trunk** snapshot (x86-64 image only) |
| [clangp2996](clangp2996) | Debian 12 + source build | clang-p2996 | **C++26 static reflection** (P2996) |

### Other architectures

These let you find portability bugs without owning the hardware. All except
`riscv` and `alpinex86` need QEMU binfmt handlers on a foreign host - see
[QEMU](#qemu) below.

| Directory | Target | Why you would use it |
|---|---|---|
| [s390](s390) | s390x, Ubuntu 20.04 | **Big-endian.** The one target that finds endianness bugs |
| [ppc64](ppc64) | ppc64le, Ubuntu 20.04 | POWER: VSX vectors, weak memory model, 128-byte cache lines |
| [armhf](armhf) | armv7l, Ubuntu 20.04 | **32-bit ARM**: AArch32 NEON, 32-bit `long` |
| [alpinex86](alpinex86) | i386, Alpine 3.24 | **32-bit x86**: 4-byte pointers, `size_t` truncation. Native on x86-64 |
| [riscv](riscv) | RISC-V cross + QEMU | Cross-compile to RISC-V and run under emulation |
| [sve2](sve2) | arm64, Ubuntu 26.04 | **ARM SVE/SVE2** at 128/256/512-bit vector lengths |

## Memory Usage

Under Windows and macOS, docker will only use relatively little memory.  You may want to allocate more: [Windows](https://docs.docker.com/docker-for-windows/#advanced) and [macOS](https://docs.docker.com/docker-for-mac/#memory).

## Requirements

- A working docker installation under Linux, macOS or related system.
- Bash

## QEMU

The `armhf`, `ppc64`, `s390` and `sve2` stations target a different processor
architecture than your machine, so they run under QEMU. That requires binfmt
handlers registered in the kernel.

Their `run-docker-station` scripts check for this before doing any work and
print an explanatory message naming the exact command for your setup, rather
than letting the build fail deep inside with a bare `exec format error`.

With **Docker**:

```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

With **podman**, the same command must be run as root:

```
sudo podman run --rm --privileged docker.io/multiarch/qemu-user-static --reset -p yes
```

The `sudo` is not optional. `binfmt_misc` is global kernel state, and a
rootless container cannot touch it - run rootless, that command prints a long
list of `Setting ... as binfmt interpreter` lines and **exits successfully
while registering nothing at all**. The `-p yes` flag matters too: it loads the
qemu interpreters into the kernel, so rootless containers can use them
afterwards.

Some distributions package the handlers instead (`sudo apt install
qemu-user-static binfmt-support` on Debian and Ubuntu, `sudo dnf install
qemu-user-static` on Fedora). Note that **RHEL-family 10 (Rocky, Alma) has no
such package** - not in BaseOS, AppStream, Extras or EPEL - so the container
command above is the route there.

Registrations do not survive a reboot; re-run the command afterwards.

On **macOS**, with Docker Desktop or OrbStack, emulation is provided by the
virtual machine and generally works with no setup.

The `riscv` and `alpinex86` stations need none of this: `riscv` invokes QEMU
explicitly rather than through binfmt, and 32-bit x86 code runs natively on any
x86-64 host.

## Podman

The scripts detect podman (including installations where `docker` is a shim for
it) and adapt: when running **rootless**, they add `--userns=keep-id` to
`docker run`.

Without that flag rootless podman maps your uid to root inside the container,
so a station that runs as your own uid cannot write to the mounted directory at
all - which defeats the whole premise that the files you create are yours. The
flag is rootless-only, and the scripts only add it when rootless, because
rootful podman rejects it.

The volumes are mounted with the shared SELinux label (`:z`) rather than the
private one (`:Z`), so that several stations can work on the same source
directory without relabelling it out from under each other.
