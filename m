Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131ED4477F1;
	Fri, 25 Sep 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363286; cv=none; b=DjZK/LtpLi4h4IZkP8LjNwDP7pg8vymARo+XqwqRuUkBwRz+ld7RgeSYvh/MQ26zY5UPhq0SpyEdtxzbw7d8J4GEJZ4/eLlit592Y1V/L6cI5QSZs/OctGasBABltbVDFNKxUs/lQFuEUTgwl2EYy3FITZsUU5Pb4NaEFo1CZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363286; c=relaxed/simple;
	bh=ZdQJDDGW4lUBuCtKFY4T8gJFKiVS7i7AmhzwavspORg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTOBxUfUwnHlg9+h32hOFHk9pnXGptFc8i2tdbFKahQVFmg5n8XihVuwnYoUghqAJELBlah6H22T9VAu7Q/ISLfB2NFVm2Bg+NruO0A2MKrBrqdqwzbGTzrlgA94I7v0khM4hHAyIuhk1AzdrBsYvFqJKIgh6qowxyK15nEH6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=alXX8SCQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="alXX8SCQ"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 955F820B716C;
	Fri, 25 Sep 2026 12:06:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 955F820B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363217;
	bh=fijCSuW93BNMPdpXySvcNdr2/KSgXrJ1FOfFp3s4emU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alXX8SCQskUEQIt9X+L64dvlDfeW2ac4c3Vf1gQYq8qkxSwxoYvGgJl2GCsYbrNn9
	 WtVgIdH4pxY/GG0z6ppiQeRASdsuVXIqGVvW70nPguRsXPWLn56jTUbMVMJR+vtkCH
	 eKLwqXsGqWN2we+mLE1VP87LY3LGBLOraz5+lWWg=
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
Subject: [PATCH RFC 4/9] iommufd/selftest: Add hypervisor external attach backend
Date: Fri, 25 Sep 2026 12:07:37 -0700
Message-ID: <20260925190742.1575380-5-jacob.pan@linux.microsoft.com>
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

Teach the mock IOMMU driver to allocate an hypervisor vIOMMU from a
partition fd and to allocate an external domain for external attach HWPT
testing.

Require a matching vDEVICE during external-domain attach so the selftest
backend exercises the vIOMMU/vDEVICE/HWPT relationship used by the
external attach flow.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/selftest.c | 120 ++++++++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ee706f18f7e9..b264114b6552 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -28,6 +28,7 @@ static struct dentry *dbgfs_root;
 static struct platform_device *selftest_iommu_dev;
 static const struct iommu_ops mock_ops;
 static struct iommu_domain_ops domain_nested_ops;
+static struct iommu_domain_ops domain_direct_ops;
 
 size_t iommufd_test_memory_limit = 65536;
 
@@ -142,9 +143,21 @@ to_mock_nested(struct iommu_domain *domain)
 	return container_of(domain, struct mock_iommu_domain_nested, domain);
 }
 
+struct mock_iommu_domain_direct {
+	struct iommu_domain domain;
+	struct mock_viommu *mock_viommu;
+};
+
+static inline struct mock_iommu_domain_direct *
+to_mock_direct(struct iommu_domain *domain)
+{
+	return container_of(domain, struct mock_iommu_domain_direct, domain);
+}
+
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+	struct file *vm_file;
 	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
 	struct mutex queue_mutex;
 
@@ -231,6 +244,12 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 			if (rc)
 				return rc;
 		}
+	} else if (domain->type == IOMMU_DOMAIN_EXTERNAL) {
+		new_viommu = to_mock_direct(domain)->mock_viommu;
+		rc = iommufd_viommu_get_vdev_id(&new_viommu->core, dev,
+						&vdev_id);
+		if (rc)
+			return rc;
 	}
 	if (new_viommu != mdev->viommu) {
 		down_write(&mdev->viommu_rwsem);
@@ -607,7 +626,15 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 	if (mock_viommu->mmap_offset)
 		iommufd_viommu_destroy_mmap(&mock_viommu->core,
 					    mock_viommu->mmap_offset);
-	free_pages((unsigned long)mock_viommu->page, 1);
+	if (mock_viommu->page)
+		free_pages((unsigned long)mock_viommu->page, 1);
+	if (mock_viommu->vm_file) {
+		pr_info("iommufd selftest: MSHV viommu destroy drops pinned vm_file=%p\n",
+			mock_viommu->vm_file);
+		fput(mock_viommu->vm_file);
+		pr_info("iommufd selftest: MSHV viommu dropped pinned vm_file=%p\n",
+			mock_viommu->vm_file);
+	}
 	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
@@ -630,6 +657,40 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return &mock_nested->domain;
 }
 
