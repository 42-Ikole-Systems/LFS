# Dockerfile for building linux kernel

# docker build -t linux-build-environment-image .
# docker run --name linux-build-environment-container --privileged -it linux-build-environment-image

FROM ubuntu:latest

# If you want to have it in a different directory inside of the container use: "--build-arg LINUX_BUILD_DIR=somedir"
ARG LINUX_BUILD_DIR=linux_build_environment

# gcc: compiling
# make: building
# git: well... git
# flex: required for kernel
# bison: required for kernel
# bc: required for kernel
# libelf-dev: required for kernel
# libssl-dev: required for kernel
# cpio: required for making initramfs
# bzip2: required for busy box
# libncurses-dev: interactive menus
RUN apt-get update && \
	apt-get install -y \
		gcc \
		make \
		git \
		flex \
		bison \
		bc \
		libelf-dev \
		libssl-dev \
		cpio \
		syslinux \
		dosfstools \
		bzip2 \ 
		libncurses-dev

RUN mkdir $LINUX_BUILD_DIR

# Cloning linux repo in the dockerfile because, if you clone it on mac and then use a volume the binaries that come with it wont work inside the container :/.
# To fix this you could use a cross-compiler aswell.
RUN git clone --depth 1 https://github.com/torvalds/linux.git $LINUX_BUILD_DIR/linux

# cloning user space
RUN git clone --depth 1 https://git.busybox.net/busybox $LINUX_BUILD_DIR/busybox

COPY scripts/Makefile $LINUX_BUILD_DIR
