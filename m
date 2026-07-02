Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C51346771;
	Thu,  2 Jul 2026 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008348; cv=none; b=NNX+7p/JZ67cB6Tra8xe5TO6su4YfbJUxqSdBix+dGg7LPGjUZpRIftsjH+ATanhKw91BCn5r518nJ61uGL/OJxBLSb7WJ11IU7yq2+n3ftYBVExOJkmIpCPlQFmiw4eDr3zQf5eTfsyzLRHTAMGPLqdVOywaCDM806aZh1Ny6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008348; c=relaxed/simple;
	bh=Kn5NrkHVHRgQj8Fa4JwpgLNa/jM8DfiVsDkswNu0aSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djS//XC1egr9Tb5hw/ptPO8HRRpHco1OxpWVgOEdzwXQ5TUeXyJMB8Y4oUPoc9kcNmSHVjiJ+Dz52lSIzx1MiP3XyWfWjehnEF5q4BAxi3xuID0rSq47iuinmSAndxexlpp7UzvHaSuaozcB3ZypHfcbE2iixW5fD5AhgemR8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mfFdIIJa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mfFdIIJa"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22FFA20B7167;
	Thu,  2 Jul 2026 09:05:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22FFA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783008344;
	bh=6OE1Mauqb92odTbNSOoBdujt4QCH/s9L+WnP1i8hHJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfFdIIJaxIiypsFDAUZIY4Zoc838CL78wnLbxefZcztN7LRwyIRMCqwWoly0x1+Bo
	 oc13ItowVTGzBmwCVggQT5i5BiwfwuhHAUwWEp0+z+7QfIHvikh9hWhLFR6YyuAsaB
	 xT5o7nywXf0O5GLD3xnbyHuMeqsbZ5LRbcS1KbFo=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
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
	mrathor@linux.microsoft.com
Subject: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush support
Date: Fri,  3 Jul 2026 00:05:18 +0800
Message-ID: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
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
---
 drivers/iommu/hyperv/iommu.c | 68 +++++++++++++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h  |  1 +
 include/hyperv/hvhdk_mini.h  | 17 +++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
index 254136946404..e9b104a322fd 100644
--- a/drivers/iommu/hyperv/iommu.c
+++ b/drivers/iommu/hyperv/iommu.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
 #define dev_fmt(fmt) pr_fmt(fmt)
 
+#include <linux/hyperv.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
 #include <linux/dma-map-ops.h>
@@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	hv_flush_device_domain(to_hv_iommu_domain(domain));
 }
 
+/*
+ * Calculate the minimal power-of-two aligned range that covers [start, end]
+ * (end is inclusive). Returns a single (page_number, page_mask_shift)
+ * descriptor that may over-flush when the range is not naturally aligned.
+ */
+static void hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
+				       union hv_iommu_flush_va *va)
+{
+	unsigned long start_pfn = HVPFN_DOWN(start);
+	unsigned long last_pfn = HVPFN_UP(end + 1) - 1;
+	unsigned long mask_shift, aligned_pfn;
+
+	if (start_pfn == last_pfn) {
+		mask_shift = 0;
+	} else {
+		/*
+		 * Find the highest bit position where start_pfn and last_pfn
+		 * differ.  A range aligned to one above that bit is the
+		 * smallest power-of-two region that covers both endpoints.
+		 */
+		mask_shift = __fls(start_pfn ^ last_pfn) + 1;
+	}
+
+	aligned_pfn = ALIGN_DOWN(start_pfn, 1UL << mask_shift);
+	va->page_number = aligned_pfn;
+	va->page_mask_shift = mask_shift;
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
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain = hv_domain->device_domain;
+	input->flags |= HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
+	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
+				  &input->iova_list[0]);
+
+	status = hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
+				     1, 0, input, NULL);
+
+	if (!hv_result_success(status)) {
+		/* Page-selective flush failed, fall back to full flush. */
+		struct hv_input_flush_device_domain *flush_all = (void *)input;
+
+		memset(flush_all, 0, sizeof(*flush_all));
+		flush_all->device_domain = hv_domain->device_domain;
+		status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
+					flush_all, NULL);
+		WARN(!hv_result_success(status),
+		     "HVCALL_FLUSH_DEVICE_DOMAIN fallback also failed: %lld\n",
+		     status);
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
 
 	iommu_put_pages_list(&iotlb_gather->freelist);
 }
@@ -455,6 +520,7 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 
 	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
 	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
 
 	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 5bdbb44da112..eaaf87171478 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -496,6 +496,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
 #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
 #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
+#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
 #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
 #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 493608e791b4..f51d5d9467f1 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -671,4 +671,21 @@ struct hv_input_flush_device_domain {
 	u32 reserved;
 } __packed;
 
+union hv_iommu_flush_va {
+	u64 iova;
+	struct {
+		u64 page_mask_shift : 12;
+		u64 page_number : 52;
+	};
+} __packed;
+
+
+struct hv_input_flush_device_domain_list {
+	struct hv_input_device_domain device_domain;
+#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT (1 << 0)
+	u32 flags;
+	u32 reserved;
+	union hv_iommu_flush_va iova_list[];
+} __packed;
+
 #endif /* _HV_HVHDK_MINI_H */
-- 
2.52.0

