/*
 *  linux/drivers/cpufreq/cpufreq.c
 *
 *  Copyright (C) 2001 Russell King
 *            (C) 2002 - 2003 Dominik Brodowski <linux@brodo.de>
 *
 *  Oct 2005 - Ashok Raj <ashok.raj@intel.com>
 *	Added handling for CPU hotplug
 *  Feb 2006 - Jacob Shin <jacob.shin@amd.com>
 *	Fix handling for CPU hotplug -- affected CPUs
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/notifier.h>
#include <linux/cpufreq.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/spinlock.h>
#include <linux/device.h>
#include <linux/slab.h>
#include <linux/cpu.h>
#include <linux/completion.h>
#include <linux/mutex.h>
#include <linux/earlysuspend.h>
#include <linux/sched.h>
#include <linux/spica.h>


#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, \
						"cpufreq-core", msg)
//unsigned long int USE_FG;


//extern int OC();
//extern int OC();
#define USE_FAKE_SHMOO


#ifdef USE_FAKE_SHMOO

#include "../nvrm/core/common/nvrm_clocks_limits_private.h"
#include "../nvrm/core/common/nvrm_power_dfs.h"
#include <nvrm_diag.h>

/* 
 * TEGRA AP20 CPU OC/UV Hack by Cpasjuste @ https://github.com/Cpasjuste/tegra_lg_p990_kernel_oc_uv
 * Inspired by mblaster @ https://github.com/mblaster/linux_2.6.32_folio100
*/

int *FakeShmoo_UV_mV_Ptr; // Stored voltage table from cpufreq sysfs
extern NvRmCpuShmoo fake_CpuShmoo;  // Stored faked CpuShmoo values
extern NvRmDfs *fakeShmoo_Dfs;

#endif // USE_FAKE_SHMOO
//#include "ap20rm_power_dfs.h"
#define MAXSPW_PROCFS_NAME   "screenoff_maxcpufreq"
#define MAXSPW_PROCFS_SIZE     7
static struct proc_dir_entry *MAXSOC_Proc_File;
static char procfs_buffer_sm[MAXSPW_PROCFS_SIZE];
static unsigned long procfs_buffer_size_sm = 0;

int maxsoc_procfile_read(char *buffer, char **buffer_location, off_t offset, int buffer_length, int *eof, void *data) { 
int ret;
printk(KERN_INFO "procfile_read (/proc/spica/%s) called\n", MAXSPW_PROCFS_NAME);
if (offset > 0) {
ret  = 0;
} else {
memcpy(buffer, procfs_buffer_sm, procfs_buffer_size_sm);
ret = procfs_buffer_size_sm;

}
return ret;
}

int maxsoc_procfile_write(struct file *file, const char *buffer, unsigned long count, void *data) {
int temp_mx;
temp_mx=0;
if ( sscanf(buffer,"%d",&temp_mx) < 1 ) return procfs_buffer_size_sm;
if ( temp_mx < 216000 || temp_mx > 816000 ) return procfs_buffer_size_sm;
//if ( temp6 != 16 || temp6 != 32 || temp6 != 64 || temp6 != 96 || 128 ) return procfs_buffer_size_sm;

procfs_buffer_size_sm = count;
	if (procfs_buffer_size_sm > MAXSPW_PROCFS_SIZE ) {
		procfs_buffer_size_sm = MAXSPW_PROCFS_SIZE;
	}
if ( copy_from_user(procfs_buffer_sm, buffer, procfs_buffer_size_sm) ) {
printk(KERN_INFO "buffer_size error\n");
return -EFAULT;
}
sscanf(procfs_buffer_sm,"%u",&SCREENOFFFREQ);
//if ( SDRAMFREQ < 216000 || SDRAMFREQ > 1100000 ) {
return procfs_buffer_size_sm;
}


static int __init init_maxsoc_procsfs(void)
{
//int rv = 0;
MAXSOC_Proc_File = spica_add(MAXSPW_PROCFS_NAME);
//spica_dir = proc_mkdir("spica", NULL); 

//MAXSOC_Proc_File = create_proc_entry(MAXSPW_PROCFS_NAME, 0755, spica_dir);
if (MAXSOC_Proc_File == NULL) {
spica_remove(MAXSPW_PROCFS_NAME);
printk(KERN_ALERT "Error: Could not initialize /proc/spica/%s\n", MAXSPW_PROCFS_NAME);
return -ENOMEM;
} else {
MAXSOC_Proc_File->read_proc  = maxsoc_procfile_read;
MAXSOC_Proc_File->write_proc = maxsoc_procfile_write;
//MAXSOC_Proc_File->owner     = THIS_MODULE;
MAXSOC_Proc_File->mode     = S_IFREG | S_IRUGO;
MAXSOC_Proc_File->uid     = 0;
MAXSOC_Proc_File->gid     = 0;
MAXSOC_Proc_File->size     = 37;
sprintf(procfs_buffer_sm,"%d",SCREENOFFFREQ);
procfs_buffer_size_sm=strlen(procfs_buffer_sm);
printk(KERN_INFO "/proc/spica/%s created\n", MAXSPW_PROCFS_NAME);
//return 0;
}
return 0;
}
module_init(init_maxsoc_procsfs);

static void __exit cleanup_maxsoc_procsfs(void) {
//printk(KERN_INFO "/proc/spica/%s removed\n", MAXSPW_PROCFS_NAME);
spica_remove(MAXSPW_PROCFS_NAME);
printk(KERN_INFO "/proc/spica/%s removed\n", MAXSPW_PROCFS_NAME);
}
module_exit(cleanup_maxsoc_procsfs);
/**
 * The "cpufreq driver" - the arch- or hardware-dependent low
 * level driver of CPUFreq support, and its spinlock. This lock
 * also protects the cpufreq_cpu_data array.
 */
static struct cpufreq_driver *cpufreq_driver;
static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);

#ifdef CONFIG_HOTPLUG_CPU
/* This one keeps track of the previously set governor of a removed CPU */
static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
#endif
static DEFINE_SPINLOCK(cpufreq_driver_lock);

/*
 * cpu_policy_rwsem is a per CPU reader-writer semaphore designed to cure
 * all cpufreq/hotplug/workqueue/etc related lock issues.
 *
 * The rules for this semaphore:
 * - Any routine that wants to read from the policy structure will
 *   do a down_read on this semaphore.
 * - Any routine that will write to the policy structure and/or may take away
 *   the policy altogether (eg. CPU hotplug), will hold this lock in write
 *   mode before doing so.
 *
 * Additional rules:
 * - All holders of the lock should check to make sure that the CPU they
 *   are concerned with are online after they get the lock.
 * - Governor routines that can be called in cpufreq hotplug path should not
 *   take this sem as top level hotplug notifier handler takes this.
 * - Lock should not be held across
 *     __cpufreq_governor(data, CPUFREQ_GOV_STOP);
 */
static DEFINE_PER_CPU(int, policy_cpu);
static DEFINE_PER_CPU(struct rw_semaphore, cpu_policy_rwsem);


#define lock_policy_rwsem(mode, cpu)					\
int lock_policy_rwsem_##mode						\
(int cpu)								\
{									\
	int policy_cpu = per_cpu(policy_cpu, cpu);			\
	BUG_ON(policy_cpu == -1);					\
	down_##mode(&per_cpu(cpu_policy_rwsem, policy_cpu));		\
	if (unlikely(!cpu_online(cpu))) {				\
		up_##mode(&per_cpu(cpu_policy_rwsem, policy_cpu));	\
		return -1;						\
	}								\
									\
	return 0;							\
}

lock_policy_rwsem(read, cpu);
EXPORT_SYMBOL_GPL(lock_policy_rwsem_read);

lock_policy_rwsem(write, cpu);
EXPORT_SYMBOL_GPL(lock_policy_rwsem_write);

void unlock_policy_rwsem_read(int cpu)
{
	int policy_cpu = per_cpu(policy_cpu, cpu);
	BUG_ON(policy_cpu == -1);
	up_read(&per_cpu(cpu_policy_rwsem, policy_cpu));
}
EXPORT_SYMBOL_GPL(unlock_policy_rwsem_read);

void unlock_policy_rwsem_write(int cpu)
{
	int policy_cpu = per_cpu(policy_cpu, cpu);
	BUG_ON(policy_cpu == -1);
	up_write(&per_cpu(cpu_policy_rwsem, policy_cpu));
}
EXPORT_SYMBOL_GPL(unlock_policy_rwsem_write);


/* internal prototypes */
static int __cpufreq_governor(struct cpufreq_policy *policy,
		unsigned int event);
static unsigned int __cpufreq_get(unsigned int cpu);
static void handle_update(struct work_struct *work);

/**
 * Two notifier lists: the "policy" list is involved in the
 * validation process for a new CPU frequency policy; the
 * "transition" list for kernel code that needs to handle
 * changes to devices when the CPU clock speed changes.
 * The mutex locks both lists.
 */
static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
static struct srcu_notifier_head cpufreq_transition_notifier_list;

