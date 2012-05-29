cmd_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.o := arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-tegra/nvrm/io/ap15/.ap15rm_gpio_vi.o.d  -nostdinc -isystem /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include -Iinclude  -I/home/hp1/kernellast/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Wall -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1 -lrt -marm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -mcpu=cortex-a8 -msoft-float -Uarm -mfloat-abi=soft -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack -DNV_IS_AVP=0 -DNV_OAL=0 -DNV_USE_FUSE_CLOCK_ENABLE=0 -DNV_DEBUG=0 -Iarch/arm/mach-tegra/nvrm/core/common -Iarch/arm/mach-tegra/nvrm/io/common -Iarch/arm/mach-tegra/nvrm/io -Iarch/arm/mach-tegra/nvrm/core  -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1  -lrt -DCONFIG_MACH_STAR_TMUS_E -DSTAR_COUNTRY_ -DSTAR_OPERATOR_ -DCONFIG_MODEM_IFX -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(ap15rm_gpio_vi)"  -D"KBUILD_MODNAME=KBUILD_STR(ap15rm_gpio_vi)"  -c -o arch/arm/mach-tegra/nvrm/io/ap15/.tmp_ap15rm_gpio_vi.o arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.c

deps_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.o := \
  arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.c \
  arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.h \
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
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/include/nvcommon.h \
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nverrval.h \
  arch/arm/mach-tegra/include/nvrm_pmu.h \
    $(wildcard include/config/mach/star.h) \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/include/nvrm_gpio.h \
  arch/arm/mach-tegra/include/nvos.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stdarg.h \
  arch/arm/mach-tegra/include/nvos_trace.h \
  arch/arm/mach-tegra/include/nvos.h \
  arch/arm/mach-tegra/nvrm/core/ap15/ap15rm_private.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_structure.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_module_private.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_relocation_table.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_moduleids.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_chipid.h \
  arch/arm/mach-tegra/include/nvrm_interrupt.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_memmgr.h \
  arch/arm/mach-tegra/include/nvrm_pinmux.h \
  arch/arm/mach-tegra/include/nvodm_modules.h \
  arch/arm/mach-tegra/include/nvrm_rmctrace.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_configuration.h \
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nvrm_power_private.h \
    $(wildcard include/config/tegra/lp2policy/disabled.h) \
    $(wildcard include/config/tegra/lp2policy/enter/in/lc.h) \
    $(wildcard include/config/tegra/lp2policy/persist/in/lc.h) \
    $(wildcard include/config/tegra/lp2policy/ignore/lc.h) \
  arch/arm/mach-tegra/include/nvrm_power.h \
  arch/arm/mach-tegra/include/nvodm_query.h \
  arch/arm/mach-tegra/include/nvodm_query.h \
  arch/arm/mach-tegra/include/ap15/arvi.h \
    $(wildcard include/config/0.h) \
    $(wildcard include/config/0/word/count.h) \
    $(wildcard include/config/0/reset/val.h) \
    $(wildcard include/config/0/reset/mask.h) \
    $(wildcard include/config/0/sw/default/val.h) \
    $(wildcard include/config/0/sw/default/mask.h) \
    $(wildcard include/config/0/read/mask.h) \
    $(wildcard include/config/0/write/mask.h) \
    $(wildcard include/config/0/mipi/cal/termosa/shift.h) \
    $(wildcard include/config/0/mipi/cal/termosa/field.h) \
    $(wildcard include/config/0/mipi/cal/termosa/range.h) \
    $(wildcard include/config/0/mipi/cal/termosa/woffset.h) \
    $(wildcard include/config/0/mipi/cal/termosa/default.h) \
    $(wildcard include/config/0/mipi/cal/termosa/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/termosa/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/termosa/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/shift.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/field.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/range.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/woffset.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/default.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/hspuosa/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/shift.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/field.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/range.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/woffset.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/default.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/hspdosa/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/prescale/shift.h) \
    $(wildcard include/config/0/mipi/cal/prescale/field.h) \
    $(wildcard include/config/0/mipi/cal/prescale/range.h) \
    $(wildcard include/config/0/mipi/cal/prescale/woffset.h) \
    $(wildcard include/config/0/mipi/cal/prescale/default.h) \
    $(wildcard include/config/0/mipi/cal/prescale/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/prescale/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/prescale/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/shift.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/field.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/range.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/woffset.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/default.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/noise/flt/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/overidea/shift.h) \
    $(wildcard include/config/0/mipi/cal/overidea/field.h) \
    $(wildcard include/config/0/mipi/cal/overidea/range.h) \
    $(wildcard include/config/0/mipi/cal/overidea/woffset.h) \
    $(wildcard include/config/0/mipi/cal/overidea/default.h) \
    $(wildcard include/config/0/mipi/cal/overidea/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/overidea/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/overidea/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/startcal/shift.h) \
    $(wildcard include/config/0/mipi/cal/startcal/field.h) \
    $(wildcard include/config/0/mipi/cal/startcal/range.h) \
    $(wildcard include/config/0/mipi/cal/startcal/woffset.h) \
    $(wildcard include/config/0/mipi/cal/startcal/default.h) \
    $(wildcard include/config/0/mipi/cal/startcal/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/startcal/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/startcal/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/termosb/shift.h) \
    $(wildcard include/config/0/mipi/cal/termosb/field.h) \
    $(wildcard include/config/0/mipi/cal/termosb/range.h) \
    $(wildcard include/config/0/mipi/cal/termosb/woffset.h) \
    $(wildcard include/config/0/mipi/cal/termosb/default.h) \
    $(wildcard include/config/0/mipi/cal/termosb/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/termosb/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/termosb/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/shift.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/field.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/range.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/woffset.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/default.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/hspuosb/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/shift.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/field.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/range.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/woffset.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/default.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/hspdosb/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/overideb/shift.h) \
    $(wildcard include/config/0/mipi/cal/overideb/field.h) \
    $(wildcard include/config/0/mipi/cal/overideb/range.h) \
    $(wildcard include/config/0/mipi/cal/overideb/woffset.h) \
    $(wildcard include/config/0/mipi/cal/overideb/default.h) \
    $(wildcard include/config/0/mipi/cal/overideb/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/overideb/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/overideb/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/termosd/shift.h) \
    $(wildcard include/config/0/mipi/cal/termosd/field.h) \
    $(wildcard include/config/0/mipi/cal/termosd/range.h) \
    $(wildcard include/config/0/mipi/cal/termosd/woffset.h) \
    $(wildcard include/config/0/mipi/cal/termosd/default.h) \
    $(wildcard include/config/0/mipi/cal/termosd/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/termosd/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/termosd/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/shift.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/field.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/range.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/woffset.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/default.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/hspuosd/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/shift.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/field.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/range.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/woffset.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/default.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/hspdosd/sw/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/overided/shift.h) \
    $(wildcard include/config/0/mipi/cal/overided/field.h) \
    $(wildcard include/config/0/mipi/cal/overided/range.h) \
    $(wildcard include/config/0/mipi/cal/overided/woffset.h) \
    $(wildcard include/config/0/mipi/cal/overided/default.h) \
    $(wildcard include/config/0/mipi/cal/overided/default/mask.h) \
    $(wildcard include/config/0/mipi/cal/overided/sw/default.h) \
    $(wildcard include/config/0/mipi/cal/overided/sw/default/mask.h) \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.h \
  arch/arm/mach-tegra/include/nvrm_hardware_access.h \
  arch/arm/mach-tegra/include/nvodm_query_discovery.h \
  arch/arm/mach-tegra/include/nvodm_services.h \
  arch/arm/mach-tegra/include/nvassert.h \
  arch/arm/mach-tegra/include/nvcolor.h \
  arch/arm/mach-tegra/include/nvodm_query_pinmux.h \
  arch/arm/mach-tegra/include/nvassert.h \

arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.o: $(deps_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.o)

$(deps_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_gpio_vi.o):
