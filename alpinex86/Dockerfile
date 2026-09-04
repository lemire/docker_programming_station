FROM --platform=linux/386 i386/alpine:3.24
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# We install some useful packages
 RUN apk add --no-cache build-base cmake g++ linux-headers git bash build-base
 RUN echo USER_NAME $USER_NAME
 RUN echo USER_ID $USER_ID
 RUN echo GROUP_ID $GROUP_ID
 RUN addgroup --gid $GROUP_ID user; exit 0
 # -G binds the user to the existing group for $GROUP_ID; without it busybox
 # adduser tries to create a group numbered like the uid and collides.
 RUN adduser -D -g '' -u $USER_ID -G "$(getent group $GROUP_ID | cut -d: -f1)" $USER_NAME
 RUN adduser $USER_NAME wheel
 RUN echo "$USER_NAME:$USER_NAME" | chpasswd 
 RUN apk add doas
 RUN echo '----->'
 RUN echo 'root:Docker!' | chpasswd
 ENV TERM xterm-256color
 USER $USER_NAME
 RUN gcc --version
 RUN cmake --version
