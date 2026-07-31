Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564C3815F0;
	Fri, 31 Jul 2026 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537300; cv=none; b=klReMKF9Myp/WzNpBaf2JlFlUhZWHdOU7rWCZSTxI44qlywGQp0/Cr9XqNbgejJA8cybzxgHXB2NN3NwBubSgmNvTwUGMKvIGxCrqFWaVDzUhFW+hBATIQNFIj5FPAnWciPeKtBLQhdqY4Z3uJn7QFQi1iMHtJzeQY1Lnq+ic2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537300; c=relaxed/simple;
	bh=Fieq2+CcBIpYuNMICZgtEYSYF55oNOQl/qvmFkWtLBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEHvzO+E4eth86Be8gchuR8dFcEUplCqt491L7W1D06BOoPtXuvz31LUXLdVVDmGYz9G0NCVndSmKVPvUiZ8dIn8S4OpcQoSX5FY9cat9O0ab689bHAliCpz1suGSX9n+IoMfC+y0iVmrH7ZgmnYmUerIa9jueJh2/VAfwuRmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xh4nwk4D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xh4nwk4D"
Received: from mrdev.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 422AE20B7167;
	Fri, 31 Jul 2026 15:34:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 422AE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785537280;
	bh=+MSRPstDoMUEReU7MiOeICHeAj4r3vsTAnoy3+ct7U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xh4nwk4DK2x8VH/H4vXiId4BeeT5Z49owcdGxmhYmW2qoZ90NfjvK9i5ddZJGOVJn
	 b64XOgcWgbLAILYr6GzdYxWaJ/eEqQnr2QDkY9NVD8cX7L3fjnVFB28Ts8RJSd/qHU
	 Orb+4BUQhssJxMliUF4IYniS/DQZSEO4GcgVTkKc=
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
Cc: jgg@nvidia.com,
	kys@microsoft.com,
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
Subject: [PATCH v5 9/9] mshv: Disable movable regions upfront if device passthru
Date: Fri, 31 Jul 2026 15:34:27 -0700
Message-ID: <20260731223427.2554388-10-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
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
in a VM, create a module parameter to allow a user to pin them upfront
if they anticipate such an action. It is understood that VFIO pins the
regions also, so there will be double pinning. This will be enhanced in
the near future with a third region type that is not movable nor pinned.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      |  1 +
 drivers/hv/mshv_root_main.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 2ef781cf8e83..f5747c43ad82 100644
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
index 14a640750ccf..e24b44051456 100644
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
@@ -1302,6 +1306,12 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
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
@@ -1332,7 +1342,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 
 	if (is_mmio)
 		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
-	else if (mshv_partition_encrypted(partition) ||
+	else if (mshv_do_pt_regions_pinned(partition) ||
 		 !mshv_region_movable_init(rg))
 		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
 	else
@@ -1818,6 +1828,9 @@ static long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
 	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
 		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
 
+	/* For now, just mark regions pinned if there is device passthru. */
+	partition->pt_regions_pinned = true;
+
 	return 0;
 
 undo_out:
-- 
2.51.2.vfs.0.1

