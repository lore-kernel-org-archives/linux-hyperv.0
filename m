Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCED3B42FC;
	Fri, 25 Sep 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363281; cv=none; b=m67ToaWncFWs/lk//GkK1FU4mGtjgZx9fMJ3OmA8SZAx5XL0PvKBs9SgmeCMB2w4mgy+yZxuOsb/9RBMNw7y+Fd9/DErcuCRIQMzxbdPqmTXc9u5RVgK/JCSHnHDzPHA1JG8QNBKXxuwS0AnbR+lci/CdThQONsa5U3KXsoL4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363281; c=relaxed/simple;
	bh=aW6TzuoRvD9yOJvMiM6Qz9GgczKPpcL4Pnj0nJhdVwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7TLFVc+Sc/AyzifYUDEYk/xJPSpEVinHjd4NEFEebJvNGohxrWhkuOOgBUv5c7ksSNYBTb94VYtvhqmlgfPKk8HGC9tWe193OS2HycteAJsrpC2wJJoBHUp5jfvkZqI8m7VY7r1kPY9L0o8bhyyPApbxeMoXBgQR2ZEU0zRTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dYUBaROo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dYUBaROo"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC6A720B716B;
	Fri, 25 Sep 2026 12:06:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC6A720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363216;
	bh=lvRZbyObRks380y2DbHO3gPJS+KcqL9EpXw32dWonK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYUBaROoX7brYPNTIR15v562gFQDZHgwNbDYpGjntwchoI+qOzSBils7lUNecPdgI
	 gzLD0KmDGGTCBsdUkIOsaFb87HTBETs2cIo5ew8nQv0JDS3WYqwQBxryzo/rWnEAPe
	 KvTGztgDdeDhDrAxvIgwU2Is3styICG9SynsYB74=
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
Subject: [PATCH RFC 3/9] iommufd: Add external HWPT support
Date: Fri, 25 Sep 2026 12:07:36 -0700
Message-ID: <20260925190742.1575380-4-jacob.pan@linux.microsoft.com>
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

Add IOMMU_HWPT_DATA_EXTERNAL and an IOMMUFD_OBJ_HWPT_EXTERNAL object for
externally managed attachable domains created under a vIOMMU.

Route vIOMMU child HWPT allocation by data type, add the driver
alloc_domain_external callback, and allow device attach/replace to
consume external HWPTs.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/device.c          |  9 +--
 drivers/iommu/iommufd/hw_pagetable.c    | 88 +++++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  7 ++
 drivers/iommu/iommufd/main.c            |  4 ++
 include/linux/iommufd.h                 | 11 ++++
 include/uapi/linux/iommufd.h            | 17 +++++
 6 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5c4b06eda546..f99b4730994c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1026,6 +1026,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev,
 		return PTR_ERR(pt_obj);
 
 	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HWPT_EXTERNAL:
 	case IOMMUFD_OBJ_HWPT_NESTED:
 	case IOMMUFD_OBJ_HWPT_PAGING: {
 		struct iommufd_hw_pagetable *hwpt =
@@ -1066,8 +1067,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev,
  * iommufd_device_attach - Connect a device/pasid to an iommu_domain
  * @idev: device to attach
  * @pasid: pasid to attach
- * @pt_id: Input an IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
- *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
+ * @pt_id: Input an IOMMUFD_OBJ_IOAS, IOMMUFD_OBJ_HWPT_PAGING, or
+ *         IOMMUFD_OBJ_HWPT_EXTERNAL. Output the HWPT ID
  *
  * This connects the device/pasid to an iommu_domain, either automatically
  * or manually selected. Once this completes the device could do DMA with
@@ -1099,8 +1100,8 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  * iommufd_device_replace - Change the device/pasid's iommu_domain
  * @idev: device to change
  * @pasid: pasid to change
- * @pt_id: Input an IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
- *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
+ * @pt_id: Input an IOMMUFD_OBJ_IOAS, IOMMUFD_OBJ_HWPT_PAGING, or
+ *         IOMMUFD_OBJ_HWPT_EXTERNAL. Output the HWPT ID
  *
  * This is the same as::
  *
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ef6e119c2a75..324a81d9bae4 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -77,6 +77,20 @@ void iommufd_hwpt_nested_abort(struct iommufd_object *obj)
 	iommufd_hwpt_nested_destroy(obj);
 }
 
+void iommufd_hwpt_external_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hwpt_external *hwpt_external =
+		container_of(obj, struct iommufd_hwpt_external, common.obj);
+
+	__iommufd_hwpt_destroy(&hwpt_external->common);
+	refcount_dec(&hwpt_external->viommu->obj.users);
+}
+
+void iommufd_hwpt_external_abort(struct iommufd_object *obj)
+{
+	iommufd_hwpt_external_destroy(obj);
+}
+
 static int
 iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 {
@@ -306,6 +320,8 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (!viommu->hwpt)
+		return ERR_PTR(-EINVAL);
 	if (!viommu->ops || !viommu->ops->alloc_domain_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -342,6 +358,53 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(rc);
 }
 
+static struct iommufd_hwpt_external *
+iommufd_viommu_alloc_hwpt_external(struct iommufd_viommu *viommu, u32 flags,
+				   const struct iommu_user_data *user_data)
+{
+	struct iommufd_hwpt_external *hwpt_external;
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!user_data->len)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!viommu->ops || !viommu->ops->alloc_domain_external)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hwpt_external = __iommufd_object_alloc(viommu->ictx, hwpt_external,
+					       IOMMUFD_OBJ_HWPT_EXTERNAL,
+					       common.obj);
+	if (IS_ERR(hwpt_external))
+		return ERR_CAST(hwpt_external);
+	hwpt = &hwpt_external->common;
+
+	hwpt_external->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+
+	hwpt->domain = viommu->ops->alloc_domain_external(viommu, flags,
+							user_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+	hwpt->domain->iommufd_hwpt = hwpt;
+	hwpt->domain->owner = viommu->iommu_dev->ops;
+	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
+
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_EXTERNAL)) {
+		rc = -EOPNOTSUPP;
+		goto out_abort;
+	}
+	return hwpt_external;
+
+out_abort:
+	iommufd_object_abort_and_destroy(viommu->ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
@@ -399,6 +462,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		}
 		hwpt = &hwpt_nested->common;
 	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_external *hwpt_external;
 		struct iommufd_hwpt_nested *hwpt_nested;
 		struct iommu_device *iommu_dev;
 		struct iommufd_viommu *viommu;