static bool init_cpufreq_transition_notifier_list_called;
static int __init init_cpufreq_transition_notifier_list(void)
{
	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
	init_cpufreq_transition_notifier_list_called = true;
	return 0;
}
pure_initcall(init_cpufreq_transition_notifier_list);

static LIST_HEAD(cpufreq_governor_list);
static DEFINE_MUTEX(cpufreq_governor_mutex);

struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
{
	struct cpufreq_policy *data;
	unsigned long flags;

	if (cpu >= nr_cpu_ids)
		goto err_out;

	/* get the cpufreq driver */
	spin_lock_irqsave(&cpufreq_driver_lock, flags);

	if (!cpufreq_driver)
		goto err_out_unlock;

	if (!try_module_get(cpufreq_driver->owner))
		goto err_out_unlock;


	/* get the CPU */
	data = per_cpu(cpufreq_cpu_data, cpu);

	if (!data)
		goto err_out_put_module;

	if (!kobject_get(&data->kobj))
		goto err_out_put_module;

	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
	return data;

err_out_put_module:
	module_put(cpufreq_driver->owner);
err_out_unlock:
	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
err_out:
	return NULL;
}
EXPORT_SYMBOL_GPL(cpufreq_cpu_get);


void cpufreq_cpu_put(struct cpufreq_policy *data)
{
	kobject_put(&data->kobj);
	module_put(cpufreq_driver->owner);
}
EXPORT_SYMBOL_GPL(cpufreq_cpu_put);


/*********************************************************************
 *                     UNIFIED DEBUG HELPERS                         *
 *********************************************************************/
#ifdef CONFIG_CPU_FREQ_DEBUG

/* what part(s) of the CPUfreq subsystem are debugged? */
static unsigned int debug;

/* is the debug output ratelimit'ed using printk_ratelimit? User can
 * set or modify this value.
 */
static unsigned int debug_ratelimit = 1;

/* is the printk_ratelimit'ing enabled? It's enabled after a successful
 * loading of a cpufreq driver, temporarily disabled when a new policy
 * is set, and disabled upon cpufreq driver removal
 */
static unsigned int disable_ratelimit = 1;
static DEFINE_SPINLOCK(disable_ratelimit_lock);

static void cpufreq_debug_enable_ratelimit(void)
{
	unsigned long flags;

	spin_lock_irqsave(&disable_ratelimit_lock, flags);
	if (disable_ratelimit)
		disable_ratelimit--;
	spin_unlock_irqrestore(&disable_ratelimit_lock, flags);
}

static void cpufreq_debug_disable_ratelimit(void)
{
	unsigned long flags;

	spin_lock_irqsave(&disable_ratelimit_lock, flags);
	disable_ratelimit++;
	spin_unlock_irqrestore(&disable_ratelimit_lock, flags);
}

void cpufreq_debug_printk(unsigned int type, const char *prefix,
			const char *fmt, ...)
{
	char s[256];
	va_list args;
	unsigned int len;
	unsigned long flags;

	WARN_ON(!prefix);
	if (type & debug) {
		spin_lock_irqsave(&disable_ratelimit_lock, flags);
		if (!disable_ratelimit && debug_ratelimit
					&& !printk_ratelimit()) {
			spin_unlock_irqrestore(&disable_ratelimit_lock, flags);
			return;
		}
		spin_unlock_irqrestore(&disable_ratelimit_lock, flags);

		len = snprintf(s, 256, KERN_DEBUG "%s: ", prefix);

		va_start(args, fmt);
		len += vsnprintf(&s[len], (256 - len), fmt, args);
		va_end(args);

		printk(s);

		WARN_ON(len < 5);
	}
}
EXPORT_SYMBOL(cpufreq_debug_printk);


module_param(debug, uint, 0644);
MODULE_PARM_DESC(debug, "CPUfreq debugging: add 1 to debug core,"
			" 2 to debug drivers, and 4 to debug governors.");

module_param(debug_ratelimit, uint, 0644);
MODULE_PARM_DESC(debug_ratelimit, "CPUfreq debugging:"
					" set to 0 to disable ratelimiting.");

#else /* !CONFIG_CPU_FREQ_DEBUG */

static inline void cpufreq_debug_enable_ratelimit(void) { return; }
static inline void cpufreq_debug_disable_ratelimit(void) { return; }

#endif /* CONFIG_CPU_FREQ_DEBUG */


/*********************************************************************
 *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
 *********************************************************************/

/**
 * adjust_jiffies - adjust the system "loops_per_jiffy"
 *
 * This function alters the system "loops_per_jiffy" for the clock
 * speed change. Note that loops_per_jiffy cannot be updated on SMP
 * systems as each CPU might be scaled differently. So, use the arch
 * per-CPU loops_per_jiffy value wherever possible.
 */
#define CONFIG_SMP
#ifndef CONFIG_SMP
static unsigned long l_p_j_ref;
static unsigned int  l_p_j_ref_freq;

static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
{
	if (ci->flags & CPUFREQ_CONST_LOOPS)
		return;

	if (!l_p_j_ref_freq) {
		l_p_j_ref = loops_per_jiffy;
		l_p_j_ref_freq = ci->old;
		dprintk("saving %lu as reference value for loops_per_jiffy; "
			"freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
	}
	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new) ||
	    (val == CPUFREQ_RESUMECHANGE || val == CPUFREQ_SUSPENDCHANGE)) {
		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq,
								ci->new);
		dprintk("scaling loops_per_jiffy to %lu "
			"for frequency %u kHz\n", loops_per_jiffy, ci->new);
	}
}
#else
static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
{
	return;
}
#endif


/**
 * cpufreq_notify_transition - call notifier chain and adjust_jiffies
 * on frequency transition.
 *
 * This function calls the transition notifiers and the "adjust_jiffies"
 * function. It is called twice on all CPU frequency changes that have
 * external effects.
 */
void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
{
	struct cpufreq_policy *policy;

	BUG_ON(irqs_disabled());

	freqs->flags = cpufreq_driver->flags;
	dprintk("notification %u of frequency transition to %u kHz\n",
		state, freqs->new);

	policy = per_cpu(cpufreq_cpu_data, freqs->cpu);
	switch (state) {

	case CPUFREQ_PRECHANGE:
		/* detect if the driver reported a value as "old frequency"
		 * which is not equal to what the cpufreq core thinks is
		 * "old frequency".
		 */
		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
			if ((policy) && (policy->cpu == freqs->cpu) &&
			    (policy->cur) && (policy->cur != freqs->old)) {
				dprintk("Warning: CPU frequency is"
					" %u, cpufreq assumed %u kHz.\n",
					freqs->old, policy->cur);
				freqs->old = policy->cur;
			}
		}
		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
				CPUFREQ_PRECHANGE, freqs);
		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
		break;

	case CPUFREQ_POSTCHANGE:
		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
				CPUFREQ_POSTCHANGE, freqs);
		if (likely(policy) && likely(policy->cpu == freqs->cpu))
			policy->cur = freqs->new;
		break;
	}
}
EXPORT_SYMBOL_GPL(cpufreq_notify_transition);



/*********************************************************************
 *                          SYSFS INTERFACE                          *
 *********************************************************************/

static struct cpufreq_governor *__find_governor(const char *str_governor)
{
	struct cpufreq_governor *t;

	list_for_each_entry(t, &cpufreq_governor_list, governor_list)
		if (!strnicmp(str_governor, t->name, CPUFREQ_NAME_LEN))
			return t;

	return NULL;
}

/**
 * cpufreq_parse_governor - parse a governor string
 */
static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
				struct cpufreq_governor **governor)
{
	int err = -EINVAL;

	if (!cpufreq_driver)
		goto out;

	if (cpufreq_driver->setpolicy) {
		if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
			*policy = CPUFREQ_POLICY_PERFORMANCE;
			err = 0;
		} else if (!strnicmp(str_governor, "powersave",
						CPUFREQ_NAME_LEN)) {
			*policy = CPUFREQ_POLICY_POWERSAVE;
			err = 0;
		}
	} else if (cpufreq_driver->target) {
		struct cpufreq_governor *t;

		mutex_lock(&cpufreq_governor_mutex);

		t = __find_governor(str_governor);

		if (t == NULL) {
			char *name = kasprintf(GFP_KERNEL, "cpufreq_%s",
								str_governor);

			if (name) {
				int ret;

				mutex_unlock(&cpufreq_governor_mutex);
				ret = request_module("%s", name);
				mutex_lock(&cpufreq_governor_mutex);

				if (ret == 0)
					t = __find_governor(str_governor);
			}

			kfree(name);
		}

		if (t != NULL) {
			*governor = t;
			err = 0;
		}

		mutex_unlock(&cpufreq_governor_mutex);
	}
out:
	return err;
}

/**
 * cpufreq_per_cpu_attr_read() / show_##file_name() -
 * print out cpufreq information
 *
 * Write out information from cpufreq_driver->policy[cpu]; object must be
 * "unsigned int".
 */

