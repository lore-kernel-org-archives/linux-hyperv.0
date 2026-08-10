Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E13E317B;
	Mon, 10 Aug 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365999; cv=none; b=fChmyJPTzGbmD7svgG4zv8vJO9qUE6tUPhThAw2BzQ96mPV9SZMdUoehkc/GdxPASlo7FCHmZP47DbyKuxhjLPV6fgZQ17U3ZDBpjF2FSSuJJpLS/6/lz2MXaX8M5nlANwETVj+tZtK3eBXjaI01pSGJqG10PkVkyErWRbYVg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365999; c=relaxed/simple;
	bh=oXgFjaIsA80Xc5hl50liEgx2uO2VsTE9hgtmanpeGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhEDXIaqSLrLJ/cl32iqyOZG28uHC8cE7WdgrRp4rbR3S9UCqksLO26p/BvudTR4nVD+wZsMKsw0kNpe7YlRuZr2nIB9/wsdxRsvR5taMcY7ptcM4TImN1fyF6rN+Ip3lpfYAOBvXQzxJyGyuPruJew5LnZIKq8YfDOo4hghzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pTVyoogs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pTVyoogs"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9250420B7166;
	Mon, 10 Aug 2026 05:46:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9250420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365973;
	bh=OOox41U55WARP3gs7wJ+z0CrHiiDHwf7Bun43XNzaqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTVyoogszyPTNqJbtgLnSxGTzZfSIIaBL1ImjAaFkgWxOgAqDxqkq8vGTFw9rlY+2
	 cqY2ychvHVDvIUhO+5h7en9DXtCP1hrwUAROeFNIHQakDzFSH05zl7k15uXAzPHo9p
	 HuTZ1YzflVArwF/9D2FPZAEq9PQreeg17fs6T1Sk=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 10/13] mshv: unmap SNP memory before state teardown
Date: Mon, 10 Aug 2026 12:45:04 +0000
Message-ID: <20260810124527.1409634-11-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810124527.1409634-1-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Unmap memory regions before destroying SNP partition state, and only
release regions after SNP state is torn down. Dropping regions first
attempts to regain host access while the partition is still secure and
can leave pages inaccessible.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_regions.c   | 2 +-
 drivers/hv/mshv_root.h      | 1 +
 drivers/hv/mshv_root_main.c | 6 ++----
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6d65e5b42152..62c49b4d2a33 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -337,7 +337,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				       page_count, flags);
 }
 
-static int mshv_region_unmap(struct mshv_mem_region *region)
+int mshv_region_unmap(struct mshv_mem_region *region)
 {
 	return mshv_region_process_range(region, 0,
 					 0, region->nr_pages,
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index ee52797727cc..0a3e236a7873 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -372,6 +372,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 int mshv_region_share(struct mshv_mem_region *region);
 int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
+int mshv_region_unmap(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index c32d3375af8c..0dbf509351bb 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2208,10 +2208,8 @@ static void destroy_partition(struct mshv_partition *partition)
 		if (mshv_partition_encrypted(partition)) {
 			hlist_for_each_entry_safe(region, n,
 						  &partition->pt_mem_regions,
-						  hnode) {
-				hlist_del(&region->hnode);
-				mshv_region_put(region);
-			}
+						  hnode)
+				mshv_region_unmap(region);
 
 			ret = destroy_snp_partition_state(partition);
 			if (ret) {
-- 
2.43.0

