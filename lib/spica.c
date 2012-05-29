
#include <linux/spica.h>

#define PROC_DIR "spica"

unsigned int NVRM_CPU1_ON_MIN_KHZ = 500000; //Default value should be changed here
//#define NVRM_CPU1_ON_MIN_KHZ (MIN_CPU_ON * 1000);
unsigned int fsync = 0;
unsigned int NVRM_CPU1_OFF_MAX_KHZ = 700000;
unsigned int realmaxfreq1 = 1000000;
unsigned int maxfq = 1000000;
unsigned int VDEFREQ = 690000;
unsigned int GPUFREQ = 340000;
unsigned int PWONOFF = 0;
unsigned int NITROONOFF = 0;
unsigned int NVRM_AP20_LOW_CORE_MV = 910;

unsigned int NVRM_AP20_LOW_CPU_MV = 770;
unsigned int VIBEONOFF = 0;
unsigned int BLONOFF = 0;

//#define NVRM_AP20_LOW_CPU_MV (770)
//#endif
//unsigned int VM_MAX_READAHEAD = 512;
//unsigned int swappiness = 10;
//unsigned int vm_swappiness = 10;
//unsigned int CARVEOUT_SIZE = 128;
unsigned int SCREENOFFFREQ = 503000;
unsigned int NVRM_CPU1_OFF_PENDING_MS = 1000;

//unsigned int STAR_RAM_CONSOLE_BASE;
//unsigned int STAR_RAM_CONSOLE_SIZE;
//void occheck();
//unsigned int USE_VALUE;
//unsigned int RAM_CONSOLE_RESERVED_SIZE = 1;
//void occheck() {
//if ( CARVEOUT_SIZE == 96 ) {
//unsigned int STAR_RAM_CONSOLE_BASE = 415*(0x00100000);
//}
//else {
//unsigned int STAR_RAM_CONSOLE_BASE = 383*(0x00100000);
//}
//}

//const unsigned int STAR_RAM_CONSOLE_BASE = size1;
const unsigned int NVRM_AP20_SUSPEND_CORE_MV=1000;
unsigned int NVRM_AP20_DDR2_MIN_KHZ = 50000;
unsigned int NVRM_AP20_LPDDR2_MIN_KHZ = 18000;


//unsigned int EMCVOLTAGE = 1200;

static struct proc_dir_entry *spica_dir = NULL;



void spica_init(void) {
spica_dir = proc_mkdir(PROC_DIR, NULL);
}



struct proc_dir_entry* spica_add(const char* name) {
if ( spica_dir == NULL ) spica_init();
return create_proc_entry(name, 0777, spica_dir);
}



void spica_remove(const char* name) {
remove_proc_entry(name, spica_dir);
}

