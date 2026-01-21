Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587C31AF1F;
	Wed, 21 Jan 2026 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031987; cv=none; b=uOj52XxtSB41rM1rV1fxzq59WjjTpgKl4zOFGzEZOdsPS5Va1k9d5+e6WOzcTkaA+lU3t3aafv1ighbEe2ImmxosjzRj3UwLjI0y4jy75nBIg8IU4EiHSMIkCdS4mHa1InhD5Yd8RpxbaJdLKihean4eJRhICE51TBIv5S0tyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031987; c=relaxed/simple;
	bh=uzeRuEk6mtsIaTnRbzrMVlLOgjMqQcPry4umGAax9Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF3TLSvVRkUaIiPhRE584qXYdB443JeaxeEyR2bv6hZNeVwzFdxGW1eRQBJurU4KtI9ijhPpBzwivsK5ieEDfP+ORDTk7TaJItHyRp+JvF8zO4or3HuJRSf+V15zPwv3coianwFV9UmKoOKUxW3cbPBS6vhFnRRsK2Kv/qlmnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hlS9IOWS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hlS9IOWS"
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 7AF9620B716A; Wed, 21 Jan 2026 13:46:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AF9620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031985;
	bh=z2o6YdqfB0oQMRtuk5ZapbPpFV9AcJv3FrMTfcI1w9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlS9IOWSscxA/z9D90ct/tz9QeIvWpz1qFkpKNtmd3s02EbyTwo87q3TnV5Xx8P5J
	 Oh6ZtcDQL8aFWK86RNbDoE07L8mMyI19KWCyzWlWkN78iNTNEP2Kh56WIF5WtBJjBb
	 HyQbtAv8/pXeuzSp0/BCucYiNPnNCdo9HPBDEL2I=
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
Subject: [PATCH v4 1/7] mshv: Ignore second stats page map result failure
Date: Wed, 21 Jan 2026 13:46:17 -0800
Message-ID: <20260121214623.76374-2-nunodasneves@linux.microsoft.com>
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

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

Older versions of the hypervisor do not have a concept of separate SELF
and PARENT stats areas. In this case, mapping the HV_STATS_AREA_SELF page
is sufficient - it's the only page and it contains all available stats.

Mapping HV_STATS_AREA_PARENT returns HV_STATUS_INVALID_PARAMETER which
currently causes module init to fail on older hypevisor versions.

Detect this case and gracefully fall back to populating
stats_pages[HV_STATS_AREA_PARENT] with the already-mapped SELF page.

Add comments to clarify the behavior, including a clarification of why
this isn't needed for hv_call_map_stats_page2() which always supports
PARENT and SELF areas.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c | 52 +++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    |  3 ++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 598eaff4ff29..1f93b94d7580 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -813,6 +813,13 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 	return hv_result_to_errno(status);
 }
 
+/*
+ * Equivalent of hv_call_map_stats_page() for cases when the caller provides
+ * the map location.
+ *
+ * NOTE: This is a newer hypercall that always supports SELF and PARENT stats
+ * areas, unlike hv_call_map_stats_page().
+ */
 static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 				   const union hv_stats_object_identity *identity,
 				   u64 map_location)
@@ -855,6 +862,34 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 	return ret;
 }
 
+static int
+hv_stats_get_area_type(enum hv_stats_object_type type,
+		       const union hv_stats_object_identity *identity)
+{
+	switch (type) {
+	case HV_STATS_OBJECT_HYPERVISOR:
+		return identity->hv.stats_area_type;
+	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
+		return identity->lp.stats_area_type;
+	case HV_STATS_OBJECT_PARTITION:
+		return identity->partition.stats_area_type;
+	case HV_STATS_OBJECT_VP:
+		return identity->vp.stats_area_type;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Map a stats page, where the page location is provided by the hypervisor.
+ *
+ * NOTE: The concept of separate SELF and PARENT stats areas does not exist on
+ * older hypervisor versions. All the available stats information can be found
+ * on the SELF page. When attempting to map the PARENT area on a hypervisor
+ * that doesn't support it, return "success" but with a NULL address. The
+ * caller should check for this case and instead fallback to the SELF area
+ * alone.
+ */
 static int hv_call_map_stats_page(enum hv_stats_object_type type,
 				  const union hv_stats_object_identity *identity,
 				  void **addr)
@@ -863,7 +898,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int ret = 0;
+	int hv_status, ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -878,11 +913,20 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 		pfn = output->map_location;
 
 		local_irq_restore(flags);
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
-			ret = hv_result_to_errno(status);
+
+		hv_status = hv_result(status);
+		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (hv_result_success(status))
 				break;
-			return ret;
+
+			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
+			    hv_status == HV_STATUS_INVALID_PARAMETER) {
+				*addr = NULL;
+				return 0;
+			}
+
+			hv_status_debug(status, "\n");
+			return hv_result_to_errno(status);
 		}
 
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1134a82c7881..1777778f84b8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -992,6 +992,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	if (err)
 		goto unmap_self;
 
+	if (!stats_pages[HV_STATS_AREA_PARENT])
+		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+
 	return 0;
 
 unmap_self:
-- 
2.34.1

