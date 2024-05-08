FROM gentoo/stage3:latest
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
 RUN emerge --sync
 RUN emerge -g sys-devel/gcc sys-devel/clang dev-build/cmake 
 RUN echo USER_ID $USER_ID
 RUN echo GROUP_ID $GROUP_ID
 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser  -u $USER_ID  $USER_NAME 
 RUN usermod -aG wheel $USER_NAME
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd 
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME
