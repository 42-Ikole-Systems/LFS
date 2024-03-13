# Dockerfile for building linux kernel

# docker build -t linux-build-environment-image .
# docker run --name linux-build-environment-container -it -v $PWD:/linux_build_environment linux-build-environment-image

FROM ubuntu:latest

# gcc: compiling
# make: building
# git: well... git
# flex: required for kernel
# bison: required for kernel
# bc: required for kernel
# libelf-dev: required for kernel
# libssl-dev: required for kernel
# cpio: required for making init-ram-fs
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

# Cloning linux repo in the dockerfile because, if you clone it on mac and then use a volume the binaries that come with it wont work inside the container.
RUN git clone --depth 1 https://github.com/torvalds/linux.git 
