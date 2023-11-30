FROM ubuntu:23.10
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apt-get update -qq
 RUN apt install -y software-properties-common
 RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 15CF4D18AF4F7421
 RUN add-apt-repository "deb http://apt.llvm.org/mantic/ llvm-toolchain-mantic-17 main"
 RUN add-apt-repository "deb-src http://apt.llvm.org/mantic/ llvm-toolchain-mantic-17 main"
 RUN apt-get update -qq
 RUN apt-get install -y clang++-17 clang-17
 RUN apt-get install -y clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang
 RUN apt-get install -y vim ninja-build valgrind curl gdb  sudo python3 python3-dev wget cmake g++ libcurl4-openssl-dev libicu-dev libboost-all-dev git  linux-tools-generic hyperfine
 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME; exit 0
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME
 RUN gcc --version
 RUN cmake --version
