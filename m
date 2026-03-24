Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B83CB2F1;
	Tue, 24 Mar 2026 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396800; cv=none; b=ZlULjnL2h5h7dkGqzJZavBgg0CqqIOkI1gnVYjdoleO3rvSt+qA0j1mnmvE6GDyTs95iw6dsnEgaqsjuf5lgcX87cvNZE+gUgLQdTZTiapKw5O8DOxHpFrorQbGKVW5KE2w38MdnCLBZKv/58rQqrABSH1qguvIUM0HmvwDrUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396800; c=relaxed/simple;
	bh=xCY+fJVJRKTZ/TSuuIAEqFtk5RX5+LEwEBVDS5MpV38=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=jcL8tHBdfiO/05TeJ0Ui/cfolTCVYZ7hfnzFSw88hi3PnHtxqL8+9luz3YnYRDKWQOe1gkNe78efNJ30WsVWB5jguRRbs3nx3bWwtw6CWrL5NDFhVJkhb4m3DiBgYKzZO9iFJYGC89jnzdMntqGC3dIxkdq/INdXdCA8FTBELnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mkn8386i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mkn8386i"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B9F320B7001;
	Tue, 24 Mar 2026 16:59:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B9F320B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774396799;
	bh=M2Z5FMeo7oWGA0PPWGad/fv7CdzFKNYhtC8weqaRKlY=;
	h=Subject:From:To:Cc:Date:From;
	b=mkn8386i5JxYyR1e396/b6sn5Z75Bvt/fIDGwUDIvAkZLxd3ETXkxRLOjQneZOwKR
	 tq/ELSztv4TyFSHSdiDzE6dl8bZc8pedhux0xs3mBmtOUzAK8C2tqVoptR3Fr2RBBo
	 fxhl3+yw0rwNQZW+Bs2M8mTY0RAgzcPHXZJmJEI4=
Subject: [PATCH] mshv: Add tracepoint for GPA intercept handling
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 23:59:59 +0000
Message-ID: 
 <177439679671.175364.15362688285596134992.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Provide visibility into GPA intercept operations for debugging and
performance analysis of Microsoft Hypervisor guest memory management.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    6 ++++--
 drivers/hv/mshv_trace.h     |   29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bb9fe4985e95..d4aab09fba47 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -675,7 +675,7 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 
 	region = mshv_partition_region_by_gfn_get(p, gfn);
 	if (!region)
-		return false;
+		goto out;
 
 	if (access_type == HV_INTERCEPT_ACCESS_WRITE &&
 	    !(region->hv_map_flags & HV_MAP_GPA_WRITABLE))
@@ -691,7 +691,9 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 
 put_region:
 	mshv_region_put(region);
-
+out:
+	trace_mshv_handle_gpa_intercept(p->pt_id, vp->vp_index, gfn,
+					access_type, ret);
 	return ret;
 }
 
diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
index ba3b3f575983..6b8fa477fa3b 100644
--- a/drivers/hv/mshv_trace.h
+++ b/drivers/hv/mshv_trace.h
@@ -12,6 +12,7 @@
 #define _MSHV_TRACE_H_
 
 #include <linux/tracepoint.h>
+#include <hyperv/hvhdk.h>
 
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH ../../drivers/hv
@@ -509,6 +510,34 @@ TRACE_EVENT(mshv_vp_wait_for_hv_kick,
 	    )
 );
 
+TRACE_EVENT(mshv_handle_gpa_intercept,
+	    TP_PROTO(u64 partition_id, u32 vp_index, u64 gfn, u8 access_type, bool handled),
+	    TP_ARGS(partition_id, vp_index, gfn, access_type, handled),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(u64, gfn)
+		    __field(u8, access_type)
+		    __field(bool, handled)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->gfn = gfn;
+		    __entry->access_type = access_type;
+		    __entry->handled = handled;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u gfn=0x%llx access_type=%c handled=%d",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->gfn,
+		    __entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
+				    (__entry->access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
+				    (__entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'X' : '?')),
+		    __entry->handled
+	    )
+);
+
 #endif /* _MSHV_TRACE_H_ */
 
 /* This part must be outside protection */


