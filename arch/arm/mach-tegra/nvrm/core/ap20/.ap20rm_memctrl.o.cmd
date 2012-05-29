cmd_arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.o := arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-tegra/nvrm/core/ap20/.ap20rm_memctrl.o.d  -nostdinc -isystem /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include -Iinclude  -I/home/hp1/kernellast/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Wall -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1 -lrt -marm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -mcpu=cortex-a8 -msoft-float -Uarm -mfloat-abi=soft -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack -DNV_IS_AVP=0 -DNV_OAL=0 -DNV_USE_FUSE_CLOCK_ENABLE=0 -DNV_DEBUG=0 -Iarch/arm/mach-tegra/nvrm/core/common -Iarch/arm/mach-tegra/nvrm/core  -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1  -lrt -DCONFIG_MACH_STAR_TMUS_E -DSTAR_COUNTRY_ -DSTAR_OPERATOR_ -DCONFIG_MODEM_IFX -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(ap20rm_memctrl)"  -D"KBUILD_MODNAME=KBUILD_STR(ap20rm_memctrl)"  -c -o arch/arm/mach-tegra/nvrm/core/ap20/.tmp_ap20rm_memctrl.o arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.c

deps_arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.o := \
  arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.c \
    $(wildcard include/config/0.h) \
  arch/arm/mach-tegra/include/nvrm_init.h \
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
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nverrval.h \
  arch/arm/mach-tegra/include/nvassert.h \
  arch/arm/mach-tegra/include/nvos.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stdarg.h \
  arch/arm/mach-tegra/include/nvos_trace.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/include/ap20/armc.h \
    $(wildcard include/config/0/secure.h) \
    $(wildcard include/config/0/word/count.h) \
    $(wildcard include/config/0/reset/val.h) \
    $(wildcard include/config/0/reset/mask.h) \
    $(wildcard include/config/0/sw/default/val.h) \
    $(wildcard include/config/0/sw/default/mask.h) \
    $(wildcard include/config/0/read/mask.h) \
    $(wildcard include/config/0/write/mask.h) \
    $(wildcard include/config/0/gart/enable/shift.h) \
    $(wildcard include/config/0/gart/enable/field.h) \
    $(wildcard include/config/0/gart/enable/range.h) \
    $(wildcard include/config/0/gart/enable/woffset.h) \
    $(wildcard include/config/0/gart/enable/default.h) \
    $(wildcard include/config/0/gart/enable/default/mask.h) \
    $(wildcard include/config/0/gart/enable/sw/default.h) \
    $(wildcard include/config/0/gart/enable/sw/default/mask.h) \
    $(wildcard include/config/0/gart/enable/init/enum.h) \
    $(wildcard include/config/0/gart/enable/disable.h) \
    $(wildcard include/config/0/gart/enable/enable.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/shift.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/field.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/range.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/woffset.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/default.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/default/mask.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/sw/default.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/sw/default/mask.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/init/enum.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/disable.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/enable.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/disabled.h) \
    $(wildcard include/config/0/mpcorer/ll/ctrl/enabled.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/shift.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/field.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/range.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/woffset.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/default.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/default/mask.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/sw/default.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/sw/default/mask.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/init/enum.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/disable.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/enable.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/disabled.h) \
    $(wildcard include/config/0/mpcorer/ll/send/both/enabled.h) \
    $(wildcard include/config/0/ll/dram/interleave/shift.h) \
    $(wildcard include/config/0/ll/dram/interleave/field.h) \
    $(wildcard include/config/0/ll/dram/interleave/range.h) \
    $(wildcard include/config/0/ll/dram/interleave/woffset.h) \
    $(wildcard include/config/0/ll/dram/interleave/default.h) \
    $(wildcard include/config/0/ll/dram/interleave/default/mask.h) \
    $(wildcard include/config/0/ll/dram/interleave/sw/default.h) \
    $(wildcard include/config/0/ll/dram/interleave/sw/default/mask.h) \
    $(wildcard include/config/0/ll/dram/interleave/init/enum.h) \
    $(wildcard include/config/0/ll/dram/interleave/disable.h) \
    $(wildcard include/config/0/ll/dram/interleave/enable.h) \
    $(wildcard include/config/0/ll/dram/interleave/disabled.h) \
    $(wildcard include/config/0/ll/dram/interleave/enabled.h) \
  arch/arm/mach-tegra/include/ap20/aremc.h \
    $(wildcard include/config/0/die/off/exp/shift.h) \
    $(wildcard include/config/0/die/off/exp/field.h) \
    $(wildcard include/config/0/die/off/exp/range.h) \
    $(wildcard include/config/0/die/off/exp/woffset.h) \
    $(wildcard include/config/0/die/off/exp/default.h) \
    $(wildcard include/config/0/die/off/exp/default/mask.h) \
    $(wildcard include/config/0/die/off/exp/sw/default.h) \
    $(wildcard include/config/0/die/off/exp/sw/default/mask.h) \
    $(wildcard include/config/0/allow/idle/insert/shift.h) \
    $(wildcard include/config/0/allow/idle/insert/field.h) \
    $(wildcard include/config/0/allow/idle/insert/range.h) \
    $(wildcard include/config/0/allow/idle/insert/woffset.h) \
    $(wildcard include/config/0/allow/idle/insert/default.h) \
    $(wildcard include/config/0/allow/idle/insert/default/mask.h) \
    $(wildcard include/config/0/allow/idle/insert/sw/default.h) \
    $(wildcard include/config/0/allow/idle/insert/sw/default/mask.h) \
    $(wildcard include/config/0/allow/idle/insert/init/enum.h) \
    $(wildcard include/config/0/allow/idle/insert/disabled.h) \
    $(wildcard include/config/0/allow/idle/insert/enabled.h) \
    $(wildcard include/config/0/max/ll/greed/shift.h) \
    $(wildcard include/config/0/max/ll/greed/field.h) \
    $(wildcard include/config/0/max/ll/greed/range.h) \
    $(wildcard include/config/0/max/ll/greed/woffset.h) \
    $(wildcard include/config/0/max/ll/greed/default.h) \
    $(wildcard include/config/0/max/ll/greed/default/mask.h) \
    $(wildcard include/config/0/max/ll/greed/sw/default.h) \
    $(wildcard include/config/0/max/ll/greed/sw/default/mask.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/shift.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/field.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/range.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/woffset.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/default.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/default/mask.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/sw/default.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/disable/sw/default/mask.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/shift.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/field.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/range.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/woffset.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/default.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/default/mask.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/sw/default.h) \
    $(wildcard include/config/0/ll/greed/diff/bank/after/disable/sw/default/mask.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/shift.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/field.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/range.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/woffset.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/default.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/default/mask.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/sw/default.h) \
    $(wildcard include/config/0/ll/force/insert/wr/disable/sw/default/mask.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/shift.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/field.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/range.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/woffset.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/default.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/default/mask.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/sw/default.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/before/disable/sw/default/mask.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/shift.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/field.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/range.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/woffset.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/default.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/default/mask.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/sw/default.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/toggle/sw/default/mask.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/shift.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/field.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/range.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/woffset.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/default.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/default/mask.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/sw/default.h) \
    $(wildcard include/config/0/ll/insert/diff/bank/after/remove/sw/default/mask.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/shift.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/field.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/range.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/woffset.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/default.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/default/mask.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/sw/default.h) \
    $(wildcard include/config/0/auto/cal/pu/offset/sw/default/mask.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/shift.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/field.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/range.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/woffset.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/default.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/default/mask.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/sw/default.h) \
    $(wildcard include/config/0/auto/cal/pd/offset/sw/default/mask.h) \
    $(wildcard include/config/0/auto/cal/step/shift.h) \
    $(wildcard include/config/0/auto/cal/step/field.h) \
    $(wildcard include/config/0/auto/cal/step/range.h) \
    $(wildcard include/config/0/auto/cal/step/woffset.h) \
    $(wildcard include/config/0/auto/cal/step/default.h) \
    $(wildcard include/config/0/auto/cal/step/default/mask.h) \
    $(wildcard include/config/0/auto/cal/step/sw/default.h) \
    $(wildcard include/config/0/auto/cal/step/sw/default/mask.h) \
    $(wildcard include/config/0/autocal/slw/override/shift.h) \
    $(wildcard include/config/0/autocal/slw/override/field.h) \
    $(wildcard include/config/0/autocal/slw/override/range.h) \
    $(wildcard include/config/0/autocal/slw/override/woffset.h) \
    $(wildcard include/config/0/autocal/slw/override/default.h) \
    $(wildcard include/config/0/autocal/slw/override/default/mask.h) \
    $(wildcard include/config/0/autocal/slw/override/sw/default.h) \
    $(wildcard include/config/0/autocal/slw/override/sw/default/mask.h) \
    $(wildcard include/config/0/auto/cal/enable/shift.h) \
    $(wildcard include/config/0/auto/cal/enable/field.h) \
    $(wildcard include/config/0/auto/cal/enable/range.h) \
    $(wildcard include/config/0/auto/cal/enable/woffset.h) \
    $(wildcard include/config/0/auto/cal/enable/default.h) \
    $(wildcard include/config/0/auto/cal/enable/default/mask.h) \
    $(wildcard include/config/0/auto/cal/enable/sw/default.h) \
    $(wildcard include/config/0/auto/cal/enable/sw/default/mask.h) \
    $(wildcard include/config/0/auto/cal/enable/init/enum.h) \
    $(wildcard include/config/0/auto/cal/enable/disabled.h) \
    $(wildcard include/config/0/auto/cal/enable/enabled.h) \
    $(wildcard include/config/0/auto/cal/override/shift.h) \
    $(wildcard include/config/0/auto/cal/override/field.h) \
    $(wildcard include/config/0/auto/cal/override/range.h) \
    $(wildcard include/config/0/auto/cal/override/woffset.h) \
    $(wildcard include/config/0/auto/cal/override/default.h) \
    $(wildcard include/config/0/auto/cal/override/default/mask.h) \
    $(wildcard include/config/0/auto/cal/override/sw/default.h) \
    $(wildcard include/config/0/auto/cal/override/sw/default/mask.h) \
    $(wildcard include/config/0/auto/cal/start/shift.h) \
    $(wildcard include/config/0/auto/cal/start/field.h) \
    $(wildcard include/config/0/auto/cal/start/range.h) \
    $(wildcard include/config/0/auto/cal/start/woffset.h) \
    $(wildcard include/config/0/auto/cal/start/default.h) \
    $(wildcard include/config/0/auto/cal/start/default/mask.h) \
    $(wildcard include/config/0/auto/cal/start/sw/default.h) \
    $(wildcard include/config/0/auto/cal/start/sw/default/mask.h) \
    $(wildcard include/config/shift.h) \
    $(wildcard include/config/field.h) \
    $(wildcard include/config/range.h) \
    $(wildcard include/config/woffset.h) \
    $(wildcard include/config/default.h) \
    $(wildcard include/config/default/mask.h) \
    $(wildcard include/config/sw/default.h) \
    $(wildcard include/config/sw/default/mask.h) \
    $(wildcard include/config/init/enum.h) \
    $(wildcard include/config/lpddr2.h) \
    $(wildcard include/config/lpddr/pop.h) \
    $(wildcard include/config/reserved.h) \
  arch/arm/mach-tegra/include/ap20/arahb_arbc.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_hwintf.h \
  arch/arm/mach-tegra/include/nvcommon.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_module_private.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_relocation_table.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_moduleids.h \
  arch/arm/mach-tegra/include/nvrm_hardware_access.h \
  arch/arm/mach-tegra/include/nvos.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_structure.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_chipid.h \
  arch/arm/mach-tegra/include/nvrm_interrupt.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_memmgr.h \
  arch/arm/mach-tegra/include/nvrm_pinmux.h \
  arch/arm/mach-tegra/include/nvodm_modules.h \
  arch/arm/mach-tegra/include/nvrm_rmctrace.h \
  arch/arm/mach-tegra/nvrm/core/common/nvrm_configuration.h \
  arch/arm/mach-tegra/include/nverror.h \

arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.o: $(deps_arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.o)

$(deps_arch/arm/mach-tegra/nvrm/core/ap20/ap20rm_memctrl.o):
