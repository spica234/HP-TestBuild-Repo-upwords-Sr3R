cmd_fs/cifs/md5.o := arm-linux-gnueabi-gcc -Wp,-MD,fs/cifs/.md5.o.d  -nostdinc -isystem /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include -Iinclude  -I/home/hp1/kernellast/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Wall -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1 -lrt -marm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -mcpu=cortex-a8 -msoft-float -Uarm -mfloat-abi=soft -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack  -DMODULE  -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1  -lrt -DCONFIG_MACH_STAR_TMUS_E -DSTAR_COUNTRY_ -DSTAR_OPERATOR_ -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(md5)"  -D"KBUILD_MODNAME=KBUILD_STR(cifs)"  -c -o fs/cifs/.tmp_md5.o fs/cifs/md5.c

deps_fs/cifs/md5.o := \
  fs/cifs/md5.c \
  include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  include/linux/compiler.h \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  include/linux/compiler-gcc4.h \
  include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /home/hp1/kernellast/arch/arm/include/asm/types.h \
  include/asm-generic/int-ll64.h \
  /home/hp1/kernellast/arch/arm/include/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
  include/linux/posix_types.h \
  include/linux/stddef.h \
  /home/hp1/kernellast/arch/arm/include/asm/posix_types.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stdarg.h \
  /home/hp1/kernellast/arch/arm/include/asm/string.h \
  fs/cifs/md5.h \

fs/cifs/md5.o: $(deps_fs/cifs/md5.o)

$(deps_fs/cifs/md5.o):
