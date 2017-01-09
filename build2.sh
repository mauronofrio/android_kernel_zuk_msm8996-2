#!/bin/bash
rm -rf modules
export CONFIG_FILE="cyanogenmod_z2_defconfig"
export ARCH="arm64"
export CROSS_COMPILE="aarch64-linux-android-"
export TOOL_CHAIN_PATH="/home/fedor917/android/aarch64-linux-android-4.9/bin"
export CONFIG_ABS_PATH="arch/${ARCH}/configs/${CONFIG_FILE}"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export objdir="/home/fedor917/kernel/obj"
export sourcedir="/media/fedor917/Fedor917/android/CM13/kernel/zuk/msm8996"
compile() {
  make O=$objdir ARCH=arm64 CROSS_COMPILE=${TOOL_CHAIN_PATH}/${CROSS_COMPILE}  $CONFIG_FILE -j4 
  make O=$objdir -j6
}
module(){
  mkdir modules
  find . -name '*.ko' -exec cp -av {} modules/ \;
  # strip modules 
 ${TOOL_CHAIN_PATH}/${CROSS_COMPILE}strip --strip-unneeded modules/*
  mkdir modules/qca_cld
  mv modules/wlan.ko modules/qca_cld/qca_cld_wlan.ko
}
compile 
cd ../
#module
#cp $objdir/arch/arm64/boot/zImage $sourcedir/zImage
#cp $objdir/arch/arm64/boot/dt.img.lz4 $sourcedir/dt.img

