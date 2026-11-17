Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903140;
	b=PrxIIDgeMD/+IRPmHbwudna5NaBb6FJokFo6EdBeUDidXXIEd6Fq+X8u/A1+e5v7C6hD
	 ExSwzHeVsvjYTvUKyEVR9vXBhV1qLF4Yr0ATFDCIYR1928tVRp0unYEsbEpWOv5eGUkeb
	 vFpdg/8TXSUWNHOJpIa2Ja4URH5Dc/S9TJwDFdQgP7Kb54Ix9mOIFFiWw7Wy1wql93U8Q
	 u2q0q/G6ZZtor86fI3TFiqNG41VohygF8cb9RRIrEE2UV8LBlvD7hT8acJxFirE762VYV
	 ek04uKlFH860SH/25yq4276izk07Tib0Kik9hzEEG78GtIlH91uP23ghMD/1wt03nqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903140;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=3Q56oJu3Qvbb8a5JtiwHd6x9aRZnKCgnczofHs62bK8=;
	b=hqShsea0ZmMd2hHJ3YLuipP1rzkzsVsmJMonqRofs20d3Udb8WkkvXS2tpnxRTbJWH+q
	 cUpsZ74CnVwlW2usjkWRrm0rzJCAvraGdYM6n2PE/TIMsnPxWICz6sE7H55qVNdqbCwN7
	 fPGjqYl1x8roOa91sjF3X+B62dYA7e5UrHbPSXr7bPLCfovFz0KXNVovTVTdGDO/f0MnO
	 N/h9pfIdRnHaNynhdgGym8v2W30SpZV2agY2pgp2E7vN26pt5VWpOLTn6Oo5DMmv4s4Uo
	 QLY3Aw4GHXOZMtUhCnr/xPex/QidaAaYXe6GxVbWphEdwdvSBc1plIqIAniaUps9/yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y9tcVMbS;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873A606A31C;
	Tue, 17 Nov 2026 08:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D873A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y9tcVMbS
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 635C320B7169;
	Tue, 17 Nov 2026 00:12:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 635C320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794903138;
	bh=3Q56oJu3Qvbb8a5JtiwHd6x9aRZnKCgnczofHs62bK8=;
	h=From:To:Cc:Subject:Date:From;
	b=Y9tcVMbST1MOnDSd7vJyGUU7DbRbUFCN4sgjNlW6uaqZEv18t49SZWrlDyewbiNNw
	 PRVS2k55hd8avGQAgUqHAtN96AQz1gLmcL12Exp2KqNxffGq0Br2hTX9xtSSBr5c/1
	 9CHVmwDYla8pjesczn26HlKXdI/BFokxxojJtkRc=
From: Naman Jain <namjain@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	namjain@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	anbelski@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mshv_vtl: Add a per-CPU transition statistics ioctl
Date: Tue, 17 Nov 2026 08:12:11 +0000
Message-ID: <20261117081211.2063781-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VTL driver does not expose per-CPU transition counts or timing.
This information is important to track number of VTL transitions based
on the use-case, debug issues where a VP gets stuck in VTL2 etc.
Add MSHV_GET_VTL_STATS IOCTL so userspace can query them and print this
information periodically or on error handling paths. Report entry and
return counts, the latest timestamps, and total and maximum interval
durations. Include the last observed state so userspace
can calculate the age of an unfinished interval. These are elapsed times,
not exclusive CPU execution times.

While at it, remove the unused num_vtl0_transitions counter.
Add documentation in a generic VTL interface file. Documentation for
existing ioctls is outside the scope of this patch.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 Documentation/virt/hyperv/index.rst    |  1 +
 Documentation/virt/hyperv/mshv-vtl.rst | 98 ++++++++++++++++++++++++++
 drivers/hv/mshv_vtl_main.c             | 72 ++++++++++++++++++-
 include/uapi/linux/mshv.h              | 35 +++++++++
 4 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/virt/hyperv/mshv-vtl.rst

diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
index c84c40fd61c91..9fcff8c0f7db8 100644
--- a/Documentation/virt/hyperv/index.rst
+++ b/Documentation/virt/hyperv/index.rst
@@ -13,3 +13,4 @@ Hyper-V Enlightenments
    vpci
    hibernation
    coco
+   mshv-vtl
diff --git a/Documentation/virt/hyperv/mshv-vtl.rst b/Documentation/virt/hyperv/mshv-vtl.rst
new file mode 100644
index 0000000000000..c8038dbdf3ff5
--- /dev/null
+++ b/Documentation/virt/hyperv/mshv-vtl.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+MSHV VTL userspace interface
+============================
+
+The MSHV VTL driver allows a userspace VMM running in VTL2 to manage
+and run a lower VTL.
+
+The ioctls described below operate on a VTL file descriptor returned
+by ``MSHV_CREATE_VTL``.
+
+MSHV_GET_VTL_STATS
+------------------
+
+Return a snapshot of transition counts and timing for one Linux CPU.
+
+Set the ``cpu`` field in ``struct mshv_vtl_stats`` before calling the
+ioctl. All other fields are output. Possible CPUs are accepted even when
+offline. Statistics are shared across VTL file descriptors and accumulate
+for the lifetime of the loaded driver.
+
+.. kernel-doc:: include/uapi/linux/mshv.h
+   :identifiers: mshv_vtl_stats
+
+Accounting
+~~~~~~~~~~
+
+Each lower-VTL switch attempt increments ``entry_count``. Its return to
+VTL2 increments ``exit_count``. Every switch in an in-kernel re-entry loop
+is counted separately. Work or cancellation before a switch does not
+add a transition.
+
+All timestamps and durations use CLOCK_MONOTONIC nanoseconds.
+
+* Lower-VTL intervals run from an entry attempt to its return.
+* VTL2 intervals run from a return to the next entry attempt.
+* Totals and maxima include completed intervals only.
+* The initial VTL2 interval before the first entry is not measured.
+
+The statistics work without tracing. They measure elapsed time,
+including switch overhead and descheduling, not exclusive CPU
+execution time. Only switches made through this driver's x86-64 Hyper-V
+return path are measured. Intervals are not split by target VTL.
+
+There is no reset, histogram, or transition-history buffer. Accounting
+adds two clock reads and short per-CPU critical sections to each switch.
+
+Current interval
+~~~~~~~~~~~~~~~~
+
+The ``state`` field reports the last observed software state:
+
+* UNKNOWN: No switch has been recorded. Do not calculate an interval age.
+* VTL2: Use ``snapshot_ns - last_exit_ns``.
+* LOWER_VTL: Use ``snapshot_ns - last_entry_ns``.
+
+Counts, durations, and transition timestamps are zero before the first
+switch. The state does not prove that the CPU is currently executing in
+that VTL. An offline CPU retains its last recorded statistics.
+
+Errors
+~~~~~~
+
+* ``EINVAL``: The CPU number is outside the possible CPU set.
+* ``EAGAIN``: The statistics are busy. Retry later.
+* ``EFAULT``: The userspace buffer could not be accessed.
+
+Reading another CPU's statistics does not send an IPI to that CPU.
+The per-CPU lock is never held across lower-VTL execution.
+
+Example
+~~~~~~~
+
+Using an existing VTL file descriptor::
+
+    struct mshv_vtl_stats stats = { .cpu = 0 };
+
+    if (ioctl(vtl_fd, MSHV_GET_VTL_STATS, &stats) == -1) {
+        perror("MSHV_GET_VTL_STATS"); /* Retry later on EAGAIN. */
+        return -1;
+    }
+
+    printf("cpu=%u state=%u\n"
+           "entry_count=%llu exit_count=%llu\n"
+           "last_entry_ns=%llu last_exit_ns=%llu\n"
+           "lower_vtl_total_ns=%llu lower_vtl_max_ns=%llu\n"
+           "vtl2_total_ns=%llu vtl2_max_ns=%llu\n"
+           "snapshot_ns=%llu\n",
+           stats.cpu, stats.state,
+           (unsigned long long)stats.entry_count,
+           (unsigned long long)stats.exit_count,
+           (unsigned long long)stats.last_entry_ns,
+           (unsigned long long)stats.last_exit_ns,
+           (unsigned long long)stats.lower_vtl_total_ns,
+           (unsigned long long)stats.lower_vtl_max_ns,
+           (unsigned long long)stats.vtl2_total_ns,
+           (unsigned long long)stats.vtl2_max_ns,
+           (unsigned long long)stats.snapshot_ns);
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 2d4fe24cecbff..1e21380b04355 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -19,6 +19,8 @@
 #include <linux/poll.h>
 #include <linux/rcupdate.h>
 #include <linux/file.h>