#define show_one(file_name, object)			\
static ssize_t show_##file_name				\
(struct cpufreq_policy *policy, char *buf)		\
{							\
	return sprintf(buf, "%u\n", policy->object);	\
}
extern unsigned int maxfq;
show_one(cpuinfo_min_freq, cpuinfo.min_freq);
show_one(cpuinfo_max_freq, cpuinfo.max_freq);
show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
show_one(scaling_min_freq, min);
show_one(scaling_max_freq, max);
show_one(maxfq, max);
show_one(scaling_cur_freq, cur);

static int __cpufreq_set_policy(struct cpufreq_policy *data,
				struct cpufreq_policy *policy);

/**
 * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
 */
#define store_one(file_name, object)			\
static ssize_t store_##file_name					\
(struct cpufreq_policy *policy, const char *buf, size_t count)		\
{									\
	unsigned int ret = -EINVAL;					\
	struct cpufreq_policy new_policy;				\
									\
	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
	if (ret)							\
		return -EINVAL;						\
									\
	ret = sscanf(buf, "%u", &new_policy.object);			\
	if (ret != 1)							\
		return -EINVAL;						\
									\
	ret = __cpufreq_set_policy(policy, &new_policy);		\
	policy->user_policy.object = policy->object;			\
									\
	return ret ? ret : count;					\
}
store_one(scaling_min_freq, min);
store_one(scaling_max_freq, max);
//store_one(realmaxfreq1, max);
/**
 * show_cpuinfo_cur_freq - current CPU frequency as detected by hardware
 */
static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
					char *buf)
{
	unsigned int cur_freq = __cpufreq_get(policy->cpu);
	if (!cur_freq)
		return sprintf(buf, "<unknown>");
	return sprintf(buf, "%u\n", cur_freq);
}


/**
 * show_scaling_governor - show the current policy for the specified CPU
 */
static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
{
	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
		return sprintf(buf, "powersave\n");
	else if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
		return sprintf(buf, "performance\n");
	else if (policy->governor)
		return scnprintf(buf, CPUFREQ_NAME_LEN, "%s\n",
				policy->governor->name);
	return -EINVAL;
}


/**
 * store_scaling_governor - store policy for the specified CPU
 */
static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	char	str_governor[16];
	struct cpufreq_policy new_policy;

	ret = cpufreq_get_policy(&new_policy, policy->cpu);
	if (ret)
		return ret;

	ret = sscanf(buf, "%15s", str_governor);
	if (ret != 1)
		return -EINVAL;

	if (cpufreq_parse_governor(str_governor, &new_policy.policy,
						&new_policy.governor))
		return -EINVAL;

	/* Do not use cpufreq_set_policy here or the user_policy.max
	   will be wrongly overridden */
	ret = __cpufreq_set_policy(policy, &new_policy);

	policy->user_policy.policy = policy->policy;
	policy->user_policy.governor = policy->governor;

	if (ret)
		return ret;
	else
		return count;
}

/**
 * show_scaling_driver - show the cpufreq driver currently loaded
 */
static ssize_t show_scaling_driver(struct cpufreq_policy *policy, char *buf)
{
	return scnprintf(buf, CPUFREQ_NAME_LEN, "%s\n", cpufreq_driver->name);
}

/**
 * show_scaling_available_governors - show the available CPUfreq governors
 */
static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
						char *buf)
{
	ssize_t i = 0;
	struct cpufreq_governor *t;

	if (!cpufreq_driver->target) {
		i += sprintf(buf, "performance powersave");
		goto out;
	}

	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
		    - (CPUFREQ_NAME_LEN + 2)))
			goto out;
		i += scnprintf(&buf[i], CPUFREQ_NAME_LEN, "%s ", t->name);
	}
out:
	i += sprintf(&buf[i], "\n");
	return i;
}

static ssize_t show_cpus(const struct cpumask *mask, char *buf)
{
	ssize_t i = 0;
	unsigned int cpu;

	for_each_cpu(cpu, mask) {
		if (i)
			i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
		if (i >= (PAGE_SIZE - 5))
			break;
	}
	i += sprintf(&buf[i], "\n");
	return i;
}

/**
 * show_related_cpus - show the CPUs affected by each transition even if
 * hw coordination is in use
 */
static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
{
	if (cpumask_empty(policy->related_cpus))
		return show_cpus(policy->cpus, buf);
	return show_cpus(policy->related_cpus, buf);
}

/**
 * show_affected_cpus - show the CPUs affected by each transition
 */
static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
{
	return show_cpus(policy->cpus, buf);
}

static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
					const char *buf, size_t count)
{
	unsigned int freq = 0;
	unsigned int ret;

	if (!policy->governor || !policy->governor->store_setspeed)
		return -EINVAL;

	ret = sscanf(buf, "%u", &freq);
	if (ret != 1)
		return -EINVAL;

	policy->governor->store_setspeed(policy, freq);

	return count;
}

static ssize_t show_scaling_setspeed(struct cpufreq_policy *policy, char *buf)
{
	if (!policy->governor || !policy->governor->show_setspeed)
		return sprintf(buf, "<unsupported>\n");

	return policy->governor->show_setspeed(policy, buf);
}

#ifdef USE_FAKE_SHMOO
static ssize_t show_cpu_temp(struct cpufreq_policy *policy, char *buf)
{
	int pTemp = 0;

	if( fakeShmoo_Dfs != NULL )
	{
		NvRmDtt* pDtt = &fakeShmoo_Dfs->ThermalThrottler;
		NvOdmTmonTemperatureGet(pDtt->hOdmTcore, &pTemp);
	}
	return sprintf(buf, "%i\n",  pTemp);
}

static ssize_t show_frequency_voltage_table(struct cpufreq_policy *policy, char *buf)
{
	int i;
	char *table = buf;

	for( i=fake_CpuShmoo.ShmooVmaxIndex; i>-1; i-- )
	{
		table += sprintf(table, "%d %d %d\n", fake_CpuShmoo.pScaledCpuLimits->MaxKHzList[i], fake_CpuShmoo.ShmooVoltages[i], fake_CpuShmoo.ShmooVoltages[i] - FakeShmoo_UV_mV_Ptr[i] );
	}
	return table - buf;
}
static ssize_t show_scaling_available_frequencies(struct cpufreq_policy *policy, char *buf)
{
	int i;
	char *table = buf;

	for( i=fake_CpuShmoo.ShmooVmaxIndex; i>-1; i-- )
	{
		table += sprintf(table, "%d ", fake_CpuShmoo.pScaledCpuLimits->MaxKHzList[i]);
	}
	return table - buf;
}

static ssize_t show_UV_mV_table(struct cpufreq_policy *policy, char *buf)
{
	int i;
	char *table = buf;

	for( i=fake_CpuShmoo.ShmooVmaxIndex; i>-1; i-- )
	{
		table += sprintf(table, "%d ", FakeShmoo_UV_mV_Ptr[i] );
	}
	table += sprintf(table, "\n" );
	return table - buf;
}

static ssize_t store_UV_mV_table(struct cpufreq_policy *policy, const char *buf, size_t count)
{
	int ret = sscanf( buf, "%i %i %i %i %i %i %i %i", 	&FakeShmoo_UV_mV_Ptr[7], &FakeShmoo_UV_mV_Ptr[6], 
								&FakeShmoo_UV_mV_Ptr[5], &FakeShmoo_UV_mV_Ptr[4], 
								&FakeShmoo_UV_mV_Ptr[3], &FakeShmoo_UV_mV_Ptr[2], 
								&FakeShmoo_UV_mV_Ptr[1], &FakeShmoo_UV_mV_Ptr[0] );
	if (ret != 1)
		return -EINVAL;

	return count;
}
#endif // USE_FAKE_SHMOO

