FROM multiarch/ubuntu-core:s390x-focal
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
 RUN apt-get update -qq
 RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
 RUN apt-get install -y g++
 RUN apt-get install -y vim sudo  cmake git 
 RUN apt-get install -y sudo
 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME; exit 0
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME

