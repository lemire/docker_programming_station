FROM ubuntu:26.04
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apt-get update -qq
 RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common ca-certificates gnupg wget
# The latest LLVM release, from apt.llvm.org (26.04 is "resolute").
 RUN wget -qO /etc/apt/keyrings/llvm-snapshot.asc https://apt.llvm.org/llvm-snapshot.gpg.key
 RUN echo "deb [signed-by=/etc/apt/keyrings/llvm-snapshot.asc] http://apt.llvm.org/resolute/ llvm-toolchain-resolute-23 main" > /etc/apt/sources.list.d/llvm.list
 RUN apt-get update -qq
 RUN apt-get install -y clang-23 clangd-23 clang-format-23 clang-tidy-23 clang-tools-23 lld-23 lldb-23 llvm-23 llvm-23-dev llvm-23-runtime libclang-23-dev libomp-23-dev libc++-23-dev libc++abi-23-dev python3-clang-23
 RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-23 100 \
  && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-23 100
 RUN apt-get install -y vim ninja-build valgrind curl gdb sudo python3 python3-dev wget cmake g++ libcurl4-openssl-dev libicu-dev libboost-all-dev git linux-tools-generic hyperfine
 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME; exit 0
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM=xterm-256color
 USER $USER_NAME
 RUN gcc --version
 RUN cmake --version
 RUN clang++ --version
