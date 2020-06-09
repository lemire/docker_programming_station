## Docker Programming Station


This project provides a simple bash script that one can use to do programming tasks in a
Docker environment capturing a standard Ubuntu distribution. 

The Dockerfile sets up an image (called by default programming_station-for-yourname). 
The image is built once when you first call the script. It contains the compilers
and build tools. It does not contain your code: your code is meant to go in 
the current directory. Importantly, the very same image can be used over
multiple projects.


Then it passes your command: your command runs in the current
directory but within the image. Docker does not copy your code to the image: everything
is read and stored in the current directory. You also have only access to the current
directory from within docker.

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

If you just want to enter in a bash shell, you can do so as well:

```bash
./run bash
```

If you like, you can even call the script from a Makefile. It is just a regular bash
script.

You can put `run` in your `PATH` by adding the `docker_programming_station` directory to it and
thus be able to call `run` from everywhere. Your are not limited to one instance. However, each
instance will only have access to its directory. However, the first time the image is constructed,
you might want to run it in the `docker_programming_station` directory otherwise you may get
the error "The Dockerfile  must be within the build context".
You can simply copy the Dockerfile and the run script in any repository if you prefer to avoid messing
with the `PATH` variable.

Features: 

- This works whether you have an ARM-based server or an Intel based mac.
- The files created in the directory will be owned by you (the user).
- I works on systems supporting Security-Enhanced Linux.

Caution:
- The first time you run the script, it builds the image which is an expensive process. It is done only once, however.
- You should map specific directories insider a user directory. Do not use this script to map system-owned  directories like `/home/` or `/usr/` as it would be unsafe.

Tricks:
- If you put the `run` command in your PATH, you will be able to run it from everywhere.
- A handy command to run from time to time is `docker system prune`, as it can help you remove unneeded images.
- If something does not work, you can try deleting all containers and images `docker rm -vf $(docker ps -a -q) ; docker rmi -f $(docker images -a -q)`. Such a reset can solve a surprising number of otherwise mysterious problems.


## Requirements

- A working docker installation under Linux, macOS or related system.
- Bash


