FROM --platform=linux/arm64 ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        software-properties-common \
        build-essential \
        clang \
        qemu-user \
        qemu-user-static \
        gdb-multiarch \
        make cmake ninja-build \
        git ca-certificates \
        vim less \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc-16 g++-16 \
        gcc-16-aarch64-linux-gnu g++-16-aarch64-linux-gnu \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-16 160 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-16 160 \
    && update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-16 160 \
    && update-alternatives --install /usr/bin/aarch64-linux-gnu-g++ aarch64-linux-gnu-g++ /usr/bin/aarch64-linux-gnu-g++-16 160 \
    && rm -rf /var/lib/apt/lists/*

# Convenience wrappers so you can just "run-sve ./a.out"
RUN printf '#!/bin/sh\nexec qemu-aarch64 -cpu max,sve128=on "$@"\n'  > /usr/local/bin/run-sve128  && \
    printf '#!/bin/sh\nexec qemu-aarch64 -cpu max,sve256=on "$@"\n'  > /usr/local/bin/run-sve256  && \
    printf '#!/bin/sh\nexec qemu-aarch64 -cpu max,sve512=on "$@"\n'  > /usr/local/bin/run-sve512  && \
    printf '#!/bin/sh\nexec qemu-aarch64 -cpu max "$@"\n'             > /usr/local/bin/run-sve2   && \
    chmod +x /usr/local/bin/run-sve*

WORKDIR /work
CMD ["/bin/bash"]
