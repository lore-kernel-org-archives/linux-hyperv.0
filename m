Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6926CE26;
	Wed, 10 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546094; cv=none; b=hX5p5EvL02tV5eOaaQQ8ryxNmpeugxUTwlsUQFNjPZNUuBGKEm4tIm2RTE6LTBDwImJPelG0ipqPc9EHkB6LW7sI4/g4M8Y2ncqW++1QWI9P1wRf3dm6i+l30/0WV31eE2cIPdM2kqcSa4C9z1hcgDPTI+LSpT+U4jEnLrVPk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546094; c=relaxed/simple;
	bh=UxGnvZTqfVMwqR+6oXhusmF727Q7xr8fIkkNq4k84CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=h307LQoyrKRfIjr/BfEb3ShU8YfwFVh2TovLWSuvdrXZNALBncPfGqhKQz9NbNq2Ta22Ns4BlLM1xExPgXxPoYK45ssYoOiagS4vqfBEW9aUscoh4wI/3MA5TEw+FUG7HA78Ern8l8WFq0bKPezgy81QC8jW/Gg+XIRTT1+AyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YZFfEExa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YZFfEExa"
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id F039820171D9; Wed, 10 Sep 2025 16:14:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F039820171D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757546092;
	bh=7i5aUGbbHrkn65yck0kCNqpX4hm9ShUUKImb3igG/7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZFfEExa2m/tNzX6nQfNcmaGAnSxTEanxQBho/wyNE9eB/b00tI37wCE5yCnAv8zG
	 HXEVFP9pBbfhyoTlIHkef/U4Nbc1cCZG1cFZ2rxREBBetQJmgnLiPBIwvknGUWQofA
	 htRr1ckftyWnj6nmZ+ffIVfA3Ucx4m3ndMvCEayk=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 1/5] mshv: Only map vp->vp_stats_pages if on root scheduler
Date: Wed, 10 Sep 2025 16:14:45 -0700
Message-Id: <1757546089-2002-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This mapping is only used for checking if the dispatch thread is
blocked. This is only relevant for the root scheduler, so check the
scheduler type to determine whether to map/unmap these pages, instead of
the current check, which is incorrect.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/mshv_root_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd417c46..24df47726363 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -934,7 +934,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 			goto unmap_register_page;
 	}
 
-	if (hv_parent_partition()) {
+	/*
+	 * This mapping of the stats page is for detecting if dispatch thread
+	 * is blocked - only relevant for root scheduler
+	 */
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
 		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
 					stats_pages);
 		if (ret)
@@ -963,7 +967,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		vp->vp_ghcb_page = page_to_virt(ghcb_page);
 
-	if (hv_parent_partition())
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
 	/*
@@ -986,7 +990,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 free_vp:
 	kfree(vp);
 unmap_stats_pages:
-	if (hv_parent_partition())
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
@@ -1740,7 +1744,7 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
-			if (hv_parent_partition())
+			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
 
 			if (vp->vp_register_page) {
-- 
2.34.1

