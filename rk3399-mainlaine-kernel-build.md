
# install on vagrant debian/strech64 box version 9.3

# Status matrix
# http://opensource.rock-chips.com/wiki_Status_Matrix

# prepare lsusb
sudo  apt install usbutils

# Kernel build tutorial
- https://kernelnewbies.org/KernelBuild
- https://www.cyberciti.biz/faq/installing-latest-stable-mainline-linux-kernel-on-ubuntu-with-apt-get/




# kernel source
- git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

#  kernel real clean = mrproper
- mrproper	  - Remove all generated files + config + various backup files

# found checkout kernel version
- make kernelversion

git tag -l | less

# change to the last stable kernel version
- the version number found you at => https://www.kernel.org/ yellowbox
- ```git checkout tags/v4.10.17```
- double check kernel version
- ```make kernelversion```
 




# last kernel version
- https://www.kernel.org/ => 4.14.10

# found last stable kernel version


#  find out your current version of Linux kernel, run:
- ```uname -mrs```



# kernl-building.txt
- 




# kernel parameter
./Documentation/admin-guide/kernel-parameters.txt



# mein wiki page
- http://rockchip.wikidot.com/

# ERROR => make[1]: arm-none-eabi-gcc: Command not found
-> sudo apt-get install gcc-arm-none-eabi

# ERROR => unable to execute 'swig': No such file or directory
error: command 'swig' failed with exit status 1
-> sudo apt-get install swig


# ERROR => ./tools/mkimage: Can't read u-boot.itb.tmp: Invalid argument

reason => this step is missing
~/cross_compiled/arm_mainline/evb_rk3399/u-boot$ ./"arch/arm/mach-rockchip/make_fit_atf.py" arch/arm/dts/rk3399-evb.dtb > u-boot.its
Solution open-> 


# ERROR => start=$(/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-nm u-boot | grep __rel_dyn_start | cut -f 1 -d ' '); end=$(/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-nm u-boot | grep __rel_dyn_end | cut -f 1 -d ' '); tools/relocate-rela u-boot-nodtb.bin 0x00200000 $start $end
make[2]: 'arch/arm/dts/rk3399-firefly.dtb' is up to date.
./"arch/arm/mach-rockchip/make_fit_atf.py" \
arch/arm/dts/rk3399-firefly.dtb > u-boot.its
Traceback (most recent call last):
  File "./arch/arm/mach-rockchip/make_fit_atf.py", line 15, in <module>
    from elftools.elf.elffile import ELFFile
ImportError: No module named elftools.elf.elffile
Makefile:986: recipe for target 'u-boot.its' failed
make: *** [u-boot.its] Error 1
Solution -> pip install pyelftools





# ERROR => scripts/dtc/pylibfdt/libfdt_wrap.c:149:21: fatal error: Python.h: No such file or directory
-> sudo apt-get install python-dev   # for python2.x installs


# theobroma-systems for  rk3399  tutorial
- https://www.theobroma-systems.com/rk3399-q7-user-manual/04-software.html


# u-boot
git clone https://github.com/u-boot/u-boot.git


# dtp => its => itb
- https://lists.denx.de/pipermail/u-boot/2017-August/304022.html
 - arch/arm/dts/sun50i-a64-pine64-plus.dtb > u-boot.its
$ ./tools/mkimage  -f u-boot.its -E u-boot.itb



# gcc version
/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Linaro GCC 6.3-2017.02) 6.3.1 20170109
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


# linaro version 
- https://www.linaro.org/downloads/



u-boot-nodtb.bin


# android-u-boot 
https://github.com/ayufan-rock64/android-u-boot/blob/master/tools/rk_tools/RKTRUST/RK3399TRUST.ini



# DOING start

OUT=${LOCALPATH}/out
# [ ! -d ${OUT} ] && mkdir ${OUT}
# [ ! -d ${OUT}/u-boot ] && mkdir ${OUT}/u-boot
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
make evb-rk3399_defconfig all -j 5
../rkbin/tools/loaderimage --pack --uboot ./u-boot-dtb.bin uboot.img 0x200000
tools/mkimage -n rk3399 -T rksd -d ../rkbin/rk33/rk3399_ddr_800MHz_v1.08.bin idbloader.img
cat ../rkbin/rk33/rk3399_miniloader_v1.06.bin >> idbloader.img
cp idbloader.img out/u-boot/
cp ../rkbin/rk33/rk3399_loader_v1.08.106.bin ${OUT}/u-boot/

#1st version
cat >trust.ini <<EOF
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

../rkbin/tools/trust_merger trust.ini


