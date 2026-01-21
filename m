Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E3258CE5;
	Wed, 21 Jan 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031988; cv=none; b=blVTYW+lm3eXR5lVIWeMuMVVDKdwOdy7KOsOuV96W+nmzuJQ8iZvRWwRKIJxRp2Lgzal6/3Xrh2o6Zq/t+McXbZaXjxJ92c+Yq5fd/blalt5DIAnvmj/zYde6J6RWapRa46wZAH5nt7cQRMxJY6ulfzEb/YILsdkl59yJ3md/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031988; c=relaxed/simple;
	bh=L4E1wo8/6fKvJEozXW8vtzU2hTEpjK6jREA7Bfv0oJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkYE11tBWEs50yqgV0gNvDD5wk6rjQtpGEjaoQw9Yp9ZCCXXjCa1GbZ0PdyPxDgOWWY8uckELYabKDWkN1eV0cqgq/1xKEFfVIrqpIdVe6AV4i/fdV9fg3xJiKPallYEEjNFH+ILwLvjX2DSCdKLxm1Ri2KHvCBQ9Lvu+yDUNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pCCpMLY6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pCCpMLY6"
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 993B720B716D; Wed, 21 Jan 2026 13:46:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 993B720B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031986;
	bh=uE6yNFSdJktjcXi31tIk+NXAAyXVgXT3CJcMYC5oQGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCCpMLY6aaHjBaV1L7lqGdaxICtgPl5GrxAKxR1QsC86Es27Dj5Bj6LDgglCFBM/j
	 6P7MnHmxTJvLCzl3yIFJBGTADaDk3qdOrW5aIxiYdj47F4bqHlAieI/dECEa6K360V
	 15VziVPNxu7AD27f7DqP1fDgR8xM3Q7eAX8RVk4A=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v4 4/7] mshv: Always map child vp stats pages regardless of scheduler type
Date: Wed, 21 Jan 2026 13:46:20 -0800
Message-ID: <20260121214623.76374-5-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Currently vp->vp_stats_pages is only used by the root scheduler for fast
interrupt injection.

Soon, vp_stats_pages will also be needed for exposing child VP stats to
userspace via debugfs. Mapping the pages a second time to a different
address causes an error on L1VH.

Remove the scheduler requirement and always map the vp stats pages.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index faca3cc63e79..fbfc9e7d9fa4 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1077,16 +1077,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 			goto unmap_register_page;
 	}
 
-	/*
-	 * This mapping of the stats page is for detecting if dispatch thread
-	 * is blocked - only relevant for root scheduler
-	 */
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
-		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
-					stats_pages);
-		if (ret)
-			goto unmap_ghcb_page;
-	}
+	ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
+				stats_pages);
+	if (ret)
+		goto unmap_ghcb_page;
 
 	vp = kzalloc(sizeof(*vp), GFP_KERNEL);
 	if (!vp)
@@ -1110,8 +1104,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		vp->vp_ghcb_page = page_to_virt(ghcb_page);
 
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
+	memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
 	/*
 	 * Keep anon_inode_getfd last: it installs fd in the file struct and
@@ -1133,8 +1126,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 free_vp:
 	kfree(vp);
 unmap_stats_pages:
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
+	mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
@@ -1754,9 +1746,8 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
-			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
-						    vp->vp_stats_pages);
+			mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
+					    vp->vp_stats_pages);
 
 			if (vp->vp_register_page) {
 				(void)hv_unmap_vp_state_page(partition->pt_id,
-- 
2.34.1

