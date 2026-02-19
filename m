Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84662673AA;
	Thu, 19 Feb 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538974; cv=none; b=azI0+ZkoVrqyM6hosBFpIiU1fCi8cnquLLBrbw7DqbRgF7JzhhmqITdXiaTBZyHpNaJ2N9XwwqQWfjKRTm9bPxwI7ICFpEbXATNOcL4HqPIH4ofQh7H4RYLJgEAFVmqKraNG//CFr+WA5Q4Sdt2uPWQBf92eITqMqbEmWAifKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538974; c=relaxed/simple;
	bh=KVgAUjwz8KnqJkBrLKb59hokg/g+2mmeBRO4n4pWxBE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WeCAWnykA2VpMf5C7agYU+mxYEOfdEDoggcGveMTNhbDdTQoUI1T02Gv3aDoS5R4QkiA2jnxVwo5YZdxfJ5bIPA5jHGZKWDRImdCuN6XHsp8GxAXsmmvEkvsWrzTnn8xpdQSf+Vyl5L/jk7XxlKe3pB9G+06b9VRBGPbKlUkxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=avhT3IgD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="avhT3IgD"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0689620B6F00;
	Thu, 19 Feb 2026 14:09:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0689620B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771538973;
	bh=YjFO2+/Mqpr/SXRWbAMo4u5S9VcPxAaolKhssx45XHY=;
	h=Subject:From:To:Cc:Date:From;
	b=avhT3IgDW/vwArNVc2RADOlndhrYT8caZabO6veeZvFYzbAXpTUF51XLoGyfc/Wvw
	 iQ5xnt6JEnzQVFG9f+6QdCGMIUaN9GGg9BnAGAfU1zFfl0EuhQ4Mgyo3Qw1QjQrt6b
	 Wwr3md8wxpQGAVTl0Xxw5IpB3m/otPOdtHEl7xRw=
Subject: [PATCH] mshv: Replace fixed memory deposit with status driven helper
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2026 22:09:32 +0000
Message-ID: 
 <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Replace hardcoded HV_MAP_GPA_DEPOSIT_PAGES usage with
hv_deposit_memory() which derives the deposit size from
the hypercall status, and remove the now-unused constant.

The previous code always deposited a fixed 256 pages on
insufficient memory, ignoring the actual demand reported
by the hypervisor. hv_deposit_memory() handles different
deposit statuses, aligning map-GPA retries with the rest
of the codebase.

This approach may require more allocation and deposit
hypercall iterations, but avoids over-depositing large
fixed chunks when fewer pages would suffice. Until any
performance impact is measured, the more frugal and
consistent behavior is preferred.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 7f91096f95a8..317191462b63 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -16,7 +16,6 @@
 
 /* Determined empirically */
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
-#define HV_MAP_GPA_DEPOSIT_PAGES	256
 #define HV_UMAP_GPA_PAGES		512
 
 #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
@@ -239,8 +238,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		completed = hv_repcomp(status);
 
 		if (hv_result_needs_memory(status)) {
-			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-						    HV_MAP_GPA_DEPOSIT_PAGES);
+			ret = hv_deposit_memory(partition_id, status);
 			if (ret)
 				break;
 


