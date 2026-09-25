Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE94D09EC;
	Fri, 25 Sep 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363288; cv=none; b=UK487NmJHmgVBiItZiS87Udzv2QRe1oBbKfSfgPpBlmGXVXLZ3sgePoorql71fhySi1jfsH7FKoKTU3bbKlaaWOSAwXTxe+ARtHNuQi7oOTFGOOzHjyXA+ypu2LM8U8zTT1cWDY7eev36E0Q8a7gQ+oYW4ejzgGJ0g3FbSpvLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363288; c=relaxed/simple;
	bh=FaeFvHouw/vWqgOvAFlzQ/Ngc9gV3TMI9KJb8lwxGkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ico+Z8mtq5gED1mRkBl8PZQhwtnm6bLJL5Dg8gbT9TfmQmIH+cEjAvBJVMKwSyJ+GtJQy+bFD2ZittI64ZfXDa4/huOD6J4ss0S33dDSbtEj6ROia5Ly0V1l3jTWj2V8hkKeJ5jaj5Ps6hvO+vvXMW+VyChOcdDt5tJxvVhKLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dmzDOXDz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dmzDOXDz"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAF8720B716F;
	Fri, 25 Sep 2026 12:06:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAF8720B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363219;
	bh=LGDInKLiB7KgFuVCYzgC2MOL5mF6WQcw35pPlJm8T4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmzDOXDzWCM8jzPhYz/j6n1UYET4DIXH5vxfIUIqJaPgvK6m5HLRm2u4wfeNBJtsO
	 oDlVJI3Sglbrt5EuanwskGyIzpOpi68Lw+0x2+vP+Gi9i/n1NGSGAPOKI3ReQoHl6J
	 K4CKfSWCfU/YK0jwvTa0DZpT3k2TwkfSuZfpwD58=
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
Subject: [PATCH RFC 7/9] iommu/hyperv: Split root IOMMU declarations
Date: Fri, 25 Sep 2026 12:07:40 -0700
Message-ID: <20260925190742.1575380-8-jacob.pan@linux.microsoft.com>
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

Move the root IOMMU shared domain type, page-size mask, and
geometry into a private Hyper-V IOMMU header so IOMMUFD support
can live outside the main root driver file.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/hyperv/hv-iommu-root.c | 11 +----------
 drivers/iommu/hyperv/hv-iommu.h      | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 10 deletions(-)
 create mode 100644 drivers/iommu/hyperv/hv-iommu.h

diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
index a5268e0e52cc..3b82891c9cab 100644
--- a/drivers/iommu/hyperv/hv-iommu-root.c
+++ b/drivers/iommu/hyperv/hv-iommu-root.c
@@ -7,6 +7,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/interval_tree.h>
 #include <linux/hyperv.h>
+#include "hv-iommu.h"
 #include <asm/iommu.h>
 #include <asm/mshyperv.h>
 #include "../dma-iommu.h"
@@ -31,15 +32,6 @@ static struct iommu_domain_ops hv_paging_domain_ops;
 /* IOMMU device that we export to the world. HyperV supports max of one */
 static struct iommu_device hv_virt_iommu;
 
-struct hv_domain {
-	struct iommu_domain iommu_dom;
-	u32 domid_num;			      /* as opposed to domain_id.type */
-	spinlock_t mappings_lock;	      /* protects mappings_tree */
-	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
-};
-
-#define to_hv_domain(d) container_of(d, struct hv_domain, iommu_dom)
-
 struct hv_iommu_mapping {
 	phys_addr_t paddr;
 	struct interval_tree_node iova;
@@ -67,7 +59,6 @@ static bool hv_special_domain(struct hv_domain *hvdom)
 	return hvdom == &hv_def_identity_dom || hvdom == &hv_def_blocked_dom;
 }
 
-#define HV_IOMMU_PGSIZES SZ_4K		/* for now, to be enhanced */
 static atomic_t hv_unique_id;		/* unique numeric id for a new domain */
 
 static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
diff --git a/drivers/iommu/hyperv/hv-iommu.h b/drivers/iommu/hyperv/hv-iommu.h
new file mode 100644
index 000000000000..6895b4e7eb6d
--- /dev/null
+++ b/drivers/iommu/hyperv/hv-iommu.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Hyper-V root vIOMMU driver.
+ * Copyright (C) 2026, Microsoft, Inc.
+ */
+
+#ifndef __HYPERV_IOMMU_H
+#define __HYPERV_IOMMU_H
+
+#include <linux/interval_tree.h>
+#include <linux/iommu.h>
+#include <linux/sizes.h>
+#include <linux/spinlock.h>
+
+#define HV_IOMMU_PGSIZES SZ_4K  /* for now, to be enhanced */
+
+struct hv_domain {
+	struct iommu_domain iommu_dom;
+	u32 domid_num;			      /* as opposed to domain_id.type */
+	spinlock_t mappings_lock;	      /* protects mappings_tree */
+	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
+};
+
+#define to_hv_domain(d) container_of(d, struct hv_domain, iommu_dom)
+
+#endif /* __HYPERV_IOMMU_H */
-- 
2.43.0

