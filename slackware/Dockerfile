FROM --platform=linux/amd64 aclemons/slackware:15.0
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# Slackware has no dependency resolution, so install the whole "d" (development)
# series rather than naming individual packages and chasing their dependencies.
 RUN slackpkg -batch=on -default_answer=yes update gpg
 RUN slackpkg -batch=on -default_answer=yes update
 # Series, not individual packages: l (libraries), n (network, for the curl
 # and nghttp2 that cmake links against), ap (applications, for vim) and
 # d (development). Naming packages one by one means chasing every missing
 # shared library by hand.
 RUN slackpkg -batch=on -default_answer=yes install l
 RUN slackpkg -batch=on -default_answer=yes install n
 RUN slackpkg -batch=on -default_answer=yes install ap
 RUN slackpkg -batch=on -default_answer=yes install d
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
