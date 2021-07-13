FROM ubuntu:20.10
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apt-get update -qq
 RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata gnuplot
 RUN apt-get install -y vim ninja-build valgrind golang llvm gdb lldb clang-format sudo pip python python-dev wget cmake g++ g++-9 git clang++-9 linux-tools-generic ruby ruby-dev python3-pip  libboost-all-dev r-base-dev r-recommended qpdf devscripts r-cran-remotes
 RUN  pip3 install ipython

# Moar compilers
 RUN apt-get install -y clang++-6
 RUN apt-get install -y clang++-7
 RUN apt-get install -y clang++-8
 RUN apt-get install -y clang++-9
 RUN apt-get install -y clang++-10
 RUN apt-get install -y clang++-11
 RUN apt-get install -y g++-7 g++-8 g++-9 g++-10
 RUN apt-get install -y ruby

 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME; exit 0
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME

 RUN gcc --version
 RUN cmake --version
 RUN python3 --version
 RUN pip3 --version
 RUN go version
