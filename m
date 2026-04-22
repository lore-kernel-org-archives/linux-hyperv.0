Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1CB20B22;
	Wed, 22 Apr 2026 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816929; cv=none; b=ARM/6BojirrUtkGHouQgQKLEMG222DJT7hoj4er79tG2/QFG2hrtorAvqWjuJ9RKiygBYu+UJvUBeBhImj02PKUJr86w/qpMn0gjX40GnMch+qn/6W3+WQx1U5TxIXV6V1gZN2CpQFWlO/AdueTv1hcQwxpWu+S+9x+MMtc1I4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816929; c=relaxed/simple;
	bh=tT7GhQ6jwheUWPaQt9dfsRnpQ4GLOf47A9mN4vb3dLQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=QpOQlwUdZGy1/qO22li4CFHrUd+eh8vaycvrPgG3MUsakP+0jCNvO5LznRK0a05a2IX8B6671TstzOXE+IxORZbvKH6fsE7i+pSY3+rb4LCvuXZDBbtOIkMgmQcgaQNVKu6LxB7NOdA0iN9zEz2jZegdA6lJL7vscsAuSx+bHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dlVAOPPv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dlVAOPPv"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E83E20B6F01;
	Tue, 21 Apr 2026 17:15:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E83E20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776816928;
	bh=+F1J0iX3/5DnVQwgNr3efCbddHMbqkJcHQ8t1rJ5Ufc=;
	h=Subject:From:To:Cc:Date:From;
	b=dlVAOPPvgYS3dZ4Jq0VhyiTA5KH8uoLVbbHEk/P5qH0rzabebfJ+bkjjjFNMnecnk
	 HWsdE5/Bbt3dF+42lIK5Yp94P71qA2SZ+h1BbBFZPSEegOy3fHRw+/q/DdqEcnuUi5
	 FKnDmdWBQYh+/MIZfco3SdRODTwRZ8xfI/t2+icI=
Subject: [PATCH] mshv: Fix interrupt state corruption in hv_do_map_pfns error
 path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Apr 2026 00:15:28 +0000
Message-ID: 
 <177681692062.637858.4160821495321404639.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Restore interrupt state before breaking out of the loop on error.

The irq_flags are saved before entering the loop, but the early exit
path on error fails to restore them. This leaves interrupts in an
inconsistent state and can lead to lockdep warnings or other
interrupt-related issues.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 7ed623668c8ec..6381f949d9d91 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -237,8 +237,10 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
 			} else {
 				pfnlist[i] = mmio_spa + done + i;
 			}
-		if (ret)
+		if (ret) {
+			local_irq_restore(irq_flags);
 			break;
+		}
 
 		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
 					     input_page, NULL);