#define define_one_ro(_name) \
static struct freq_attr _name = \
__ATTR(_name, 0444, show_##_name, NULL)

#define define_one_ro0400(_name) \
static struct freq_attr _name = \
__ATTR(_name, 0400, show_##_name, NULL)

#define define_one_rw(_name) \
static struct freq_attr _name = \
__ATTR(_name, 0644, show_##_name, store_##_name)

define_one_ro0400(cpuinfo_cur_freq);
define_one_ro(cpuinfo_min_freq);
define_one_ro(cpuinfo_max_freq);
define_one_ro(cpuinfo_transition_latency);
define_one_ro(scaling_available_governors);
define_one_ro(scaling_driver);
define_one_ro(scaling_cur_freq);
define_one_ro(related_cpus);
define_one_ro(affected_cpus);
define_one_rw(scaling_min_freq);
define_one_rw(scaling_max_freq);
define_one_rw(scaling_governor);
define_one_rw(scaling_setspeed);
#ifdef USE_FAKE_SHMOO
define_one_ro(cpu_temp);
define_one_ro(frequency_voltage_table);
define_one_ro(scaling_available_frequencies);
define_one_rw(UV_mV_table);
#endif // USE_FAKE_SHMOO


static struct attribute *default_attrs[] = {
	&cpuinfo_min_freq.attr,
	&cpuinfo_max_freq.attr,
	&cpuinfo_transition_latency.attr,
	&scaling_min_freq.attr,
	&scaling_max_freq.attr,
	&affected_cpus.attr,
	&related_cpus.attr,
	&scaling_governor.attr,
	&scaling_driver.attr,
	&scaling_available_governors.attr,
	&scaling_setspeed.attr,
#ifdef USE_FAKE_SHMOO
	&cpu_temp.attr,
	&frequency_voltage_table.attr,
&scaling_available_frequencies.attr,
	&UV_mV_table.attr,
#endif // USE_FAKE_SHMOO

	NULL
};

struct kobject *cpufreq_global_kobject;
EXPORT_SYMBOL(cpufreq_global_kobject);

#define to_policy(k) container_of(k, struct cpufreq_policy, kobj)
#define to_attr(a) container_of(a, struct freq_attr, attr)

static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
{
	struct cpufreq_policy *policy = to_policy(kobj);
	struct freq_attr *fattr = to_attr(attr);
	ssize_t ret = -EINVAL;
	policy = cpufreq_cpu_get(policy->cpu);
	if (!policy)
		goto no_policy;

	if (lock_policy_rwsem_read(policy->cpu) < 0)
		goto fail;

	if (fattr->show)
		ret = fattr->show(policy, buf);
	else
		ret = -EIO;

	unlock_policy_rwsem_read(policy->cpu);
fail:
	cpufreq_cpu_put(policy);
no_policy:
	return ret;
}

static ssize_t store(struct kobject *kobj, struct attribute *attr,
		     const char *buf, size_t count)
{
	struct cpufreq_policy *policy = to_policy(kobj);
	struct freq_attr *fattr = to_attr(attr);
	ssize_t ret = -EINVAL;
	policy = cpufreq_cpu_get(policy->cpu);
	if (!policy)
		goto no_policy;

	if (lock_policy_rwsem_write(policy->cpu) < 0)
		goto fail;

	if (fattr->store)
		ret = fattr->store(policy, buf, count);
	else
		ret = -EIO;

	unlock_policy_rwsem_write(policy->cpu);
fail:
	cpufreq_cpu_put(policy);
no_policy:
	return ret;
}

static void cpufreq_sysfs_release(struct kobject *kobj)
{
	struct cpufreq_policy *policy = to_policy(kobj);
	dprintk("last reference is dropped\n");
	complete(&policy->kobj_unregister);
}

static struct sysfs_ops sysfs_ops = {
	.show	= show,
	.store	= store,
};

static struct kobj_type ktype_cpufreq = {
	.sysfs_ops	= &sysfs_ops,
	.default_attrs	= default_attrs,
	.release	= cpufreq_sysfs_release,
};
#ifdef CONFIG_SMP
static int cpufreq_check_managed(int cpu, struct cpufreq_policy *pol)
{
int pcpu = per_cpu(policy_cpu, cpu);
return (cpumask_weight(pol->cpus) > 1 &&
cpumask_test_cpu(cpu, pol->cpus) && cpu != pcpu) ? pcpu : -1;
}
#endif // CONFIG_SMP
/*
 * Returns:
 *   Negative: Failure
 *   0:        Success
 *   Positive: When we have a managed CPU and the sysfs got symlinked
 */
int cpufreq_add_dev_policy(unsigned int cpu, struct cpufreq_policy *policy,
		struct sys_device *sys_dev)
{
	int ret = 0;
#ifdef CONFIG_SMP
	unsigned long flags;
	unsigned int j;
#ifdef CONFIG_HOTPLUG_CPU
	struct cpufreq_governor *gov;

	gov = __find_governor(per_cpu(cpufreq_cpu_governor, cpu));
	if (gov) {
		policy->governor = gov;
		dprintk("Restoring governor %s for cpu %d\n",
		       policy->governor->name, cpu);
	}
#endif

	for_each_cpu(j, policy->cpus) {
		struct cpufreq_policy *managed_policy;

		if (cpu == j)
			continue;

		/* Check for existing affected CPUs.
		 * They may not be aware of it due to CPU Hotplug.
		 * cpufreq_cpu_put is called when the device is removed
		 * in __cpufreq_remove_dev()
		 */
		managed_policy = cpufreq_cpu_get(j);
		if (unlikely(managed_policy)) {

			/* Set proper policy_cpu */
			unlock_policy_rwsem_write(cpu);
			per_cpu(policy_cpu, cpu) = managed_policy->cpu;

			if (lock_policy_rwsem_write(cpu) < 0) {
				/* Should not go through policy unlock path */
				if (cpufreq_driver->exit)
					cpufreq_driver->exit(policy);
				cpufreq_cpu_put(managed_policy);
				return -EBUSY;
			}

			spin_lock_irqsave(&cpufreq_driver_lock, flags);
			cpumask_copy(managed_policy->cpus, policy->cpus);
			per_cpu(cpufreq_cpu_data, cpu) = managed_policy;
			spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

			dprintk("CPU already managed, adding link\n");
			ret = sysfs_create_link(&sys_dev->kobj,
						&managed_policy->kobj,
						"cpufreq");
			if (ret)
				cpufreq_cpu_put(managed_policy);
			/*
			 * Success. We only needed to be added to the mask.
			 * Call driver->exit() because only the cpu parent of
			 * the kobj needed to call init().
			 */
			if (cpufreq_driver->exit)
				cpufreq_driver->exit(policy);

			if (!ret)
				return 1;
			else
				return ret;
		}
	}
#endif
	return ret;
}


/* symlink affected CPUs */
int cpufreq_add_dev_symlink(unsigned int cpu, struct cpufreq_policy *policy)
{
	unsigned int j;
	int ret = 0;

	for_each_cpu(j, policy->cpus) {
		struct cpufreq_policy *managed_policy;
		struct sys_device *cpu_sys_dev;

		if (j == cpu)
			continue;
		if (!cpu_online(j))
			continue;

		dprintk("CPU %u already managed, adding link\n", j);
		managed_policy = cpufreq_cpu_get(cpu);
		cpu_sys_dev = get_cpu_sysdev(j);
		ret = sysfs_create_link(&cpu_sys_dev->kobj, &policy->kobj,
					"cpufreq");
		if (ret) {
			cpufreq_cpu_put(managed_policy);
			return ret;
		}
	}
	return ret;
}

int cpufreq_add_dev_interface(unsigned int cpu, struct cpufreq_policy *policy,
		struct sys_device *sys_dev)
{
	struct cpufreq_policy new_policy;
	struct freq_attr **drv_attr;
	unsigned long flags;
	int ret = 0;
	unsigned int j;

	/* prepare interface data */
	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
				   &sys_dev->kobj, "cpufreq");
	if (ret)
		return ret;

	/* set up files for this cpu device */
	drv_attr = cpufreq_driver->attr;
	while ((drv_attr) && (*drv_attr)) {
		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
		if (ret)
			goto err_out_kobj_put;
		drv_attr++;
	}
	if (cpufreq_driver->get) {
		ret = sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
		if (ret)
			goto err_out_kobj_put;
	}
	if (cpufreq_driver->target) {
		ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
		if (ret)
			goto err_out_kobj_put;
	}

	spin_lock_irqsave(&cpufreq_driver_lock, flags);
	for_each_cpu(j, policy->cpus) {
	if (!cpu_online(j))
		continue;
		per_cpu(cpufreq_cpu_data, j) = policy;
		per_cpu(policy_cpu, j) = policy->cpu;
	}
	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

	ret = cpufreq_add_dev_symlink(cpu, policy);
	if (ret)
		goto err_out_kobj_put;

	memcpy(&new_policy, policy, sizeof(struct cpufreq_policy));
	/* assure that the starting sequence is run in __cpufreq_set_policy */
	policy->governor = NULL;

	/* set default policy */
	ret = __cpufreq_set_policy(policy, &new_policy);
	policy->user_policy.policy = policy->policy;
	policy->user_policy.governor = policy->governor;

	if (ret) {
		dprintk("setting policy failed\n");
		if (cpufreq_driver->exit)
			cpufreq_driver->exit(policy);
	}
	return ret;

err_out_kobj_put:
	kobject_put(&policy->kobj);
	wait_for_completion(&policy->kobj_unregister);
	return ret;
}


/**
 * cpufreq_add_dev - add a CPU device
 *
 * Adds the cpufreq interface for a CPU device.
 *
 * The Oracle says: try running cpufreq registration/unregistration concurrently
 * with with cpu hotplugging and all hell will break loose. Tried to clean this
 * mess up, but more thorough testing is needed. - Mathieu
 */
static int cpufreq_add_dev(struct sys_device *sys_dev)
{
	unsigned int cpu = sys_dev->id;
	int ret = 0, found = 0;
	struct cpufreq_policy *policy;
	unsigned long flags;
	unsigned int j;
#ifdef CONFIG_HOTPLUG_CPU
	int sibling;
struct cpufreq_policy *cp=NULL;
#endif

	if (cpu_is_offline(cpu))
		return 0;

	cpufreq_debug_disable_ratelimit();
	dprintk("adding CPU %u\n", cpu);

#ifdef CONFIG_SMP
	/* check whether a different CPU already registered this
	 * CPU because it is in the same boat. */
	policy = cpufreq_cpu_get(cpu);
	if (unlikely(policy)) {
ret = sysfs_create_link_nowarn(&sys_dev->kobj,
&policy->kobj, "cpufreq");
if (ret) {
		cpufreq_cpu_put(policy);
} else {
spin_lock_irqsave(&cpufreq_driver_lock, flags);
cpumask_set_cpu(cpu, policy->cpus);
spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
}
		cpufreq_debug_enable_ratelimit();
		return 0;
	}
#endif

	if (!try_module_get(cpufreq_driver->owner)) {
		ret = -EINVAL;
		goto module_out;
	}

	ret = -ENOMEM;
	policy = kzalloc(sizeof(struct cpufreq_policy), GFP_KERNEL);
	if (!policy)
		goto nomem_out;

	if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
		goto err_free_policy;

	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
		goto err_free_cpumask;

	policy->cpu = cpu;
	cpumask_copy(policy->cpus, cpumask_of(cpu));

	/* Initially set CPU itself as the policy_cpu */
	per_cpu(policy_cpu, cpu) = cpu;
	ret = (lock_policy_rwsem_write(cpu) < 0);
	WARN_ON(ret);

	init_completion(&policy->kobj_unregister);
	INIT_WORK(&policy->update, handle_update);

	/* Set governor before ->init, so that driver could check it */
#ifdef CONFIG_HOTPLUG_CPU
//struct cpufreq_policy *cp;
	for_each_online_cpu(sibling) {
		cp = per_cpu(cpufreq_cpu_data, sibling);

dprintk("found sibling CPU, copying policy\n");
if (cp && cp->governor &&
(cpumask_test_cpu(cpu, cp->related_cpus))) {
policy->min = cp->min;
policy->max = cp->max;
#endif
policy->user_policy.min = policy->min;
policy->user_policy.max = policy->max;
maxfq = policy->user_policy.max;
			found = 1;

			break;
		}
	}
	if (!found) {
dprintk("failed to find sibling CPU, falling back to defaults\n");
		policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
}
	/* call driver. From then on the cpufreq must be able
	 * to accept all calls to ->verify and ->setpolicy for this CPU
	 */
	ret = cpufreq_driver->init(policy);
	if (ret) {
		dprintk("initialization failed\n");
		goto err_unlock_policy;
	}
	policy->user_policy.min = policy->min;
	policy->user_policy.max = policy->max;
if (found)
{
 /* Calling the driver can overwrite policy frequencies again */
dprintk("Overriding policy max and min with sibling settings\n");
policy->min = cp->min;
policy->max = cp->max;
policy->user_policy.min = cp->user_policy.min;
policy->user_policy.max = cp->user_policy.max;
}

	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
				     CPUFREQ_START, policy);

	ret = cpufreq_add_dev_policy(cpu, policy, sys_dev);
	if (ret) {
		if (ret > 0)
			/* This is a managed cpu, symlink created,
			   exit with 0 */
			ret = 0;
		goto err_unlock_policy;
	}

	ret = cpufreq_add_dev_interface(cpu, policy, sys_dev);
	if (ret)
		goto err_out_unregister;

	unlock_policy_rwsem_write(cpu);
free_cpumask_var(policy->cpus);
free_cpumask_var(policy->related_cpus);
	kobject_uevent(&policy->kobj, KOBJ_ADD);
	module_put(cpufreq_driver->owner);
	dprintk("initialization complete\n");
	cpufreq_debug_enable_ratelimit();

	return 0;


err_out_unregister:
	spin_lock_irqsave(&cpufreq_driver_lock, flags);
	for_each_cpu(j, policy->cpus)
		per_cpu(cpufreq_cpu_data, j) = NULL;
	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

	kobject_put(&policy->kobj);
	wait_for_completion(&policy->kobj_unregister);

err_unlock_policy:
	unlock_policy_rwsem_write(cpu);
free_cpumask_var(policy->related_cpus);
err_free_cpumask:
	free_cpumask_var(policy->cpus);
err_free_policy:
	kfree(policy);
nomem_out:
	module_put(cpufreq_driver->owner);
module_out:
	cpufreq_debug_enable_ratelimit();
	return ret;
}


/**
 * __cpufreq_remove_dev - remove a CPU device
 *
 * Removes the cpufreq interface for a CPU device.
 * Caller should already have policy_rwsem in write mode for this CPU.
 * This routine frees the rwsem before returning.
 */
static int __cpufreq_remove_dev(struct sys_device *sys_dev)
{
	unsigned int cpu = sys_dev->id;
	unsigned long flags;
	struct cpufreq_policy *data;
struct kobject *kobj;
struct completion *cmp;
#ifdef CONFIG_SMP
	struct sys_device *cpu_sys_dev;
	unsigned int j;
#endif

	cpufreq_debug_disable_ratelimit();
	dprintk("unregistering CPU %u\n", cpu);

	spin_lock_irqsave(&cpufreq_driver_lock, flags);
	data = per_cpu(cpufreq_cpu_data, cpu);

	if (!data) {
		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
		cpufreq_debug_enable_ratelimit();
		unlock_policy_rwsem_write(cpu);
		return -EINVAL;
	}
	per_cpu(cpufreq_cpu_data, cpu) = NULL;


#ifdef CONFIG_SMP
	/* if this isn't the CPU which is the parent of the kobj, we
	 * only need to unlink, put and exit
	 */
	if (unlikely(cpu != data->cpu)) {
		dprintk("removing link\n");
		cpumask_clear_cpu(cpu, data->cpus);
		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
		kobj = &sys_dev->kobj;
		cpufreq_cpu_put(data);
		cpufreq_debug_enable_ratelimit();
		unlock_policy_rwsem_write(cpu);
sysfs_remove_link(kobj, "cpufreq");
		return 0;
	}
#endif

#ifdef CONFIG_SMP

#ifdef CONFIG_HOTPLUG_CPU
	if (data->governor)
		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
			data->governor->name, CPUFREQ_NAME_LEN);
#endif

	/* if we have other CPUs still registered, we need to unlink them,
	 * or else wait_for_completion below will lock up. Clean the
	 * per_cpu(cpufreq_cpu_data) while holding the lock, and remove
	 * the sysfs links afterwards.
	 */
	if (unlikely(cpumask_weight(data->cpus) > 1)) {
		for_each_cpu(j, data->cpus) {
			if (j == cpu)
				continue;
			per_cpu(cpufreq_cpu_data, j) = NULL;
		}
	}

	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

	if (unlikely(cpumask_weight(data->cpus) > 1)) {
		for_each_cpu(j, data->cpus) {
			if (j == cpu)
				continue;
			dprintk("removing link for cpu %u\n", j);
#ifdef CONFIG_HOTPLUG_CPU
			if (data->governor)
				strncpy(per_cpu(cpufreq_cpu_governor, j),
					data->governor->name, CPUFREQ_NAME_LEN);
#endif
			cpu_sys_dev = get_cpu_sysdev(j);
kobj = &cpu_sys_dev->kobj;
unlock_policy_rwsem_write(cpu);
sysfs_remove_link(kobj, "cpufreq");
lock_policy_rwsem_write(cpu);
			cpufreq_cpu_put(data);
		}
	}
#else
	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
#endif

	if (cpufreq_driver->target)
		__cpufreq_governor(data, CPUFREQ_GOV_STOP);

kobj = &data->kobj;
cmp = &data->kobj_unregister;
unlock_policy_rwsem_write(cpu);
kobject_put(kobj);

	/* we need to make sure that the underlying kobj is actually
	 * not referenced anymore by anybody before we proceed with
	 * unloading.
	 */
	dprintk("waiting for dropping of refcount\n");
wait_for_completion(cmp);
	dprintk("wait complete\n");

lock_policy_rwsem_write(cpu);	
if (cpufreq_driver->exit)
		cpufreq_driver->exit(data);

	unlock_policy_rwsem_write(cpu);

	cpufreq_debug_enable_ratelimit();

#ifdef CONFIG_HOTPLUG_CPU
	/* when the CPU which is the parent of the kobj is hotplugged
	 * offline, check for siblings, and create cpufreq sysfs interface
	 * and symlinks
	 */
	if (unlikely(cpumask_weight(data->cpus) > 1)) {
		/* first sibling now owns the new sysfs dir */
		cpumask_clear_cpu(cpu, data->cpus);
		cpufreq_add_dev(get_cpu_sysdev(cpumask_first(data->cpus)));

		/* finally remove our own symlink */
		lock_policy_rwsem_write(cpu);
		__cpufreq_remove_dev(sys_dev);
	}
#endif

	free_cpumask_var(data->related_cpus);
	free_cpumask_var(data->cpus);
	kfree(data);

	return 0;
}


