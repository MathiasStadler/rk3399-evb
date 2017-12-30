# rk3399-evb


# change storagemedia=emmc 

- (first hint)[https://www.cubietruck.com/blogs/news/15243013-how-to-choose-storage-media-in-cubieboard]

# unpack images
- (Link) [http://wiki.t-firefly.com/index.php/Firefly-RK3399/Customize_android_firmware/en#Extract_Firmware]


./cache/sources/rockchip-kernel/release-4.4/Documentation/frv/booting.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/arm64/booting.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/zh_CN/arm64/booting.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/x86/boot.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/x86/x86_64/boot-options.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/devicetree/bindings/mips/cavium/bootbus.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/devicetree/booting-without-of.txt
./cache/sources/rockchip-kernel/release-4.4/Documentation/device-mapper/boot.txt


# change commandline
- https://forum.armbian.com/topic/329-moving-linux-to-sata-or-external-drive/


# find content in file
- ```find ./ -type f | xargs grep storagemedia```

# boot rk3399
- http://wiki.t-firefly.com/index.php/Firefly-RK3399/Boot_mode/en

# board doku
- https://dl.vamrs.com/products/sapphire_excavator/RK3399_EVB_User_Guide-20160920.pdf


# xypron/debian-image-firefly-rk3399
- https://github.com/xypron/debian-image-firefly-rk3399

# boot from sdmmc
- http://bbs.t-firefly.com/forum.php?mod=viewthread&tid=1921&extra=&page=2

# compile kernel 
- http://wiki.t-firefly.com/index.php/Firefly-RK3399/Build_kernel/en

# FASTBOOT uBoot
- http://www.denx.de/en/pub/Documents/Presentations/EWC2012_Roeder_Zundel_Fastboot.pdf

# toybox
- http://landley.net/toybox/about.html
- http://landley.net/talks/celf-2013.txt good explanation  why toolbox

# Armbian Blog post about img building and github repo
- (Link)[https://forum.armbian.com/topic/4854-add-support-for-rk3399-2xa724xa53/]

# rk3288 mali kernel
- https://github.com/Miouyouyou/MyyQi

# wiki rk3288
- http://wiki.t-firefly.com/index.php/Firefly-RK3288/en


# How to Upgrade Firmware in Rockchip RK3288, RK3328, RK3399 Android TV Boxes

- https://www.cnx-software.com/2014/08/12/how-to-upgrade-firmware-in-rockchip-rk3288-android-tv-boxes/


# next tutorial
- http://blog.geekbuying.com/2014/08/how-to-flash-stock-firmware-for-rk3288-tv-box-tablet-pc-newest-flash-tools-download-available/

# linux tool  rktool v1.24
- https://drive.google.com/file/d/0B7HO8lbGgAqAendKNTZMQlBXS2c/view


# update rktool
- http://en.t-firefly.com/doc/product/info/id/263.html

# MaskRom mode
- http://en.t-firefly.com/index.php/doc/product/info/id/401.html

# How to enter Rockusb maskrom mode MaskRom mode 
- http://rockchip.wikidot.com/how-to-enter-rockusb-maskrom-mode

# Rockchip Linux user guide
- http://opensource.rock-chips.com/wiki_Linux_user_guide

# Linux user guide
- http://rockchip.wikidot.com/linux-user-guide

# Rockchip Excavator_sapphire_board
- http://opensource.rock-chips.com/wiki_Excavator_sapphire_board

# Boot_from_eMMC
- http://opensource.rock-chips.com/wiki_Boot_option#Boot_from_eMMC



# irclog.whitequark.org/linux-rockchip  <= https://irclog.whitequark.org/linux-rockchip/2015-11-10
- Usb Timeout, Return for boot recovery!


# create com object
- Creating Comm Object failed!
- http://wiki.radxa.com/Rock/flash_the_image
- last paragraph of article 

- ```echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666", GROUP="plugdev"' | sudo tee /etc/udev/rules.d/51-android.rules ```
- then restart udev
- ```sudo udevadm control --reload-rules && sudo udevadm trigger```


https://github.com/linuxerwang/rkflashkit


# another RK3399_Linux_Manual 
- http://x.9tripod.com/wiki/zh/index.php/RK3399_Linux_Manual


# rkflashkit 
- i'm use this
- https://github.com/linuxerwang/rkflashkit.git
- ```cd ~/Projecte```
- ```sudo apt-get install build-essential fakeroot``` 
- ```git clone  https://github.com/linuxerwang/rkflashkit. ```
- ```./waf debian ```
- ``` sudo apt-get install python-gtk2```
- ```sudo dpkg -i rkflashkit_0.1.5_all.deb```

- start rkflashkit device in rockusb mode
- ```sudo rkflashkit```


# rkflashkit cli
- http://wiki.t-firefly.com/index.php/Firefly-RK3399/Flash_image/en
- last remark



# https://www.cnx-software.com/2017/09/25/checking-out-debian-and-linux-sdk-for-videostrong-vs-rd-rk3399-board/


# https://www.cnx-software.com/2014/05/25/how-to-upgrade-firmware-for-rockchip-rk3066rk3188-devices-with-the-command-line-in-linux/
# https://www.cnx-software.com/2014/05/25/how-to-upgrade-firmware-for-rockchip-rk3066rk3188-devices-with-the-command-line-in-linux/

https://www.cnx-software.com/2017/08/11/videostrong-vs-rd-rk3399-is-another-development-board-based-on-rockchip-rk3399-processor/


# docker build iamges
- https://github.com/rockchip-linux/docker-rockchip
- https://github.com/rockchip-linux/rk-rootfs-build
- http://opensource.rock-chips.com/wiki_Cross_Compile#Docker


- http://opensource.rock-chips.com/wiki_Board_Config




# build rk3399-excavator from soure first try
- use vagrant image xenial

- follow mainly tutorial http://rockchip.wikidot.com/linux-user-guide#toc4

## instal first missing package that not notes in tutorial not a error maby the vagrant dafault iamge are missing this package 

- ``` sudo apt-get install repo libssl-dev bs ```

1a) ```apt-get update && apt-get upgarde```

1) install package according to instructions
- ``` sudo apt-get install git-core gitk git-gui gcc-arm-linux-gnueabihf u-boot-tools device-tree-compiler gcc-aarch64-linux-gnu     mtools parted pv```
2) instal missing package that not include in tutorial and vagrant images
- ``` sudo apt-get install repo libssl-dev bc dpkg-dev debhelper```
4) create and change to directory according to instructions
``` mkdir rk-linux && cd rk-linux```
3) clone repo for debian according to instructions 
- ``` repo init -u https://github.com/rockchip-linux/manifests ```
- ``` repo sync```
4) Building rootfs
- i'm according to instructions this instruction
- "or you could use the (rootfs-build-script)[https://github.com/rockchip-linux/rk-rootfs-build] from Rockchip to build rootfs yourselves"
- and used this command
- ``` cd ~/rk-linux && git clone https://github.com/rockchip-linux/rk-rootfs-build.git && cd rk-rootfs-build ```
- the dir rk-rootfs-build is expect as subdirectory of rk-linux :-)
- ```sudo apt-get install binfmt-support qemu-user-static```
- ```sudo sed -i '10s/^$/yes/g' /var/lib/binfmts/qemu-arm /var/lib/binfmts/qemu-aarch64```
- ```systemctl restart binfmt-support```
- ```sudo dpkg -i ubuntu-build-service/packages/*```
- ```sudo apt-get install -f```
- ```RELEASE=stretch TARGET=desktop ARCH=armhf ./mk-base-debian.sh```
- ```RELEASE=stretch ARCH=armhf ./mk-rootfs.sh```
- ``` ./mk-image.sh ```

