#!/bin/bash -e


# settings
KERNEL_DIR="linux-stable"
KERNEL_TAG="v4.14.12"
BOARD="rk3399-excavator"
# flags

MAINLINE=y
KERNEL_DEBUG=y

# vars

#TODO old DEFCONFIG=rockchip_linux_defconfig
#TODO old DEFCONFIG_MAINLINE=defconfig
#TODO old UBOOT_DEFCONFIG=evb-rk3399_defconfig
#TODO old DTB_MAINLINE=rk3399-sapphire-excavator.dtb
#TODO odl DTB=rk3399-sapphire-excavator-linux.dtb

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
CONFIG_FILES=${LOCALPATH}/config_files
#TODO old TOOLPATH=${LOCALPATH}/rkbin/tools
EXTLINUXPATH=${LOCALPATH}/build/extlinux
KERNEL_BUILD_LOG="${OUT}/kernel_build.log"
#TODO old CHIP="rk3399"
#TODO old TARGET=""
#TDOD old ROOTFS_PATH=""
#KERNEL_DIR="linux-stable"



PATH_TO_ARM_DEFCONFIG="./arch/arm64/configs"


# from here
# https://stackoverflow.com/questions/8455991/elegant-way-for-verbose-mode-in-scripts
# set verbose level to info

__VERBOSE=6

declare -A LOG_LEVELS
# https://en.wikipedia.org/wiki/Syslog#Severity_level
LOG_LEVELS=([0]="emerg" [1]="alert" [2]="crit" [3]="err" [4]="warning" [5]="notice" [6]="info" [7]="debug")
function .log () {
  local LEVEL=${1}
  shift
  if [ ${__VERBOSE} -ge "${LEVEL}" ]; then
    echo "[${LOG_LEVELS[$LEVEL]}]" "$@"
  fi
}

.log 6 "Start logging"


finish() {
    echo -e "\e[31m CREATE BOOT.IMG FAILED.\e[0m"
    exit -1
}
trap finish ERR


# help function
version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }


# script path
# from here
# https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


#load board configs
#TODO OLD source "${LOCALPATH}"/build/board_configs.sh "${BOARD}"

source ${SCRIPT_PATH}/board_configs.sh "${BOARD}"


#check out advailble 
# save out
# FROM HERE
# https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/
dir="${OUT}"
if [ -d "${dir}" -a ! -h "${dir}" ]
then
   echo "${dir} found "
   mv "${dir}" "${dir}_$(date +"%Y_%m_%d_%I_%M_%S")"
   
else
   echo "$dir not availble Nothing to save"
fi



# house keeping
[ ! -d "${OUT}" ] && mkdir "${OUT}"
[ ! -d "${OUT}/${CONFIG_FILES}" ] && mkdir "${OUT}/${CONFIG_FILES}"
[ ! -d "${OUT}/kernel" ] && mkdir "${OUT}/kernel"

cd ${KERNEL_DIR}

#clean
#TODO make flagable 
make mrproper

#TODO old git checkout tags/v4.10.17
git checkout tags/${KERNEL_TAG}

KERNEL_VERSION=$(make kernelversion)

if [ "${MAINLINE}" == "y" ]; then

    DTB=${DTB_MAINLINE}
    DEFCONFIG=${DEFCONFIG_MAINLINE}

else

    if version_gt "${KERNEL_VERSION}" "4.5"; then
        if [ "${DTB_MAINLINE}" ]; then
            DTB=${DTB_MAINLINE}
            DEFCONFIG=${DEFCONFIG_MAINLINE}
        fi
    fi

fi

if [ "${KERNEL_DEBUG}" == "y" ]; then

    # delete old if exists
    [ -e "${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug" ] && rm -rf "${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug"

    # copy defconfig to defconfig-debug
    cp "${PATH_TO_ARM_DEFCONFIG}"/"${DEFCONFIG}" "${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug"

    # add to defconfig
    # CONFIG_DEBUG_LL=y
    # CONFIG_EARLY_PRINTK=y
    echo "CONFIG_DEBUG_LL=y" >>"${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug"
    echo "CONFIG_EARLY_PRINTK=y" >>"${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug"

    cat "${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug" |grep CONFIG_DEBUG_LL=y
    cat "${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug" |grep CONFIG_EARLY_PRINTK=y
    
    # set defconfig_debug as current defconfig
    defconfig=${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}-debug

fi

echo -e "\e[36m We used KERNEL_VERSION => ${KERNEL_VERSION}\e[0m"
echo -e "\e[36m We used DTB => ${DTB}\e[0m"
echo -e "\e[36m We used DEFCONFIG => ${DEFCONFIG}\e[0m"

# save configfiles
mkdir -p "${CONFIG_FILES}"
cp "${KERNEL_DIR}/arch/arm64/boot/dts/rockchip/${DTB}" "${CONFIG_FILES}/kernel"
cp "${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}" "${CONFIG_FILES}/${defconfig}"

#cat ${PATH_TO_ARM_DEFCONFIG}/${DEFCONFIG}

make ${DEFCONFIG}

make -j$(nproc) 2>1 | tee "${KERNEL_BUILD_LOG}"

#TDOD old KERNEL_VERSION=$(cat ${LOCALPATH}/${KERNEL_DIR}/include/config/kernel.release)

cd ..

cp "${KERNEL_DIR}/arch/arm64/boot/Image" "${OUT}"/kernel/




#cp kernel/arch/arm64/boot/dts/rockchip/${DTB} ${OUT}/kernel/

BOOT=${OUT}/boot.img

rm -rf "${BOOT}"

# Change extlinux.conf according board
echo -e "\e[36mChange extlinux.conf according board\e[0m"
sed -e "s,fdt .*,fdt /$DTB,g" \
    -i "${EXTLINUXPATH}/${CHIP}.conf"
cat "${EXTLINUXPATH}/${CHIP}.conf"
echo -e "\e[36m Generate Boot image start\e[0m"
# 100 Mb default size
mkfs.vfat -n "boot" -S 512 -C ${BOOT} $((100 * 1024))
mmd -i "${BOOT}" ::/extlinux
mcopy -i "${BOOT}" -s "${EXTLINUXPATH}/${CHIP}.conf" ::/extlinux/extlinux.conf
mcopy -i "${BOOT}" -s "${OUT}/kernel/*" ::
#TODO old echo -e "\e[36m Generated Boot image : ${BOOT} success! \e[0m"

echo -e "\e[36m Summery:\e[0m"
echo -e "\e[36m We used DTB => ${DTB}\e[0m"
echo -e "\e[36m We used DEFCONFIG => ${DEFCONFIG}\e[0m"
echo -e "\e[36m We used KERNEL_VERSION => ${KERNEL_VERSION}\e[0m"
echo -e "\e[36m Generate Boot image : ${BOOT} success! \e[0m"

echo -e "Bring board is msrom mode and flash boot.img"
echo -e "rkbin/tools/rkdeveloptool  db ${OUT}/rkbin/rk33/rk3399_loader_v1.08.106.bin"
echo -e "rkbin/tools/rkdeveloptool  wl 0x8000 ${OUT}/boot.img "
echo -e "rkbin/tools/rkdeveloptool rd "

## END ##
