FROM amazonlinux:2022
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
 ARG HTTP_PROXY

#set yum and environment to use the corporate proxy if one exits

# We install some useful packages
 RUN yum update -y
 RUN yum upgrade -y
 RUN yum install -y  shadow-utils

 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser   --uid $USER_ID --gid $GROUP_ID $USER_NAME
 RUN ls /home/
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd 
 RUN usermod -aG wheel $USER_NAME
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd

 RUN yum install -y  tar clang tzdata gnuplot vim shadow-utils ninja-build git valgrind wget gcc curl clang-tools-extra llvm gdb sudo python3-pip  python3  python3-devel wget cmake perf 
 RUN echo python3 --version
 
 RUN  python3 -m pip install ipykernel


 ENV TERM xterm-256color
 USER $USER_NAME

