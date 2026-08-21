Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD348A2CE;
	Fri, 21 Aug 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318845; cv=none; b=sS7NNHjMNqW9CT68p8rsAsY9KKzwet3OUSXRxlE8E+YL9CNWO4GLeJog3mAfafY2gztnkDGjnn26rHofeoysYlcq+ByfWiW8LRIKpSblroCxEJNiHWu/YL3+Awcm6AE3FnRQGgFi5Bz6HoLViYXhT66eSo77JYRLvUdHWbX7d4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318845; c=relaxed/simple;
	bh=E8sgcggN4XqDrTpBDaS1PxIA9CcWolF73AfOnkRnQlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmELQcbxAdTDIKRdi6uptyRSIRk9gLSMQqp7zQXYE+3+cyjPFhJZWv9WaeM7Vw7bFjKCuzyU4Eb2+gxqxEi3AypameasWwGph9AIJV86CVNoiAN/7vOWNqz61MzgF2skCTynB+lQ2TTbjtixJghGVQMXndeeQQuuiqUpsoVZejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CUMpAiEh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CUMpAiEh"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 212AF20B7128;
	Fri, 21 Aug 2026 06:26:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 212AF20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787318809;
	bh=yuNvgsrd17bq25Q3Vdh9MWZm+oooDaNTqJ+d4sn2xgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUMpAiEhAFjcXbjzBS1Uhk8DFm2qFJgo6djh+RbAluKKv6JE7PAr/aTCPJ2B/mcS5
	 PmNFRZ8VNI3/i4SrbZuMFHWgq57ol/yYOYi5HuTf1+Z1wrnkCi4AsgOb9KGMQxnjKM
	 FFAiOnX7mJAf5DsHQ32lvHelLEoUCFMKT4LlCtOM=
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
Subject: [PATCH v4 3/5] iommu/x86: Add architectural MSI reserved region helper
Date: Fri, 21 Aug 2026 21:26:52 +0800
Message-ID: <20260821132654.211730-4-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
address window from normal IOVA mappings, but each open-codes the range
and its allocation attributes.

Add iommu_alloc_resv_x86_msi_region() to encapsulate those details, and
convert the Intel and AMD drivers to use it.

Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 arch/x86/include/asm/iommu.h | 14 ++++++++++++++
 drivers/iommu/amd/iommu.c    |  6 +-----
 drivers/iommu/intel/iommu.c  |  6 +-----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 3be2451e7bc8..6404f4fbeae8 100644
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
@@ -21,6 +26,15 @@ extern bool x86_swiotlb_enable;
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
 
+#ifdef CONFIG_IOMMU_API
+static inline struct iommu_resv_region *
+iommu_alloc_resv_x86_msi_region(void)
+{
+	return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
+				       IOMMU_RESV_MSI, GFP_KERNEL);
+}
+#endif
+
 static inline int __init
 arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c6..b9bbd9aa99a8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -50,8 +50,6 @@
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
 /* Reserved IOVA ranges */
-#define MSI_RANGE_START		(0xfee00000)
-#define MSI_RANGE_END		(0xfeefffff)
 #define HT_RANGE_START		(0xfd00000000ULL)
 #define HT_RANGE_END		(0xffffffffffULL)
 
@@ -3140,9 +3138,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, head);
 	}
 
-	region = iommu_alloc_resv_region(MSI_RANGE_START,
-					 MSI_RANGE_END - MSI_RANGE_START + 1,
-					 0, IOMMU_RESV_MSI, GFP_KERNEL);
+	region = iommu_alloc_resv_x86_msi_region();
 	if (!region)
 		return;
 	list_add_tail(&region->list, head);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..c4de4bbcb065 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -39,8 +39,6 @@
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
-#define IOAPIC_RANGE_START	(0xfee00000)
-#define IOAPIC_RANGE_END	(0xfeefffff)
 #define IOVA_START_ADDR		(0x1000)
 
 #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
@@ -3459,9 +3457,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	}
 #endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
 
-	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
-				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
-				      0, IOMMU_RESV_MSI, GFP_KERNEL);
+	reg = iommu_alloc_resv_x86_msi_region();
 	if (!reg)
 		return;
 	list_add_tail(&reg->list, head);
-- 
2.52.0