+static struct iommu_domain *
+mock_viommu_alloc_domain_external(struct iommufd_viommu *viommu, u32 flags,
+				  const struct iommu_user_data *user_data)
+{
+	struct mock_iommu_domain_direct *mock_direct;
+	struct iommu_hwpt_external data = {};
+	int rc;
+
+	if (viommu->type != IOMMU_VIOMMU_TYPE_HYPERVISOR)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (user_data->type != IOMMU_HWPT_DATA_EXTERNAL)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	rc = iommu_copy_struct_from_user(&data, user_data,
+					 IOMMU_HWPT_DATA_EXTERNAL, flags);
+	if (rc)
+		return ERR_PTR(rc);
+	if (data.flags || data.__reserved)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mock_direct = kzalloc_obj(*mock_direct);
+	if (!mock_direct)
+		return ERR_PTR(-ENOMEM);
+
+	mock_direct->domain.ops = &domain_direct_ops;
+	mock_direct->domain.type = IOMMU_DOMAIN_EXTERNAL;
+	mock_direct->mock_viommu = to_mock_viommu(viommu);
+	pr_info("iommufd selftest: external attach domain allocated viommu_id=%u\n",
+		viommu->obj.id);
+	return &mock_direct->domain;
+}
+
 static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 					struct iommu_user_data_array *array)
 {
@@ -777,6 +838,7 @@ static int mock_hw_queue_init_phys(struct iommufd_hw_queue *hw_queue, u32 index,
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
+	.alloc_domain_external = mock_viommu_alloc_domain_external,
 	.cache_invalidate = mock_viommu_cache_invalidate,
 	.get_hw_queue_size = mock_viommu_get_hw_queue_size,
 	.hw_queue_init_phys = mock_hw_queue_init_phys,
@@ -785,7 +847,8 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
 static size_t mock_get_viommu_size(struct device *dev,
 				   enum iommu_viommu_type viommu_type)
 {
-	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
+	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST &&
+	    viommu_type != IOMMU_VIOMMU_TYPE_HYPERVISOR)
 		return 0;
 	return VIOMMU_STRUCT_SIZE(struct mock_viommu, core);
 }
@@ -797,10 +860,32 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
 	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
-	struct iommu_viommu_selftest data;
+	struct iommu_viommu_selftest data = {};
 	int rc;
 
-	if (user_data) {
+	if (viommu->type == IOMMU_VIOMMU_TYPE_HYPERVISOR) {
+		struct iommu_viommu_hypervisor hypervisor = {};
+
+		if (!user_data)
+			return -EINVAL;
+
+		rc = iommu_copy_struct_from_user(&hypervisor, user_data,
+						 IOMMU_VIOMMU_TYPE_HYPERVISOR,
+						 vm_fd);
+		if (rc)
+			return rc;
+		if (hypervisor.flags || hypervisor.__reserved)
+			return -EOPNOTSUPP;
+
+		mock_viommu->vm_file = fget(hypervisor.vm_fd);
+		if (!mock_viommu->vm_file)
+			return -EBADF;
+		pr_info("iommufd selftest: MSHV viommu init type=%u vm_fd=%d vm_file=%p has_hwpt_paging=%u\n",
+			viommu->type, hypervisor.vm_fd, mock_viommu->vm_file,
+			!!parent_domain);
+		pr_info("iommufd selftest: MSHV viommu pins vm_file=%p, userspace close waits for viommu destroy\n",
+			mock_viommu->vm_file);
+	} else if (user_data) {
 		rc = iommu_copy_struct_from_user(
 			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
 		if (rc)
@@ -809,8 +894,10 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 		/* Allocate two pages */
 		mock_viommu->page =
 			(u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
-		if (!mock_viommu->page)
-			return -ENOMEM;
+		if (!mock_viommu->page) {
+			rc = -ENOMEM;
+			goto err_put_vm_file;
+		}
 
 		rc = iommufd_viommu_alloc_mmap(&mock_viommu->core,
 					       __pa(mock_viommu->page),
@@ -832,7 +919,8 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 
 	refcount_inc(&mock_iommu->users);
 	mutex_init(&mock_viommu->queue_mutex);
-	mock_viommu->s2_parent = to_mock_domain(parent_domain);
+	if (parent_domain)
+		mock_viommu->s2_parent = to_mock_domain(parent_domain);
 
 	viommu->ops = &mock_viommu_ops;
 	return 0;
@@ -842,6 +930,11 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 				    mock_viommu->mmap_offset);
 err_free_page:
 	free_pages((unsigned long)mock_viommu->page, 1);
+err_put_vm_file:
+	if (mock_viommu->vm_file) {
+		fput(mock_viommu->vm_file);
+		mock_viommu->vm_file = NULL;
+	}
 	return rc;
 }
 
@@ -870,6 +963,11 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(to_mock_nested(domain));
 }
 
+static void mock_domain_free_direct(struct iommu_domain *domain)
+{
+	kfree(to_mock_direct(domain));
+}
+
 static int
 mock_domain_cache_invalidate_user(struct iommu_domain *domain,
 				  struct iommu_user_data_array *array)
@@ -925,6 +1023,11 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
+static struct iommu_domain_ops domain_direct_ops = {
+	.free = mock_domain_free_direct,
+	.attach_dev = mock_domain_nop_attach,
+};
+
 static inline struct iommufd_hw_pagetable *
 __get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id, u32 hwpt_type)
 {
@@ -1817,7 +1920,8 @@ iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
 	if (IS_ERR(pt_obj))
 		return ERR_CAST(pt_obj);
 
-	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
+	if (pt_obj->type != IOMMUFD_OBJ_HWPT_EXTERNAL &&
+	    pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
 	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
 		iommufd_put_object(ucmd->ictx, pt_obj);
 		return ERR_PTR(-EINVAL);
-- 
2.43.0

