Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA623F0A97;
	Mon,  4 May 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921834; cv=none; b=oHDq1Idvq+Zd6m5XTshvDFtl210ZN70h22BQbp4J7oIN8/AeAeoZ0DVw3Ki7xyUKcpNnEjPAv2KMZbYKLZsnPmGX1/aJGD2Bjp/zLYs+RUXH0+19YieSCPQHfcAkaM0BtoXJP/J7dDkQylvm+Bgv8PVvG3Ida3KLNDnMlmXetMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921834; c=relaxed/simple;
	bh=zfPOZ8qGdX0xfUipYSZ4qhqOe0yx4yfnvs8xlSp0ULY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3kmK/qza0FdnE5ZWijU/Vi4PEDwwItAycuozMMTpNA1Aax4n6aCDb+eTkAx3oeRIaG6v26g1WhnKsmmYpEud/B4U9el+dKoXIeQ+c4qVA2/g18Wcor649tANtBrYYiwFgSqJWem5uTskKNt7VJUImFlQ4WprGqofoEuoCUFyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PhBdOJkz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PhBdOJkz"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A05520B7168;
	Mon,  4 May 2026 12:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A05520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921831;
	bh=n/qwE24s7ZIoWv+Do7YYqGqPJYsGAUUBMV2Y3B54kbo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PhBdOJkzfzw8IcijoNRAgItkwGU07mVannwDj3y0B+SG6e+enVRw0V9mn6Pcygkxc
	 S2Al4SV/c3M6u6Q4WR8/RctSs4vwYGSe2xuQEQZLys01Hd2FR9tZdhIbjJzIuLfz1y
	 cnfgJIRZ2Vin+yX7iRrtbBzldkCYI1+ZCcRfbDeM=
Subject: [PATCH v3 18/18] mshv: Fix missing error code on VP allocation
 failure
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:32 +0000
Message-ID: 
 <177792183285.90827.12459146753889819881.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit

In mshv_partition_ioctl_create_vp(), when kzalloc for the VP struct
fails, the code jumps to the cleanup path without setting ret. At that
point ret is 0 from the preceding successful mshv_vp_stats_map() call,
so the function returns success to userspace despite having failed to
create the VP. No fd is installed and no VP is registered in pt_vp_array,
but userspace has no way to know the operation failed.

Set ret to -ENOMEM before jumping to the cleanup path.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 4d58e0b005183..52b760dec3687 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1186,8 +1186,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 		goto unmap_ghcb_page;
 
 	vp = kzalloc_obj(*vp);
-	if (!vp)
+	if (!vp) {
+		ret = -ENOMEM;
 		goto unmap_stats_pages;
+	}
 
 	vp->vp_partition = mshv_partition_get(partition);
 	if (!vp->vp_partition) {


