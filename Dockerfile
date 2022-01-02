FROM ubuntu:22.04
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apt-get update -qq
 RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata gnuplot
 RUN apt-get install -y vim sudo wget cmake git linux-tools-generic

# Moar compilers
 RUN apt-get install -y clang++-13
 RUN apt-get install -y g++-11
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
