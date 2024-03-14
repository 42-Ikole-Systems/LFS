# LFS
🤓 [Linux From Scratch](https://www.linuxfromscratch.org/lfs/view/stable/index.html)

## About
- Bootloader: []()
- Kernel: [Linux]](https://github.com/torvalds/linux)
- Use space: [Busy box]()

## Requirements
- Docker

## To build
We build the kernel in a docker container so it can be done on any system without crosscompiling.

```sh
# Build the docker image
$ docker build -t linux-build-environment-image .

# Run the docker image, note that we use the --privilged flag so we can move our boot-files to the filesystem outside of the container.
$ docker run --name linux-build-environment-container --privileged --rm -it linux-build-environment-image
```

Now that you are inside of the container we can actually build the kernel and userspace
```sh
# Go into the build folder
$ cd linux_build_environment

# Just call make :)
$ make
```
