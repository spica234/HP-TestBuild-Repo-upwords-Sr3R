cmd_arch/arm/mach-tegra/nvddk/nvddk_nand.o := arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-tegra/nvddk/.nvddk_nand.o.d  -nostdinc -isystem /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include -Iinclude  -I/home/hp1/kernellast/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Wall -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1 -lrt -marm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -mcpu=cortex-a8 -msoft-float -Uarm -mfloat-abi=soft -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack -DNV_IS_AVP=0 -DNV_OAL=0 -DNV_USE_FUSE_CLOCK_ENABLE=0 -DNV_DEBUG=0  -O3 -fgcse-sm -floop-optimize -falign-loops -falign-labels -falign-functions -falign-jumps -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=soft -DPERFORMANCE_RUN=1  -lrt -DCONFIG_MACH_STAR_TMUS_E -DSTAR_COUNTRY_ -DSTAR_OPERATOR_ -DCONFIG_MODEM_IFX -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(nvddk_nand)"  -D"KBUILD_MODNAME=KBUILD_STR(nvddk_nand)"  -c -o arch/arm/mach-tegra/nvddk/.tmp_nvddk_nand.o arch/arm/mach-tegra/nvddk/nvddk_nand.c

deps_arch/arm/mach-tegra/nvddk/nvddk_nand.o := \
  arch/arm/mach-tegra/nvddk/nvddk_nand.c \
  arch/arm/mach-tegra/include/nvddk_nand.h \
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
  arch/arm/mach-tegra/include/nvos.h \
  /usr/bin/../lib/gcc/arm-linux-gnueabi/4.7.1/include/stdarg.h \
  arch/arm/mach-tegra/include/nverror.h \
  arch/arm/mach-tegra/include/nverrval.h \
  arch/arm/mach-tegra/include/nvos_trace.h \
  arch/arm/mach-tegra/include/nvrm_init.h \
  arch/arm/mach-tegra/include/nvodm_query_nand.h \
  arch/arm/mach-tegra/include/nvodm_modules.h \
  arch/arm/mach-tegra/include/nvodm_query_nand.h \
  arch/arm/mach-tegra/include/ap20/arnandflash.h \
    $(wildcard include/config/0.h) \
    $(wildcard include/config/0/secure.h) \
    $(wildcard include/config/0/word/count.h) \
    $(wildcard include/config/0/reset/val.h) \
    $(wildcard include/config/0/reset/mask.h) \
    $(wildcard include/config/0/sw/default/val.h) \
    $(wildcard include/config/0/sw/default/mask.h) \
    $(wildcard include/config/0/read/mask.h) \
    $(wildcard include/config/0/write/mask.h) \
    $(wildcard include/config/0/hw/ecc/shift.h) \
    $(wildcard include/config/0/hw/ecc/field.h) \
    $(wildcard include/config/0/hw/ecc/range.h) \
    $(wildcard include/config/0/hw/ecc/woffset.h) \
    $(wildcard include/config/0/hw/ecc/default.h) \
    $(wildcard include/config/0/hw/ecc/default/mask.h) \
    $(wildcard include/config/0/hw/ecc/sw/default.h) \
    $(wildcard include/config/0/hw/ecc/sw/default/mask.h) \
    $(wildcard include/config/0/hw/ecc/disable.h) \
    $(wildcard include/config/0/hw/ecc/enable.h) \
    $(wildcard include/config/0/ecc/sel/shift.h) \
    $(wildcard include/config/0/ecc/sel/field.h) \
    $(wildcard include/config/0/ecc/sel/range.h) \
    $(wildcard include/config/0/ecc/sel/woffset.h) \
    $(wildcard include/config/0/ecc/sel/default.h) \
    $(wildcard include/config/0/ecc/sel/default/mask.h) \
    $(wildcard include/config/0/ecc/sel/sw/default.h) \
    $(wildcard include/config/0/ecc/sel/sw/default/mask.h) \
    $(wildcard include/config/0/ecc/sel/hamming.h) \
    $(wildcard include/config/0/ecc/sel/rs.h) \
    $(wildcard include/config/0/hw/err/correction/shift.h) \
    $(wildcard include/config/0/hw/err/correction/field.h) \
    $(wildcard include/config/0/hw/err/correction/range.h) \
    $(wildcard include/config/0/hw/err/correction/woffset.h) \
    $(wildcard include/config/0/hw/err/correction/default.h) \
    $(wildcard include/config/0/hw/err/correction/default/mask.h) \
    $(wildcard include/config/0/hw/err/correction/sw/default.h) \
    $(wildcard include/config/0/hw/err/correction/sw/default/mask.h) \
    $(wildcard include/config/0/hw/err/correction/disable.h) \
    $(wildcard include/config/0/hw/err/correction/enable.h) \
    $(wildcard include/config/0/pipeline/en/shift.h) \
    $(wildcard include/config/0/pipeline/en/field.h) \
    $(wildcard include/config/0/pipeline/en/range.h) \
    $(wildcard include/config/0/pipeline/en/woffset.h) \
    $(wildcard include/config/0/pipeline/en/default.h) \
    $(wildcard include/config/0/pipeline/en/default/mask.h) \
    $(wildcard include/config/0/pipeline/en/sw/default.h) \
    $(wildcard include/config/0/pipeline/en/sw/default/mask.h) \
    $(wildcard include/config/0/pipeline/en/disable.h) \
    $(wildcard include/config/0/pipeline/en/enable.h) \
    $(wildcard include/config/0/ecc/en/tag/shift.h) \
    $(wildcard include/config/0/ecc/en/tag/field.h) \
    $(wildcard include/config/0/ecc/en/tag/range.h) \
    $(wildcard include/config/0/ecc/en/tag/woffset.h) \
    $(wildcard include/config/0/ecc/en/tag/default.h) \
    $(wildcard include/config/0/ecc/en/tag/default/mask.h) \
    $(wildcard include/config/0/ecc/en/tag/sw/default.h) \
    $(wildcard include/config/0/ecc/en/tag/sw/default/mask.h) \
    $(wildcard include/config/0/ecc/en/tag/disable.h) \
    $(wildcard include/config/0/ecc/en/tag/enable.h) \
    $(wildcard include/config/0/tvalue/shift.h) \
    $(wildcard include/config/0/tvalue/field.h) \
    $(wildcard include/config/0/tvalue/range.h) \
    $(wildcard include/config/0/tvalue/woffset.h) \
    $(wildcard include/config/0/tvalue/default.h) \
    $(wildcard include/config/0/tvalue/default/mask.h) \
    $(wildcard include/config/0/tvalue/sw/default.h) \
    $(wildcard include/config/0/tvalue/sw/default/mask.h) \
    $(wildcard include/config/0/tvalue/tval4.h) \
    $(wildcard include/config/0/tvalue/tval6.h) \
    $(wildcard include/config/0/tvalue/tval8.h) \
    $(wildcard include/config/0/tvalue/tval/rsvd.h) \
    $(wildcard include/config/0/skip/spare/shift.h) \
    $(wildcard include/config/0/skip/spare/field.h) \
    $(wildcard include/config/0/skip/spare/range.h) \
    $(wildcard include/config/0/skip/spare/woffset.h) \
    $(wildcard include/config/0/skip/spare/default.h) \
    $(wildcard include/config/0/skip/spare/default/mask.h) \
    $(wildcard include/config/0/skip/spare/sw/default.h) \
    $(wildcard include/config/0/skip/spare/sw/default/mask.h) \
    $(wildcard include/config/0/skip/spare/disable.h) \
    $(wildcard include/config/0/skip/spare/enable.h) \
    $(wildcard include/config/0/com/bsy/shift.h) \
    $(wildcard include/config/0/com/bsy/field.h) \
    $(wildcard include/config/0/com/bsy/range.h) \
    $(wildcard include/config/0/com/bsy/woffset.h) \
    $(wildcard include/config/0/com/bsy/default.h) \
    $(wildcard include/config/0/com/bsy/default/mask.h) \
    $(wildcard include/config/0/com/bsy/sw/default.h) \
    $(wildcard include/config/0/com/bsy/sw/default/mask.h) \
    $(wildcard include/config/0/com/bsy/disable.h) \
    $(wildcard include/config/0/com/bsy/enable.h) \
    $(wildcard include/config/0/bus/width/shift.h) \
    $(wildcard include/config/0/bus/width/field.h) \
    $(wildcard include/config/0/bus/width/range.h) \
    $(wildcard include/config/0/bus/width/woffset.h) \
    $(wildcard include/config/0/bus/width/default.h) \
    $(wildcard include/config/0/bus/width/default/mask.h) \
    $(wildcard include/config/0/bus/width/sw/default.h) \
    $(wildcard include/config/0/bus/width/sw/default/mask.h) \
    $(wildcard include/config/0/bus/width/bus/width/8.h) \
    $(wildcard include/config/0/bus/width/bus/width/16.h) \
    $(wildcard include/config/0/lpddr1/mode/shift.h) \
    $(wildcard include/config/0/lpddr1/mode/field.h) \
    $(wildcard include/config/0/lpddr1/mode/range.h) \
    $(wildcard include/config/0/lpddr1/mode/woffset.h) \
    $(wildcard include/config/0/lpddr1/mode/default.h) \
    $(wildcard include/config/0/lpddr1/mode/default/mask.h) \
    $(wildcard include/config/0/lpddr1/mode/sw/default.h) \
    $(wildcard include/config/0/lpddr1/mode/sw/default/mask.h) \
    $(wildcard include/config/0/lpddr1/mode/disable.h) \
    $(wildcard include/config/0/lpddr1/mode/enable.h) \
    $(wildcard include/config/0/edo/mode/shift.h) \
    $(wildcard include/config/0/edo/mode/field.h) \
    $(wildcard include/config/0/edo/mode/range.h) \
    $(wildcard include/config/0/edo/mode/woffset.h) \
    $(wildcard include/config/0/edo/mode/default.h) \
    $(wildcard include/config/0/edo/mode/default/mask.h) \
    $(wildcard include/config/0/edo/mode/sw/default.h) \
    $(wildcard include/config/0/edo/mode/sw/default/mask.h) \
    $(wildcard include/config/0/edo/mode/disable.h) \
    $(wildcard include/config/0/edo/mode/enable.h) \
    $(wildcard include/config/0/page/size/sel/shift.h) \
    $(wildcard include/config/0/page/size/sel/field.h) \
    $(wildcard include/config/0/page/size/sel/range.h) \
    $(wildcard include/config/0/page/size/sel/woffset.h) \
    $(wildcard include/config/0/page/size/sel/default.h) \
    $(wildcard include/config/0/page/size/sel/default/mask.h) \
    $(wildcard include/config/0/page/size/sel/sw/default.h) \
    $(wildcard include/config/0/page/size/sel/sw/default/mask.h) \
    $(wildcard include/config/0/page/size/sel/page/size/256.h) \
    $(wildcard include/config/0/page/size/sel/page/size/512.h) \
    $(wildcard include/config/0/page/size/sel/page/size/1024.h) \
    $(wildcard include/config/0/page/size/sel/page/size/2048.h) \
    $(wildcard include/config/0/page/size/sel/page/size/4096.h) \
    $(wildcard include/config/0/page/size/sel/page/size/rsvd1.h) \
    $(wildcard include/config/0/page/size/sel/page/size/rsvd2.h) \
    $(wildcard include/config/0/page/size/sel/page/size/rsvd3.h) \
    $(wildcard include/config/0/skip/spare/sel/shift.h) \
    $(wildcard include/config/0/skip/spare/sel/field.h) \
    $(wildcard include/config/0/skip/spare/sel/range.h) \
    $(wildcard include/config/0/skip/spare/sel/woffset.h) \
    $(wildcard include/config/0/skip/spare/sel/default.h) \
    $(wildcard include/config/0/skip/spare/sel/default/mask.h) \
    $(wildcard include/config/0/skip/spare/sel/sw/default.h) \
    $(wildcard include/config/0/skip/spare/sel/sw/default/mask.h) \
    $(wildcard include/config/0/skip/spare/sel/skip/spare/size/4.h) \
    $(wildcard include/config/0/skip/spare/sel/skip/spare/size/8.h) \
    $(wildcard include/config/0/skip/spare/sel/skip/spare/size/12.h) \
    $(wildcard include/config/0/skip/spare/sel/skip/spare/size/16.h) \
    $(wildcard include/config/0/debug/mode/shift.h) \
    $(wildcard include/config/0/debug/mode/field.h) \
    $(wildcard include/config/0/debug/mode/range.h) \
    $(wildcard include/config/0/debug/mode/woffset.h) \
    $(wildcard include/config/0/debug/mode/default.h) \
    $(wildcard include/config/0/debug/mode/default/mask.h) \
    $(wildcard include/config/0/debug/mode/sw/default.h) \
    $(wildcard include/config/0/debug/mode/sw/default/mask.h) \
    $(wildcard include/config/0/debug/sel/shift.h) \
    $(wildcard include/config/0/debug/sel/field.h) \
    $(wildcard include/config/0/debug/sel/range.h) \
    $(wildcard include/config/0/debug/sel/woffset.h) \
    $(wildcard include/config/0/debug/sel/default.h) \
    $(wildcard include/config/0/debug/sel/default/mask.h) \
    $(wildcard include/config/0/debug/sel/sw/default.h) \
    $(wildcard include/config/0/debug/sel/sw/default/mask.h) \
    $(wildcard include/config/0/tag/byte/size/shift.h) \
    $(wildcard include/config/0/tag/byte/size/field.h) \
    $(wildcard include/config/0/tag/byte/size/range.h) \
    $(wildcard include/config/0/tag/byte/size/woffset.h) \
    $(wildcard include/config/0/tag/byte/size/default.h) \
    $(wildcard include/config/0/tag/byte/size/default/mask.h) \
    $(wildcard include/config/0/tag/byte/size/sw/default.h) \
    $(wildcard include/config/0/tag/byte/size/sw/default/mask.h) \
    $(wildcard include/config/0/ll/start/shift.h) \
    $(wildcard include/config/0/ll/start/field.h) \
    $(wildcard include/config/0/ll/start/range.h) \
    $(wildcard include/config/0/ll/start/woffset.h) \
    $(wildcard include/config/0/ll/start/default.h) \
    $(wildcard include/config/0/ll/start/default/mask.h) \
    $(wildcard include/config/0/ll/start/sw/default.h) \
    $(wildcard include/config/0/ll/start/sw/default/mask.h) \
    $(wildcard include/config/0/ll/start/disable.h) \
    $(wildcard include/config/0/ll/start/enable.h) \
    $(wildcard include/config/0/word/cnt/status/en/shift.h) \
    $(wildcard include/config/0/word/cnt/status/en/field.h) \
    $(wildcard include/config/0/word/cnt/status/en/range.h) \
    $(wildcard include/config/0/word/cnt/status/en/woffset.h) \
    $(wildcard include/config/0/word/cnt/status/en/default.h) \
    $(wildcard include/config/0/word/cnt/status/en/default/mask.h) \
    $(wildcard include/config/0/word/cnt/status/en/sw/default.h) \
    $(wildcard include/config/0/word/cnt/status/en/sw/default/mask.h) \
    $(wildcard include/config/0/word/cnt/status/en/disable.h) \
    $(wildcard include/config/0/word/cnt/status/en/enable.h) \
    $(wildcard include/config/0/burst/size/shift.h) \
    $(wildcard include/config/0/burst/size/field.h) \
    $(wildcard include/config/0/burst/size/range.h) \
    $(wildcard include/config/0/burst/size/woffset.h) \
    $(wildcard include/config/0/burst/size/default.h) \
    $(wildcard include/config/0/burst/size/default/mask.h) \
    $(wildcard include/config/0/burst/size/sw/default.h) \
    $(wildcard include/config/0/burst/size/sw/default/mask.h) \
    $(wildcard include/config/0/burst/size/burst/rsvd1.h) \
    $(wildcard include/config/0/burst/size/burst/rsvd2.h) \
    $(wildcard include/config/0/burst/size/burst/1words.h) \
    $(wildcard include/config/0/burst/size/burst/4words.h) \
    $(wildcard include/config/0/burst/size/burst/8words.h) \
    $(wildcard include/config/0/burst/size/burst/16words.h) \
    $(wildcard include/config/0/burst/size/burst/rsvd3.h) \
    $(wildcard include/config/0/burst/size/burst/rsvd4.h) \
    $(wildcard include/config/0/ll/length/shift.h) \
    $(wildcard include/config/0/ll/length/field.h) \
    $(wildcard include/config/0/ll/length/range.h) \
    $(wildcard include/config/0/ll/length/woffset.h) \
    $(wildcard include/config/0/ll/length/default.h) \
    $(wildcard include/config/0/ll/length/default/mask.h) \
    $(wildcard include/config/0/ll/length/sw/default.h) \
    $(wildcard include/config/0/ll/length/sw/default/mask.h) \
    $(wildcard include/config/0/bch/tvalue/shift.h) \
    $(wildcard include/config/0/bch/tvalue/field.h) \
    $(wildcard include/config/0/bch/tvalue/range.h) \
    $(wildcard include/config/0/bch/tvalue/woffset.h) \
    $(wildcard include/config/0/bch/tvalue/default.h) \
    $(wildcard include/config/0/bch/tvalue/default/mask.h) \
    $(wildcard include/config/0/bch/tvalue/sw/default.h) \
    $(wildcard include/config/0/bch/tvalue/sw/default/mask.h) \
    $(wildcard include/config/0/bch/tvalue/bch/tval4.h) \
    $(wildcard include/config/0/bch/tvalue/bch/tval8.h) \
    $(wildcard include/config/0/bch/tvalue/bch/tval14.h) \
    $(wildcard include/config/0/bch/tvalue/bch/tval16.h) \
    $(wildcard include/config/0/bch/ecc/shift.h) \
    $(wildcard include/config/0/bch/ecc/field.h) \
    $(wildcard include/config/0/bch/ecc/range.h) \
    $(wildcard include/config/0/bch/ecc/woffset.h) \
    $(wildcard include/config/0/bch/ecc/default.h) \
    $(wildcard include/config/0/bch/ecc/default/mask.h) \
    $(wildcard include/config/0/bch/ecc/sw/default.h) \
    $(wildcard include/config/0/bch/ecc/sw/default/mask.h) \
    $(wildcard include/config/0/bch/ecc/disable.h) \
    $(wildcard include/config/0/bch/ecc/enable.h) \
    $(wildcard include/config/shift.h) \
    $(wildcard include/config/field.h) \
    $(wildcard include/config/range.h) \
    $(wildcard include/config/row.h) \
    $(wildcard include/config/disable.h) \
    $(wildcard include/config/enable.h) \
  arch/arm/mach-tegra/include/nvrm_hardware_access.h \
  arch/arm/mach-tegra/include/nvrm_power.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/include/nvrm_module.h \
  arch/arm/mach-tegra/include/nvrm_gpio.h \
  arch/arm/mach-tegra/include/nvrm_drf.h \
  arch/arm/mach-tegra/include/nvassert.h \
  arch/arm/mach-tegra/include/nvrm_memmgr.h \
  arch/arm/mach-tegra/include/nvrm_interrupt.h \
  arch/arm/mach-tegra/include/nvrm_pinmux.h \
  arch/arm/mach-tegra/include/nvodm_query_pinmux.h \
  arch/arm/mach-tegra/include/nvodm_query_gpio.h \
  arch/arm/mach-tegra/include/nvodm_query_discovery.h \
  arch/arm/mach-tegra/include/nvodm_services.h \
    $(wildcard include/config/mach/star.h) \
  arch/arm/mach-tegra/include/nvassert.h \
  arch/arm/mach-tegra/include/nvcolor.h \
  arch/arm/mach-tegra/include/nvodm_query_pinmux.h \
  arch/arm/mach-tegra/include/nvodm_query.h \
  arch/arm/mach-tegra/include/nvrm_pmu.h \

arch/arm/mach-tegra/nvddk/nvddk_nand.o: $(deps_arch/arm/mach-tegra/nvddk/nvddk_nand.o)

$(deps_arch/arm/mach-tegra/nvddk/nvddk_nand.o):