+#include <linux/spinlock.h>
+#include <linux/timekeeping.h>
 #include <linux/vmalloc.h>
 #include <asm/debugreg.h>
 #include <asm/mshyperv.h>
@@ -102,7 +104,16 @@ static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
 static union hv_register_vsm_capabilities mshv_vsm_capabilities;
 
 static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
-static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
+
+struct mshv_vtl_cpu_stats {
+	raw_spinlock_t lock;
+	struct mshv_vtl_stats stats;
+};
+
+static DEFINE_PER_CPU(struct mshv_vtl_cpu_stats, mshv_vtl_stats) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(mshv_vtl_stats.lock),
+};
+
 static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
 
 static const union hv_input_vtl input_vtl_zero;
@@ -649,6 +660,36 @@ static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set)
 	return 1;
 }
 
+static void mshv_vtl_record_transition(bool entering)
+{
+	struct mshv_vtl_cpu_stats *cpu_stats = this_cpu_ptr(&mshv_vtl_stats);
+	struct mshv_vtl_stats *stats = &cpu_stats->stats;
+	u64 now, elapsed;
+
+	raw_spin_lock(&cpu_stats->lock);
+	now = ktime_get_ns();
+
+	if (entering) {
+		if (stats->state == MSHV_VTL_STATS_STATE_VTL2) {
+			elapsed = now - stats->last_exit_ns;
+			stats->vtl2_total_ns += elapsed;
+			stats->vtl2_max_ns = max(stats->vtl2_max_ns, elapsed);
+		}
+		stats->entry_count++;
+		stats->last_entry_ns = now;
+		stats->state = MSHV_VTL_STATS_STATE_LOWER_VTL;
+	} else {
+		elapsed = now - stats->last_entry_ns;
+		stats->lower_vtl_total_ns += elapsed;
+		stats->lower_vtl_max_ns = max(stats->lower_vtl_max_ns, elapsed);
+		stats->exit_count++;
+		stats->last_exit_ns = now;
+		stats->state = MSHV_VTL_STATS_STATE_VTL2;
+	}
+
+	raw_spin_unlock(&cpu_stats->lock);
+}
+
 static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
 {
 	struct hv_vp_assist_page *hvp;
@@ -672,7 +713,9 @@ static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
 		       min_t(u32, offset, sizeof(hvp->vtl_ret_actions)));
 	}
 
+	mshv_vtl_record_transition(true);
 	mshv_vtl_return_call(vtl0);
+	mshv_vtl_record_transition(false);
 }
 
 static bool mshv_vtl_process_intercept(void)
@@ -725,7 +768,6 @@ static int mshv_vtl_ioctl_return_to_lower_vtl(void)
 		local_irq_restore(irq_flags);
 
 		hvp = hv_vp_assist_page[smp_processor_id()];
