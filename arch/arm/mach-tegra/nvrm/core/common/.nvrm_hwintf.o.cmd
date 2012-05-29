cmd_arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.o := arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-tegra/nvrm/core/common/.nvrm_hwintf.o.d  -nostdinc -isystem /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include -Iinclude  -I/home/hp1/kernellast/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Wall -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1 -lrt -marm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -mcpu=cortex-a8 -msoft-float -Uarm -mfloat-abi=soft -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack -DNV_IS_AVP=0 -DNV_OAL=0 -DNV_USE_FUSE_CLOCK_ENABLE=0 -DNV_SHMOO_DATA_INIT=0 -DNV_DEBUG=0 -Iarch/arm/mach-tegra/nvrm/core/common -Iarch/arm/mach-tegra/nvrm/core  -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1  -lrt -DCONFIG_MACH_STAR_TMUS_E -DSTAR_COUNTRY_ -DSTAR_OPERATOR_ -DCONFIG_MODEM_IFX -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(nvrm_hwintf)"  -D"KBUILD_MODNAME=KBUILD_STR(nvrm_hwintf)"  -c -o arch/arm/mach-tegra/nvrm/core/common/.tmp_nvrm_hwintf.o arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.c

deps_arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.o := \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.c \
  arch/arm/mach-tegra/include/nvcommon.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stddef.h \
  /home/hp1/kernellast/arch/arm/include/asm/div64.h \
  /home/hp1/kernellast/arch/arm/include/asm/system.h \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/arch/has/barriers.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/32v6k.h) \
  include/linux/linkage.h \
  include/linux/compiler.h \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  include/linux/compiler-gcc4.h \
  /home/hp1/kernellast/arch/arm/include/asm/linkage.h \
  include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
    $(wildcard include/config/x86.h) \
  include/linux/typecheck.h \
  /home/hp1/kernellast/arch/arm/include/asm/irqflags.h \
  /home/hp1/kernellast/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/cpu/endian/be8.h) \
    $(wildcard include/config/arm/thumb.h) \
  /home/hp1/kernellast/arch/arm/include/asm/hwcap.h \
  /home/hp1/kernellast/arch/arm/include/asm/outercache.h \
    $(wildcard include/config/outer/cache/sync.h) \
    $(wildcard include/config/outer/cache.h) \
  arch/arm/mach-tegra/include/mach/barriers.h \
  include/asm-generic/cmpxchg-local.h \
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
  /home/hp1/kernellast/arch/arm/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/debug/bugverbose.h) \
  include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  arch/arm/mach-tegra/include/nvassert.h \
  arch/arm/mach-tegra/include/nvcommon.h \
  arch/arm/mach-tegra/include/nvrm_hardware_access.h \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nverrval.h \
  arch/arm/mach-tegra/include/nvos.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stdarg.h \
  arch/arm/mach-tegra/include/nvos_trace.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_module_private.h \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_relocation_table.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_moduleids.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/include/nvrm_rmctrace.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_chiplib.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.h \

arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.o: $(deps_arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.o)

$(deps_arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.o):