static int cpufreq_remove_dev(struct sys_device *sys_dev)
{
	unsigned int cpu = sys_dev->id;
	int retval;

	if (cpu_is_offline(cpu))
		return 0;

	if (unlikely(lock_policy_rwsem_write(cpu)))
		BUG();

	retval = __cpufreq_remove_dev(sys_dev);
	return retval;
}


static void handle_update(struct work_struct *work)
{
	struct cpufreq_policy *policy =
		container_of(work, struct cpufreq_policy, update);
	unsigned int cpu = policy->cpu;
	dprintk("handle_update for cpu %u called\n", cpu);
	cpufreq_update_policy(cpu);
}

/**
 *	cpufreq_out_of_sync - If actual and saved CPU frequency differs, we're in deep trouble.
 *	@cpu: cpu number
 *	@old_freq: CPU frequency the kernel thinks the CPU runs at
 *	@new_freq: CPU frequency the CPU actually runs at
 *
 *	We adjust to current frequency first, and need to clean up later.
 *	So either call to cpufreq_update_policy() or schedule handle_update()).
 */
static void cpufreq_out_of_sync(unsigned int cpu, unsigned int old_freq,
				unsigned int new_freq)
{
	struct cpufreq_freqs freqs;

	dprintk("Warning: CPU frequency out of sync: cpufreq and timing "
	       "core thinks of %u, is %u kHz.\n", old_freq, new_freq);

	freqs.cpu = cpu;
	freqs.old = old_freq;
	freqs.new = new_freq;
	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
}