-		this_cpu_inc(num_vtl0_transitions);
 		switch (hvp->vtl_entry_reason) {
 		case MSHV_ENTRY_REASON_INTERRUPT:
 			if (!mshv_vsm_capabilities.intercept_page_available &&
@@ -807,6 +849,29 @@ mshv_vtl_ioctl_set_regs(void __user *user_args)
 	return ret;
 }
 
+static long mshv_vtl_ioctl_get_stats(struct mshv_vtl_stats __user *user_stats)
+{
+	struct mshv_vtl_cpu_stats *cpu_stats;
+	struct mshv_vtl_stats stats;
+	unsigned long flags;
+	u32 cpu;
+
+	if (get_user(cpu, &user_stats->cpu))
+		return -EFAULT;
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
+		return -EINVAL;
+
+	cpu_stats = per_cpu_ptr(&mshv_vtl_stats, cpu);
+	if (!raw_spin_trylock_irqsave(&cpu_stats->lock, flags))
+		return -EAGAIN;
+	stats = cpu_stats->stats;
+	stats.cpu = cpu;
+	stats.snapshot_ns = ktime_get_ns();
+	raw_spin_unlock_irqrestore(&cpu_stats->lock, flags);
+
+	return copy_to_user(user_stats, &stats, sizeof(stats)) ? -EFAULT : 0;
+}
+
 static long
 mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -826,6 +891,9 @@ mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_RETURN_TO_LOWER_VTL:
 		ret = mshv_vtl_ioctl_return_to_lower_vtl();
 		break;
+	case MSHV_GET_VTL_STATS:
+		ret = mshv_vtl_ioctl_get_stats((void __user *)arg);
+		break;
 	case MSHV_ADD_VTL0_MEMORY:
 		ret = mshv_vtl_ioctl_add_vtl0_mem(vtl, (void __user *)arg);
 		break;
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 32ff92b6342b2..a15d6eb3b95ab 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -365,6 +365,40 @@ struct mshv_vtl_set_poll_file {
 	__u32 fd;
 };
 
+#define MSHV_VTL_STATS_STATE_UNKNOWN	0
+#define MSHV_VTL_STATS_STATE_VTL2		1
+#define MSHV_VTL_STATS_STATE_LOWER_VTL	2
+
+/**
+ * struct mshv_vtl_stats - arguments for MSHV_GET_VTL_STATS
+ * @cpu: Input Linux CPU number; all other fields are output.
+ * @state: Last observed MSHV_VTL_STATS_STATE_* software state.
+ * @entry_count: Number of lower-VTL switch attempts.
+ * @exit_count: Number of switch calls that returned to VTL2.
+ * @last_entry_ns: CLOCK_MONOTONIC timestamp of the last entry attempt.
+ * @last_exit_ns: CLOCK_MONOTONIC timestamp of the last return.
+ * @lower_vtl_total_ns: Total duration of completed entry-to-return intervals.
+ * @lower_vtl_max_ns: Maximum duration of a completed entry-to-return interval.
+ * @vtl2_total_ns: Total duration of completed return-to-next-entry intervals.
+ * @vtl2_max_ns: Maximum duration of a completed return-to-next-entry interval.
+ * @snapshot_ns: CLOCK_MONOTONIC timestamp of this snapshot.
+ *
+ * Durations are elapsed nanoseconds, not exclusive CPU execution time.
+ */
+struct mshv_vtl_stats {
+	__u32 cpu;
+	__u32 state;
+	__u64 entry_count;
+	__u64 exit_count;
+	__u64 last_entry_ns;
+	__u64 last_exit_ns;
+	__u64 lower_vtl_total_ns;
+	__u64 lower_vtl_max_ns;
+	__u64 vtl2_total_ns;
+	__u64 vtl2_max_ns;
+	__u64 snapshot_ns;
+};
+
 struct mshv_vtl_hvcall_setup {
 	__u64 bitmap_array_size; /* stores number of bytes */
 	__u64 allow_bitmap_ptr;
@@ -392,6 +426,7 @@ struct mshv_sint_mask {
 #define MSHV_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
 #define MSHV_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
 #define MSHV_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
+#define MSHV_GET_VTL_STATS	_IOWR(MSHV_IOCTL, 0x41, struct mshv_vtl_stats)
 #define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
 #define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
 
-- 
2.43.0

