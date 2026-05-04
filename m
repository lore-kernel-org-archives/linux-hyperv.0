Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C463F0A8E;
	Mon,  4 May 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921752; cv=none; b=Opglkt2mFPmgXjnHo6BoF5pPz9iEoz8/+2Avy31YWMngELcFrUUilWY0OIkpoe8/1Q6dAcrmZQdLKPGPAXLEfPXRwePysiMTDj4ga8ZCcPG1wZliOQkmBeXJtLhVIXroX95IlQ8kwaLcYaZj1yXYh2iU3FkHfGuxbefOfqjIF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921752; c=relaxed/simple;
	bh=LKg6XQ9kOCE5ahDArI5b8L75v0fF2CWuwK8AM5CIeFQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZIOPEHlfWiwt1Fiu4SisSeMxJJzTE7A9zhY0BFXeXakJ1VbS6aITheAdHxT88nv0aC+alVimyBRNPmiuw4g5m0hYGUDntQART9IjFF0+zixGYY0rFoe8Adr3jlaGvMvt4I09ZQfdDG4ywriyjbD0RiOinoERvpm0sIjHkZIV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CnY31QkK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CnY31QkK"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8E0B20B7168;
	Mon,  4 May 2026 12:09:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8E0B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921748;
	bh=qv/zUzZcJzd6kXDrJZiNYMHMZp1e9YT/bSHUEU6NMVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CnY31QkKZNL0+yMLmpjCxjs01x6PbpXYCr/aUAKiajhi/z9RSPlLzbtCHjZRdzooE
	 P+cP0t5f2YmlPNCaBEGzKp8+rVklNfbROOUKOeadZzVTF3dglME+BME/xfe95jmHBB
	 e1G+QvQIYxZQRxKy1NW6rSjVDDbSbU+EwUWRH7xM=
Subject: [PATCH v3 03/18] mshv: Fix mshv_prepare_pinned_region error path for
 unencrypted partitions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:10 +0000
Message-ID: 
 <177792175020.90827.15921027473686056141.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

mshv_prepare_pinned_region() returns 0 (success) when mshv_region_map()
fails on an unencrypted partition. The condition on the error path:

    if (ret && mshv_partition_encrypted(partition))

only handles map failures for encrypted partitions — if the partition is
not encrypted and the map fails, execution falls through to 'return 0',
silently ignoring the error.

Additionally, calling mshv_region_invalidate() inline on map failure
zeroes the mreg_pages array before the caller's cleanup path
(mshv_region_destroy) can call mshv_region_unmap(). Since unmap skips
pages where mreg_pages[offset] is NULL, this can leave stale SLAT
mappings for partially-mapped pages.

Fix by returning immediately on success and falling through to error
return on failure. For unencrypted partitions, the caller's
mshv_region_destroy() handles unmap followed by invalidate in the
correct order. For encrypted partitions where re-sharing fails, zero
the page array without unpinning — the pages are inaccessible to the
host and must not be unpinned, but zeroing prevents
mshv_region_destroy() from attempting to unpin them.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 665d565899c15..7e4252b6bc65c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1360,32 +1360,38 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 			pt_err(partition,
 			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
 			       region->start_gfn, ret);
-			goto invalidate_region;
+			goto err_out;
 		}
 	}
 
 	ret = mshv_region_map(region);
-	if (ret && mshv_partition_encrypted(partition)) {
+	if (ret)
+		goto share_region;
+
+	return 0;
+
+share_region:
+	if (mshv_partition_encrypted(partition)) {
 		int shrc;
 
 		shrc = mshv_region_share(region);
 		if (!shrc)
-			goto invalidate_region;
+			goto err_out;
 
 		pt_err(partition,
 		       "Failed to share memory region (guest_pfn: %llu): %d\n",
 		       region->start_gfn, shrc);
 		/*
-		 * Don't unpin if marking shared failed because pages are no
-		 * longer mapped in the host, ie root, anymore.
+		 * Re-sharing failed — the pages remain inaccessible to the
+		 * host.  Zero the page array so that mshv_region_destroy()
+		 * won't attempt to unpin them (leaking the page references
+		 * is intentional; unpinning host-inaccessible pages would be
+		 * unsafe).
 		 */
+		memset(region->mreg_pages, 0,
+		       region->nr_pages * sizeof(region->mreg_pages[0]));
 		goto err_out;
 	}
-
-	return 0;
-
-invalidate_region:
-	mshv_region_invalidate(region);
 err_out:
 	return ret;
 }


