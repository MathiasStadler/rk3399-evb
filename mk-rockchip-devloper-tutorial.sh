#!/bin/bash
#we will have a new envoriment :-)
echo $(pwd) >/tmp/target_path
sudo -i
cd $(cat /tmp/target_path)
export MAKEFLAGS="-j 8"
export PATH="/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/:$PATH"
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
export PATH="/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/:$PATH"
#default for xenia
./build/mk-uboot.sh rk3399-excavator  && \
./build/mk-kernel.sh rk3399-excavator && \
cd rootfs/ && \
ARCH=armhf ./mk-base-debian.sh && \
ARCH=armhf ./mk-rootfs.sh && \
./mk-image.sh

