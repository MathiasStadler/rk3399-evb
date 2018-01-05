#!bin/bash

rkbin/tools/rkdeveloptool  db out/u-boot/rk3399_loader_v1.08.106.bin 
rkbin/tools/rkdeveloptool gpt rkbin/tools/parameter_gpt.txt 
rkbin/tools/rkdeveloptool pgpt 
rkbin/tools/rkdeveloptool  wl 0x40 out/u-boot/idbloader.img  
rkbin/tools/rkdeveloptool  wl 0x4000 out/u-boot/uboot.img 
rkbin/tools/rkdeveloptool  wl 0x6000 out/u-boot/trust.img 
rkbin/tools/rkdeveloptool  wl 0x8000 out/boot.img 
rkbin/tools/rkdeveloptool  wl 0x40000 rootfs/linaro-rootfs.img



OUT_DIR="${OUT:-out}"
let local WAIT_SLEEP=3
echo "OUT_DIR => ${OUT_DIR}"
rkbin/tools/rkdeveloptool  db "${OUT_DIR}"/u-boot/rk3399_loader_v1.08.106.bin && \
sleep $WAIT_SLEEP  && \
rkbin/tools/rkdeveloptool  wl 0x40 "${OUT_DIR}"/u-boot/idbloader.img  && \
sleep $WAIT_SLEEP  && \
rkbin/tools/rkdeveloptool  wl 0x4000 "${OUT_DIR}"/u-boot/uboot.img && \
sleep $WAIT_SLEEP  && \
rkbin/tools/rkdeveloptool  wl 0x6000 "${OUT_DIR}"/u-boot/trust.img && \
sleep $WAIT_SLEEP  && \
rkbin/tools/rkdeveloptool  wl 0x8000 "${OUT_DIR}"/boot.img && \
sleep $WAIT_SLEEP  && \
rkbin/tools/rkdeveloptool  wl 0x40000 "${OUT_DIR}"/rootfs/linaro-rootfs.img && \
sleep $WAIT_SLEEP  && \
rkbin/tools/rkdeveloptool rd