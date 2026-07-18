Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2C1DF73A;
	Sat, 18 Jul 2026 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341227; cv=none; b=ArOyGD0RNXNiDYlN8a9RyaLqL2hmbE0raKaFVjJ3nnSAFeOmvYuiXuKh85mVT4Ieop5kXO5lwOOMSDFDkyOLikRW/T3/6bamDTyVzHfzD/Jyg+ajYGAL8iwlhMZvj5ml02Yppx56hIOkdLYa1ew/9Ylr4Yi/8MOyf45bJs72th0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341227; c=relaxed/simple;
	bh=jyU2w0jeFYELp815bsCTGQ+aognhy4mbcl5lWzjtNb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZdKWqFcI+cMJ/6t1qa1i5IsreMfN5UFycFKjLZL4CXz8az3dbbOve7glqnr6+VpJmBlTuqM6udPtN0JKNvXCgCSUXXoxF2zNzGnI5OAE67iF1IJyMFFanHXmO6FOm5PXWsOFfbwf6YJYTGWQy8r8rIj8Z2xGYmXcejs34aQ1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SkUKF79B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SkUKF79B"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 399EF20B7170;
	Fri, 17 Jul 2026 19:20:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 399EF20B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784341211;
	bh=l8wD5Vo36bk7TEZt0YFS7oU60KHn/BuclqHBWIjSUh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkUKF79B8bnHuYly2t8ucM7V+JDRfxf3QLVRQNlgwTAqTX1SrSbRuCzMYt98H4oP8
	 lzcyB3x+Fkom1XfZZ7qAu4K+vTql8QrzoM0EP2SCl5Is7oNVL3WN3W5qhf/ynLEFz7
	 JvVV8kM82NjZQE6Ql6iTQmuC6HGDB57PLm9rhHlc=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V4 9/9] mshv: Disable movable regions upfront if device passthru
Date: Fri, 17 Jul 2026 19:19:49 -0700
Message-ID: <20260718021949.926306-10-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260718021949.926306-1-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a VM is started with device attached, the mem regions must be marked
non-movable as the device attach hypercall right away allows the use of
SLAT for IOMMU. Marking them non-movable forces mapping of the entire
guest RAM in the SLAT at the time of region creation along with the region
pinned. Also, because a device could be dynamically attached much later
in a VM, create a boot parameter to allow a user to pin them upfront
if they anticipate such an action. It is understood that VFIO pins the
regions also, so there will be double pinning. This will be enhanced in
the near future with a third region type that is not movable nor pinned.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      |  1 +
 drivers/hv/mshv_root_main.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index c97a1b5da9ad..0282f489ad90 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -141,6 +141,7 @@ struct mshv_partition {
 	pid_t pt_vmm_tgid;
 	bool import_completed;
 	bool pt_initialized;
+	bool pt_regions_pinned;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *pt_stats_dentry;
 	struct dentry *pt_vp_dentry;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 6bce4123c5ff..d7cc131652af 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -46,6 +46,10 @@ MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 #define HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED 95
 #endif
 
+static uint hv_memreg;  /* mshv_mem_region allocations type */
+module_param(hv_memreg, uint, 0644);
+MODULE_PARM_DESC(hv_memreg, "0: movable (default), 1: pinned");
+
 struct mshv_root mshv_root;
 
 enum hv_scheduler_type hv_scheduler_type;
@@ -1293,6 +1297,12 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
 	*status = partition->async_hypercall_status;
 }
 
+static bool mshv_do_pt_regions_pinned(struct mshv_partition *pt)
+{
+	return pt->pt_regions_pinned || mshv_partition_encrypted(pt) ||
+	       hv_memreg == 1;
+}
+
 /*
  * NB: caller checks and makes sure mem->size is page aligned
  * Returns: 0 with regionpp updated on success, or -errno
@@ -1323,7 +1333,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 
 	if (is_mmio)
 		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
-	else if (mshv_partition_encrypted(partition) ||
+	else if (mshv_do_pt_regions_pinned(partition) ||
 		 !mshv_region_movable_init(rg))
 		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
 	else
@@ -1801,6 +1811,9 @@ static long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
 	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
 		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
 
+	/* For now, just mark regions pinned if there is device passthru. */
+	partition->pt_regions_pinned = true;
+
 	return 0;
 
 undo_out:
-- 
2.51.2.vfs.0.1

