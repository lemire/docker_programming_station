FROM alpine:3.19
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apk add --no-cache sudo ninja-build ninja-is-really-ninja python3  build-base cmake g++ linux-headers git bash build-base
 RUN ln -sf python3 /usr/bin/python
 RUN echo USER_NAME $USER_NAME
 RUN echo USER_ID $USER_ID
 RUN echo GROUP_ID $GROUP_ID
 RUN addgroup --gid $GROUP_ID user; exit 0
 RUN adduser -D -g '' -S -u $USER_ID -g $GROUP_ID --ingroup "user" $USER_NAME --disabled-password
 RUN adduser $USER_NAME wheel
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd 
 RUN apk add doas
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME
 RUN gcc --version
 RUN cmake --version
