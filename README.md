## Docker Programming Station


This project provides a simple bash script that one can use to do programming tasks in a
Docker environment capturing a standard Ubuntu distribution. 

You can simply copy the Dockerfile and run script in any repository.
The Dockerfile sets up an image (called by default programming_station) and bind this
repository to the image. Then it passes your command: your command runs in the current
directory but within the image. So you can do basic programming tasks:

```bash
./run ' gcc --version  '
./run ' git clone https://github.com/simdjson/simdjson.git '
./run ' mkdir build '
./run ' cd build && cmake ../simdjson '
./run ' cd build && cmake --build . '
```

Importantly, this work whether you have an ARM-based server or an Intel based mac.


## Requirements

- A working docker installation under Linux, macOS or related system.
- Bash

