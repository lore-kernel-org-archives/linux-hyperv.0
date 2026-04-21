Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1F3624C8;
	Tue, 21 Apr 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811473; cv=none; b=hgZ0K0zcOnuXDb8b+VeRjQGsDx/KMCBWYCiLa5vh2fcwSMbEZD0iC3SoWd9+QPxPrviTp4beLVZhAoEhm1uwVEw2tM/NNw6pJWjFgKw4ks0+wIhSf1fra883NL9KXVrCddHk2wE28uRlkO5vwlkk9CzvMfYhOij2wuPg+NXFJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811473; c=relaxed/simple;
	bh=2lPqIGtfHcKZzu/NY8CZkJDbqvQTvIw+w6mDLrNNVaE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=pI7mWERhIlAgKgLb8AETTYOVIpk1jk/bs3emRNidAT/yBqf5NXWImn7AG72MIvuI1ZNIt1/odCIJ8Q7if06R05O1VnfB9xH1YGfDyJS9QoUcZtjyMSFd4Fs7pyWuDjY8MbySoHwfHX50CEolrymYIblRlAaMR8zkUnYLS+Cv5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=orS0tHI/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="orS0tHI/"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09EAA20B6F01;
	Tue, 21 Apr 2026 15:44:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09EAA20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776811472;
	bh=GgFI+8CgEpqN/vB3diUC17IbzYIDb6MA2AXMpvE1ihI=;
	h=Subject:From:To:Cc:Date:From;
	b=orS0tHI/nl0kfNNiAc7tv6KlkqJhgOCZ+kJ58MmqOtw9e4ERXWKH/K6ktAMRWwy/k
	 6J9qUKm4RJVFEWUh0Bb6rH4EvMH5IdmI27+ztjFUHrmLhaKwJ8hhTQ45rHHyqN/rxG
	 qvjPVyvCaBgskCpI2Z09LtrXt44eDdDupiwknGnk=
Subject: [PATCH] mshv: Fix large page unmap count in error path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 22:44:31 +0000
Message-ID: 
 <177681147147.272057.768228641434857320.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When hv_do_map_pfns() fails after partially mapping large pages, the
unmap count passed to hv_call_unmap_pfns() is incorrect. The 'done'
variable tracks the number of large pages mapped, but the unmap
function expects the count in 4KB page units.

This causes incomplete cleanup on error, potentially leaving stale
mappings in the partition. Shift the count by large_shift to convert
from large page count to 4KB page count before calling the unmap
function.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 6381f949d9d9..905ea32e2c75 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -268,8 +268,10 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
 	if (ret && done) {
 		u32 unmap_flags = 0;
 
-		if (flags & HV_MAP_GPA_LARGE_PAGE)
+		if (flags & HV_MAP_GPA_LARGE_PAGE) {
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+			done <<= large_shift;
+		}
 		hv_call_unmap_pfns(partition_id, gfn, done, unmap_flags);
 	}
 


