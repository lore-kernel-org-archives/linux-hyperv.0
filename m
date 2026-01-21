Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1722F388;
	Wed, 21 Jan 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031988; cv=none; b=qkj3NwqqEUD8FjFW3xUDvaEY6upziSmmD9OZkWexsmMA1K08fTw5BAtKvpGBYsAKmd3+6s05BWo6vcjAMaa8x6Kkxq+5AvszuhU6n4vdEy+waPrIttTLnCupIvPmQXq4YO6OofPVWk9fRCs+uYSYzE4Tal0mZqNiRorRU/BW6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031988; c=relaxed/simple;
	bh=2s9lIeHsh8FM2pqJpMLaCsT4ujORbpAFNEZIFfRk+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEj3DD4CMBjhR3Lo475OO8pw4g9wHOaYDZSJMeG+uQf7TxYrm1cnY50C3J8UMfqaJ1orGnIOUvekHnsv2sdVWosq9Errp9fAwXeFvXb23Z2uhntpjIODIti3ZodcxEew2J9A0Xr7mrhfZaW5QmHw2KRhl79azrDXsUNwQ/wPiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mnFD4pdQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mnFD4pdQ"
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 27E3020B716C; Wed, 21 Jan 2026 13:46:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27E3020B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031986;
	bh=9BzoOa0wVBQB143I2PH957+WYxTAU/R3jKcGrn898r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnFD4pdQYLOx/wpK7yrZqns3LEldUQUqqo+oq3cMXrLjjHddyFJNfYIsgdcL+fGp4
	 9zEjwXVL2cQgo9agOEB7Kz4bjpYM33lcdtbmLVRAXtostk+Rk0TbEPDNGTKL3zVyhl
	 UXwxn4ARlqhQhLXtQFlFQIvLsJ3ebeVxd+yPvftM=
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
Subject: [PATCH v4 3/7] mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
Date: Wed, 21 Jan 2026 13:46:19 -0800
Message-ID: <20260121214623.76374-4-nunodasneves@linux.microsoft.com>
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

These functions are currently only used to map child partition VP stats,
on root partition. However, they will soon be used on L1VH, and and also
used for mapping the host's own VP stats.

Introduce a helper is_l1vh_parent() to determine whether we are mapping
our own VP stats. In this case, do not attempt to map the PARENT area.
Note this is a different case than mapping PARENT on an older hypervisor
where it is not available at all, so must be handled separately.

On unmap, pass the stats pages since on L1VH the kernel allocates them
and they must be freed in hv_unmap_stats_page().

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      | 10 ++++++
 drivers/hv/mshv_root_main.c | 61 ++++++++++++++++++++++++++-----------
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 05ba1f716f9e..e4912b0618fa 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -254,6 +254,16 @@ struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
 void mshv_partition_put(struct mshv_partition *partition);
 struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold(RCU);
 
+static inline bool is_l1vh_parent(u64 partition_id)
+{
+	return hv_l1vh_partition() && (partition_id == HV_PARTITION_ID_SELF);
+}
+
+int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
+		      struct hv_stats_page **stats_pages);
+void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
+			 struct hv_stats_page **stats_pages);
+
 /* hypercalls */
 
 int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index be5ad0fbfbee..faca3cc63e79 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -956,23 +956,36 @@ mshv_vp_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
-				struct hv_stats_page *stats_pages[])
+void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
+			 struct hv_stats_page *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
 		.vp.vp_index = vp_index,
 	};
+	int err;
 
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
-
-	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_VP,
+				  stats_pages[HV_STATS_AREA_SELF],
+				  &identity);
+	if (err)
+		pr_err("%s: failed to unmap partition %llu vp %u self stats, err: %d\n",
+		       __func__, partition_id, vp_index, err);
+
+	if (stats_pages[HV_STATS_AREA_PARENT] != stats_pages[HV_STATS_AREA_SELF]) {
+		identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
+		err = hv_unmap_stats_page(HV_STATS_OBJECT_VP,
+					  stats_pages[HV_STATS_AREA_PARENT],
+					  &identity);
+		if (err)
+			pr_err("%s: failed to unmap partition %llu vp %u parent stats, err: %d\n",
+			       __func__, partition_id, vp_index, err);
+	}
 }
 
-static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
-			     struct hv_stats_page *stats_pages[])
+int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
+		      struct hv_stats_page *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
@@ -983,23 +996,37 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
 	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
 				&stats_pages[HV_STATS_AREA_SELF]);
-	if (err)
+	if (err) {
+		pr_err("%s: failed to map partition %llu vp %u self stats, err: %d\n",
+		       __func__, partition_id, vp_index, err);
 		return err;
+	}
 
-	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
-				&stats_pages[HV_STATS_AREA_PARENT]);
-	if (err)
-		goto unmap_self;
-
-	if (!stats_pages[HV_STATS_AREA_PARENT])
+	/*
+	 * L1VH partition cannot access its vp stats in parent area.
+	 */
+	if (is_l1vh_parent(partition_id)) {
 		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+	} else {
+		identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
+		err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
+					&stats_pages[HV_STATS_AREA_PARENT]);
+		if (err) {
+			pr_err("%s: failed to map partition %llu vp %u parent stats, err: %d\n",
+			       __func__, partition_id, vp_index, err);
+			goto unmap_self;
+		}
+		if (!stats_pages[HV_STATS_AREA_PARENT])
+			stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+	}
 
 	return 0;
 
 unmap_self:
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP,
+			    stats_pages[HV_STATS_AREA_SELF],
+			    &identity);
 	return err;
 }
 
-- 
2.34.1

