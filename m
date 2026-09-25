Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C574D09FB;
	Fri, 25 Sep 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363289; cv=none; b=LJTwiWj5t95ybxb9avch3oQ9mOb0pwB7DbuktrFQUx1xRmEU++x+V2hJ9h0GSb/EuqOb9BVVAP9ck8cv4J2B2MsOHa8CTvyKspNkUKPy0gJVN/AJ7chgEhLTx0wjtuVDTPIIWyMnkiZrnAwQz8QVHQ1x7q6V7QE4D8lZJ7c+AFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363289; c=relaxed/simple;
	bh=uc/GuUSTmqTINuY8L8g4g+Xjn2GAVkPX6V5Kbf56aj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5+uoGk9PYO8Y7C+rD3Y6diN4V0eJiBagm9z+K6XVnOxgJMRDT3spBZhdoaocoOV5EceFNquF2Y08t2/4cgVi3VaRagFOFyN0qACAcm7gOL8nLCLopyqKV1FN/Gj7EkTmW77NXDMfyAjz3DcDkW6gGnvaaTMe+IhswSoTpAkzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LlBcpABN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LlBcpABN"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D00920B7170;
	Fri, 25 Sep 2026 12:07:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D00920B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363220;
	bh=6OAcyUWcJJXaEY9f2saEuX6qFLR1eIWBMRBG0yT/ZAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlBcpABNfDDwEtAnzMzePEcM8v6472ZSYU8DRBEdH8HMBC/EnR5WlnftATzYYNHK6
	 Vo5qFg3ziwqEbBN0hgItKAB+QXjXVNk9USd62QyjOdjHed/JDDQIJLUrtAyiNcO7YD
	 nHdSPrxht1MSCzREPyba6VHr5V6O42ZLNOjT3aGw=
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
Subject: [PATCH RFC 8/9] iommu/hyperv: Add fd-backed vIOMMU support
Date: Fri, 25 Sep 2026 12:07:41 -0700
Message-ID: <20260925190742.1575380-9-jacob.pan@linux.microsoft.com>
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

Wire Hyper-V root IOMMU ops to initialize hypervisor vIOMMUs from
MSHV partition file descriptors. Keep the VM file pinned for the
vIOMMU lifetime and derive the partition ID from the fd instead
of the VMM thread identity.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/hyperv/Makefile           |  2 +-
 drivers/iommu/hyperv/hv-iommu-iommufd.c | 91 +++++++++++++++++++++++++
 drivers/iommu/hyperv/hv-iommu-root.c    |  2 +
 drivers/iommu/hyperv/hv-iommu.h         |  9 +++
 4 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/hyperv/hv-iommu-iommufd.c

diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
index c7e7d0dac2a4..2b61a407ee58 100644
--- a/drivers/iommu/hyperv/Makefile
+++ b/drivers/iommu/hyperv/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap-x86.o
-obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o
+obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o hv-iommu-iommufd.o
diff --git a/drivers/iommu/hyperv/hv-iommu-iommufd.c b/drivers/iommu/hyperv/hv-iommu-iommufd.c
new file mode 100644
index 000000000000..486a85c0d1e8
--- /dev/null
+++ b/drivers/iommu/hyperv/hv-iommu-iommufd.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyper-V root vIOMMU IOMMUFD support.
+ * Copyright (C) 2026, Microsoft, Inc.
+ */
+
+#include <linux/file.h>
+#include <linux/iommufd.h>
+#include <linux/slab.h>
+
+#include <asm/mshyperv.h>
+
+#include "hv-iommu.h"
+
+struct hv_iommu_viommu {
+	struct iommufd_viommu core;
+	struct file *vm_file;
+	u64 partid;
+};
+
+static const struct iommufd_viommu_ops hv_iommu_hypervisor_viommu_ops;
+
+static struct hv_iommu_viommu *
+to_hv_iommu_viommu(struct iommufd_viommu *viommu)
+{
+	return container_of(viommu, struct hv_iommu_viommu, core);
+}
+
+static void hv_iommu_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	struct hv_iommu_viommu *hv_viommu = to_hv_iommu_viommu(viommu);
+
+	fput(hv_viommu->vm_file);
+}
+
+static const struct iommufd_viommu_ops hv_iommu_hypervisor_viommu_ops = {
+	.destroy = hv_iommu_viommu_destroy,
+};
+
+size_t hv_iommufd_get_viommu_size(struct device *dev,
+				  enum iommu_viommu_type viommu_type)
+{
+	if (viommu_type != IOMMU_VIOMMU_TYPE_HYPERVISOR)
+		return 0;
+	return VIOMMU_STRUCT_SIZE(struct hv_iommu_viommu, core);
+}
+
+int hv_iommufd_viommu_init(struct iommufd_viommu *viommu,
+			   struct iommu_domain *parent_domain,
+			   const struct iommu_user_data *user_data)
+{
+	struct hv_iommu_viommu *hv_viommu = to_hv_iommu_viommu(viommu);
+	struct iommu_viommu_hypervisor hypervisor = {};
+	int rc;
+
+	if (viommu->type != IOMMU_VIOMMU_TYPE_HYPERVISOR)
+		return -EOPNOTSUPP;
+	if (parent_domain || !user_data)
+		return -EINVAL;
+
+	rc = iommu_copy_struct_from_user(&hypervisor, user_data,
+					 IOMMU_VIOMMU_TYPE_HYPERVISOR, vm_fd);
+	if (rc)
+		return rc;
+	if (hypervisor.flags || hypervisor.__reserved)
+		return -EOPNOTSUPP;
+
+	hv_viommu->vm_file = fget(hypervisor.vm_fd);
+	if (!hv_viommu->vm_file)
+		return -EBADF;
+
+	if (!file_is_mshv_partition(hv_viommu->vm_file)) {
+		rc = -EINVAL;
+		goto out_put_file;
+	}
+
+	hv_viommu->partid =
+		mshv_partition_file_get_partid(hv_viommu->vm_file);
+	if (hv_viommu->partid == HV_PARTITION_ID_INVALID) {
+		rc = -EINVAL;
+		goto out_put_file;
+	}
+
+	viommu->ops = &hv_iommu_hypervisor_viommu_ops;
+	return 0;
+
+out_put_file:
+	fput(hv_viommu->vm_file);
+	hv_viommu->vm_file = NULL;
+	return rc;
+}
diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
index 3b82891c9cab..d6424b9ea0cd 100644
--- a/drivers/iommu/hyperv/hv-iommu-root.c
+++ b/drivers/iommu/hyperv/hv-iommu-root.c
@@ -530,6 +530,8 @@ static struct iommu_domain_ops hv_paging_domain_ops = {
 static struct iommu_ops hv_iommu_ops = {
 	.capable	    = hv_iommu_capable,
 	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
+	.get_viommu_size    = hv_iommufd_get_viommu_size,
+	.viommu_init	    = hv_iommufd_viommu_init,
 	.probe_device	    = hv_iommu_probe_device,
 	.device_group	    = hv_iommu_device_group,
 	.get_resv_regions   = hv_iommu_get_resv_regions,
diff --git a/drivers/iommu/hyperv/hv-iommu.h b/drivers/iommu/hyperv/hv-iommu.h
index 6895b4e7eb6d..6fdbe56a4b1d 100644
--- a/drivers/iommu/hyperv/hv-iommu.h
+++ b/drivers/iommu/hyperv/hv-iommu.h
@@ -14,6 +14,9 @@
 
 #define HV_IOMMU_PGSIZES SZ_4K  /* for now, to be enhanced */
 
+struct iommufd_viommu;
+struct iommu_user_data;
+
 struct hv_domain {
 	struct iommu_domain iommu_dom;
 	u32 domid_num;			      /* as opposed to domain_id.type */
@@ -23,4 +26,10 @@ struct hv_domain {
 
 #define to_hv_domain(d) container_of(d, struct hv_domain, iommu_dom)
 
+size_t hv_iommufd_get_viommu_size(struct device *dev,
+				  enum iommu_viommu_type viommu_type);
+int hv_iommufd_viommu_init(struct iommufd_viommu *viommu,
+			   struct iommu_domain *parent_domain,
+			   const struct iommu_user_data *user_data);
+
 #endif /* __HYPERV_IOMMU_H */
-- 
2.43.0

