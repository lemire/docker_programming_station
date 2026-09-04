FROM openmandriva/cooker
 ARG USER_NAME
 ARG USER_ID
 ARG GROUP_ID
# OpenMandriva uses dnf, and builds its distribution with clang rather than gcc.
 # glibc-devel is not pulled in by the compilers here, and without it neither
 # g++ nor clang++ can find features.h -- nothing compiles at all.
 RUN dnf install -y vim cmake gcc-c++ glibc-devel libstdc++-devel clang gdb git make ninja
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
 RUN clang --version
 RUN cmake --version
 RUN printf '#include <cstdio>\nint main(){puts("ok");}\n' > /tmp/t.cpp && g++ /tmp/t.cpp -o /tmp/t && /tmp/t
