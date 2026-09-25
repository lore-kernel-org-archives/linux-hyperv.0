Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D7446C17;
	Fri, 25 Sep 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363281; cv=none; b=iCo0EKyFv0L98jDysDvCfy7YFtY4MQkRpZyiBJYBZ7J3OUX9rK25saFxJ+U+oUMHP6HOvriu7OyRHyJ0mIeEFcVLysgkExABdtOjUTrisMMzKnUHBWla/l0ieJeZ+YxcQfm9AVJapGZhv0vgSBd+BHTU+46Yi6wo8Fjqj0h2s28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363281; c=relaxed/simple;
	bh=gdk5DrAnEhO7IbQyx0qQuh/Odu36KVV9jkbbmnTQXc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKaZdQbaQkuuPFcgwcqjw6LMR8OXaasp0ANj+FhYSMuU1oEJLs9m+sKYm9LqGBmZ8Nq5cnA0tyT3SXt24YJj2TTAacCd3YlNSL3bVHzjhuNqoKFGPRLoRxE8XeKpGBj13kNWwBostaKq/k5ylShu74UwnGOZtbf/bVcnyJFbXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WCPWEAV7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WCPWEAV7"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0079720B716A;
	Fri, 25 Sep 2026 12:06:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0079720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363216;
	bh=GB/b+h/Q30DY24zncUEJneqMr1IkwfqnAV3mludw02w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCPWEAV7D292iW/sdhrN3j44E6o46/Yum2CCX5LhQuvOr+nuCqcBQGW6SscpyFFXq
	 l6Nu8DikIuOokvxwLqWuqo9D/uGNiUaxInECSgwzlunrJ51DzIbn0A5XdHwhJrTEWz
	 QHTwRFBvq2e1Rqyz91ScWZ93KxgDWBj/vqmRSIDo=
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
Subject: [PATCH RFC 2/9] iommufd: Introduce hypervisor vIOMMU type
Date: Fri, 25 Sep 2026 12:07:35 -0700
Message-ID: <20260925190742.1575380-3-jacob.pan@linux.microsoft.com>
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

Add IOMMU_VIOMMU_TYPE_HYPERVISOR with a file-based VM partition
reference. This represents a hypervisor-backed per-VM IOMMU object used
to bind and organize vDEVICEs for a guest VM partition, with or without
a guest vIOMMU.

This type has no nesting-parent HWPT. Teach the vIOMMU core to pass a
NULL parent domain to the driver callback.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Assisted-by: GPT-5.6 Sol
---
 drivers/iommu/amd/iommufd.c    | 10 ++++++++-
 drivers/iommu/iommufd/viommu.c | 37 +++++++++++++++++++++++-----------
 include/linux/iommu.h          |  8 +++++---
 include/uapi/linux/iommufd.h   | 25 ++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f..8fcd5228c547 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -34,6 +34,10 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
 
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
 {
+	/* AMD vIOMMUs require a nesting parent; hypervisor vIOMMUs are parentless. */
+	if (viommu_type == IOMMU_VIOMMU_TYPE_HYPERVISOR)
+		return 0;
+
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
@@ -41,9 +45,13 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 			    const struct iommu_user_data *user_data)
 {
 	unsigned long flags;
-	struct protection_domain *pdom = to_pdomain(parent);
+	struct protection_domain *pdom;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
+	if (!parent)
+		return -EOPNOTSUPP;
+
+	pdom = to_pdomain(parent);
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f7951057a1e5..73a06c1a2ada 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -10,7 +10,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
-	refcount_dec(&viommu->hwpt->common.obj.users);
+	if (viommu->hwpt)
+		refcount_dec(&viommu->hwpt->common.obj.users);
 	xa_destroy(&viommu->vdevs);
 }
 
