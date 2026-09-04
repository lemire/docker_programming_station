FROM artixlinux/artixlinux:base
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# Artix is Arch without systemd; same pacman, same rolling package set.
 RUN pacman -Syu --noconfirm
 RUN pacman -S --noconfirm base-devel cmake git vim gdb clang ninja sudo
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
