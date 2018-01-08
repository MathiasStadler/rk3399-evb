#!/bin/bash -e

#FROM HERE
#https://github.com/rockchip-linux/build
#truncated


export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

BOARD=$1
DEFCONFIG=""
DTB=""
KERNELIMAGE=""
CHIP=""
UBOOT_DEFCONFIG=""

case ${BOARD} in
        "rk3399-excavator")
                DEFCONFIG=rockchip_linux_defconfig
                DEFCONFIG_MAINLINE=defconfig
                UBOOT_DEFCONFIG=evb-rk3399_defconfig
                DTB_MAINLINE=rk3399-sapphire-excavator.dtb
                DTB=rk3399-sapphire-excavator-linux.dtb
                export ARCH=arm64
                export CROSS_COMPILE=aarch64-linux-gnu-
                CHIP="rk3399"
                ;;
        "rk3399-firefly")
                DEFCONFIG=rockchip_linux_defconfig
                UBOOT_DEFCONFIG=firefly-rk3399_defconfig
                DTB_MAINLINE=rk3399-firefly.dtb
                DTB=rk3399-firefly-linux.dtb
                export ARCH=arm64
                export CROSS_COMPILE=aarch64-linux-gnu-
                CHIP="rk3399"
                ;;
        "rk3328-rock64")
                DEFCONFIG=rockchip_linux_defconfig
                UBOOT_DEFCONFIG=evb-rk3328_defconfig
                DTB=rk3328-rock64.dtb
                export ARCH=arm64
                export CROSS_COMPILE=aarch64-linux-gnu-
                CHIP="rk3328"
                ;;
        "rk3328-evb")
                DEFCONFIG=rockchip_linux_defconfig
                UBOOT_DEFCONFIG=evb-rk3328_defconfig
                DTB=rk3328-evb.dtb
                export ARCH=arm64
                export CROSS_COMPILE=aarch64-linux-gnu-
                CHIP="rk3328"
                ;;
                *)
                echo "board '${BOARD}' not supported!"
                exit -1
                ;;
esac


