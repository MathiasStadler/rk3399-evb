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
- i'm used the comment from the README.md file
- build/pack_deb.sh -c rk3399-excavator -d /dev/mmcblk0(mmc index in target device, not host) (-r rk-rootfs-build/linaro-rootfs.img)
- more info see (here)[https://github.com/rockchip-linux/rk-rootfs-build]
- and used this command
- ```sudo apt-get install binfmt-support qemu-user-static```
- ```sudo sed -i '10s/^$/yes/g' /var/lib/binfmts/qemu-arm /var/lib/binfmts/qemu-aarch64```
- ```systemctl restart binfmt-support```
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
- ```build/mk-image.sh -c rk3399-excavator  -t system -s 3000 -r rk-debian-build/linaro-rootfs.img``` 






2) run ```build/mk-kernel.sh rk3399-excavator```


