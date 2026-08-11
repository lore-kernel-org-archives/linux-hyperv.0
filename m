Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFBD3C10A6;
	Tue, 11 Aug 2026 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463451; cv=none; b=teBN0rWYPMVOCalP6mi4a61cAI0hHRx7CIr8htXni0DI63yvqWKnL9xGr9GPArmkdSMgv9LFh159Y/9QIr58xPD7ixEIMuJufxYmRFf3WGtdwofmsBsJRQrelUYxchYPZmTPsxqCeg7eeZvbivKjKJxvKUzsaXGSYwKV4cO8kWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463451; c=relaxed/simple;
	bh=KpeOKbamEsHn3xIkp6aMommTlTHjDOTB0vBPkCMQozs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI8YwOhH7m0FFcnQLfq8Z8MD4THcupyzXO4GtMp0ah8hSc8LwpH8ml3OpsOdbpfbgHCG2Fdst+wfuWbS76ZhcP8RktSWvzUFrvr5yxOGEkoYHlK6+a8f0J4Jj2xOFbLdTK1igTVLp3Jm/+tL97hfaZcpjmv7efZEVZUpVwrk/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fE/gIA4Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fE/gIA4Y"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD1FA20B7167;
	Tue, 11 Aug 2026 08:50:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD1FA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786463425;
	bh=KT7NDUHn7Ng6Rv02pJPtcdHyMmoDDFo5O0iPuPMTh9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fE/gIA4YbwF2EZD4AM/s3Jnk2ifoSnFCGUfOTwDs+IMlAPWOxnNMQZ00UMulqBY9P
	 4TNdmaq8Tgx1aaZYcVyAgi3DOXFvXp5b+4cnIx/gcn25I5nroJnNDKHK+KGz901aM1
	 Cw4EbUEz+duqa2tfPfrJVXC29FqpRjfyY2us0OSU=
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
Subject: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved range
Date: Tue, 11 Aug 2026 23:50:19 +0800
Message-ID: <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
address window from normal IOVA mappings. Define the range in the
common x86 IOMMU header and use it in both drivers.

Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 arch/x86/include/asm/iommu.h | 3 +++
 drivers/iommu/amd/iommu.c    | 7 +++----
 drivers/iommu/intel/iommu.c  | 7 +++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 3be2451e7bc8..386db10ea909 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -6,6 +6,9 @@
 
 #include <asm/e820/api.h>
 
+#define X86_IOMMU_MSI_RANGE_START        0xfee00000
+#define X86_IOMMU_MSI_RANGE_END          0xfeefffff
+
 extern int force_iommu, no_iommu;
 extern int iommu_detected;
 extern int iommu_merge;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 29dc18d3d22e..ead96acdb766 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -50,8 +50,6 @@
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
 /* Reserved IOVA ranges */
-#define MSI_RANGE_START		(0xfee00000)
-#define MSI_RANGE_END		(0xfeefffff)
 #define HT_RANGE_START		(0xfd00000000ULL)
 #define HT_RANGE_END		(0xffffffffffULL)
 
@@ -3097,8 +3095,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, head);
 	}
 
-	region = iommu_alloc_resv_region(MSI_RANGE_START,
-					 MSI_RANGE_END - MSI_RANGE_START + 1,
+	region = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
+					 X86_IOMMU_MSI_RANGE_END -
+					 X86_IOMMU_MSI_RANGE_START + 1,
 					 0, IOMMU_RESV_MSI, GFP_KERNEL);
 	if (!region)
 		return;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..500f6fa5bf72 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -39,8 +39,6 @@
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
-#define IOAPIC_RANGE_START	(0xfee00000)
-#define IOAPIC_RANGE_END	(0xfeefffff)
 #define IOVA_START_ADDR		(0x1000)
 
 #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
@@ -3432,8 +3430,9 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	}
 #endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
 
-	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
-				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
+	reg = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
+				      X86_IOMMU_MSI_RANGE_END -
+				      X86_IOMMU_MSI_RANGE_START + 1,
 				      0, IOMMU_RESV_MSI, GFP_KERNEL);
 	if (!reg)
 		return;
-- 
2.52.0

