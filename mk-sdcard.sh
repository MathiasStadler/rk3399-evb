#!/bin/bash

sudo dd if=idbloader.img of=/dev/sdb seek=64
sudo dd if=uboot.img of=/dev/sdb seek=16384
sudo dd if=trust.img of=/dev/sdb seek=24576
sudo dd if=boot.img of=/dev/sdb seek=32768
sudo dd if=rootfs.img of=/dev/sdb seek=262144