/**
 * cpufreq_quick_get - get the CPU frequency (in kHz) from policy->cur
 * @cpu: CPU number
 *
 * This is the last known freq, without actually getting it from the driver.
 * Return value will be same as what is shown in scaling_cur_freq in sysfs.
 */
unsigned int cpufreq_quick_get(unsigned int cpu)
{
	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
	unsigned int ret_freq = 0;

	if (policy) {
		ret_freq = policy->cur;
		cpufreq_cpu_put(policy);
	}

	return ret_freq;
}
EXPORT_SYMBOL(cpufreq_quick_get);


static unsigned int __cpufreq_get(unsigned int cpu)
{
	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
	unsigned int ret_freq = 0;

	if (!cpufreq_driver->get)
		return ret_freq;

	ret_freq = cpufreq_driver->get(cpu);

	if (ret_freq && policy->cur &&
		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
		/* verify no discrepancy between actual and
					saved value exists */
		if (unlikely(ret_freq != policy->cur)) {
			cpufreq_out_of_sync(cpu, policy->cur, ret_freq);
			schedule_work(&policy->update);
		}
	}

	return ret_freq;
}

/**
 * cpufreq_get - get the current CPU frequency (in kHz)
 * @cpu: CPU number
 *
 * Get the CPU current (static) CPU frequency
 */
unsigned int cpufreq_get(unsigned int cpu)
{
	unsigned int ret_freq = 0;
	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);

	if (!policy)
		goto out;

	if (unlikely(lock_policy_rwsem_read(cpu)))
		goto out_policy;

	ret_freq = __cpufreq_get(cpu);

	unlock_policy_rwsem_read(cpu);

out_policy:
	cpufreq_cpu_put(policy);
out:
	return ret_freq;
}
EXPORT_SYMBOL(cpufreq_get);


/**
 *	cpufreq_suspend - let the low level driver prepare for suspend
 */

static int cpufreq_suspend(struct sys_device *sysdev, pm_message_t pmsg)
{
	int ret = 0;

	int cpu = sysdev->id;
	struct cpufreq_policy *cpu_policy;

	dprintk("suspending cpu %u\n", cpu);

	if (!cpu_online(cpu))
		return 0;

	/* we may be lax here as interrupts are off. Nonetheless
	 * we need to grab the correct cpu policy, as to check
	 * whether we really run on this CPU.
	 */

	cpu_policy = cpufreq_cpu_get(cpu);
	if (!cpu_policy)
		return -EINVAL;

	/* only handle each CPU group once */
	if (unlikely(cpu_policy->cpu != cpu))
		goto out;

	if (cpufreq_driver->suspend) {
		ret = cpufreq_driver->suspend(cpu_policy, pmsg);
		if (ret)
			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
					"step on CPU %u\n", cpu_policy->cpu);
	}

out:
	cpufreq_cpu_put(cpu_policy);
	return ret;
}

/**
 *	cpufreq_resume -  restore proper CPU frequency handling after resume
 *
 *	1.) resume CPUfreq hardware support (cpufreq_driver->resume())
 *	2.) schedule call cpufreq_update_policy() ASAP as interrupts are
 *	    restored. It will verify that the current freq is in sync with
 *	    what we believe it to be. This is a bit later than when it
 *	    should be, but nonethteless it's better than calling
 *	    cpufreq_driver->get() here which might re-enable interrupts...
 */
static int cpufreq_resume(struct sys_device *sysdev)
{
	int ret = 0;

	int cpu = sysdev->id;
	struct cpufreq_policy *cpu_policy;

	dprintk("resuming cpu %u\n", cpu);

	if (!cpu_online(cpu))
		return 0;

	/* we may be lax here as interrupts are off. Nonetheless
	 * we need to grab the correct cpu policy, as to check
	 * whether we really run on this CPU.
	 */

	cpu_policy = cpufreq_cpu_get(cpu);
	if (!cpu_policy)
		return -EINVAL;

	/* only handle each CPU group once */
	if (unlikely(cpu_policy->cpu != cpu))
		goto fail;

	if (cpufreq_driver->resume) {
		ret = cpufreq_driver->resume(cpu_policy);
		if (ret) {
			printk(KERN_ERR "cpufreq: resume failed in ->resume "
					"step on CPU %u\n", cpu_policy->cpu);
			goto fail;
		}
	}

	schedule_work(&cpu_policy->update);

fail:
	cpufreq_cpu_put(cpu_policy);
	return ret;
}

static struct sysdev_driver cpufreq_sysdev_driver = {
	.add		= cpufreq_add_dev,
	.remove		= cpufreq_remove_dev,
	.suspend	= cpufreq_suspend,
	.resume		= cpufreq_resume,
};


/*********************************************************************
 *                     NOTIFIER LISTS INTERFACE                      *
 *********************************************************************/

/**
 *	cpufreq_register_notifier - register a driver with cpufreq
 *	@nb: notifier function to register
 *      @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER
 *
 *	Add a driver to one of two lists: either a list of drivers that
 *      are notified about clock rate changes (once before and once after
 *      the transition), or a list of drivers that are notified about
 *      changes in cpufreq policy.
 *
 *	This function may sleep, and has the same return conditions as
 *	blocking_notifier_chain_register.
 */
int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
{
	int ret;

	WARN_ON(!init_cpufreq_transition_notifier_list_called);

	switch (list) {
	case CPUFREQ_TRANSITION_NOTIFIER:
		ret = srcu_notifier_chain_register(
				&cpufreq_transition_notifier_list, nb);
		break;
	case CPUFREQ_POLICY_NOTIFIER:
		ret = blocking_notifier_chain_register(
				&cpufreq_policy_notifier_list, nb);
		break;
	default:
		ret = -EINVAL;
	}

	return ret;
}
EXPORT_SYMBOL(cpufreq_register_notifier);


/**
 *	cpufreq_unregister_notifier - unregister a driver with cpufreq
 *	@nb: notifier block to be unregistered
 *      @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER
 *
 *	Remove a driver from the CPU frequency notifier list.
 *
 *	This function may sleep, and has the same return conditions as
 *	blocking_notifier_chain_unregister.
 */
int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
{
	int ret;

	switch (list) {
	case CPUFREQ_TRANSITION_NOTIFIER:
		ret = srcu_notifier_chain_unregister(
				&cpufreq_transition_notifier_list, nb);
		break;
	case CPUFREQ_POLICY_NOTIFIER:
		ret = blocking_notifier_chain_unregister(
				&cpufreq_policy_notifier_list, nb);
		break;
	default:
		ret = -EINVAL;
	}

	return ret;
}
EXPORT_SYMBOL(cpufreq_unregister_notifier);


/*********************************************************************
 *                              GOVERNORS                            *
 *********************************************************************/


int __cpufreq_driver_target(struct cpufreq_policy *policy,
			    unsigned int target_freq,
			    unsigned int relation)
{
	int retval = -EINVAL;

	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
		target_freq, relation);
	if (cpu_online(policy->cpu) && cpufreq_driver->target)
		retval = cpufreq_driver->target(policy, target_freq, relation);

	return retval;
}
EXPORT_SYMBOL_GPL(__cpufreq_driver_target);

int cpufreq_driver_target(struct cpufreq_policy *policy,
			  unsigned int target_freq,
			  unsigned int relation)
{
	int ret = -EINVAL;

	policy = cpufreq_cpu_get(policy->cpu);
	if (!policy)
		goto no_policy;

	if (unlikely(lock_policy_rwsem_write(policy->cpu)))
		goto fail;

	ret = __cpufreq_driver_target(policy, target_freq, relation);

	unlock_policy_rwsem_write(policy->cpu);

fail:
	cpufreq_cpu_put(policy);
no_policy:
	return ret;
}
EXPORT_SYMBOL_GPL(cpufreq_driver_target);

int __cpufreq_driver_getavg(struct cpufreq_policy *policy, unsigned int cpu)
{
	int ret = 0;

	policy = cpufreq_cpu_get(policy->cpu);
	if (!policy)
		return -EINVAL;

	if (cpu_online(cpu) && cpufreq_driver->getavg)
		ret = cpufreq_driver->getavg(policy, cpu);

	cpufreq_cpu_put(policy);
	return ret;
}
EXPORT_SYMBOL_GPL(__cpufreq_driver_getavg);

