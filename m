Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA21263C7F;
	Sat,  2 May 2026 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696055; cv=none; b=qoT3bq6pah4xpPRArRLAlDlUhpTSdG4tXaeaItLTTlvZQfcA07QFrBbHWScraa7TmZjmkMbTQrOGN48r4o+1GsMyItsjsUSw4PxfnEeYIMgE+Zgpsrae08p/vwaeqfTkMWtZ3IRWVD4zjDwYKq0kBajGR1BNmpJDIcUTy9084yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696055; c=relaxed/simple;
	bh=vu1DlLyl3gaoTwPxXmv1XMMuFlVctr7yc9Npo6K2PHc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAlS2B4LItOfKqxONhxWd2L+LDTl4cEw/MyXbTvaO6KHI80sOMtXwTLL5DMOsuDuAQW29HqWOvNsn175Z2nH/hztQQABMdRWWBe7SjHcnS+75iJO5+6ybO10D4FETNqClUO8yenOag9EmNHcS7+gP2e/BCNharH2xkPTD21bSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NGR+zeyu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NGR+zeyu"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id E760320B7168;
	Fri,  1 May 2026 21:27:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E760320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696054;
	bh=h8/5auGFEMCPIhXmW1nMtgZizsfhzIzE+ojlyzvpol0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NGR+zeyuP0I4QZ9GHX8/ohyTsObeC9f7kG1LEkxj5o+Joa/Sd+Fs4HGR2u6YFciL7
	 EWsyOTH3Ma6ZbhyL/b2SN4aUx3RTcsUnDG0Uho3aVZYiv59irkACeAIYJQVyzHu0wO
	 NEo3wmkujwuYnbbeBHOAqI2K7QNEfhwDgxHliowA=
Subject: [PATCH v2 04/18] mshv: Fix potential u64 overflow in region overlap
 check
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:33 +0000
Message-ID: 
 <177769605396.222166.10882510116990837727.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

mshv_partition_create_region() checks for overlapping guest memory
regions using arithmetic that can overflow u64:

  mem->guest_pfn + nr_pages <= rg->start_gfn

If guest_pfn is near U64_MAX, the addition wraps around to a small
value, causing the overlap check to incorrectly pass. This could allow
creation of overlapping regions.

Fix by validating the sum with check_add_overflow() before the loop and
using the pre-computed end_gfn in the comparison.

Fixes: f91bc8f61abf ("mshv: Allow mappings that overlap in uaddr")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index aa0f452aa17c1..2b7d56e108bad 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1290,11 +1290,15 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 {
 	struct mshv_mem_region *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
+	u64 end_gfn;
+
+	if (check_add_overflow(mem->guest_pfn, nr_pages, &end_gfn))
+		return -EINVAL;
 
 	/* Reject overlapping regions */
 	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		if (end_gfn <= rg->start_gfn ||
 		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
 			continue;
 		spin_unlock(&partition->pt_mem_regions_lock);


