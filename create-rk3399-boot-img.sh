#!/bin/bash
## build  kernel
## START ##

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

DEFCONFIG=rockchip_linux_defconfig
DEFCONFIG_MAINLINE=defconfig


UBOOT_DEFCONFIG=evb-rk3399_defconfig
DTB_MAINLINE=rk3399-sapphire-excavator.dtb
DTB=rk3399-sapphire-excavator-linux.dtb

CHIP="rk3399"
LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
TOOLPATH=${LOCALPATH}/rkbin/tools
EXTLINUXPATH=${LOCALPATH}/build/extlinux
CHIP="rk3399"
TARGET=""
ROOTFS_PATH=""
KERNEL_DIR="linux-stable"
KERNEL_TAG="v4.14.10"

# help function
version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }


finish() {
        echo -e "\e[31m CREATE BOOT.IMG FAILED.\e[0m"
        exit -1
}
trap finish ERR




# house keeping
[ ! -d ${OUT} ] && mkdir ${OUT} 
[ ! -d ${OUT}/kernel ] && mkdir ${OUT}/kernel


cd ${KERNEL_DIR}
#TODO old git checkout tags/v4.10.17
git checkout tags/${KERNEL_TAG}

KERNEL_VERSION=$(make kernelversion) 

if version_gt "${KERNEL_VERSION}" "4.5"; then
        if [ "${DTB_MAINLINE}" ]; then
                DTB=${DTB_MAINLINE}
                DEFCONFIG=${DEFCONFIG_MAINLINE}
        fi
fi

echo -e "\e[36m We used DTB => ${DTB}\e[0m"
echo -e "\e[36m We used DEFCONFIG => ${DEFCONFIG}\e[0m"
echo -e "\e[36m We used KERNEL_VERSION => ${KERNEL_VERSION}\e[0m"


make ${DEFCONFIG}

make -j6

#TDOD old KERNEL_VERSION=$(cat ${LOCALPATH}/${KERNEL_DIR}/include/config/kernel.release)

cd ..

cp ${KERNEL_DIR}/arch/arm64/boot/Image ${OUT}/kernel/


cp ${KERNEL_DIR}/arch/arm64/boot/dts/rockchip/${DTB} ${OUT}/kernel/
#cp kernel/arch/arm64/boot/dts/rockchip/${DTB} ${OUT}/kernel/

BOOT=${OUT}/boot.img

rm -rf ${BOOT}

# Change extlinux.conf according board
echo -e "\e[36mChange extlinux.conf according board\e[0m"
sed -e "s,fdt .*,fdt /$DTB,g" \
        -i ${EXTLINUXPATH}/${CHIP}.conf
cat ${EXTLINUXPATH}/${CHIP}.conf   
echo -e "\e[36m Generate Boot image start\e[0m"
# 100 Mb default size
mkfs.vfat -n "boot" -S 512 -C ${BOOT} $((100 * 1024))
mmd -i ${BOOT} ::/extlinux
mcopy -i ${BOOT} -s ${EXTLINUXPATH}/${CHIP}.conf ::/extlinux/extlinux.conf
mcopy -i ${BOOT} -s ${OUT}/kernel/* ::
#TODO old echo -e "\e[36m Generate Boot image : ${BOOT} success! \e[0m"

echo -e "\e[36m Summery:\e[0m"
echo -e "\e[36m We used DTB => ${DTB}\e[0m"
echo -e "\e[36m We used DEFCONFIG => ${DEFCONFIG}\e[0m"
echo -e "\e[36m We used KERNEL_VERSION => ${KERNEL_VERSION}\e[0m"
echo -e "\e[36m Generate Boot image : ${BOOT} success! \e[0m"


echo -e "Bring board is msrom mode and flash boot.img"

echo -e "rkbin/tools/rkdeveloptool  db out/u-boot/rk3399_loader_v1.08.106.bin "
echo -e "rkbin/tools/rkdeveloptool  wl 0x8000 out/boot.img "
echo -e "rkbin/tools/rkdeveloptool rd "

## END ##
