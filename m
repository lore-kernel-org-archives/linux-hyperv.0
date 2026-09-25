Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AB4C6EFC;
	Fri, 25 Sep 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363288; cv=none; b=rXuaR16e3yyZJ19IKpWsRXwx5kk49UhwvQJswom18oL5Wv5QyDIMtKBuZE3GGBj7OzutF0KL2VbREPwapsVhiM0miRiIE6xI8e73OQVfeIo5h8TPJJXQvLtnaE16T28aHNWh+7L2Bk8X16hvlyGLbhaAa6sCcKoKW0to4+ib5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363288; c=relaxed/simple;
	bh=bYRHyoNZS5V0rKxLP8o3T7TsUkjuDA5Z/rh07b2zojc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgT67vLYjxPAkdsoeoSekZF3hR/aEYA5qjxv18W0Hm3pnQ8sV8YoUppj5RTARi8PVZLYOGhBPqGJbhaZVUpkocclElPoUDEj7vwDBwe59EX2kaCkAjn5jP4hOxp692XCmq13wYKj/GGrfyOzqvBX2tGWC05ZnVY2wBM3m8foO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bY2ERHF/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bY2ERHF/"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0BD4620B716E;
	Fri, 25 Sep 2026 12:06:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BD4620B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363219;
	bh=L1s97NRSfTsYmPGyRHyQ3MxhO0Su/Io/Yxtd1xKiBC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY2ERHF/hHk/QDQOf7kQommbAS0CQLVMYjdxRMou0RCNlf560ubA16tlNwFrPH2c0
	 svUbDLZ21NgvC7JvWSHy2HgPptiE0KZQQr/Cye3xo34cjCW8i7JVKEeXxfbzvXKPyV
	 Du8VUEdS0XwCoCWvp2Kql2+xY7EQcz2X7QB6c/CY=
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
Subject: [PATCH RFC 6/9] mshv: Add prepare callback for external device attach
Date: Fri, 25 Sep 2026 12:07:39 -0700
Message-ID: <20260925190742.1575380-7-jacob.pan@linux.microsoft.com>
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

Unlike VFIO/IOMMUFD paging domains, external attach bypasses the DMA
map flow that pins mapped memory. The ownership model is also different
for MSHV external attach: MSHV, as the L0 hypervisor, owns address
translation and DMA fault handling.

Guest memory must therefore be pinned through the MSHV/userspace VMM
contract before it is mapped for DMA, rather than by the VFIO/IOMMUFD
pin-and-map flow.

Add a partition-file prepare_attach callback that lets MSHV apply its
guest-memory pinning policy and perform any other preparation required
before an external device is attached. A later external-domain patch
invokes the callback through the vIOMMU-held VM file.

The per-region conversion helper is intentionally left as a stub for
this RFC to show where MSHV will pin guest memory.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/hv/hv_common.c         | 24 ++++++++++++++++++++++-
 drivers/hv/mshv_regions.c      |  6 ++++++
 drivers/hv/mshv_root.h         |  1 +
 drivers/hv/mshv_root_main.c    | 35 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  7 +++++++
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index d259cb833376..7acea1bceae1 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -46,7 +46,8 @@ int mshv_partition_file_ops_register(const struct mshv_partition_file_ops *ops)
 {
 	int ret = 0;
 
-	if (!ops || !ops->file_is_partition || !ops->get_partid)
+	if (!ops || !ops->file_is_partition || !ops->get_partid ||
+	    !ops->prepare_attach)
 		return -EINVAL;
 
 	mutex_lock(&mshv_partition_file_ops_lock);
@@ -106,6 +107,27 @@ u64 mshv_partition_file_get_partid(struct file *file)
 }
 EXPORT_SYMBOL_GPL(mshv_partition_file_get_partid);
 
