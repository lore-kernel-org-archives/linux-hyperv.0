Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC24D0A02;
	Fri, 25 Sep 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363288; cv=none; b=bucZSbWBscrNDh1DevGogKKJyrAvsewxF8gGlEJVDKL6QLRZAQoevvz6hoE6Cpi9nprgk91IPKitTMPMP1PxFftkrXDliXq40wGBL66TrPUQcKuiuNq3OBy54E4WqYq6LzuGOIy4oGgNpJb4TfOos/+62IZfQI16UrREKoQCdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363288; c=relaxed/simple;
	bh=5X+mnxBQNb7I64OfqLtrW/sJn+mW48nbnX0Azou/8VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3agZ5Vr6sM+N3CiL9CLI+Qp4il2O7bW3GX1PHE1uK8JCiUeDZI4jXjqyUHWqpS5Piuf90OwsZsX0dpJDxLnBZyq2KojWTe8SCRUSn9fY9wCv4bsjjjhFuEiIhDHXjj7Au3VZ0q3xqEyLU16mKIK8NoJdkGfvlv9b6FIfp2WtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JW89HmnN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JW89HmnN"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5658220B716D;
	Fri, 25 Sep 2026 12:06:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5658220B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363218;
	bh=BoBzNlrsUGm3UP4I+pr45MrOD+dOEKC2c0VOt7Ua8iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JW89HmnNVbc1O1+5CXVHTfb//SFPZ83PF7JViOXnPPgYvIM7YsVq6NXKAemYdoPKW
	 PUA0F2fV3SiSWAYJH4SCWB9BH+muJyayHz+3EHva/wXSVKyM2rCtv/Fr3HfgLNodHG
	 pYsTrChkbUA+e6+ackhGwGbmP03ZlsGLay/ZW2aM=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH RFC 5/9] mshv: Add partition file identity helper
Date: Fri, 25 Sep 2026 12:07:38 -0700
Message-ID: <20260925190742.1575380-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a helper to derive the immutable MSHV partition ID from a
partition file. IOMMU drivers can use this to bind a vIOMMU to the
partition object represented by a userspace fd instead of relying on
current-task lookup.

Keep the public helper in built-in Hyper-V common code and let the MSHV
root driver register the partition-file callbacks. This lets built-in
IOMMU callers avoid symbol_get() when MSHV_ROOT is built as a module.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/hv/hv_common.c         | 69 ++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root_main.c    | 36 +++++++++++++++++-
 include/asm-generic/mshyperv.h | 35 +++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 31256cb22b39..d259cb833376 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
+#include <linux/fs.h>
 #include <linux/sched/task_stack.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
@@ -24,6 +25,7 @@
 #include <linux/efi.h>
 #include <linux/kdebug.h>
 #include <linux/kmsg_dump.h>
+#include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
@@ -37,6 +39,73 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
 enum hv_partition_type hv_curr_partition_type;
 EXPORT_SYMBOL_GPL(hv_curr_partition_type);
 