#2nd version with own compiled bl31.elf
cat >trust_bl31.ini <<EOF
[VERSION]
MAJOR=1
MINOR=0
[BL30_OPTION]
SEC=0
[BL31_OPTION]
SEC=1
PATH=../arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
ADDR=0x10000
[BL32_OPTION]
SEC=0
[BL33_OPTION]
SEC=0
[OUTPUT]
PATH=trust.img
EOF

../rkbin/tools/trust_merger trust_bl31.ini
cp uboot.img out/u-boot/
mv trust.img out/u-boot/

### DOING end


#bl31 build image
- https://github.com/ARM-software/arm-trusted-firmware/commit/8382e17c4c6bffd15119dfce1ee4372e3c1a7890


# u-boot board


"rk3399-excavator")
		DEFCONFIG=rockchip_linux_defconfig
		UBOOT_DEFCONFIG=evb-rk3399_defconfig
		DTB_MAINLINE=rk3399-sapphire-excavator.dtb
		DTB=rk3399-sapphire-excavator-linux.dtb
		export ARCH=arm64
		export CROSS_COMPILE=aarch64-linux-gnu-
		CHIP="rk3399"
		;;

# u-boot


[ ! -d ${OUT} ] && mkdir ${OUT} 
[ ! -d ${OUT}/u-boot ] && mkdir ${OUT}/u-boot

source $LOCALPATH/build/board_configs.sh $BOARD

if [ $? -ne 0 ]; then
        exit
fi

echo -e "\e[36m Building U-boot for ${BOARD} board! \e[0m"
echo -e "\e[36m Using ${UBOOT_DEFCONFIG} \e[0m"

cd ${LOCALPATH}/u-boot
make ${UBOOT_DEFCONFIG} all

$TOOLPATH/loaderimage --pack --uboot ./u-boot-dtb.bin uboot.img 0x200000

        tools/mkimage -n rk3399 -T rksd -d ../rkbin/rk33/rk3399_ddr_800MHz_v1.08.bin idbloader.img
        cat ../rkbin/rk33/rk3399_miniloader_v1.06.bin >> idbloader.img
        cp idbloader.img ${OUT}/u-boot/
        cp ../rkbin/rk33/rk3399_loader_v1.08.106.bin ${OUT}/u-boot/

        cat >trust.ini <<EOF
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

        $TOOLPATH/trust_merger trust.ini

        cp uboot.img ${OUT}/u-boot/
        mv trust.img ${OUT}/u-boot/




# build arm-trusted-firmware
- https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/user-guide.rst




# bl31.bin
# DOING start
git clone https://github.com/ARM-software/arm-trusted-firmware.git
  700  cd arm-trusted-firmware/
  701  export ARCH=arm64
  702  export CROSS_COMPILE=/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
  703  make PLAT=rk3399 all
# DOING end




#Install Boot/kernel
http://opensource.rock-chips.com/wiki_Upstream_Kernel



##########
##########

#
http://opensource.rock-chips.com/wiki_Rockchip_Kernel

#upstream kernel
- http://opensource.rock-chips.com/wiki_Upstream_Kernel


# START make linux boot.img 
git clone git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
cd linux-rockchip/
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
make kernelversion
make ARCH=arm64 defconfig
# linux 4.14.10 
make -j 8 Image dtbs
cd ..

rm -rf boot
mkdir boot
#cp linux-rockchip/arch/arm64/boot/Image boot/
cp linux-4.14.10/arch/arm64/boot/Image boot/
mkdir boot/extlinux


# version 4.4 form developer kit => run
# cp linux-rockchip/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator-linux.dtb boot
cat >boot/extlinux/extlinux.conf <<EOF
label kernel-4.4
kernel /Image
fdt /rk3399-sapphire-excavator-linux.dtb
append earlyprintk console=ttyFIQ0,1500000n8 rw root=PARTUUID=b921b045-1d rootfstype=ext4 init=/sbin/init rootwait
EOF

# version from http://opensource.rock-chips.com/wiki_Upstream_Kernel
cp linux-4.14.10/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb boot/
#cp linux-rockchip/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb boot/
cat >boot/extlinux/extlinux.conf <<EOF
label kernel-mainline
kernel /Image
fdt /rk3399-sapphire-excavator.dtb
append earlycon=uart8250,mmio,0xff1a0000 console=ttyS2,1500000n8 root=dev/mmcblk0p5 rootwait rootfstype=ext4 init=/sbin/init
EOF



# versiom from both
cp linux-rockchip/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb boot
cat >boot/extlinux/extlinux.conf <<EOF
label kernel-mainline-me
kernel /Image
fdt /rk3399-sapphire-excavator.dtb
append earlyprintk console=ttyFIQ0,1500000n8 root=PARTUUID=b921b045-1d rootwait rootfstype=ext4 init=/sbin/init
EOF


