Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539633;
	b=jzt5qOArHmEi4VKo3/exzG4GfUdyIUo5qpE8FVfuLx+QILkbhqHqUfy3o055ASkv2unz
	 rzaEdzgT9IZXDBjcsrk08F9WJAjGRspCFNZCZvx8Vgsiq9RrAVHWwi2MPAQmQGBTAyIu0
	 1v8K1wROqXxWOzUH2ZrQuqmSJDW9ThZjmiQwv29+9tdn2uX16ByT3sNKaWBBb8JgVU7k5
	 Q8E3izbSdl5xmXwKFWCVKMwVKurs7yP8oVybUwxXNJe9NoKdBGnSA8DryFwMO8ZEiDr8C
	 E2unpcEOSu01EjNowoasIPoDXeT7Cr4TIYz/OHp4vEtX2OaEYPFP/mWT9t86W1m9vbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539633;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=rLvIDzuS+bBYcDjqk+6P8BDBb6QRLgcxeyxRXmgzD78=;
	b=zMQUp8YSVqdMNb4EebPfiSfHXvADC2gzzUGfxZZnSAXSfYh824rk/vYxQxuvewDoKHiJ
	 wc5vIIpb1wIqKvUYTDUroj0iiojQRjdrdO1rdZu5LPQtgK8NSz3t1IpQh4SSReitqfncZ
	 HMS1MGDGL+HHNT4MsEKnG2HZvZ9ySxET+QEX7lCzi20nIVVVp1d24oMv3ZHhMayjphLy5
	 JKbqQ0B545asC+vWWVHSqDmThnU1l66iLt7yrZiB2PAmDmD+IZhSEraM42rZdpJgVEksr
	 LinxaB5zjX0JtReHCfaE9cs4yCMVwgziBFXSWZ0D/d9cvYxsDclnD/YQvUfhk8IvYKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=R1smuqmx;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17C606A323;
	Fri, 13 Nov 2026 03:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A17C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=R1smuqmx
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9DF9220B7166;
	Thu, 12 Nov 2026 19:13:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DF9220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794539628;
	bh=rLvIDzuS+bBYcDjqk+6P8BDBb6QRLgcxeyxRXmgzD78=;
	h=From:To:Cc:Subject:Date:From;
	b=R1smuqmxw4svIv+CUHb/DzuDOLOIH+sQuFI2HJCXZlV/9bZ4qOC/F0oKC/SJdrbdn
	 7LazFP0LNH87BdLVv9nbKIz4CW8OhGMq0u240YJ6lqdoSlxYlZyXexf0jduMB8iwBX
	 DtiW4dVP0ieQsgaUu8fLPc4ZIReoDTE7xd2MH4RQ=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH] mshv: Do not map mmio in map user memory ioctl
Date: Thu, 12 Nov 2026 19:13:43 -0800
Message-ID: <20261113031343.896489-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mshv_map_user_memory() snoops into vma to get the mmio
pfn via vm_pgoff. The mmio pfn is no longer stored there and will
cause the system to crash. Moreover, it is not legit to obtain
mmio pfn via that method. So, remove upfront mmio mappings, just
create region and do basic checks. The mmio entries will be populated
on demand during intercepts in future.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |  1 -
 drivers/hv/mshv_root_hv_call.c | 15 ---------------
 drivers/hv/mshv_root_main.c    | 28 +++++++++++-----------------
 3 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index c61b52db7f00..c0844b28b6a8 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -281,7 +281,6 @@ int hv_call_create_partition(u64 flags,
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
 int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 			  u32 flags, struct page **pages);
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index e8485d949951..1287c0a8d118 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -327,21 +327,6 @@ int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 				   flags, pages, 0);
 }
 
-/* Ask the hypervisor to map guest mmio space */
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
-{
-	int i;
-	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
-		    HV_MAP_GPA_NOT_CACHED;
-
-	for (i = 0; i < numpgs; i++)
-		if (page_is_ram(mmio_spa + i))
-			return -EINVAL;
-
-	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
-				   mmio_spa);
-}
-
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 			    u32 flags)
 {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index f0bfbbbd7bdd..a11756e5c48d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1345,16 +1345,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 }
 
 /*
- * This maps two things: guest RAM and for pci passthru mmio space.
- *
- * mmio:
- *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
- *  - Two things need to happen for mapping mmio range:
- *	1. mapped in the uaddr so VMM can access it.
- *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
- *
- *   This function takes care of the second. The first one is managed by vfio,
- *   and hence is taken care of via vfio_pci_mmap_fault().
+ * This is called for both user ram and mmio space. The mmio space is not
+ * mapped here, that should happen later during intercept on demand.
  */
 static long
 mshv_map_user_memory(struct mshv_partition *partition,
@@ -1363,7 +1355,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	struct mshv_mem_region *region;
 	struct vm_area_struct *vma;
 	bool is_mmio;
-	ulong mmio_pfn;
+	size_t vma_sz;
 	long ret;
 
 	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
@@ -1373,12 +1365,18 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, mem->userspace_addr);
 	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
-	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
+	if (vma && is_mmio)
+		vma_sz = vma->vm_end - mem->userspace_addr;
 	mmap_read_unlock(current->mm);
 
 	if (!vma)
 		return -EINVAL;
 
+	if (is_mmio)
+		/* Upon mmio intercept, entire region is mapped */
+		if (mem->size > vma_sz)
+			return -EPERM;
+
 	ret = mshv_partition_create_region(partition, mem, &region,
 					   is_mmio);
 	if (ret)
@@ -1399,11 +1397,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 					    region->nr_pages,
 					    HV_MAP_GPA_NO_ACCESS, NULL);
 		break;
-	case MSHV_REGION_TYPE_MMIO:
-		ret = hv_call_map_mmio_pages(partition->pt_id,
-					     region->start_gfn,
-					     mmio_pfn,
-					     region->nr_pages);
+	default:
 		break;
 	}
 
-- 
2.51.2.vfs.0.1

