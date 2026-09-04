Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFA3EAC71;
	Fri,  4 Sep 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508552; cv=none; b=fsKxKrYljmUYJuT17IQ2U/Q2zgogrUpn6hVsgy9gt43+eXaJyeqIjROwclXt5ncHwIAlUR/M2juLTDSQdMXPbVJ0jEKtUdRXyQ9c3IPn7aWEUBAmEVR/6KcHciX7nbAwbFuykjGDHF317nL4lYnpId2DO/WEgX1eQfZPIn4X1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508552; c=relaxed/simple;
	bh=7ZcwQtLb/gts2AMOOqkxAEZ0EJHDfW2sUMB8C6HDCdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKRMeoyRhYHm9TbuwkVZFJ5fuOhcfppZxJ+dBrwrgj3L0wfrTVdHPa+fbTfJOtdzZuV31phNgPh6c1UKhDmt6/p/cNVHLesmWxnOni+PVSP/ZiAjQlIglBoGQANWGzmiNwtjRIe9z645g2ktF/2opO3AJviYNcGc6q27U2DKzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ddqD6yBc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ddqD6yBc"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3344920B7136;
	Fri,  4 Sep 2026 00:55:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3344920B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788508513;
	bh=6WJheD3Cd5YqDfkLzmyJu2QuITfgVn7AXl1MZmTh0ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddqD6yBcyypqAZcMJ2vIO+OtrRrAXICrVeaAsH5zmm63eJyWj3PqXJpeOaGPnRoxJ
	 BdGyGtR3MvpK54Fal1rDqDedWsy9tV0oHHmNjgooWq54V1TNmDtMeYL0S7wJC2guTQ
	 yBFskgJMprvG5ZYmVulMHzu/4cdaU2xiEOENP/Cc=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	arnd@arndb.de,
	jgg@ziepe.ca,
	mhklinux@outlook.com,
	jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: [PATCH v5 5/5] iommu/hyperv: Add page-selective IOTLB flush support
Date: Fri,  4 Sep 2026 15:55:12 +0800
Message-ID: <20260904075512.174154-6-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
This hypercall accepts a list of (page_number, page_mask_shift) entries,
enabling finer-grained IOTLB invalidation compared to the domain-wide
HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().

hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
range that covers the target IOVA region, producing a single flush
descriptor. This may over-flush when the range is not naturally aligned,
matching the approach used by Intel VT-d PSI. If the page-selective
flush fails, the code falls back to a full domain flush.

Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 74 ++++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h           |  1 +
 include/hyperv/hvhdk_mini.h           | 18 +++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index 137f232d74fe..13eb85b4a424 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -384,11 +384,82 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	hv_flush_device_domain(to_hv_iommu_domain(domain));
 }
 
+/*
+ * Calculate the minimal power-of-two aligned range that covers [start, end]
+ * (end is inclusive). Returns a single (page_number, page_mask_shift)
+ * descriptor that may over-flush when the range is not naturally aligned.
+ */
+static void
+hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
+			  union hv_iommu_flush_va *va)
+{
+	unsigned long aligned_start;
+	unsigned int sz_lg2;
+
+	sz_lg2 = max(fls_long(start ^ end), HV_HYP_PAGE_SHIFT);
+
+	/*
+	 * A valid IOVA range shall not span bit 63. Use the maximum mask
+	 * so the host can safely perform a full flush.
+	 */
+	if (WARN_ON_ONCE(sz_lg2 == BITS_PER_LONG))
+		aligned_start = 0;
+	else
+		aligned_start =
+			start & GENMASK(BITS_PER_LONG - 1, sz_lg2);
+
+	va->page_number = aligned_start >> HV_HYP_PAGE_SHIFT;
+	va->page_mask_shift = sz_lg2 - HV_HYP_PAGE_SHIFT;
+}
+
+static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domain,
+					struct iommu_iotlb_gather *iotlb_gather)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_flush_device_domain_list *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	/* Clear the fixed header and the single range entry. */
+	memset(input, 0, struct_size(input, iova_list, 1));
+
+	input->device_domain = hv_domain->device_domain;
+	input->flags |= HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
+	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
+				  &input->iova_list[0]);
+
+	status = hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
+				     1, 0, input, NULL);
+
+	if (WARN_ONCE(!hv_result_success(status),
+		      "HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed: %#llx (%s)\n",
+		      status, hv_result_to_string(status))) {
+		/* Page-selective flush failed, fall back to full flush. */
+		struct hv_input_flush_device_domain *flush_all = (void *)input;
+
+		memset(flush_all, 0, sizeof(*flush_all));
+		flush_all->device_domain = hv_domain->device_domain;
+		status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
+					 flush_all, NULL);
+		WARN(!hv_result_success(status),
+		     "HVCALL_FLUSH_DEVICE_DOMAIN fallback also failed: %#llx (%s)\n",
+		     status, hv_result_to_string(status));
+	}
+
+	local_irq_restore(flags);
+}
+
 static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *iotlb_gather)
 {
-	hv_flush_device_domain(to_hv_iommu_domain(domain));
+	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);
 
+	/*
+	 * The hypercall also invalidates non-leaf page-walk caches, so
+	 * detached page-table pages can now be freed.
+	 */
 	iommu_put_pages_list(&iotlb_gather->freelist);
 }
 
@@ -440,6 +511,7 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 
 	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
 	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 	/*
 	 * Hyper-V S1 domains use a 4-level root for IOVA widths up to
 	 * 48 bits. A 5-level root is used only for wider apertures when
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 5d1338197eee..966945f0504f 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -497,6 +497,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
 #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
 #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
+#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 7b9f43b320cd..57b70efe60d4 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -685,4 +685,22 @@ struct hv_input_flush_device_domain {
 	u32 reserved;
 } __packed;
 
+union hv_iommu_flush_va {	/* HV_IOMMU_GVA_RANGE */
+	u64 as_uint64;
+	struct {
+		u64 page_mask_shift : 6;
+		u64 reserved : 6;
+		u64 page_number : 52;
+	};
+} __packed;
+
+/* HV_INPUT_FLUSH_DEVICE_DOMAIN_LIST */
+struct hv_input_flush_device_domain_list {
+	struct hv_input_device_domain device_domain;
+#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT BIT(0)
+	u32 flags;
+	u32 reserved;
+	union hv_iommu_flush_va iova_list[];
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.52.0