/*
 * when "event" is CPUFREQ_GOV_LIMITS
 */

static int __cpufreq_governor(struct cpufreq_policy *policy,
					unsigned int event)
{
	int ret;

	/* Only must be defined when default governor is known to have latency
	   restrictions, like e.g. conservative or ondemand.
	   That this is the case is already ensured in Kconfig
	*/
#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
	struct cpufreq_governor *gov = &cpufreq_gov_performance;
#else
	struct cpufreq_governor *gov = NULL;
#endif

	if (policy->governor->max_transition_latency &&
	    policy->cpuinfo.transition_latency >
	    policy->governor->max_transition_latency) {
		if (!gov)
			return -EINVAL;
		else {
			printk(KERN_WARNING "%s governor failed, too long"
			       " transition latency of HW, fallback"
			       " to %s governor\n",
			       policy->governor->name,
			       gov->name);
			policy->governor = gov;
		}
	}

	if (!try_module_get(policy->governor->owner))
		return -EINVAL;

	dprintk("__cpufreq_governor for CPU %u, event %u\n",
						policy->cpu, event);
	ret = policy->governor->governor(policy, event);

	/* we keep one module reference alive for
			each CPU governed by this CPU */
	if ((event != CPUFREQ_GOV_START) || ret)
		module_put(policy->governor->owner);
	if ((event == CPUFREQ_GOV_STOP) && !ret)
		module_put(policy->governor->owner);

	return ret;
}


int cpufreq_register_governor(struct cpufreq_governor *governor)
{
	int err;

	if (!governor)
		return -EINVAL;

	mutex_lock(&cpufreq_governor_mutex);

	err = -EBUSY;
	if (__find_governor(governor->name) == NULL) {
		err = 0;
		list_add(&governor->governor_list, &cpufreq_governor_list);
	}

	mutex_unlock(&cpufreq_governor_mutex);
	return err;
}
EXPORT_SYMBOL_GPL(cpufreq_register_governor);


void cpufreq_unregister_governor(struct cpufreq_governor *governor)
{
#ifdef CONFIG_HOTPLUG_CPU
	int cpu;
#endif

	if (!governor)
		return;

#ifdef CONFIG_HOTPLUG_CPU
	for_each_present_cpu(cpu) {
		if (cpu_online(cpu))
			continue;
		if (!strcmp(per_cpu(cpufreq_cpu_governor, cpu), governor->name))
			strcpy(per_cpu(cpufreq_cpu_governor, cpu), "\0");
	}
#endif

	mutex_lock(&cpufreq_governor_mutex);
	list_del(&governor->governor_list);
	mutex_unlock(&cpufreq_governor_mutex);
	return;
}
EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);



/*********************************************************************
 *                          POLICY INTERFACE                         *
 *********************************************************************/

/**
 * cpufreq_get_policy - get the current cpufreq_policy
 * @policy: struct cpufreq_policy into which the current cpufreq_policy
 *	is written
 *
 * Reads the current cpufreq policy.
 */
int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
{
	struct cpufreq_policy *cpu_policy;
	if (!policy)
		return -EINVAL;

	cpu_policy = cpufreq_cpu_get(cpu);
	if (!cpu_policy)
		return -EINVAL;

	memcpy(policy, cpu_policy, sizeof(struct cpufreq_policy));

	cpufreq_cpu_put(cpu_policy);
	return 0;
}
EXPORT_SYMBOL(cpufreq_get_policy);


/*
 * data   : current policy.
 * policy : policy to be set.
 */
static int __cpufreq_set_policy(struct cpufreq_policy *data,
				struct cpufreq_policy *policy)
{
	int ret = 0;

	cpufreq_debug_disable_ratelimit();
	dprintk("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
		policy->min, policy->max);

	memcpy(&policy->cpuinfo, &data->cpuinfo,
				sizeof(struct cpufreq_cpuinfo));

	if (policy->min > data->max || policy->max < data->min) {
		ret = -EINVAL;
		goto error_out;
	}

	/* verify the cpu speed can be set within this limit */
	ret = cpufreq_driver->verify(policy);
	if (ret)
		goto error_out;

	/* adjust if necessary - all reasons */
	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
			CPUFREQ_ADJUST, policy);

	/* adjust if necessary - hardware incompatibility*/
	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
			CPUFREQ_INCOMPATIBLE, policy);

	/* verify the cpu speed can be set within this limit,
	   which might be different to the first one */
	ret = cpufreq_driver->verify(policy);
	if (ret)
		goto error_out;

	/* notification of the new policy */
	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
			CPUFREQ_NOTIFY, policy);

	data->min = policy->min;
	data->max = policy->max;

	dprintk("new min and max freqs are %u - %u kHz\n",
					data->min, data->max);

	if (cpufreq_driver->setpolicy) {
		data->policy = policy->policy;
		dprintk("setting range\n");
		ret = cpufreq_driver->setpolicy(policy);
	} else {
		if (policy->governor != data->governor) {
			/* save old, working values */
			struct cpufreq_governor *old_gov = data->governor;

			dprintk("governor switch\n");

			/* end old governor */
			if (data->governor)
				__cpufreq_governor(data, CPUFREQ_GOV_STOP);

			/* start new governor */
			data->governor = policy->governor;
			if (__cpufreq_governor(data, CPUFREQ_GOV_START)) {
				/* new governor failed, so re-start old one */
				dprintk("starting governor %s failed\n",
							data->governor->name);
				if (old_gov) {
					data->governor = old_gov;
					__cpufreq_governor(data,
							   CPUFREQ_GOV_START);
				}
				ret = -EINVAL;
				goto error_out;
			}
			/* might be a policy change, too, so fall through */
		}
		dprintk("governor: change or update limits\n");
		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
	}

error_out:
	cpufreq_debug_enable_ratelimit();
	return ret;
}

/**
 *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
 *	@cpu: CPU which shall be re-evaluated
 *
 *	Usefull for policy notifiers which have different necessities
 *	at different times.
 */
int cpufreq_update_policy(unsigned int cpu)
{
	struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
	struct cpufreq_policy policy;
	int ret;

	if (!data) {
		ret = -ENODEV;
		goto no_policy;
	}

	if (unlikely(lock_policy_rwsem_write(cpu))) {
		ret = -EINVAL;
		goto fail;
	}
#ifdef CONFIG_SMP
if (cpufreq_check_managed(cpu, data) >= 0) {
unlock_policy_rwsem_write(cpu);
ret = 0;
goto fail;
}
#endif
	dprintk("updating policy for CPU %u\n", cpu);
	memcpy(&policy, data, sizeof(struct cpufreq_policy));
	policy.min = data->user_policy.min;
	policy.max = data->user_policy.max;
	policy.policy = data->user_policy.policy;
	policy.governor = data->user_policy.governor;

	/* BIOS might change freq behind our back
	  -> ask driver for current freq and notify governors about a change */
	if (cpufreq_driver->get) {
		policy.cur = cpufreq_driver->get(cpu);
		if (!data->cur) {
			dprintk("Driver did not initialize current freq");
			data->cur = policy.cur;
		} else {
			if (data->cur != policy.cur)
				cpufreq_out_of_sync(cpu, data->cur,
								policy.cur);
		}
	}

	ret = __cpufreq_set_policy(data, &policy);

	unlock_policy_rwsem_write(cpu);

fail:
	cpufreq_cpu_put(data);
no_policy:
	return ret;
}
EXPORT_SYMBOL(cpufreq_update_policy);

static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
					unsigned long action, void *hcpu)
{
	unsigned int cpu = (unsigned long)hcpu;
	struct sys_device *sys_dev;

	sys_dev = get_cpu_sysdev(cpu);
	if (sys_dev) {
		switch (action) {
		case CPU_ONLINE:
		case CPU_ONLINE_FROZEN:
			cpufreq_add_dev(sys_dev);
			break;
		case CPU_DOWN_PREPARE:
		case CPU_DOWN_PREPARE_FROZEN:
			if (unlikely(lock_policy_rwsem_write(cpu)))
				BUG();

			__cpufreq_remove_dev(sys_dev);
			break;
		case CPU_DOWN_FAILED:
		case CPU_DOWN_FAILED_FROZEN:
			cpufreq_add_dev(sys_dev);
			break;
		}
	}
	return NOTIFY_OK;
}

static struct notifier_block __refdata cpufreq_cpu_notifier =
{
    .notifier_call = cpufreq_cpu_callback,
};

/*********************************************************************
 *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
 *********************************************************************/

/**
 * cpufreq_register_driver - register a CPU Frequency driver
 * @driver_data: A struct cpufreq_driver containing the values#
 * submitted by the CPU Frequency driver.
 *
 *   Registers a CPU Frequency driver to this core code. This code
 * returns zero on success, -EBUSY when another driver got here first
 * (and isn't unregistered in the meantime).
 *
 */