- change to rk-linux
- ```cd ..```


- Binfmt support (info)[https://github.com/ayufan-rock64/linux-build/blob/master/recipes/binfmt-misc.md] 
- ```build/pack_deb.sh -c rk3399-excavator -d /dev/mmcblk0 ```
- The mmc index can you found here 2nd table
- http://opensource.rock-chips.com/wiki_Board_Config
5) compile kernel according to instructions
- ```build/mk-kernel.sh rk3399-excavator```
6) compile uboot according to instructions
- ```build/mk-uboot.sh rk3399-excavator```
7) pack kernel and extlinux as boot.img according to instructions 
- ```build/mk-image.sh -c rk3399-excavator -t boot```
8) pack one image according to instructions
- ```build/mk-image.sh -c rk3399-excavator -t system -r rk-rootfs-build/linaro-rootfs.img```
-  the output found you in the out directory



# pdf with more info
- http://opensource.rock-chips.com/images/f/f9/RK3399_Linux_Debain_V1.1_Development_Guide170620.pdf

# flash to emmc
- prepare  vagrantBox for usb
- ```echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666", GROUP="plugdev"' | sudo tee /etc/udev/rules.d/51-android.rules```
- then restart udev
- ```sudo udevadm control --reload-rules && sudo udevadm trigger```




