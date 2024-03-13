# Dockerfile for building linux kernel

# docker build -t linux-build-environment-image .
# docker run --name linux-build-environment-container -it -v ./:/linux_build_environment linux-build-environment-image

FROM ubuntu:latest

RUN apt-get update

# gcc: compiling
# make: building
# flex: required for kernel
# bison: required for kernel
# bc: required for kernel
# libelf-dev: required for kernel
# libssl-dev: required for kernel
# cpio: required for making init-ram-fs
# bzip2: required for busy box
# libncurses-dev: interactive menus
RUN apt-get install -y	gcc \
						make \
						flex \
						bison \
						bc \
						libelf-dev \
						libssl-dev \
						cpio \
						bzip2 \ 
						libncurses-dev

