#!/bin/bash

# set in board_config.sh
# export ARCH=arm
# export CROSS_COMPILE=arm-linux-gnueabihf-

U_BOOT_DIR="u-boot-rockchip"

LOCALPATH=$(pwd)

OUT="${LOCALPATH}"/out

TOOLPATH="${LOCALPATH}"/rkbin/tools

BOARD=$1

PATH=$PATH:$TOOLPATH

MKIMAGE="${LOCALPATH}"/u-boot/tools/mkimage

finish_error() {
    echo -e "\e[31m MAKE UBOOT IMAGE FAILED.\e[0m"
    exit -1
}
trap finish_error ERR

dir="${OUT}"

# save out
# FROM HERE
# https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/
if [ -d "$dir" -a ! -h "$dir" ]
then
   echo "$dir found "
   cp -a $dir "${DIR}_$(date +"%Y_%m_%d_%I_%M_%S")"
   
else
   echo "$dir not availble Nothing to save"
fi



if [ $# != 1 ]; then
    BOARD="rk3399-excavator"
fi

[ ! -d "${OUT}" ] && mkdir "${OUT}"
[ ! -d "${OUT}"/u-boot ] && mkdir "${OUT}"/u-boot

source "${LOCALPATH}"/build/board_configs.sh "${BOARD}"

if [ $? -ne 0 ]; then
    exit
fi

echo -e "\e[36m Building U-boot for BOARD => ${BOARD} board! \e[0m"
echo -e "\e[36m Using UBOOT_DEFCONFIG => ${UBOOT_DEFCONFIG} \e[0m"

cd "${LOCALPATH}"/${U_BOOT_DIR}

make clean

make "${UBOOT_DEFCONFIG}" all

#TODO 
#Makefile:1024: recipe for target 'u-boot.itb' failed
#make u-boot.itb

"${TOOLPATH}"/loaderimage --pack --uboot ./u-boot-dtb.bin uboot.img 0x200000


#TODO Which mkimage version support rk3399
#TODOD select the current git
"${MKIMAGE}" -n rk3399 -T rksd -d "${LOCALPATH}"/rkbin/rk33/rk3399_ddr_800MHz_v1.08.bin idbloader.img
cat "${LOCALPATH}"/rkbin/rk33/rk3399_miniloader_v1.06.bin >>idbloader.img
cp idbloader.img "${OUT}"/u-boot/
cp "${LOCALPATH}"/rkbin/rk33/rk3399_loader_v1.08.106.bin "${OUT}"/u-boot/

cat >"${LOCALPATH}"/trust.ini <<EOF
[VERSION]
MAJOR=1
MINOR=0
[BL30_OPTION]
SEC=0
[BL31_OPTION]
SEC=1
PATH=../rkbin/rk33/rk3399_bl31_v1.00.elf
ADDR=0x10000
[BL32_OPTION]
SEC=0
[BL33_OPTION]
SEC=0
[OUTPUT]
PATH=trust.img
EOF

"$TOOLPATH"/trust_merger "${LOCALPATH}"/trust.ini

# save trust.ini
cp "${LOCALPATH}"/trust.ini "${OUT}"
cp uboot.img "${OUT}"/u-boot/
mv trust.img "${OUT}"/u-boot/


echo -e "\e[36m Generated u-boot image \e[0m"


cat >"${LOCALPATH}"/flash_u-boot.sh <<EOF
OUT_DIR="${OUT}"
wait_sleep=3
rkbin/tools/rkdeveloptool  db ${OUT_DIR}/u-boot/rk3399_loader_v1.08.106.bin && \
sleep wait_sleep  && \
rkbin/tools/rkdeveloptool  wl 0x40 ${OUT_DIR}/u-boot/idbloader.img  && \
sleep wait_sleep  && \
rkbin/tools/rkdeveloptool  wl 0x4000 ${OUT_DIR}/u-boot/uboot.img && \
sleep wait_sleep  && \
rkbin/tools/rkdeveloptool rd
EOF

echo -e "\e[36m flash u-boot image \e[0m"
cat "${LOCALPATH}"/flash_u-boot.sh
exit 0 

cat >"${LOCALPATH}"/flash_u-boot.sh <<EOF
OUT_DIR="${OUT}"
wait_sleep=3
rkbin/tools/rkdeveloptool  db ${OUT_DIR}/u-boot/rk3399_loader_v1.08.106.bin && \
sleep ${wait_sleep}  && \
rkbin/tools/rkdeveloptool  wl 0x40 ${OUT_DIR}/u-boot/idbloader.img  && \
sleep ${wait_sleep}  && \
rkbin/tools/rkdeveloptool  wl 0x4000 ${OUT_DIR}/u-boot/uboot.img && \
sleep ${wait_sleep}  && \
rkbin/tools/rkdeveloptool  wl 0x6000 ${OUT_DIR}/u-boot/trust.img && \
sleep ${wait_sleep}  && \
rkbin/tools/rkdeveloptool  wl 0x8000 ${OUT_DIR}/boot.img && \
sleep ${wait_sleep}  && \
rkbin/tools/rkdeveloptool  wl 0x40000 ${OUT_DIR}/rootfs/linaro-rootfs.img && \
sleep ${wait_sleep}  && \
rkbin/tools/rkdeveloptool rd
EOF