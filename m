Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C14FB9AB;
	Wed, 30 Sep 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777685; cv=none; b=rw/MP3BBZl+cTJqZDHDgjQAKezR34iwh1KoTFoy/o52YsFVoO+kY7/J+Jn8hCeHbqcIueI0SZbbZIyENVjHE3+hhHIXBqE7bghgQbRr0EfR2AXiz2jTHKq5i8X5h4XmP1KiYOeLn1Ejbm8ZEFD0gcMger1IcSXELbdR1eHxjhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777685; c=relaxed/simple;
	bh=665MxM9Q3Yt+npjNzauXPiqRMbDtQwIIneE9wLRfetE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJRY9tTAO158831nixXF73JE8cX51kv5xxFLGooCBG21LDRqCNL4NT7XyLDyqUHwP4lW4MBNhEf9CFDLi+cCPrrd9e5FixsPhrmX1OqEyjIvOQFdCnqUcop9dC6zvsy5EqC4TCwjCWq6HVJdlKMxltMFTvT2qMit5QH+Zu9hmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Az2PA5Fo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Az2PA5Fo"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 431C820B7168;
	Wed, 30 Sep 2026 07:13:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 431C820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790777619;
	bh=WSo/sxxZND5+/31eqg1hNcrxUTRfspyBAaGJZS0dGN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Az2PA5Fol/lKfectQjTFhs+xeGdRC1CrTd05efUh7Ea0yRI0PdUUw7XE1olz23QK3
	 1pGlk65PlbPWAg4Be/Uqkdf/V0AYL2iyswfyAhv1MDlPKQoimeJKFaOHNjwusu5KL2
	 wGneF3o4jn2NBsWXU98UsMWS73IxISV8jZnXwF4g=
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
Subject: [PATCH v6 3/5] iommu/x86: Add architectural MSI reserved region helper
Date: Wed, 30 Sep 2026 22:14:07 +0800
Message-ID: <20260930141409.437904-4-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
address window from normal IOVA mappings, but each open-codes the range,
allocation attributes, and insertion into the reserved-region list.

Add iommu_add_resv_x86_msi_region() to encapsulate those operations, and
convert the Intel and AMD drivers to use it. Return an error on allocation
failure so callers can preserve their existing error paths.

Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/x86/include/asm/iommu.h | 20 ++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |  8 +-------
 drivers/iommu/intel/iommu.c  | 11 ++---------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 3be2451e7bc8..4e1e55c3c09a 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -4,6 +4,11 @@
 
 #include <linux/acpi.h>
 
+#ifdef CONFIG_IOMMU_API
+#include <linux/iommu.h>
+#include <linux/sizes.h>
+#endif
+
 #include <asm/e820/api.h>
 
 extern int force_iommu, no_iommu;
@@ -21,6 +26,21 @@ extern bool x86_swiotlb_enable;
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
 
+#ifdef CONFIG_IOMMU_API
+static inline int iommu_add_resv_x86_msi_region(struct list_head *head)
+{
+	struct iommu_resv_region *region;
+
+	region = iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
+					 IOMMU_RESV_MSI, GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	list_add_tail(&region->list, head);
+	return 0;
+}
+#endif
+
 static inline int __init
 arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..391cec4d86c0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -50,8 +50,6 @@
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
 /* Reserved IOVA ranges */
-#define MSI_RANGE_START		(0xfee00000)
-#define MSI_RANGE_END		(0xfeefffff)
 #define HT_RANGE_START		(0xfd00000000ULL)
 #define HT_RANGE_END		(0xffffffffffULL)
 
@@ -3137,12 +3135,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, head);
 	}
 
-	region = iommu_alloc_resv_region(MSI_RANGE_START,
-					 MSI_RANGE_END - MSI_RANGE_START + 1,
-					 0, IOMMU_RESV_MSI, GFP_KERNEL);
-	if (!region)
+	if (iommu_add_resv_x86_msi_region(head))
 		return;
-	list_add_tail(&region->list, head);
 
 	if (amd_iommu_ht_range_ignore())
 		return;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..74fb5c894fe5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -39,8 +39,6 @@
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
-#define IOAPIC_RANGE_START	(0xfee00000)
-#define IOAPIC_RANGE_END	(0xfeefffff)
 #define IOVA_START_ADDR		(0x1000)
 
 #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
@@ -3412,7 +3410,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
 					 struct list_head *head)
 {
 	int prot = DMA_PTE_READ | DMA_PTE_WRITE;
-	struct iommu_resv_region *reg;
 	struct dmar_rmrr_unit *rmrr;
 	struct device *i_dev;
 	int i;
@@ -3448,6 +3445,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
 	if (dev_is_pci(device)) {
 		struct pci_dev *pdev = to_pci_dev(device);
+		struct iommu_resv_region *reg;
 
 		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
 			reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
@@ -3459,12 +3457,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	}
 #endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
 
-	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
-				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
-				      0, IOMMU_RESV_MSI, GFP_KERNEL);
-	if (!reg)
-		return;
-	list_add_tail(&reg->list, head);
+	iommu_add_resv_x86_msi_region(head);
 }
 
 static struct iommu_group *intel_iommu_device_group(struct device *dev)
-- 
2.52.0

