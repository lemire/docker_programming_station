FROM fedora:44
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN dnf install -y vim cmake g++ gdb clang git diffutils libasan libubsan redhat-rpm-config
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