# boot.img ext2 bases
sudo apt-get -y install genext2fs
rm -rf boot_rk3399.img
genext2fs -b 32768 -B $((32*1024*1024/32768)) -d boot/ -i 8192 -U boot_rk3399.img

# START boot.img vfat based
BOOT=boot_vfat.img
rm -rf ${BOOT}
echo -e "\e[36m Generate Boot image start\e[0m"
# 100 Mb
sudo mkfs.vfat -n "boot" -S 512 -C ${BOOT} $((100 * 1024))
sudo chmod 0666 ${BOOT}
mmd -i ${BOOT} ::/extlinux
#mcopy -i ${BOOT} -s boot/extlinux/extlinux.conf ::/extlinux/extlinux.conf
mcopy -i ${BOOT} -s boot/* ::
echo -e "\e[36m Generate Boot image : ${BOOT} success! \e[0m"
# END boot.img vfat based




# According to Rockchip partition definition, you need to flash this image to boot partiton which offset is 0x8000
rkdeveloptool db rkbin/rk33/rk3399_loader_v1.08.106.bin  
sleep 3  
rkbin/tools/rkdeveloptool  wl 0x8000 boot_rk3399.img 
sleep 3
rkbin/tools/rkdeveloptool  rd
#END make linux boot.img 







  ###########


#cmdline in debian
> cat /proc/cmdline


=============
lable kernel-mainline
    kernel /Image
    fdt /rk3399.dtb
    append earlycon=uart8250,mmio,0xff1a0000 console=ttyS2,1500000n8 root=dev/mmcblk0p7 rootwait rootfstype=ext4 init=/sbin/init
=============
label kernel-4.4
    kernel /Image
    fdt /rk3399-sapphire-excavator-linux.dtb
append earlyprintk console=ttyFIQ0,1500000n8 rw root=PARTUUID=b921b045-1d rootfstype=ext4 init=/sbin/init rootwait

===========
#work
earlyprintk console=ttyFIQ0,1500000n8 rw root=PARTUUID=b921b045-1d rootfstype=ext4 init=/sbin/init rootwait

===========
label kernel-4.4
    kernel /Image
    fdt /rk3399-sapphire-excavator-linux.dtb
append earlyprintk console=ttyFIQ0,1500000n8 rw root=PARTUUID=b921b045-1d rootfstype=ext4 init=/sbin/init rootwait
==================


setenv bootargs earlycon=uart8250,mmio,0xff1a0000 console=ttyS2,1500000n8 root=dev/mmcblk0p7 rootwait rootfstype=ext4 init=/sbin/init




# defconfig
https://github.com/rockchip-linux/kernel/blob/release-4.4/arch/arm/configs/rockchip_linux_defconfig


# dtb 


# earlyprintk — Show early boot messages. 
- from here
- http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/re05.html

# earlycon=   [KNL] Output early console device and options.
-  from here



uboot:ext2ls mmc 0:4
uboot:ext2ls mmc 0:5 sbin



# Booting_Linux_kernel_using_U-Boot
- http://processors.wiki.ti.com/index.php/Booting_Linux_kernel_using_U-Boot


# dtb create dts/dtsi => dtb
- from here
- http://www.wiki.xilinx.com/Build+Device+Tree+Blob
> ./scripts/dtc/dtc -I dts -O dtb -o <devicetree name>.dtb <devicetree name>.dts

- for arm linux kernel only
> make ARCH=arm dtbs
- compiled kernel with dtb
> make ARCH=arm <devicetree name>.dtb


# dtb How to decompile dtb file?
- dtc -I dtb -O dts -o rk3399-sapphire-excavator-linux.dts rk3399-sapphire-excavator-linux.dtb



# uboot boot order mayby
- nice to know
- https://github.com/notro/rpi-build/wiki/U-Boot
boot    - boot default, i.e., run 'bootcmd'
bootcmd=run distro_bootcmd 
distro_bootcmd=for target in ${boot_t; do run bootcmd_${target}; done


# build mainline kernel by hand

- borad info
case ${BOARD} in
        "rk3399-excavator")
                DEFCONFIG=rockchip_linux_defconfig
                UBOOT_DEFCONFIG=evb-rk3399_defconfig
                DTB_MAINLINE=rk3399-sapphire-excavator.dtb
                DTB=rk3399-sapphire-excavator-linux.dtb
                export ARCH=arm64
                export CROSS_COMPILE=aarch64-linux-gnu-
                CHIP="rk3399"
                ;;

- gcc version

>  aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


> uname -a
Linux ubuntu-xenial 4.4.0-104-generic #127-Ubuntu SMP Mon Dec 11 12:16:42 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux


> lsb_relaese -a
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.3 LTS


## build  kernel
## START ##
DEFCONFIG=rockchip_linux_defconfig
UBOOT_DEFCONFIG=evb-rk3399_defconfig
DTB_MAINLINE=rk3399-sapphire-excavator.dtb
DTB=rk3399-sapphire-excavator-linux.dtb
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
CHIP="rk3399"
LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
TOOLPATH=${LOCALPATH}/rkbin/tools
EXTLINUXPATH=${LOCALPATH}/build/extlinux
CHIP="rk3399"
TARGET=""
ROOTFS_PATH=""
KERNEL_DIR="linux-stable"
KERNEL_TAG="v4.10.17"
cd ${KERNEL_DIR}
#TODO old git checkout tags/v4.10.17
git checkout tags/${KERNEL_TAG}
KERNEL_VERSION=$(make kernelversion) 
make rockchip_linux_defconfig
make -j8
#TDOD old KERNEL_VERSION=$(cat ${LOCALPATH}/${KERNEL_DIR}/include/config/kernel.release)
version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
if version_gt "${KERNEL_VERSION}" "4.5"; then
        if [ "${DTB_MAINLINE}" ]; then
                DTB=${DTB_MAINLINE}
        fi
fi
echo -e "\e[36m We used DTB => ${DTB}\e[0m"
cp kernel/arch/arm64/boot/Image ${OUT}/kernel/
cp kernel/arch/arm64/boot/dts/rockchip/${DTB} ${OUT}/kernel/
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
echo -e "\e[36m Generate Boot image : ${BOOT} success! \e[0m"
## END ##



# How to unpack and repack an initial ramdisk (initrd/initramfs) image? 
- https://access.redhat.com/solutions/24029


# ayufan rootfs
- https://github.com/ayufan-rock64/linux-build/blob/master/rootfs/make_rootfs.sh


What is  /sbin/init files



apt-get install shellcheck




#boot from sdcard
In the boot rom, the eMMC has higher priority if it have firmware.
So what you need to do is override the firmware in eMMC, then you can 
use SD card.
You can do this.
dd if=/dev/zero of=out count=4096

rkdeveloptool db rkxx_loader_vx.xx.bin
rkdeveloptool wl 0x40 out
rkdeveloptool rd

After this, the bootrom should not able to found firmware in eMMC, and 
it will
try to find the firmware in SD card.

# linux master
https://kernel.googlesource.com/pub/scm/linux/kernel/git/mmind/linux-rockchip/



https://github.com/mmind/u-boot-rockchip/tree/master-rockchip

# uboot-rockchip master
https://github.com/mmind/u-boot-rockchip/tree/master-rockchip


# builöd rootfs
http://bbs.t-firefly.com/forum.php?mod=viewthread&tid=2072



# To customize Android firmware, there are two methods: 
- http://wiki.t-firefly.com/index.php/Firefly-RK3399/Customize_android_firmware/en


ttyO0,115200n8

# ??This issue looks like environment setting/version mismatch with Boot loader to Linux Kernel.
- https://forums.xilinx.com/t5/Embedded-Linux/u-boot-load-kernel-stop-at-starting-kernel/td-p/755815


# uboot compress issus
- https://unix.stackexchange.com/questions/291408/linux-kernel-hangs-at-starting-kernel


# bootarg
- https://github.com/raspberrypi/linux/issues/2123

# 7.3. Passing Kernel Arguments
- https://www.denx.de/wiki/DULG/LinuxKernelArgs


# What is a system image??


# build image from rockchip
http://rockchip.wikidot.com/linux-user-guide#toc22


# rockchip gpt partion
- http://rockchip.wikidot.com/partition


!!!! gpt write mmc 0 $partitions


partitions=uuid_disk=${uuid_gpt_disk};r2,start=8MB,size=4MB,uuid=${uuid_gpt_loader2};name=trust,size=4t};name=rootfs,size=-,uuid=B921B045-1    DF0-41C3-AF44-4C6F280D3FAE; oot=echo Scanning ${devtype} ${devnum}:${distro_bootpart}...; fon_dev_for_scripts; done;run scan_dev_for_efi;

# vi ./include/configs/rockchip-common.h
# ./include/configs/rk3399_common.h:	"partitions=" PARTS_DEFAULT \




# uboot error
Writing GPT: ERROR: ** Can't read from device 0 **

at disk/part_efi.c:363/set_protective_mbr()
** Can't write to device 0 **
error!


append: earlyprintk otfstype=ext4 init=/sbin/init roreading /rk3399-sapphire-excavator-linux.dtb



