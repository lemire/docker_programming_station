FROM debian:stable AS builder

ARG SYSROOT="/riscv"
ARG QEMU_STATIC="/usr/bin/qemu-riscv64-static"
ARG THE_QEMU_VERSION="7.2.0"

# install build essentials
RUN apt-get update && \
    apt-get install -y python3 build-essential git debootstrap debian-ports-archive-keyring git glib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build pkg-config binfmt-support wget

# Download and build QEMU
RUN wget https://download.qemu.org/qemu-${THE_QEMU_VERSION}.tar.xz && \
    tar xvJf qemu-${THE_QEMU_VERSION}.tar.xz && \
    cd qemu-${THE_QEMU_VERSION} && \
    sh ./configure --target-list=riscv64-linux-user --static && \
    make -j$(nproc) && \
    cp ./build/qemu-riscv64 ${QEMU_STATIC}

# debootstrap && second stage
ENV DEBIAN_FRONTEND noninteractive
RUN debootstrap --arch=riscv64 --foreign --keyring /usr/share/keyrings/debian-ports-archive-keyring.gpg --include=debian-ports-archive-keyring unstable ${SYSROOT}/ http://deb.debian.org/debian-ports && \
    mkdir -p ${SYSROOT}/usr/bin && \
    cp ${QEMU_STATIC} ${SYSROOT}/usr/bin/ && \
    chroot ${SYSROOT} /debootstrap/debootstrap --second-stage

# install build essentials in the RISC-V sysroot. Feel free to install other essentials!
RUN chroot ${SYSROOT} ${QEMU_STATIC} /usr/bin/apt-get update && \
    chroot ${SYSROOT} ${QEMU_STATIC} /usr/bin/apt-get install -y \
        libzip-dev ninja-build sudo cmake clang ca-certificates vim build-essential wget curl which diffutils file make gcc time zip unzip \
        libcups2-dev libx11-dev binutils libxtst-dev libxt-dev libxrandr-dev libxrender-dev libx11-dev libxext-dev libasound2-dev \
        libfreetype6-dev libffi-dev autoconf libfontconfig1-dev xvfb wget dos2unix git && \
    echo "alias ll='ls -l --color'" >> ${SYSROOT}/root/.bashrc

# For installing openjdk in a chroot environment: we need /proc (ant depends on openjdk)
RUN --mount=type=bind,from=debian:stable,source=/proc,target=${SYSROOT}/proc chroot ${SYSROOT} ${QEMU_STATIC} /usr/bin/apt-get install -y ant && \
        wget https://repo1.maven.org/maven2/ant-contrib/ant-contrib/1.0b3/ant-contrib-1.0b3.jar -O ant-contrib.jar && \
        mv ant-contrib.jar "${SYSROOT}"/usr/share/ant/lib/

# shrink: only keep the sysroot and qemu
FROM scratch

COPY --from=builder /riscv /

CMD ["/bin/bash"]