@@ -409,13 +473,25 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			rc = -EINVAL;
 			goto out_unlock;
 		}
-		hwpt_nested = iommufd_viommu_alloc_hwpt_nested(
-			viommu, cmd->flags, &user_data);
-		if (IS_ERR(hwpt_nested)) {
-			rc = PTR_ERR(hwpt_nested);
-			goto out_unlock;
+		if (cmd->data_type == IOMMU_HWPT_DATA_EXTERNAL) {
+			hwpt_external =
+				iommufd_viommu_alloc_hwpt_external(viommu,
+								   cmd->flags,
+								   &user_data);
+			if (IS_ERR(hwpt_external)) {
+				rc = PTR_ERR(hwpt_external);
+				goto out_unlock;
+			}
+			hwpt = &hwpt_external->common;
+		} else {
+			hwpt_nested = iommufd_viommu_alloc_hwpt_nested(
+				viommu, cmd->flags, &user_data);
+			if (IS_ERR(hwpt_nested)) {
+				rc = PTR_ERR(hwpt_nested);
+				goto out_unlock;
+			}
+			hwpt = &hwpt_nested->common;
 		}
-		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb2e85b27e42..8b7aaaaba194 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -403,6 +403,11 @@ struct iommufd_hwpt_nested {
 	struct iommufd_viommu *viommu;
 };
 
+struct iommufd_hwpt_external {
+	struct iommufd_hw_pagetable common;
+	struct iommufd_viommu *viommu;
+};
+
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
 {
 	return hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING;
@@ -465,6 +470,8 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj);
+void iommufd_hwpt_external_destroy(struct iommufd_object *obj);
+void iommufd_hwpt_external_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b153162..6835bb87916a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -736,6 +736,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
+	[IOMMUFD_OBJ_HWPT_EXTERNAL] = {
+		.destroy = iommufd_hwpt_external_destroy,
+		.abort = iommufd_hwpt_external_abort,
+	},
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..ce740a2d1588 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -31,6 +31,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_DEVICE,
 	IOMMUFD_OBJ_HWPT_PAGING,
 	IOMMUFD_OBJ_HWPT_NESTED,
+	IOMMUFD_OBJ_HWPT_EXTERNAL,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
@@ -149,6 +150,12 @@ struct iommufd_hw_queue {
  *                       must be defined in include/uapi/linux/iommufd.h.
  *                       It must fully initialize the new iommu_domain before
  *                       returning. Upon failure, ERR_PTR must be returned.
+ * @alloc_domain_external: Allocate a IOMMU_DOMAIN_EXTERNAL on a vIOMMU that holds
+ *                       the VM identity for an external attach domain. @user_data must
+ *                       be defined in
+ *                       include/uapi/linux/iommufd.h. It must fully initialize
+ *                       the new iommu_domain before returning. Upon failure,
+ *                       ERR_PTR must be returned.
  * @cache_invalidate: Flush hardware cache used by a vIOMMU. It can be used for
  *                    any IOMMU hardware specific cache: TLB and device cache.
  *                    The @array passes in the cache invalidation requests, in
@@ -186,6 +193,10 @@ struct iommufd_viommu_ops {
 	struct iommu_domain *(*alloc_domain_nested)(
 		struct iommufd_viommu *viommu, u32 flags,
 		const struct iommu_user_data *user_data);
+	struct iommu_domain *
+		(*alloc_domain_external)(struct iommufd_viommu *viommu,
+					 u32 flags,
+					 const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
 	const size_t vdevice_size;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index bffa25c5267e..fa6185f04c1c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -506,18 +506,31 @@ struct iommu_hwpt_amd_guest {
 	__aligned_u64 dte[4];
 };
 
+/**
+ * struct iommu_hwpt_external - external attach domain
+ *			      (IOMMU_HWPT_DATA_EXTERNAL)
+ * @flags: Must be 0
+ * @__reserved: Must be 0
+ */
+struct iommu_hwpt_external {
+	__u32 flags;
+	__u32 __reserved;
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
  * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
+ * @IOMMU_HWPT_DATA_EXTERNAL: external attach domain
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
 	IOMMU_HWPT_DATA_AMD_GUEST = 3,
+	IOMMU_HWPT_DATA_EXTERNAL = 4,
 };
 
 /**
@@ -552,6 +565,10 @@ enum iommu_hwpt_data_type {
  * via @dev_id and the vIOMMU via @pt_id must be associated to the same IOMMU
  * instance.
  *
+ * An external attach HWPT can be created from a given vIOMMU via @pt_id. In this
+ * case, @data_type selects the external attach domain type, such as
+ * IOMMU_HWPT_DATA_EXTERNAL, and the created HWPT is not IOAS-backed.
+ *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
  * must be given.
-- 
2.43.0

