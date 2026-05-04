Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69A3EFD14;
	Mon,  4 May 2026 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921750; cv=none; b=NyrAtU14LR0ycpjRdiV087diy80Gy3ZphDy1xktgYnvzsNTkK26Dc1u04iutRXfFrHWe3eihVUpkWizmcZHJzCQ4mkwN+rbgmZLW+IVmNPf6dgypDoIMADOhLKXuK911oPuN8PgCsvcp9D+alg1C771/eoIkEjqaBgrRFMI2PR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921750; c=relaxed/simple;
	bh=pTT6Hswg7L3inYnv97QRqYWAPiZYEb3wMOjLKxxbICI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIeKBEk2VCCHmamDn6YlSOkS/3Mfp5Lu8nKDyE5cnOq3zQW2Y2FEq1Z/zpknsE1DvEQL9jxv/JFwrtGg1FW8Vg62hu4mvQcBn9K8LBwc2XnA+HArd/IjTRC79Tbkkjq3lqe/5ZOEsJ9T9WVJ62xBxh3h9e8EnunRdHux58d328o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cwcncfss; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cwcncfss"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 43A0320B716A;
	Mon,  4 May 2026 12:09:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43A0320B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921743;
	bh=Uk8wk6XlWEHWPtWm07hcZvv/blXW1ZRa96uVpenLlnQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cwcncfssveAPAn+OHR4546INMYv378atmeZ+X2MC335tKAPFhKrMPVYFN2RQvEGdQ
	 0qwt4jNo3NXcQrvWaiaWTviu4PuW7zYSnqT9DFyUIwNTVb721x9fMLflhIJNfawmdD
	 /NlvfrRDgf3j80pJ6oDpqTJvNwiI7hnXY6ch9xqY=
Subject: [PATCH v3 02/18] mshv: Fix potential integer overflow in
 mshv_region_create
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:04 +0000
Message-ID: 
 <177792174469.90827.1223001767715615291.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

The allocation size is computed as:

  sizeof(*region) + sizeof(struct page *) * nr_pages

where nr_pages is a u64 originating from userspace. A sufficiently
large nr_pages can overflow the multiplication, resulting in a small
allocation followed by out-of-bounds writes when populating mreg_pages.

Use struct_size() which returns SIZE_MAX on overflow, causing vzalloc
to safely return NULL — caught by the existing error check.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6f..1d04a97980b8b 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -177,7 +177,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 {
 	struct mshv_mem_region *region;
 
-	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	region = vzalloc(struct_size(region, mreg_pages, nr_pages));
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 