+int mshv_partition_file_prepare_attach(struct file *file)
+{
+	const struct mshv_partition_file_ops *ops;
+	int ret = -EOPNOTSUPP;
+
+	if (!file)
+		return -EINVAL;
+
+	mutex_lock(&mshv_partition_file_ops_lock);
+	ops = mshv_partition_file_ops;
+	if (ops && ops->file_is_partition(file))
+		ret = 0;
+	mutex_unlock(&mshv_partition_file_ops_lock);
+
+	if (!ret)
+		ret = ops->prepare_attach(file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshv_partition_file_prepare_attach);
+
 /*
  * ms_hyperv and hv_nested are defined here with other
  * Hyper-V specific globals so they are shared across all architectures and are
diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index dddaade31b5d..b98e5c3e7819 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -324,6 +324,12 @@ int mshv_region_pin(struct mshv_mem_region *region)
 	return ret < 0 ? ret : -ENOMEM;
 }
 
+int mshv_region_make_pinned(struct mshv_mem_region *region)
+{
+	/* Guest-memory pin conversion is not implemented in this RFC. */
+	return 0;
+}
+
 static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				   u32 flags,
 				   u64 page_offset, u64 page_count,
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index d57c26950203..d0f3a28abb3b 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -393,6 +393,7 @@ int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
+int mshv_region_make_pinned(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
 int mshv_region_get(struct mshv_mem_region *region);
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 838ea6397c9f..fb422ed23662 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2182,9 +2182,44 @@ static u64 mshv_partition_file_get_partid_impl(struct file *file)
 	return HV_PARTITION_ID_INVALID;
 }
 
+static int mshv_partition_file_prepare_attach_impl(struct file *file)
+{
+	struct mshv_mem_region *region;
+	struct mshv_partition *partition;
+	int ret = 0;
+
+#if IS_ENABLED(CONFIG_IOMMUFD_TEST)
+	if (file->f_op == &mshv_fake_partition_fops)
+		return 0;
+#endif
+	if (file->f_op != &mshv_partition_fops)
+		return -EINVAL;
+
+	partition = file->private_data;
+	if (!partition)
+		return -EINVAL;
+
+	mutex_lock(&partition->pt_mutex);
+	if (partition->pt_regions_pinned)
+		goto out_unlock;
+
+	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+		ret = mshv_region_make_pinned(region);
+		if (ret)
+			goto out_unlock;
+	}
+
+	partition->pt_regions_pinned = true;
+
+out_unlock:
+	mutex_unlock(&partition->pt_mutex);
+	return ret;
+}
+
 static const struct mshv_partition_file_ops mshv_partition_file_ops = {
 	.file_is_partition = mshv_partition_file_is_valid,
 	.get_partid = mshv_partition_file_get_partid_impl,
+	.prepare_attach = mshv_partition_file_prepare_attach_impl,
 };
 
 static int
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ed7ab21d68a2..6af793444a4b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -405,6 +405,7 @@ struct file;
 struct mshv_partition_file_ops {
 	bool (*file_is_partition)(struct file *file);
 	u64 (*get_partid)(struct file *file);
+	int (*prepare_attach)(struct file *file);
 };
 
 #if IS_ENABLED(CONFIG_HYPERV)
@@ -413,6 +414,7 @@ void
 mshv_partition_file_ops_unregister(const struct mshv_partition_file_ops *ops);
 bool file_is_mshv_partition(struct file *file);
 u64 mshv_partition_file_get_partid(struct file *file);
+int mshv_partition_file_prepare_attach(struct file *file);
 #else
 static inline int
 mshv_partition_file_ops_register(const struct mshv_partition_file_ops *ops)
@@ -434,6 +436,11 @@ static inline u64 mshv_partition_file_get_partid(struct file *file)
 {
 	return HV_PARTITION_ID_INVALID;
 }
+
+static inline int mshv_partition_file_prepare_attach(struct file *file)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline int hv_deposit_memory(u64 partition_id, u64 status)
-- 
2.43.0

