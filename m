Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255304;
	b=3lnDYQ9/sf2GoENsyiTAw2p/sfYFzwqzfZZmEP3l2Nt8sCzO10qAnvY1HQKmBC/DQ+ui
	 uQbYs3Phfa+Am6EjQUnxTS0QH3E7ulGAMb4L7HB9RgEEjUV28iuugXiQfXInNeiPTNMFs
	 l8w8M+XLb4nR2uCR03cKm/2qhBLWodOllGAb/lS7Pk4gUDQU6/o/IKv9NpoWdnW/euGZ0
	 Q/0KVJHyyMh8vhGomqpwLssxnu6mp2F0qNlUfgvacIi8h+sbABzU7tbZ27d/puA4LVfcu
	 Kcawv2q7tKcNyoyVi73oyNgj5HSNBNrDBUN8wynyahWc/oSxd50aqAxPQR0gFEiqofg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255304;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O9z+VTdTqEa82imXMe709oq11pFPy29dib7ICq/Ie40=;
	b=IAwNStBbBzEzIJdxH57zUNwd8i6rNYOJ0Dgz7a4Rf8JzJr6Mu4d2ALOKvT8naobQkXbI
	 YxWD/XxJNFSN1IySTXgCooDxho1mKogyS2pAOE1BsaTCZtwdadBHB11I2e4KwdXNcd/Jy
	 A/vvAr0hXhMS88NmpYPFsDgENpC8WN7lamNPUdA4Zv0/ckdoif4m026qXWiv1nQrOpGYH
	 CznEMjdIlU044behaRfb2RKssLO8YFsFM6L64xUr8gFczJTNIzax8HAKCOSuiVHxB0omU
	 NNU7rPQG2gkgovCWPmPuaGXFQmYYASTyyecjdG4nXEnXB4DjxOk+Z9iGsFCzAFkPaPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6tIJOKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22F606A320;
	Thu, 29 Oct 2026 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6tIJOKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2896B1F01825;
	Thu, 29 Oct 2026 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793255304;
	bh=O9z+VTdTqEa82imXMe709oq11pFPy29dib7ICq/Ie40=;
	h=From:To:Cc:Subject:Date;
	b=W6tIJOKKCEe7K1cQtw50GoVo4KV2wGtZUcqq/AnMlk7mNPXTS/sYWP2XUb3FGsDwZ
	 wi0j5VrMK/pdUtFPjtqmLB7nBXiqhe2GhBDcZEkH0rTtpRZqdYVdn7ipNF1WzGNhOS
	 0GV/SgjIDNSH7YTAnujDNeAbtCWrEoiY2mVtB5kutX/eqkMyrkSk83dsAE/Gy3y+dE
	 d5leBP7KMOJehnhnR1IIxRcPC2Q2e0TiSuEbppu++VRZyrBwlevB80d/6+ANVWg747
	 3MnS3eWrhbL3Zrrtw3yFXBshd0yks1cv0mxvIITWIGJlM2CW6NkmGLzTAWATjdZnWZ
	 BUPRlXrZo3boQ==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	dblanzeanu@linux.microsoft.com,
	John Starks <jostarks@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mshv: Add an ioctl to scrub partition state
Date: Wed, 28 Oct 2026 23:27:54 -0700
Message-ID: <20261029062801.28598-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: John Starks <jostarks@microsoft.com>

Userspace VMMs need to reset a child partition's hypervisor-managed state
without destroying its VPs or rebuilding its memory and eventfd
registrations. Exposing HvCallScrubPartition through generic hypercall
passthrough would bypass the synchronization and cached-state updates
needed by the driver.

Add MSHV_SCRUB_PARTITION as a no-argument partition-fd ioctl. Hold the
partition mutex and try-lock each populated VP mutex in index order,
using the partition mutex as the lockdep nesting lock. Return -EBUSY
without issuing the hypercall if a VP is busy. This excludes VP ioctls
without waiting indefinitely for a running VP; userspace must stop its
run threads before requesting scrub.

After a successful scrub, clear cached intercept suspend so the next run
clears explicit suspend rather than trying to consume a stale intercept.
Preserve deferred blocked waits and notification accounting: a VP becoming
dispatchable does not imply its host notification has already arrived.
Keep the locks through this update and unwind them on every exit.

Scrub is nonallocating, so issue one fast hypercall, trace its status and
return the existing errno translation. Let the hypervisor determine which
partition configurations support scrub. Device quiescing and restoring
guest execution state remain userspace responsibilities.

Signed-off-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>

---
Tested repeated scrub/run, sparse and 64-VP locking, busy unwinding,
interrupted blocked runs, concurrent memory invalidation and irqfd
activity on x86-64, and delayed notifications with separate diagnostic
instrumentation. The affected ARM64 objects compile. ARM64 runtime and
hypervisor scheduling remain untested. Doorbell delivery across scrub
works, but exposes an existing eventfd hardirq wait-context warning under
lockdep, separate from this change.

