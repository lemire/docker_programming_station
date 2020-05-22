## Docker Programming Station


This project provides a simple bash script that one can use to do programming tasks in a
Docker environment capturing a standard Ubuntu distribution. 

You can simply copy the Dockerfile and run script in any repository.
The Dockerfile sets up an image (called by default programming_station). 
The image is built once when you first call the script. It contains the compilers
and build tools. It does not contain your code: your code is meant to in 
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

Importantly, this works whether you have an ARM-based server or an Intel based mac.


If you like, you can even call the script from a Makefile. It is just a regular bash
script.

## Requirements

- A working docker installation under Linux, macOS or related system.
- Bash

