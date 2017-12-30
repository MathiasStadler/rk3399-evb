rkbin/tools/rkdeveloptool  db out/u-boot/rk3399_loader_v1.08.106.bin 
 rkbin/tools/rkdeveloptool gpt rkbin/tools/parameter_gpt.txt 
 rkbin/tools/rkdeveloptool pgpt 
 rkbin/tools/rkdeveloptool  wl 0x40 out/u-boot/idbloader.img  
 rkbin/tools/rkdeveloptool  wl 0x4000 out/u-boot/uboot.img 
 rkbin/tools/rkdeveloptool  wl 0x6000 out/u-boot/trust.img 
 rkbin/tools/rkdeveloptool  wl 0x8000 out/boot.img 
 rkbin/tools/rkdeveloptool  wl 0x40000 rootfs/linaro-rootfs.img