Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844082;
	b=sxcukLW6Tkm5G5smZXhQpVsw+MiYIjseSxCj6Dtd/tjhB8GB3UwAZPZxovrIO4l2DV+u
	 dVfPJEHgTKoKSVR+IFNoyFtjLYcG76b2uA2aSSNFZMQKqMHRgD69NBdPJPGy8bPgcY37+
	 zf1N/iG0U+21WL8Gir/O1zA4bPcd2X0ePEVleCLuLvKFISlkBszFvD1+QchRoNkay8RUb
	 VThansLNlEBKAtcAG7WRptsUaVKzpTZmhxeNtNaZ5VPCp3JaPfoAXdJwVWlViuQs+7etf
	 JC5hMnO7Xpm4SyQxjB0Cal1sVxgl5BXN3KoqzXNxSSTWlyhMI2q/BxwBVX2+oJlRTTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844082;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=4Y6oHXTvDP3D/r6bj3sFJrcNWxTqMhnFq48JU9X+5bk=;
	b=1nf6yBT9Tl74gOLV0xIPKXO8Sn38AcBJ8fQXepd6rSmM7exp1FKyasaWTXjDusUSigS2
	 XMgRrarXEN4HD2rIew3ZUXL0XmkJuzzJHtXVJKSbuqU2dkCwDk9fMEjEnnoOgdo9dERJL
	 En5iCzsRHlVXfE2zpDQCg8pz9gq6MAbclz5MNRkOWB2zhLJTJCplxnbIgfHb2HwLFU5Sm
	 K6HLs+FRSY7RrmU95A2PEsWaDbLwnclwsJvELXC/+o7dNzheDhf+5blhLIw8qh9bvdUqQ
	 7/LS9W/ZfK1/FfF9JcqNIyZdL3ggnDCQItjwY5caAA8XVHwF2vu4a5b1eAjCFgDvHpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=J4gTxX0+;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B915606D825;
	Thu,  5 Nov 2026 02:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B915606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=J4gTxX0+
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A18E220B7167;
	Wed,  4 Nov 2026 18:01:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A18E220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793844065;
	bh=4Y6oHXTvDP3D/r6bj3sFJrcNWxTqMhnFq48JU9X+5bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4gTxX0+ZbXK5cEVNQtpaKI3EU+BNGmawIBDDLeG5Gq8G8lKD15gMPCNV2+hKi1r/
	 KJdbXgEtgNCQzdRWP1rUOlTJVX0/wQ/mZ7FiBN++0I6IbjYF5ES/6mDk+0iCCVC06G
	 zFbzE+I7wOULKPC5MZJR02Hn4zm/2ZaiEYFyLBrA=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V4 1/5] mshv: Add gfp flags to deposit memory logic
Date: Wed,  4 Nov 2026 18:01:02 -0800
Message-ID: <20261105020106.3496339-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
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

Currently GFP_KERNEL is hard coded in hv_alloc_dep_pages(). Add gfp_flags
parameter so it can be called in atomic context from map_pages callback in
struct iommu_domain_ops and other places in future. A new function
hv_deposit_memory_gfp() is added to facilitate this, so hv_deposit_memory()
can continue to function as is.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/hv_proc.c           | 20 +++++++++++---------
 include/asm-generic/mshyperv.h | 14 +++++++++++---
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index f811bb5c42a1..8380e9050f46 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -22,7 +22,7 @@
  * Returns: number of pages allocated or -ENOMEM
  */
 static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages,
-			      bool single)
+			      bool single, gfp_t gfp_flags)
 {
 	struct page *page;
 	int num_allocd, count = 0;
@@ -37,7 +37,6 @@ static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages,
 	while (num_pages) {
 		/* Find highest order we can actually allocate */
 		int order = 31 - __builtin_clz(num_pages);
-		gfp_t gfp_flags = GFP_KERNEL;
 
 		if (!single)
 			gfp_flags |= __GFP_NOWARN;
@@ -81,7 +80,8 @@ static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages,
  * so we must split that also. Lastly, HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is
  * not guaranteed to always be power of 2.
  */
-static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
+static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous,
+				 gfp_t gfp_flags)
 {
 	struct hv_deposit_memory *hc_input;
 	int i, rc, num_pages;
@@ -98,14 +98,15 @@ static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
 		num_pages = HV_DEPOSIT_MAX;
 	}
 
-	hc_input = (struct hv_deposit_memory *)get_zeroed_page(GFP_KERNEL);
+	hc_input = (struct hv_deposit_memory *)get_zeroed_page(gfp_flags);
 	if (hc_input == NULL)
 		return -ENOMEM;
 
 	hc_input->partition_id = partition_id;
 	pfna = hc_input->gpa_page_list;
 
-	rc = hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages, contiguous);
+	rc = hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages, contiguous,
+				gfp_flags);
 	if (rc < 0)
 		goto out_free;
 
@@ -159,7 +160,7 @@ static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
 	return rc;
 }
 
-int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
+int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status, gfp_t gfp_flags)
 {
 	int result = hv_result(hv_status);
 	bool contiguous = false;
@@ -179,7 +180,7 @@ int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
 	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY)
 		contiguous = true;
 
-	return hv_call_deposit_pages(node, pt_id, contiguous);
+	return hv_call_deposit_pages(node, pt_id, contiguous, gfp_flags);
 }
 EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
 
@@ -232,7 +233,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 			break;
 		}
 		ret = hv_deposit_memory_node(node, hv_current_partition_id,
-					     status);
+					     status, GFP_KERNEL);
 	} while (!ret);
 
 	return ret;
@@ -266,7 +267,8 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 			}
 			break;
 		}
-		ret = hv_deposit_memory_node(node, partition_id, status);
+		ret = hv_deposit_memory_node(node, partition_id, status,
+					     GFP_KERNEL);
 
 	} while (!ret);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4c9f3353074a..2584e693d7b3 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -346,7 +346,7 @@ static inline bool hv_parent_partition(void)
 }
 
 bool hv_result_needs_memory(u64 status);
-int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
+int hv_deposit_memory_node(int node, u64 partition_id, u64 status, gfp_t gfp);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
@@ -357,7 +357,8 @@ static inline bool hv_root_partition(void) { return false; }
 static inline bool hv_l1vh_partition(void) { return false; }
 static inline bool hv_parent_partition(void) { return false; }
 static inline bool hv_result_needs_memory(u64 status) { return false; }
-static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
+static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status,
+					 gfp_t gfp)
 {
 	return -EOPNOTSUPP;
 }
@@ -379,9 +380,16 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 }
 #endif /* CONFIG_MSHV_ROOT */
 
+/* Generic deposit function with no default numa node and GFP_KERNEL */
 static inline int hv_deposit_memory(u64 partition_id, u64 status)
 {
-	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
+	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status,
+				      GFP_KERNEL);
+}
+
+static inline int hv_deposit_memory_gfp(u64 partition_id, u64 status, gfp_t gfp)
+{
+	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status, gfp);
 }
 
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
-- 
2.51.2.vfs.0.1