+static DEFINE_MUTEX(mshv_partition_file_ops_lock);
+static const struct mshv_partition_file_ops *mshv_partition_file_ops;
+
+int mshv_partition_file_ops_register(const struct mshv_partition_file_ops *ops)
+{
+	int ret = 0;
+
+	if (!ops || !ops->file_is_partition || !ops->get_partid)
+		return -EINVAL;
+
+	mutex_lock(&mshv_partition_file_ops_lock);
+	if (mshv_partition_file_ops)
+		ret = -EBUSY;
+	else
+		mshv_partition_file_ops = ops;
+	mutex_unlock(&mshv_partition_file_ops_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshv_partition_file_ops_register);
+
+void
+mshv_partition_file_ops_unregister(const struct mshv_partition_file_ops *ops)
+{
+	mutex_lock(&mshv_partition_file_ops_lock);
+	if (mshv_partition_file_ops == ops)
+		mshv_partition_file_ops = NULL;
+	mutex_unlock(&mshv_partition_file_ops_lock);
+}
+EXPORT_SYMBOL_GPL(mshv_partition_file_ops_unregister);
+
+bool file_is_mshv_partition(struct file *file)
+{
+	const struct mshv_partition_file_ops *ops;
+	bool ret = false;
+
+	if (!file)
+		return false;
+
+	mutex_lock(&mshv_partition_file_ops_lock);
+	ops = mshv_partition_file_ops;
+	if (ops)
+		ret = ops->file_is_partition(file);
+	mutex_unlock(&mshv_partition_file_ops_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(file_is_mshv_partition);
+
+u64 mshv_partition_file_get_partid(struct file *file)
+{
+	const struct mshv_partition_file_ops *ops;
+	u64 ret = HV_PARTITION_ID_INVALID;
+
+	if (!file)
+		return HV_PARTITION_ID_INVALID;
+
+	mutex_lock(&mshv_partition_file_ops_lock);
+	ops = mshv_partition_file_ops;
+	if (ops && ops->file_is_partition(file))
+		ret = ops->get_partid(file);
+	mutex_unlock(&mshv_partition_file_ops_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshv_partition_file_get_partid);
+
 /*
  * ms_hyperv and hv_nested are defined here with other
  * Hyper-V specific globals so they are shared across all architectures and are
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 8b31e3948c09..838ea6397c9f 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2160,6 +2160,33 @@ u64 mshv_current_partid(void)
 }
 EXPORT_SYMBOL_GPL(mshv_current_partid);
 
+static bool mshv_partition_file_is_valid(struct file *file)
+{
+	if (!file)
+		return false;
+
+	if (file->f_op == &mshv_partition_fops)
+		return true;
+
+	return false;
+}
+
+static u64 mshv_partition_file_get_partid_impl(struct file *file)
+{
+	if (file->f_op == &mshv_partition_fops) {
+		struct mshv_partition *partition = file->private_data;
+
+		return partition ? partition->pt_id : HV_PARTITION_ID_INVALID;
+	}
+
+	return HV_PARTITION_ID_INVALID;
+}
+
+static const struct mshv_partition_file_ops mshv_partition_file_ops = {
+	.file_is_partition = mshv_partition_file_is_valid,
+	.get_partid = mshv_partition_file_get_partid_impl,
+};
+
 static int
 add_partition(struct mshv_partition *partition)
 {
@@ -2599,10 +2626,14 @@ static int __init mshv_parent_partition_init(void)
 	if (hv_get_hypervisor_version(&version_info))
 		return -ENODEV;
 
-	ret = misc_register(&mshv_dev);
+	ret = mshv_partition_file_ops_register(&mshv_partition_file_ops);
 	if (ret)
 		return ret;
 
+	ret = misc_register(&mshv_dev);
+	if (ret)
+		goto unregister_file_ops;
+
 	dev = mshv_dev.this_device;
 
 	if (version_info.build_number < MSHV_HV_MIN_VERSION ||
@@ -2652,6 +2683,8 @@ static int __init mshv_parent_partition_init(void)
 	mshv_synic_exit();
 device_deregister:
 	misc_deregister(&mshv_dev);
+unregister_file_ops:
+	mshv_partition_file_ops_unregister(&mshv_partition_file_ops);
 	return ret;
 }
 
@@ -2661,6 +2694,7 @@ static void __exit mshv_parent_partition_exit(void)
 	mshv_port_table_fini();
 	mshv_debugfs_exit();
 	misc_deregister(&mshv_dev);
+	mshv_partition_file_ops_unregister(&mshv_partition_file_ops);
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
 	mshv_synic_exit();
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c7258cd72a89..ed7ab21d68a2 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -401,6 +401,41 @@ static inline u64 mshv_current_partid(void)
 }
 #endif /* CONFIG_MSHV_ROOT */
 
+struct file;
+struct mshv_partition_file_ops {
+	bool (*file_is_partition)(struct file *file);
+	u64 (*get_partid)(struct file *file);
+};
+
+#if IS_ENABLED(CONFIG_HYPERV)
+int mshv_partition_file_ops_register(const struct mshv_partition_file_ops *ops);
+void
+mshv_partition_file_ops_unregister(const struct mshv_partition_file_ops *ops);
+bool file_is_mshv_partition(struct file *file);
+u64 mshv_partition_file_get_partid(struct file *file);
+#else
+static inline int
+mshv_partition_file_ops_register(const struct mshv_partition_file_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+mshv_partition_file_ops_unregister(const struct mshv_partition_file_ops *ops)
+{
+}
+
+static inline bool file_is_mshv_partition(struct file *file)
+{
+	return false;
+}
+
+static inline u64 mshv_partition_file_get_partid(struct file *file)
+{
+	return HV_PARTITION_ID_INVALID;
+}
+#endif
+
 static inline int hv_deposit_memory(u64 partition_id, u64 status)
 {
 	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
-- 
2.43.0

