
# Stage 1. Check out LLVM source code and run the build.
FROM debian:12 as builder
# First, Update the apt's source list and include the sources of the packages.
RUN grep deb /etc/apt/sources.list | \
    sed 's/^deb/deb-src /g' >> /etc/apt/sources.list
# Install compiler, python and subversion.
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates gnupg \
           build-essential cmake make python3 zlib1g wget subversion unzip ninja-build git && \
    rm -rf /var/lib/apt/lists/*
RUN git clone --depth=1 --branch p2996  https://github.com/bloomberg/clang-p2996.git /tmp/clang-source
RUN cmake -S /tmp/clang-source/llvm -B /tmp/clang-source/build-llvm -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_UNREACHABLE_OPTIMIZE=ON \
    -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
    -DLLVM_ENABLE_PROJECTS=clang
RUN cmake --build /tmp/clang-source/build-llvm 
RUN cmake --install /tmp/clang-source/build-llvm --prefix /tmp/clang-install


# Stage 2. Produce a minimal release image with build results.
FROM debian:12
LABEL maintainer "LLVM Developers"
# Install packages for minimal useful image.
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential cmake make wget python3 python3-dev sudo curl ninja-build vim git binutils && \
    rm -rf /var/lib/apt/lists/*
# Copy build results of stage 1 to /usr/local.
COPY --from=builder /tmp/clang-install/ /usr/local/

# Setting up the "LD_LIBRARY_PATH" 
RUN export LD_LIBRARY_PATH=/usr/local/lib/aarch64-unknown-linux-gnu:$LD_LIBRARY_PATH

# Creating symbolic links for version-specific naming
RUN ln -s /usr/local/lib/aarch64-unknown-linux-gnu/libc++.so.1.0 /usr/local/lib/aarch64-unknown-linux-gnu/libc++.so.1 && \
    ln -s /usr/local/lib/aarch64-unknown-linux-gnu/libc++abi.so.1.0 /usr/local/lib/aarch64-unknown-linux-gnu/libc++abi.so.1 && \
    ln -s /usr/local/lib/aarch64-unknown-linux-gnu/libunwind.so.1.0 /usr/local/lib/aarch64-unknown-linux-gnu/libunwind.so.1