GitHub Copilot generated the implementation and test probes, investigated
locking and notification handling, ran builds and Incubator tests, and
drafted this description. Human review selected the dedicated ioctl and
try-lock policy and corrected the nonallocating hypercall contract.
---
 drivers/hv/mshv_root.h         |  1 +
 drivers/hv/mshv_root_hv_call.c | 11 ++++++++
 drivers/hv/mshv_root_main.c    | 50 ++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_trace.h        | 17 ++++++++++++
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk.h         |  4 +++
 include/uapi/linux/mshv.h      | 11 ++++++++
 7 files changed, 95 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..0c89d47c3ab5 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -279,6 +279,7 @@ int hv_call_create_partition(u64 flags,
 			     union hv_partition_isolation_properties isolation_properties,
 			     u64 *partition_id);
 int hv_call_initialize_partition(u64 partition_id);
+int hv_call_scrub_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
 int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..8ab99f1afeed 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -161,6 +161,17 @@ int hv_call_initialize_partition(u64 partition_id)
 	return ret;
 }
 
+int hv_call_scrub_partition(u64 partition_id)
+{
+	u64 status;
+
+	status = hv_do_fast_hypercall8(HVCALL_SCRUB_PARTITION, partition_id);
+
+	trace_mshv_hvcall_scrub_partition(partition_id, status);
+
+	return hv_result_to_errno(status);
+}
+
 int hv_call_finalize_partition(u64 partition_id)
 {
 	struct hv_input_finalize_partition input;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..9f21855b8518 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1648,6 +1648,53 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	return ret;
 }
 
+static int mshv_partition_ioctl_scrub(struct mshv_partition *partition)
+{
+	unsigned int i, vps_locked = 0;
+	int ret;
+
+	lockdep_assert_held(&partition->pt_mutex);
+
+	/*
+	 * Run ioctls may wait indefinitely. Userspace must stop its run
+	 * threads; never wait for a VP while holding the others. The
+	 * partition mutex stabilizes even a sparse VP array.
+	 */
+	for (; vps_locked < MSHV_MAX_VPS; vps_locked++) {
+		struct mshv_vp *vp = partition->pt_vp_array[vps_locked];
+
+		if (vp && !mutex_trylock_nest_lock(&vp->vp_mutex,
+						  &partition->pt_mutex)) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+	}
+
+	ret = hv_call_scrub_partition(partition->pt_id);
+	if (ret)
+		goto unlock;
+
+	/*
+	 * Scrub clears intercept suspend and sets explicit suspend.
+	 * Retain deferred waits and lifetime notification accounting.
+	 */
+	for (i = 0; i < MSHV_MAX_VPS; i++) {
+		struct mshv_vp *vp = partition->pt_vp_array[i];
+
+		if (vp)
+			vp->run.flags.intercept_suspend = 0;
+	}
+
+unlock:
+	while (vps_locked) {
+		struct mshv_vp *vp = partition->pt_vp_array[--vps_locked];
+
+		if (vp)
+			mutex_unlock(&vp->vp_mutex);
+	}
+	return ret;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -1662,6 +1709,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_INITIALIZE_PARTITION:
 		ret = mshv_partition_ioctl_initialize(partition);
 		break;
+	case MSHV_SCRUB_PARTITION:
+		ret = mshv_partition_ioctl_scrub(partition);
+		break;
 	case MSHV_SET_GUEST_MEMORY:
 		ret = mshv_partition_ioctl_set_memory(partition, uarg);
 		break;
diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
index e7280c47e579..9f6d9e67d987 100644
--- a/drivers/hv/mshv_trace.h
+++ b/drivers/hv/mshv_trace.h
@@ -71,6 +71,23 @@ TRACE_EVENT(mshv_hvcall_initialize_partition,
 	    )
 );
 
+TRACE_EVENT(mshv_hvcall_scrub_partition,
+	    TP_PROTO(u64 partition_id, u64 status),
+	    TP_ARGS(partition_id, status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu status=%#llx",
+		    __entry->partition_id,
+		    __entry->status
+	    )
+);
+
 TRACE_EVENT(mshv_partition_release,
 	    TP_PROTO(u64 partition_id),
 	    TP_ARGS(partition_id),
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..c0172699b145 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -478,6 +478,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
 #define HVCALL_ENTER_SLEEP_STATE			0x0084
 #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
+#define HVCALL_SCRUB_PARTITION				0x008d
 #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
 #define HVCALL_CREATE_PORT				0x0095
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 0c89c62c9706..d0043860693c 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -369,6 +369,10 @@ struct hv_input_delete_partition {
 	u64 partition_id;
 } __packed;
 
+struct hv_input_scrub_partition {
+	u64 partition_id;
+} __packed;
+
 struct hv_input_get_partition_property {
 	u64 partition_id;
 	u32 property_code; /* enum hv_partition_property_code */
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 32ff92b6342b..7681e3c73a7a 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -255,6 +255,17 @@ struct mshv_root_hvcall {
 /* Generic hypercall */
 #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
 
+/*
+ * Scrub a partition's guest state; takes no arguments.
+ * Stop all VP run threads first: a busy VP causes -EBUSY without issuing
+ * the hypercall. On success, the VPs are explicitly suspended.
+ *
+ * Kernel resource registrations and VP fd/mmap lifetimes are preserved.
+ * Userspace must quiesce its devices and restore guest execution state.
+ * Failure does not imply successful reset or guaranteed rollback.
+ */
+#define MSHV_SCRUB_PARTITION	_IO(MSHV_IOCTL, 0x0B)
+
 /*
  ********************************
  * VP APIs for child partitions *
-- 
2.53.0

