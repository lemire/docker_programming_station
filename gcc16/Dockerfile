FROM sourcemation/gcc-16
ARG USER_NAME
ARG USER_ID
ARG GROUP_ID
# We install some useful packages
RUN apt-get update -qq
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata gnuplot
RUN apt-get install -y vim ninja-build valgrind golang curl wget cmake git ruby python3 python3-dev python3-pip
RUN pip3 install --break-system-packages ipython

# Moar compilers if needed, but GCC 16 is already there
RUN apt-get install -y ruby

RUN addgroup --gid $GROUP_ID user; exit 0
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME; exit 0
RUN echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo
RUN echo '----->'
RUN echo 'root:Docker!' | chpasswd
ENV TERM=xterm-256color
USER $USER_NAME

RUN gcc --version
RUN cmake --version
RUN python3 --version
RUN pip3 --version
RUN go version