- ```rkbin/tools/rkdeveloptool  db out/u-boot/rk3399_loader_v1.08.106.bin ```
- ```rkbin/tools/rkdeveloptool gpt rkbin/tools/parameter_gpt.txt ```
- ```rkbin/tools/rkdeveloptool pgpt ``
- ```rkbin/tools/rkdeveloptool  wl 0x40 out/u-boot/idbloader.img ``` 
- ```rkbin/tools/rkdeveloptool  wl 0x4000 out/u-boot/uboot.img ```
- ```rkbin/tools/rkdeveloptool  wl 0x6000 out/u-boot/trust.img ```
- ```rkbin/tools/rkdeveloptool  wl 0x8000 out/boot.img ```
- ```rkbin/tools/rkdeveloptool  wl 0x40000 rk-rootfs-build/linaro-rootfs.img ```
- reboot device
- ```rkbin/tools/rkdeveloptool rd```




# boot SBC explian SPL
- http://opensource.rock-chips.com/wiki_Boot_option

#gpt
- http://opensource.rock-chips.com/wiki_Partitions#Default_storage_map
- http://rockchip.wikidot.com/partitions
- https://github.com/rockchip-linux/rkbin/blob/master/tools/parameter_gpt.txt


# rockchip kernel info
- http://opensource.rock-chips.com/wiki_Rockchip_Kernel#Install_Boot.2Fkernel


# mmc part
- TODO




# install  rkdeveloptool
- git clone https://github.com/rockchip-linux/rkdeveloptool

install libusb and libudev
	sudo apt-get install libudev-dev libusb-1.0-0-dev dh-autoreconf
2 go into root of rkdeveloptool
3 autoreconf -i
4 ./configure
5 make





# install rkflashtool
- http://opensource.rock-chips.com/wiki_Partitions

git clone https://github.com/ARM-software/arm-trusted-firmware.git
   92  git clone https://github.com/rockchip-linux/rkbin
   93  git clone https://github.com/rockchip-linux/rkflashtool
   94  cd rkflashtool/
   95  make
   96  sudo apt-get install libusb-1.0
   97  make
   98  sudo make install 


build/flash_tool.sh  -c rk3399 -p system  -i  out/system.img

# upgrade_tool
- boot.img
- kernel.img
- 
- http://wiki.t-firefly.com/index.php/Firefly-RK3399/Flash_image/en#upgrade_tool


# boot problem
- You can use ```rkdeveloptool wl 64 ``` (loader1 offset) dirty_content to erase it
- from here https://github.com/rockchip-linux/kernel/issues/14


2) run ```build/mk-kernel.sh rk3399-excavator```





cd rk-rootfs-build/
   38  sudo dpkg -i ubuntu-build-service/packages/*
   39  sudo apt-get install -f
   40  RELEASE=stretch TARGET=desktop ARCH=armhf ./mk-base-debian.sh
   41  RELEASE=stretch ARCH=armhf ./mk-rootfs.sh
   42  ./mk-image.sh





MRBus Width=32 Col=10 Bank=8 Row=15/15 CS=2 Die Bus-Width=32 Size=048MB         
256B stride                                                                     
ch 0 ddrconfig = 0x101, ddrsize = 0x2020                                        
ch 1 ddrconfig = 0x101, ddrsize = 0x2020                                        
pmugrf_os_reg[2] = 0x3AA0DAA0, stride = 0xD                                     
OUT                                                                             
Boot1: 2017-04-07, version: 1.06                                                
CPUId = 0x0                                                                     
ChipType = 0x10, 1836                                                           
SdmmcInit=2 0                                                                   
BootCapSize=100000                                                              
UserCapSize=7456MB                                                              
FwPartOffset=2000 , 100000                                                      
SdmmcInit=0 20                                                                  
StorageInit ok = 66275                                                          
LoadTrustBL                                                                     
LoadTrustBL error:-1                                                            
powerOn 482761  



#meta gpt 
- https://github.com/rockchip-linux/meta-rockchip/blob/master/classes/rockchip-gpt-img.bbclass


# http://wiki.t-firefly.com/index.php/Firefly-RK3399/ADC/en



# Status Matrix
- http://opensource.rock-chips.com/wiki_Status_Matrix#Mainline_Kernel_Status_Matrix


# uboot from TI
- http://processors.wiki.ti.com/index.php/Linux_Core_U-Boot_User%27s_Guide#Updating_an_SD_card_or_eMMC_using_DFU




mmc part
mmc dev <n>
mmc list

gpio status




https://github.com/umiddelb/armhf/wiki/Get-more-out-of-%22Das-U-Boot%22#boot-an-alternative-kernel-image


sudo setenv m_boot_usb 'setenv bootargs "root=/dev/sda1 rootwait rw console=ttyS0,115200n8 console=tty0 no_console_suspend vdaccfg=0xa000 logo=osd1,loaded,0x7900000,720p,full dmfc=3 cvbsmode=576cvbs hdmimode=1080p m_bpp=32 vout=hdmi disablehpd=true"; fatload mmc 0:1 0x21000000 uImage;fatload mmc 0:1 0x22000000 uInitrd; fatload mmc 0:1 0x21800000 meson8b_odroidc.dtb; fdt addr 21800000; fdt rm /mesonstream; fdt rm /vdec; fdt rm /ppmgr; fdt rm /mesonfb; bootm 0x21000000 0x22000000 0x21800000'


- uboot explaination
- https://free-electrons.com/pub/conferences/2015/captronic/captronic-porting-linux-on-arm.pdf



- uboot: bootvx ???


# Difference between arm-none-eabi and arm-linux-gnueabi?
- https://stackoverflow.com/questions/38956680/difference-between-arm-none-eabi-and-arm-linux-gnueabi


