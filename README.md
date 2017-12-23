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


#create com object
- http://wiki.radxa.com/Rock/flash_the_image

debug udev