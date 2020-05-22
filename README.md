## Docker Programming Station


This project provides a simple bash script that one can use to do programming tasks in a
Docker environment capturing a standard Ubuntu distribution. 

You can simply copy the Dockerfile and run script in any repos:qitory.
The Dockerfile sets up an image (called by default programming_station-for-yourname). 
The image is built once when you first call the script. It contains the compilers
and build tools. It does not contain your code: your code is meant to go in 
the current directory. Importantly, the very same image can be used over
multiple projects.


Then it passes your command: your command runs in the current
directory but within the image. Docker does not copy your code to the image: everything
is read and stored in the current directory. 

So you can do basic programming tasks:

```bash
./run ' gcc --version  '
./run ' git clone https://github.com/simdjson/simdjson.git '
./run ' mkdir build '
./run ' cd build && cmake ../simdjson '
./run ' cd build && cmake --build . '
```

You can even run perf though you need to know where to find it:

```bash
./run ' /usr/lib/linux-tools/5.4.0-26-generic/perf stat ls '
```

If you like, you can even call the script from a Makefile. It is just a regular bash
script.

Features: 

- This works whether you have an ARM-based server or an Intel based mac.
- The files created in the directory will be owned by you (the user).


## Requirements

- A working docker installation under Linux, macOS or related system.
- Bash


