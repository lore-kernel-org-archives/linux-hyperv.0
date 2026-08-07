Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999E379C5D;
	Fri,  7 Aug 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110763; cv=none; b=MVCrVreAKoLfw7JyedjwLX4rNVvHXK3yh2VGdQu34w3hQytzUSVv6hFN7dkWMmCzfBm4YMXhVebWMeWhH4znZkDmkLhTzPbZQcff8RofDJljmn5uskU/hBgocIjw9pHpaC3WYMFbqeWl9psCz+3V7wfOSwzdGU/MLCADR5MX2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110763; c=relaxed/simple;
	bh=jOF/x+H7YDkUrdp9lYRIKD/TMR/gN8sIieUG6PnDkro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8nnqsroRdHRKL6JKw45dIMNE5S/5HsKs8h2B1ctTyoKidxpanWuSURpC1Hpux1b5wnj5L6bAoBlIXif8hWhZFy/xldIZrpkJ0KwcWpjPnM10qjkih1XgzP5SeRfVBezgQtXgZ+qTu9aYOLAcqqBxqiHtwwS/mDlIM+6qMKVRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fcGeLIG6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fcGeLIG6"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3BF420B710C;
	Fri,  7 Aug 2026 06:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3BF420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110730;
	bh=L4SPuDscPiMPt7pF1O9bV1IW64SBjPDni2R1MboDAaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcGeLIG6or/8AIb9UJQi2qMIR2xurBtfEhGdrfPUB+mT+fI6XFaMTYLx7aQazK0yy
	 gokgyrmyek4W30qRdYuM3asCQ192y2MTg8I2nUGWnEKbYF98HiWICYkxfenPg87Tae
	 CBxKgjRaJCamcMvtTUrvZzvEVYrFWHz52cVIRgPs=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v1 10/13] mshv: unmap SNP memory before state teardown
Date: Fri,  7 Aug 2026 13:51:16 +0000
Message-ID: <20260807135134.303943-11-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807135134.303943-1-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
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
index 0e6d4ce25112..0423f4adb3ac 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -370,6 +370,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 int mshv_region_share(struct mshv_mem_region *region);
 int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
+int mshv_region_unmap(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index c81a8d0493c1..0fbd2158968d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2166,10 +2166,8 @@ static void destroy_partition(struct mshv_partition *partition)
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

