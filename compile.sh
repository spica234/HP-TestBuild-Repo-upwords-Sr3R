#!/bin/sh

export ARCH=arm;
export CCOMPILER=arm-linux-gnueabi-;
#export PATH=$PATH:/home/one/Downloads/android-arm/bin/;
export CROSS_COMPILE=arm-linux-gnueabi-;
export STAR_TMUS_REV=TMUS_10;
export TARGET_STAR_HWREV=TMUS_E;
export TARGET_MODEM=ifx;
#cp -f .config ../config;
#make mrproper && make clean;
#cp -f ../.config .;
make  ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- STAR_TMUS_REV=TMUS_10 TARGET_STAR_HWREV=TMUS_E TARGET_MODEM=ifx -j`grep "processor" /proc/cpuinfo | wc -l` && cp -f arch/arm/boot/zImage /home/one/new && cp -f drivers/net/wireless/bcm4329/wireless.ko /home/one/new && cp -f drivers/scsi/scsi_wait_scan.ko /home/one/new && cp -f crypto/ansi_cprng.ko /home/one/new && cp -f fs/smbfs/smbfs.ko /home/one/new && cp -f fs/cifs/cifs.ko /home/one/new;
cd /home/one/Downloads/compcache-0.6.2/ && make -j6 && cp -f ramzswap.ko /home/one/new && cp -f sub-projects/rzscontrol/rzscontrol /home/one/new;
echo "done";