int cpufreq_register_driver(struct cpufreq_driver *driver_data)
{
	unsigned long flags;
	int ret;

	if (!driver_data || !driver_data->verify || !driver_data->init ||
	    ((!driver_data->setpolicy) && (!driver_data->target)))
		return -EINVAL;

	dprintk("trying to register driver %s\n", driver_data->name);

	if (driver_data->setpolicy)
		driver_data->flags |= CPUFREQ_CONST_LOOPS;

	spin_lock_irqsave(&cpufreq_driver_lock, flags);
	if (cpufreq_driver) {
		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
		return -EBUSY;
	}
	cpufreq_driver = driver_data;
	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

	ret = sysdev_driver_register(&cpu_sysdev_class,
					&cpufreq_sysdev_driver);

	if ((!ret) && !(cpufreq_driver->flags & CPUFREQ_STICKY)) {
		int i;
		ret = -ENODEV;

		/* check for at least one working CPU */
		for (i = 0; i < nr_cpu_ids; i++)
			if (cpu_possible(i) && per_cpu(cpufreq_cpu_data, i)) {
				ret = 0;
				break;
			}

		/* if all ->init() calls failed, unregister */
		if (ret) {
			dprintk("no CPU initialized for driver %s\n",
							driver_data->name);
			sysdev_driver_unregister(&cpu_sysdev_class,
						&cpufreq_sysdev_driver);

			spin_lock_irqsave(&cpufreq_driver_lock, flags);
			cpufreq_driver = NULL;
			spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
		}
	}

	if (!ret) {
		register_hotcpu_notifier(&cpufreq_cpu_notifier);
		dprintk("driver %s up and running\n", driver_data->name);
		cpufreq_debug_enable_ratelimit();
	}

	return ret;
}
EXPORT_SYMBOL_GPL(cpufreq_register_driver);


/**
 * cpufreq_unregister_driver - unregister the current CPUFreq driver
 *
 *    Unregister the current CPUFreq driver. Only call this if you have
 * the right to do so, i.e. if you have succeeded in initialising before!
 * Returns zero if successful, and -EINVAL if the cpufreq_driver is
 * currently not initialised.
 */
int cpufreq_unregister_driver(struct cpufreq_driver *driver)
{
	unsigned long flags;

	cpufreq_debug_disable_ratelimit();

	if (!cpufreq_driver || (driver != cpufreq_driver)) {
		cpufreq_debug_enable_ratelimit();
		return -EINVAL;
	}

	dprintk("unregistering driver %s\n", driver->name);

	sysdev_driver_unregister(&cpu_sysdev_class, &cpufreq_sysdev_driver);
	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);

	spin_lock_irqsave(&cpufreq_driver_lock, flags);
	cpufreq_driver = NULL;
	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

	return 0;
}
EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
unsigned int oldmaxclock;
unsigned int oldminclock;
unsigned int oldvdefreq;
unsigned int oldgpufreq;
unsigned int oldddr2;
unsigned int oldlpddr2;

static void powersave_early_suspend(struct early_suspend *handler)
{
	int cpu;

	for_each_online_cpu(cpu) {
		struct cpufreq_policy *cpu_policy, new_policy;

		cpu_policy = cpufreq_cpu_get(cpu);
		if (!cpu_policy)
			continue;
		if (cpufreq_get_policy(&new_policy, cpu))
			goto out;
//oldmaxclock = evaluate_cpu_freq(cpu_policy,
//					cpu_policy->cpuinfo.max_freq >> 1);
oldmaxclock = cpu_policy->user_policy.max;
maxfq = oldmaxclock;
oldminclock = cpu_policy->user_policy.min;
oldgpufreq = GPUFREQ;
oldvdefreq = VDEFREQ;
oldddr2 = NVRM_AP20_DDR2_MIN_KHZ;
oldlpddr2 = NVRM_AP20_LPDDR2_MIN_KHZ;
new_policy.max = SCREENOFFFREQ;
new_policy.min = oldminclock;
__cpufreq_set_policy(cpu_policy, &new_policy);
		cpu_policy->user_policy.policy = cpu_policy->policy;
if (PWONOFF == 4)
{
NITROONOFF = 0;
GPUFREQ = 320000;
VDEFREQ = 630000;
NVRM_AP20_DDR2_MIN_KHZ = 40000;
NVRM_AP20_LPDDR2_MIN_KHZ = 15000;
//NVRM_AP20_LOW_CORE_MV = 910;
//NVRM_AP20_LOW_CPU_MV = 760;
}
else if (PWONOFF == 5)
{
NITROONOFF = 0;
GPUFREQ = 310000;
VDEFREQ = 620000;
NVRM_AP20_DDR2_MIN_KHZ = 30000;
NVRM_AP20_LPDDR2_MIN_KHZ = 12000;
//NVRM_AP20_LOW_CORE_MV = 895;
//NVRM_AP20_LOW_CPU_MV = 750;
}
 else if (PWONOFF == 6)
{
NITROONOFF = 0;
GPUFREQ = 300000;
VDEFREQ = 610000;
NVRM_AP20_DDR2_MIN_KHZ = 10000;
NVRM_AP20_LPDDR2_MIN_KHZ = 12000;
//NVRM_AP20_LOW_CORE_MV = 880;
//NVRM_AP20_LOW_CPU_MV = 740;
}
 
cpu_policy->user_policy.governor = cpu_policy->governor;

out:
		cpufreq_cpu_put(cpu_policy);
	}
}

static void powersave_late_resume(struct early_suspend *handler)
{
	int cpu;

	for_each_online_cpu(cpu) {
		struct cpufreq_policy *cpu_policy, new_policy;

		cpu_policy = cpufreq_cpu_get(cpu);
		if (!cpu_policy)
			continue;
		if (cpufreq_get_policy(&new_policy, cpu))
			goto out;
		new_policy.max = oldmaxclock;
		new_policy.min = oldminclock;
		__cpufreq_set_policy(cpu_policy, &new_policy);
		cpu_policy->user_policy.policy = cpu_policy->policy;
//extern int USE_FG;
if (PWONOFF == 1)
{
NITROONOFF = 0;
GPUFREQ = 320000;
VDEFREQ = 630000;
NVRM_AP20_DDR2_MIN_KHZ = 40000;
NVRM_AP20_LPDDR2_MIN_KHZ = 15000;
//NVRM_AP20_LOW_CORE_MV = 910;
//NVRM_AP20_LOW_CPU_MV = 760;
}
else if (PWONOFF == 2)
{
NITROONOFF = 0;
GPUFREQ = 310000;
VDEFREQ = 620000;
NVRM_AP20_DDR2_MIN_KHZ = 30000;
NVRM_AP20_LPDDR2_MIN_KHZ = 12000;
//NVRM_AP20_LOW_CORE_MV = 895;
//NVRM_AP20_LOW_CPU_MV = 750;
}
 else if (PWONOFF == 3)
{
NITROONOFF = 0;
GPUFREQ = 300000;
VDEFREQ = 610000;
NVRM_AP20_DDR2_MIN_KHZ = 10000;
NVRM_AP20_LPDDR2_MIN_KHZ = 12000;
//NVRM_AP20_LOW_CORE_MV = 880;
//NVRM_AP20_LOW_CPU_MV = 740;
}
 else if (NITROONOFF == 1)
{
PWONOFF = 0;
GPUFREQ = 400000;
VDEFREQ = 700000;
NVRM_AP20_DDR2_MIN_KHZ = 50000;
NVRM_AP20_LPDDR2_MIN_KHZ = 18000;
//NVRM_AP20_LOW_CORE_MV = 925;
//NVRM_AP20_LOW_CPU_MV = 770;
}
 else if ((PWONOFF == 4) || (PWONOFF == 5) || (PWONOFF == 6) || (PWONOFF == 0))
{
//NITROONOFF = 0;
//GPUFREQ = oldgpufreq;
//VDEFREQ = oldvdefreq;
//NVRM_AP20_DDR2_MIN_KHZ = oldddr2;
//NVRM_AP20_LPDDR2_MIN_KHZ = oldlpddr2;
//NVRM_AP20_LOW_CORE_MV = 925;
//NVRM_AP20_LOW_CPU_MV = 770;
};

		cpu_policy->user_policy.governor = cpu_policy->governor;
out:
		cpufreq_cpu_put(cpu_policy);
	}
}

static struct early_suspend _powersave_early_suspend = {
	.suspend = powersave_early_suspend,
	.resume = powersave_late_resume,
	.level = EARLY_SUSPEND_LEVEL_BLANK_SCREEN,
};


static int __init cpufreq_core_init(void)
{
	int cpu;

#ifdef USE_FAKE_SHMOO
	// Allocate some memory for the voltage tab
	FakeShmoo_UV_mV_Ptr = kzalloc(sizeof(int)*(fake_CpuShmoo.ShmooVmaxIndex+1), GFP_KERNEL);
#endif // USE_FAKE_SHMOO

	for_each_possible_cpu(cpu) {
		per_cpu(policy_cpu, cpu) = -1;
		init_rwsem(&per_cpu(cpu_policy_rwsem, cpu));
	}

	cpufreq_global_kobject = kobject_create_and_add("cpufreq",
						&cpu_sysdev_class.kset.kobj);
	BUG_ON(!cpufreq_global_kobject);
register_early_suspend(&_powersave_early_suspend);
	return 0;
}
core_initcall(cpufreq_core_init);
