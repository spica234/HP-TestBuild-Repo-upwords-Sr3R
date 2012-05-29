#
# linux/arch/arm/vfp/Makefile
#
# Copyright (C) 2001 ARM Limited
#

# EXTRA_CFLAGS := -DDEBUG
# EXTRA_AFLAGS := -DDEBUG

KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-marm,-march=armv7-a,-msoft-float=-Wa,-mcpu=cortex-a8,-mfpu=vfpv3-d16,-mfloat-abi=soft)
LDFLAGS		+=--no-warn-mismatch

obj-y			+= vfp.o

vfp-$(CONFIG_VFP)	+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
