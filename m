Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AC4D0CE1;
	Fri, 25 Sep 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363290; cv=none; b=WLOY02KhIsv4Ac16GaXtpw/H7m81r6B5weW8Y3GdBtuQ/BCKDyXmyBK/2Fwm/4y/4rtMHFP3IO4eS03HqiNrbrm841QQLnjFlXOG7QPnFGjS2Xy7/hogOeFHqWw8RTgJsdZBI6uSoIM5reXEzE6SXWi9d2XjPdRYpCSIAUadVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363290; c=relaxed/simple;
	bh=GZZMXG8OarCWWW+jwF7/L5uJFiWpK4K/j+8dsbx/yPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e72uEp8cwN5OzqckBDv+f41guIfqlJ27KHoVzVs67EpWC01ZQw9ZtKyG8hpqjLXdo2FcGOiecrRgdiyV/dXkD0lpazFYcq7Z1HDfSP/NmyOsMYNuH1fciTEmDLbQJATBg7mqOFX13O9G6BlIKlgYSI2Q24x+wosDOmrqFoVha8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qDfH5P+t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qDfH5P+t"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id CFBC620B7171;
	Fri, 25 Sep 2026 12:07:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFBC620B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363221;
	bh=FoeEr+OnLwxx2zLyfVK537I78o+eF433Mirxja5xOvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDfH5P+tFwXtkWJr3ON3rc1hK1VX3Tlcft/tm4vdEk/zx+PSHT+2Zx+UTAYdYvMGi
	 WcXuHg7F9/0QjwIF4Dm7njX5IJSoFCKcISLZEvWaXUvHyAHxTcAZW07mqPVzJrCvVV
	 eopQh4lHzJSyI9k83iTjLOjJCsXvvQa2TZ+NfNio=
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
Subject: [PATCH RFC 9/9] iommu/hyperv: Add IOMMUFD external domains
Date: Fri, 25 Sep 2026 12:07:42 -0700
Message-ID: <20260925190742.1575380-10-jacob.pan@linux.microsoft.com>
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

Allocate IOMMU_DOMAIN_EXTERNAL domains under Hyper-V vIOMMUs and use
HVCALL_ATTACH_DEVICE to assign devices to an MSHV partition.

Resolve the userspace-assigned vDEVICE virt_id during attach and use it
as the Hyper-V logical device ID. External domains retain their vIOMMU
so attach preparation can pin guest memory before atomically replacing
the previous device assignment.

Keep paging domains backed by normal Hyper-V device domains.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/hyperv/hv-iommu-iommufd.c | 44 ++++++++++++
 drivers/iommu/hyperv/hv-iommu-root.c    | 89 +++++++++++++++++++++++++
 drivers/iommu/hyperv/hv-iommu.h         |  5 ++
 3 files changed, 138 insertions(+)

diff --git a/drivers/iommu/hyperv/hv-iommu-iommufd.c b/drivers/iommu/hyperv/hv-iommu-iommufd.c
index 486a85c0d1e8..e595f53ddc66 100644
--- a/drivers/iommu/hyperv/hv-iommu-iommufd.c
+++ b/drivers/iommu/hyperv/hv-iommu-iommufd.c
@@ -33,10 +33,54 @@ static void hv_iommu_viommu_destroy(struct iommufd_viommu *viommu)
 	fput(hv_viommu->vm_file);
 }
 
+static struct iommu_domain *
+hv_iommu_alloc_domain_external(struct iommufd_viommu *viommu, u32 flags,
+			       const struct iommu_user_data *user_data)
+{
+	struct hv_iommu_viommu *hv_viommu = to_hv_iommu_viommu(viommu);
+	struct iommu_hwpt_external external = {};
+	struct hv_domain *hvdom;
+	int rc;
+
+	if (viommu->type != IOMMU_VIOMMU_TYPE_HYPERVISOR)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!user_data || user_data->type != IOMMU_HWPT_DATA_EXTERNAL)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	rc = iommu_copy_struct_from_user(&external, user_data,
+					 IOMMU_HWPT_DATA_EXTERNAL, flags);
+	if (rc)
+		return ERR_PTR(rc);
+	if (external.flags || external.__reserved)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hvdom = kzalloc_obj(*hvdom, GFP_KERNEL_ACCOUNT);
+	if (!hvdom)
+		return ERR_PTR(-ENOMEM);
+
+	hvdom->iommu_dom.type = IOMMU_DOMAIN_EXTERNAL;
+	hvdom->iommu_dom.ops = &hv_iommu_external_domain_ops;
+	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
+	hvdom->partid = hv_viommu->partid;
+	hvdom->viommu = viommu;
+
+	return &hvdom->iommu_dom;
+}
+
 static const struct iommufd_viommu_ops hv_iommu_hypervisor_viommu_ops = {
 	.destroy = hv_iommu_viommu_destroy,
+	.alloc_domain_external = hv_iommu_alloc_domain_external,
 };
 
+int hv_iommufd_prepare_attach(struct iommufd_viommu *viommu)
+{
+	struct hv_iommu_viommu *hv_viommu = to_hv_iommu_viommu(viommu);
+
+	return mshv_partition_file_prepare_attach(hv_viommu->vm_file);
+}
+
 size_t hv_iommufd_get_viommu_size(struct device *dev,
 				  enum iommu_viommu_type viommu_type)
 {
diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
index d6424b9ea0cd..b87152489630 100644
--- a/drivers/iommu/hyperv/hv-iommu-root.c
+++ b/drivers/iommu/hyperv/hv-iommu-root.c
@@ -7,6 +7,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/interval_tree.h>
 #include <linux/hyperv.h>
+#include <linux/iommufd.h>
 #include "hv-iommu.h"
 #include <asm/iommu.h>
 #include <asm/mshyperv.h>
@@ -59,6 +60,13 @@ static bool hv_special_domain(struct hv_domain *hvdom)
 	return hvdom == &hv_def_identity_dom || hvdom == &hv_def_blocked_dom;
 }
 
