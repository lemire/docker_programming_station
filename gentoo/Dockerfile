FROM gentoo/stage3:latest
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
 # emerge-webrsync fetches the tree over HTTP(S). Plain 'emerge --sync' uses
 # rsync on port 873, which is blocked on many networks and then fails with
 # "Exhausted addresses for rsync.gentoo.org".
 RUN emerge-webrsync
 RUN emerge -g sys-devel/gcc llvm-core/clang dev-build/cmake 
 RUN echo USER_ID $USER_ID
 RUN echo GROUP_ID $GROUP_ID
 # Gentoo ships shadow's groupadd/useradd, not Debian's addgroup/adduser.
 RUN groupadd --gid $GROUP_ID user; exit 0
 RUN useradd -m -u $USER_ID -g $GROUP_ID $USER_NAME
 RUN usermod -aG wheel $USER_NAME
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd 
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME
