FROM fedora:latest
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
 ARG HTTP_PROXY

RUN dnf update -y -qq
RUN dnf install -y shadow-utils

RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser   --uid $USER_ID --gid $GROUP_ID $USER_NAME
 RUN ls /home/
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd 
 RUN usermod -aG wheel $USER_NAME
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd

# We install some useful packages
 

 RUN dnf install -y tar vim ninja-build clang-tools-extra valgrind curl llvm gdb  sudo gcc clang python3 python3-devel  wget cmake g++ git  python3-pip  
 
 RUN  python3 -m pip install ipykernel

# Moar compilers
# RUN dnf install -y clang++-6
# RUN dnf install -y clang++-7
# RUN dnf install -y clang++-8
# RUN dnf install -y clang++-9
# RUN dnf install -y clang++-10
# RUN dnf install -y clang++-11
# RUN dnf install -y g++-7 g++-8 g++-9 g++-10
#RUN dnf install -y ruby

 
 ENV TERM xterm-256color
 USER $USER_NAME

 
