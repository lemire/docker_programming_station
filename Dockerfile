FROM ubuntu:20.10

 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apt-get update -qq
 RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
 RUN apt-get install -y cmake g++ g++-9 git clang++-9 linux-tools-generic  
 RUN mkdir project

 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user; exit 0
 USER user
 RUN gcc --version
 RUN clang-9 --version

 WORKDIR /project