+static u64 hv_iommu_host_device_id(struct pci_dev *pdev)
+{
+	u64 devid = hv_pci_vmbus_device_id(pdev);
+
+	return devid ? devid : hv_build_devid_type_pci(pdev);
+}
+
 static atomic_t hv_unique_id;		/* unique numeric id for a new domain */
 
 static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
@@ -205,6 +213,11 @@ static void hv_iommu_domain_free(struct iommu_domain *immdom)
 	if (hv_special_domain(hvdom))
 		return;
 
+	if (immdom->type == IOMMU_DOMAIN_EXTERNAL) {
+		kfree(hvdom);
+		return;
+	}
+
 	/* Cleanup any remaining. 0 for size results in ULONG_MAX as the last */
 	hv_iommu_del_tree_mappings(hvdom, 0, 0);
 
@@ -269,6 +282,10 @@ static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
 
 	pdev = to_pci_dev(dev);
 
+	/*
+	 * HVCALL_ATTACH_DEVICE_DOMAIN atomically replaces any existing
+	 * assignment, leaving @old intact if the new attachment fails.
+	 */
 	rc = hv_iommu_att_dev2dom(hvdom_new, pdev);
 	if (rc)
 		WARN(1, "Failed to attach pdev:%s\n", pci_name(pdev));
@@ -276,6 +293,73 @@ static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
 	return rc;
 }
 
+static int hv_iommu_external_attach_device(struct pci_dev *pdev, u64 partid,
+					   unsigned long vdev_id)
+{
+	struct hv_input_attach_device *input;
+	union hv_device_id host_devid;
+	unsigned long flags;
+	u64 status;
+	int rc;
+
+	if (partid == HV_PARTITION_ID_INVALID)
+		return -EINVAL;
+
+	host_devid.as_uint64 = hv_iommu_host_device_id(pdev);
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+
+		input->partition_id = partid;
+		input->device_id = host_devid;
+		input->attdev_flags.logical_id = 1;
+		input->logical_devid = vdev_id;
+
+		status = hv_do_hypercall(HVCALL_ATTACH_DEVICE, input, NULL);
+		local_irq_restore(flags);
+
+		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+			rc = hv_call_deposit_pages(NUMA_NO_NODE, partid, 1);
+			if (rc)
+				return rc;
+		}
+	} while (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+
+	return hv_result_to_errno(status);
+}
+
+static int hv_iommu_external_attach_dev(struct iommu_domain *immdom,
+					struct device *dev,
+					struct iommu_domain *old)
+{
+	struct hv_domain *hvdom_new = to_hv_domain(immdom);
+	unsigned long vdev_id;
+	int rc;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	rc = iommufd_viommu_get_vdev_id(hvdom_new->viommu, dev, &vdev_id);
+	if (rc)
+		return rc;
+
+	rc = hv_iommufd_prepare_attach(hvdom_new->viommu);
+	if (rc)
+		return rc;
+
+	/*
+	 * HVCALL_ATTACH_DEVICE atomically replaces any existing assignment,
+	 * leaving @old intact if the new attachment fails.
+	 */
+	return hv_iommu_external_attach_device(to_pci_dev(dev),
+					       hvdom_new->partid, vdev_id);
+}
+
 static u64 hv_iommu_unmap_batch(u32 domid_num, ulong iova, u16 count)
 {
 	ulong flags;
@@ -527,6 +611,11 @@ static struct iommu_domain_ops hv_paging_domain_ops = {
 	.free = hv_iommu_domain_free,
 };
 
+const struct iommu_domain_ops hv_iommu_external_domain_ops = {
+	.attach_dev = hv_iommu_external_attach_dev,
+	.free = hv_iommu_domain_free,
+};
+
 static struct iommu_ops hv_iommu_ops = {
 	.capable	    = hv_iommu_capable,
 	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
diff --git a/drivers/iommu/hyperv/hv-iommu.h b/drivers/iommu/hyperv/hv-iommu.h
index 6fdbe56a4b1d..647fead81533 100644
--- a/drivers/iommu/hyperv/hv-iommu.h
+++ b/drivers/iommu/hyperv/hv-iommu.h
@@ -20,16 +20,21 @@ struct iommu_user_data;
 struct hv_domain {
 	struct iommu_domain iommu_dom;
 	u32 domid_num;			      /* as opposed to domain_id.type */
+	u64 partid;			      /* partition id for external attach */
+	struct iommufd_viommu *viommu;
 	spinlock_t mappings_lock;	      /* protects mappings_tree */
 	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
 };
 
 #define to_hv_domain(d) container_of(d, struct hv_domain, iommu_dom)
 
+extern const struct iommu_domain_ops hv_iommu_external_domain_ops;
+
 size_t hv_iommufd_get_viommu_size(struct device *dev,
 				  enum iommu_viommu_type viommu_type);
 int hv_iommufd_viommu_init(struct iommufd_viommu *viommu,
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
+int hv_iommufd_prepare_attach(struct iommufd_viommu *viommu);
 
 #endif /* __HYPERV_IOMMU_H */
-- 
2.43.0