@@ -63,15 +64,19 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
-	if (IS_ERR(hwpt_paging)) {
-		rc = PTR_ERR(hwpt_paging);
-		goto out_put_idev;
-	}
+	if (cmd->type == IOMMU_VIOMMU_TYPE_HYPERVISOR) {
+		hwpt_paging = NULL;
+	} else {
+		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+		if (IS_ERR(hwpt_paging)) {
+			rc = PTR_ERR(hwpt_paging);
+			goto out_put_idev;
+		}
 
-	if (!hwpt_paging->nest_parent) {
-		rc = -EINVAL;
-		goto out_put_hwpt;
+		if (!hwpt_paging->nest_parent) {
+			rc = -EINVAL;
+			goto out_put_hwpt;
+		}
 	}
 
 	viommu = (struct iommufd_viommu *)_iommufd_object_alloc_ucmd(
@@ -85,7 +90,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
-	refcount_inc(&viommu->hwpt->common.obj.users);
+	if (viommu->hwpt)
+		refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
 	init_rwsem(&viommu->veventqs_rwsem);
 	/*
@@ -95,7 +101,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = iommu_dev;
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
+	rc = ops->viommu_init(viommu,
+			      hwpt_paging ? hwpt_paging->common.domain : NULL,
 			      user_data.len ? &user_data : NULL);
 	if (rc)
 		goto out_put_hwpt;
@@ -110,7 +117,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_put_hwpt:
-	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+	if (hwpt_paging)
+		iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
@@ -394,6 +402,11 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(viommu))
 		return PTR_ERR(viommu);
 
+	if (!viommu->hwpt) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
 	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
 	    !viommu->ops->hw_queue_init_phys) {
 		rc = -EOPNOTSUPP;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ede77b90f0fd..95211e95ea5d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -685,9 +685,11 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *                   driver-level vIOMMU structure related to the core one
  * @viommu_init: Init the driver-level struct of an iommufd_viommu on a physical
  *               IOMMU instance @viommu->iommu_dev, as the set of virtualization
- *               resources shared/passed to user space IOMMU instance. Associate
- *               it with a nesting @parent_domain. It is required for driver to
- *               set @viommu->ops pointing to its own viommu_ops
+ *               resources shared/passed to user space IOMMU instance.
+ *               @parent_domain may be NULL for a parentless vIOMMU type; a
+ *               driver advertising such a type through @get_viommu_size must
+ *               accept a NULL parent. It is required for driver to set
+ *               @viommu->ops pointing to its own viommu_ops
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
  *                   translation.
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..bffa25c5267e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1095,6 +1095,11 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_HYPERVISOR: Hypervisor-backed per-VM IOMMU object
+ *                                tracks a file-based VM partition
+ *                                reference; also used to bind and organize
+ *                                vDEVICEs for a guest VM partition, with or
+ *                                without a guest vIOMMU.
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1105,6 +1110,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_HYPERVISOR = 3,
 };
 
 /**
@@ -1123,13 +1129,29 @@ struct iommu_viommu_tegra241_cmdqv {
 	__aligned_u64 out_vintf_mmap_length;
 };
 
+/**
+ * struct iommu_viommu_hypervisor - Hypervisor-backed virtual IOMMU
+ *                            (IOMMU_VIOMMU_TYPE_HYPERVISOR)
+ * @vm_fd: Hypervisor VM/partition file descriptor
+ * @flags: Must be 0 for now. Future flags may indicate the presence of a guest
+ *         virtual IOMMU, allowing hypervisor pvIOMMU drivers to enable
+ *         PASID/ATS and prepare for nested translation as appropriate.
+ * @__reserved: Must be 0
+ */
+struct iommu_viommu_hypervisor {
+	__s32 vm_fd;
+	__u32 flags;
+	__aligned_u64 __reserved;
+};
+
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
  * @flags: Must be 0
  * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
- * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @hwpt_id: ID of a nesting parent HWPT to associate to. This field is
+ *           ignored if the vIOMMU type does not use a nesting parent
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
  * @data_len: Length of the type specific data
  * @__reserved: Must be 0
@@ -1146,6 +1168,7 @@ struct iommu_viommu_tegra241_cmdqv {
  * - Delivery of paravirtualized invalidation
  * - Direct assigned invalidation queues
  * - Direct assigned interrupts
+ * - Hypervisor controlled translation, e.g. for Type-1 Bare-metal hypervisors
  */
 struct iommu_viommu_alloc {
 	__u32 size;
-- 
2.43.0

