FROM ubuntu:20.10
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apt-get update -qq
 RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
 RUN apt-get install -y vim golang clang-format sudo python wget cmake g++ g++-9 git clang++-9 linux-tools-generic  

 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME; exit 0
 RUN echo 'root:Docker!' | chpasswd
 USER $USER_NAME
 RUN gcc --version
 RUN cmake --version
 RUN python3 --version
 RUN go version