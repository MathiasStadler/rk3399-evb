#!/bin/bash -e 

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
TOOLPATH=${LOCALPATH}/rkbin/tools
EXTLINUXPATH=${LOCALPATH}/build/extlinux
CHIP=""
TARGET=""
ROOTFS_PATH=""

PATH=$PATH:$TOOLPATH

source ./partitions.sh

finish() {
        echo -e "\e[31m MAKE IMAGE FAILED.\e[0m"
        exit -1
}
trap finish ERR

generate_system_image() {
    if [ ! -f "${OUT}/boot.img" ]; then
        echo -e "\e[31m CAN'T FIND BOOT IMAGE \e[0m"
        usage
        exit
    fi

    if [ ! -f "${ROOTFS_PATH}" ]; then
        echo -e "\e[31m CAN'T FIND ROOTFS IMAGE \e[0m"
        usage
        exit
    fi

    SYSTEM=${OUT}/system.img
    rm -rf "${SYSTEM}"

    echo "Generate System image : ${SYSTEM} !"

    # last dd rootfs will extend gpt image to fit the size,
    # but this will overrite the backup table of GPT
    # will cause corruption error for GPT
    IMG_ROOTFS_SIZE=$(stat -L --format="%s" "${ROOTFS_PATH}")
    GPTIMG_MIN_SIZE=$(expr $IMG_ROOTFS_SIZE + \( ${LOADER1_SIZE} + ${RESERVED1_SIZE} + ${RESERVED2_SIZE} + ${LOADER2_SIZE} + ${ATF_SIZE} + ${BOOT_SIZE} + 35 \) \* 512)
    GPT_IMAGE_SIZE=$(expr $GPTIMG_MIN_SIZE \/ 1024 \/ 1024 + 2)

exit 0


    dd if=/dev/zero of=${SYSTEM} bs=1M count=0 seek=$GPT_IMAGE_SIZE

    parted -s ${SYSTEM} mklabel gpt
    parted -s ${SYSTEM} unit s mkpart loader1 ${LOADER1_START} $(expr ${RESERVED1_START} - 1)
    # parted -s ${SYSTEM} unit s mkpart reserved1 ${RESERVED1_START} $(expr ${RESERVED2_START} - 1)
    # parted -s ${SYSTEM} unit s mkpart reserved2 ${RESERVED2_START} $(expr ${LOADER2_START} - 1)
    parted -s ${SYSTEM} unit s mkpart loader2 ${LOADER2_START} $(expr ${ATF_START} - 1)
    parted -s ${SYSTEM} unit s mkpart trust ${ATF_START} $(expr ${BOOT_START} - 1)
    parted -s ${SYSTEM} unit s mkpart boot ${BOOT_START} $(expr ${ROOTFS_START} - 1)
    parted -s ${SYSTEM} set 4 boot on
    parted -s ${SYSTEM} -- unit s mkpart rootfs ${ROOTFS_START} -34s

    if [ "$CHIP" == "rk3328" ] || [ "$CHIP" == "rk3399" ]; then
        ROOT_UUID="B921B045-1DF0-41C3-AF44-4C6F280D3FAE"
    else
        ROOT_UUID="69DAD710-2CE4-4E3C-B16C-21A1D49ABED3"
    fi

    gdisk ${SYSTEM} <<EOF
x
c
5
${ROOT_UUID}
w
y
EOF

    # burn u-boot
    if [ "$CHIP" == "rk3288" ] || [ "$CHIP" == "rk322x" ] || [ "$CHIP" == "rk3036" ]; then
        dd if=${OUT}/u-boot/idbloader.img of=${SYSTEM} seek=${LOADER1_START} conv=notrunc
    elif [ "$CHIP" == "rk3399" ]; then
        dd if=${OUT}/u-boot/idbloader.img of=${SYSTEM} seek=${LOADER1_START} conv=notrunc

        dd if=${OUT}/u-boot/uboot.img of=${SYSTEM} seek=${LOADER2_START} conv=notrunc
        dd if=${OUT}/u-boot/trust.img of=${SYSTEM} seek=${ATF_START} conv=notrunc
    elif [ "$CHIP" == "rk3328" ]; then
        dd if=${OUT}/u-boot/idbloader.img of=${SYSTEM} seek=${LOADER1_START} conv=notrunc

        dd if=${OUT}/u-boot/uboot.img of=${SYSTEM} seek=${LOADER2_START} conv=notrunc
        dd if=${OUT}/u-boot/trust.img of=${SYSTEM} seek=${ATF_START} conv=notrunc
    fi

    # burn boot image
    dd if=${OUT}/boot.img of=${SYSTEM} conv=notrunc seek=${BOOT_START}

    # burn rootfs image
    dd if=${ROOTFS_PATH} of=${SYSTEM} conv=notrunc,fsync seek=${ROOTFS_START}
}

if [ "$TARGET" = "boot" ]; then
    generate_boot_image
elif [ "$TARGET" == "system" ]; then
    generate_system_image
fi


generate_system_image