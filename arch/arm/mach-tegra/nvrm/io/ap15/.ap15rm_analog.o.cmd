cmd_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.o := arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-tegra/nvrm/io/ap15/.ap15rm_analog.o.d  -nostdinc -isystem /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include -Iinclude  -I/home/hp1/kernellast/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Wall -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1 -lrt -marm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -mcpu=cortex-a8 -msoft-float -Uarm -mfloat-abi=soft -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack -DNV_IS_AVP=0 -DNV_OAL=0 -DNV_USE_FUSE_CLOCK_ENABLE=0 -DNV_DEBUG=0 -Iarch/arm/mach-tegra/nvrm/core/common -Iarch/arm/mach-tegra/nvrm/io/common -Iarch/arm/mach-tegra/nvrm/io -Iarch/arm/mach-tegra/nvrm/core  -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1  -lrt -DCONFIG_MACH_STAR_TMUS_E -DSTAR_COUNTRY_ -DSTAR_OPERATOR_ -DCONFIG_MODEM_IFX -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(ap15rm_analog)"  -D"KBUILD_MODNAME=KBUILD_STR(ap15rm_analog)"  -c -o arch/arm/mach-tegra/nvrm/io/ap15/.tmp_ap15rm_analog.o arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.c

deps_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.o := \
  arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.c \
    $(wildcard include/config/0.h) \
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
  arch/arm/mach-tegra/nvrm/core/common/nvrm_structure.h \
  arch/arm/mach-tegra/include/nvos.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stdarg.h \
  arch/arm/mach-tegra/include/nvcommon.h \
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nverrval.h \
  arch/arm/mach-tegra/include/nvos_trace.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_module_private.h \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_relocation_table.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_moduleids.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_chipid.h \
  arch/arm/mach-tegra/include/nvrm_interrupt.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvos.h \
  arch/arm/mach-tegra/include/nvrm_memmgr.h \
  arch/arm/mach-tegra/include/nvrm_pinmux.h \
  arch/arm/mach-tegra/include/nvodm_modules.h \
  arch/arm/mach-tegra/include/nvrm_rmctrace.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_configuration.h \
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nvrm_analog.h \
  arch/arm/mach-tegra/include/nvodm_query.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/include/nvassert.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.h \
  arch/arm/mach-tegra/include/nvrm_hardware_access.h \
  arch/arm/mach-tegra/include/nvrm_power.h \
  arch/arm/mach-tegra/include/ap16/arapb_misc.h \
    $(wildcard include/config/ctl/0.h) \
    $(wildcard include/config/ctl/0/word/count.h) \
    $(wildcard include/config/ctl/0/reset/val.h) \
    $(wildcard include/config/ctl/0/reset/mask.h) \
    $(wildcard include/config/ctl/0/sw/default/val.h) \
    $(wildcard include/config/ctl/0/sw/default/mask.h) \
    $(wildcard include/config/ctl/0/read/mask.h) \
    $(wildcard include/config/ctl/0/write/mask.h) \
    $(wildcard include/config/ctl/0/tbe/shift.h) \
    $(wildcard include/config/ctl/0/tbe/field.h) \
    $(wildcard include/config/ctl/0/tbe/range.h) \
    $(wildcard include/config/ctl/0/tbe/woffset.h) \
    $(wildcard include/config/ctl/0/tbe/default.h) \
    $(wildcard include/config/ctl/0/tbe/default/mask.h) \
    $(wildcard include/config/ctl/0/tbe/sw/default.h) \
    $(wildcard include/config/ctl/0/tbe/sw/default/mask.h) \
    $(wildcard include/config/ctl/0/tbe/init/enum.h) \
    $(wildcard include/config/ctl/0/tbe/disable.h) \
    $(wildcard include/config/ctl/0/tbe/enable.h) \
    $(wildcard include/config/ctl/0/jtag/shift.h) \
    $(wildcard include/config/ctl/0/jtag/field.h) \
    $(wildcard include/config/ctl/0/jtag/range.h) \
    $(wildcard include/config/ctl/0/jtag/woffset.h) \
    $(wildcard include/config/ctl/0/jtag/default.h) \
    $(wildcard include/config/ctl/0/jtag/default/mask.h) \
    $(wildcard include/config/ctl/0/jtag/sw/default.h) \
    $(wildcard include/config/ctl/0/jtag/sw/default/mask.h) \
    $(wildcard include/config/ctl/0/jtag/init/enum.h) \
    $(wildcard include/config/ctl/0/jtag/disable.h) \
    $(wildcard include/config/ctl/0/jtag/enable.h) \
    $(wildcard include/config/0/word/count.h) \
    $(wildcard include/config/0/reset/val.h) \
    $(wildcard include/config/0/reset/mask.h) \
    $(wildcard include/config/0/sw/default/val.h) \
    $(wildcard include/config/0/sw/default/mask.h) \
    $(wildcard include/config/0/read/mask.h) \
    $(wildcard include/config/0/write/mask.h) \
    $(wildcard include/config/0/td/corepwr/en/shift.h) \
    $(wildcard include/config/0/td/corepwr/en/field.h) \
    $(wildcard include/config/0/td/corepwr/en/range.h) \
    $(wildcard include/config/0/td/corepwr/en/woffset.h) \
    $(wildcard include/config/0/td/corepwr/en/default.h) \
    $(wildcard include/config/0/td/corepwr/en/default/mask.h) \
    $(wildcard include/config/0/td/corepwr/en/sw/default.h) \
    $(wildcard include/config/0/td/corepwr/en/sw/default/mask.h) \
    $(wildcard include/config/0/td/corepwr/en/init/enum.h) \
    $(wildcard include/config/0/td/corepwr/en/disable.h) \
    $(wildcard include/config/0/td/corepwr/en/enable.h) \
    $(wildcard include/config/0/ve/corepwr/en/shift.h) \
    $(wildcard include/config/0/ve/corepwr/en/field.h) \
    $(wildcard include/config/0/ve/corepwr/en/range.h) \
    $(wildcard include/config/0/ve/corepwr/en/woffset.h) \
    $(wildcard include/config/0/ve/corepwr/en/default.h) \
    $(wildcard include/config/0/ve/corepwr/en/default/mask.h) \
    $(wildcard include/config/0/ve/corepwr/en/sw/default.h) \
    $(wildcard include/config/0/ve/corepwr/en/sw/default/mask.h) \
    $(wildcard include/config/0/ve/corepwr/en/init/enum.h) \
    $(wildcard include/config/0/ve/corepwr/en/disable.h) \
    $(wildcard include/config/0/ve/corepwr/en/enable.h) \
    $(wildcard include/config/0/cpu/corepwr/en/shift.h) \
    $(wildcard include/config/0/cpu/corepwr/en/field.h) \
    $(wildcard include/config/0/cpu/corepwr/en/range.h) \
    $(wildcard include/config/0/cpu/corepwr/en/woffset.h) \
    $(wildcard include/config/0/cpu/corepwr/en/default.h) \
    $(wildcard include/config/0/cpu/corepwr/en/default/mask.h) \
    $(wildcard include/config/0/cpu/corepwr/en/sw/default.h) \
    $(wildcard include/config/0/cpu/corepwr/en/sw/default/mask.h) \
    $(wildcard include/config/0/cpu/corepwr/en/init/enum.h) \
    $(wildcard include/config/0/cpu/corepwr/en/disable.h) \
    $(wildcard include/config/0/cpu/corepwr/en/enable.h) \
    $(wildcard include/config/0/dac/fifo/th/shift.h) \
    $(wildcard include/config/0/dac/fifo/th/field.h) \
    $(wildcard include/config/0/dac/fifo/th/range.h) \
    $(wildcard include/config/0/dac/fifo/th/woffset.h) \
    $(wildcard include/config/0/dac/fifo/th/default.h) \
    $(wildcard include/config/0/dac/fifo/th/default/mask.h) \
    $(wildcard include/config/0/dac/fifo/th/sw/default.h) \
    $(wildcard include/config/0/dac/fifo/th/sw/default/mask.h) \
    $(wildcard include/config/0/dac/source/shift.h) \
    $(wildcard include/config/0/dac/source/field.h) \
    $(wildcard include/config/0/dac/source/range.h) \
    $(wildcard include/config/0/dac/source/woffset.h) \
    $(wildcard include/config/0/dac/source/default.h) \
    $(wildcard include/config/0/dac/source/default/mask.h) \
    $(wildcard include/config/0/dac/source/sw/default.h) \
    $(wildcard include/config/0/dac/source/sw/default/mask.h) \
    $(wildcard include/config/0/dac/source/tvdac/off.h) \
    $(wildcard include/config/0/dac/source/tvo.h) \
    $(wildcard include/config/0/dac/source/display.h) \
    $(wildcard include/config/0/dac/source/displayb.h) \
    $(wildcard include/config/0/dac/din/oride/en/shift.h) \
    $(wildcard include/config/0/dac/din/oride/en/field.h) \
    $(wildcard include/config/0/dac/din/oride/en/range.h) \
    $(wildcard include/config/0/dac/din/oride/en/woffset.h) \
    $(wildcard include/config/0/dac/din/oride/en/default.h) \
    $(wildcard include/config/0/dac/din/oride/en/default/mask.h) \
    $(wildcard include/config/0/dac/din/oride/en/sw/default.h) \
    $(wildcard include/config/0/dac/din/oride/en/sw/default/mask.h) \
    $(wildcard include/config/0/dac/din/oride/en/disable.h) \
    $(wildcard include/config/0/dac/din/oride/en/enable.h) \
    $(wildcard include/config/0/dac/din/oride/shift.h) \
    $(wildcard include/config/0/dac/din/oride/field.h) \
    $(wildcard include/config/0/dac/din/oride/range.h) \
    $(wildcard include/config/0/dac/din/oride/woffset.h) \
    $(wildcard include/config/0/dac/din/oride/default.h) \
    $(wildcard include/config/0/dac/din/oride/default/mask.h) \
    $(wildcard include/config/0/dac/din/oride/sw/default.h) \
    $(wildcard include/config/0/dac/din/oride/sw/default/mask.h) \
    $(wildcard include/config/0/dac/ampin/shift.h) \
    $(wildcard include/config/0/dac/ampin/field.h) \
    $(wildcard include/config/0/dac/ampin/range.h) \
    $(wildcard include/config/0/dac/ampin/woffset.h) \
    $(wildcard include/config/0/dac/ampin/default.h) \
    $(wildcard include/config/0/dac/ampin/default/mask.h) \
    $(wildcard include/config/0/dac/ampin/sw/default.h) \
    $(wildcard include/config/0/dac/ampin/sw/default/mask.h) \
  arch/arm/mach-tegra/include/ap15/arclk_rst.h \
  arch/arm/mach-tegra/include/ap15/arfuse.h \
  arch/arm/mach-tegra/include/nvodm_query.h \
  arch/arm/mach-tegra/include/nvodm_pmu.h \
    $(wildcard include/config/mach/star.h) \
    $(wildcard include/config/mach/star/firenze.h) \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_clocks.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_clocks_limits_private.h \
  arch/arm/mach-tegra/include/nvrm_power_private.h \
    $(wildcard include/config/tegra/lp2policy/disabled.h) \
    $(wildcard include/config/tegra/lp2policy/enter/in/lc.h) \
    $(wildcard include/config/tegra/lp2policy/persist/in/lc.h) \
    $(wildcard include/config/tegra/lp2policy/ignore/lc.h) \
  arch/arm/mach-tegra/include/nvrm_power.h \
  arch/arm/mach-tegra/include/nvrm_diag.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_clockids.h \

arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.o: $(deps_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.o)

$(deps_arch/arm/mach-tegra/nvrm/io/ap15/ap15rm_analog.o):
