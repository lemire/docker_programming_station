FROM rockylinux/rockylinux:10
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# EPEL and CRB carry the developer tools that the base repositories omit.
 RUN dnf install -y epel-release
 RUN dnf config-manager --set-enabled crb
 RUN dnf install -y vim cmake gcc-c++ gdb clang git diffutils make sudo
 RUN echo USER_ID $USER_ID
 RUN echo GROUP_ID $GROUP_ID
 RUN groupadd --gid $GROUP_ID user; exit 0
 RUN useradd -m -u $USER_ID -g $GROUP_ID $USER_NAME
 RUN usermod -aG wheel $USER_NAME
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM=xterm-256color
 USER $USER_NAME
 RUN gcc --version
 RUN cmake --version
