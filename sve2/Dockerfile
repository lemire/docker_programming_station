FROM --platform=linux/arm64 ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        gcc-14 g++-14 \
        gcc-14-aarch64-linux-gnu g++-14-aarch64-linux-gnu \
        clang \
        qemu-user \
        qemu-user-static \
        gdb-multiarch \
        make cmake ninja-build \
        git ca-certificates \
        vim less \
    && rm -rf /var/lib/apt/lists/*

# Convenience wrappers so you can just "run-sve ./a.out"
RUN printf '#!/bin/sh\nexec qemu-aarch64 -cpu max,sve128=on "$@"\n'  > /usr/local/bin/run-sve128  && \
    printf '#!/bin/sh\nexec qemu-aarch64 -cpu max,sve256=on "$@"\n'  > /usr/local/bin/run-sve256  && \
    printf '#!/bin/sh\nexec qemu-aarch64 -cpu max,sve512=on "$@"\n'  > /usr/local/bin/run-sve512  && \
    printf '#!/bin/sh\nexec qemu-aarch64 -cpu max "$@"\n'             > /usr/local/bin/run-sve2   && \
    chmod +x /usr/local/bin/run-sve*

WORKDIR /work
CMD ["/bin/bash"]
