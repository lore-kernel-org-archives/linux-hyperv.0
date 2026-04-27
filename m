Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364803A0B01;
	Mon, 27 Apr 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301046; cv=none; b=qfMWolQaAuGIZzOlNNJ5UH1cskQ4rJOzI37fe1oPEQk78e1t1LyWU4SykbtPJY4eb8X08ng8rjq44Sthnp4C1meCoBOQxJaow1aNUdpIPcELc0fiLrZsAixQD3AucWKNRlhWb6Sn0MEa21mcuD5DjeldsKXQWDcaQOXpEuSN7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301046; c=relaxed/simple;
	bh=9n7ZiPKAVIAGk8oDDwHVFHz3W7/i7E23oQfB9W1zkzM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=BlYDrsD25Bn6KyIXwi1CVMRHOy20VD6/Bzihh/L5v7v3GRQIk+6oq9/hFTWezXLobZdJ7+ygBSuipW/PY1CZD2xI+vOdknArM0NPbJBlb8KoE3vVhHWf4Gop+8J9s25ppnKVzsXtOUhTmpQ40M/yNpd/oJqtaX4hIrDshDB5pRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WO6F95wg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WO6F95wg"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6253520B716A;
	Mon, 27 Apr 2026 07:44:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6253520B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777301044;
	bh=9YCzQCfX3xO+WwWoiUKCuNNQIYIYggXUwpprN+1bBCs=;
	h=Subject:From:To:Cc:Date:From;
	b=WO6F95wgATdmxJm2yDE7+b27h63v/vBkTXtDiJD1Iwuscpaa2k7qbmj9eOSV5nw9q
	 oCCRRQs0diFlMLG5gkyfvYlt1asH7vsL4o/JAPzaSq4URqPKa5zL72Nyt6YeHo3SzY
	 GmRzJyNyatUhOVm5xPckP/FXiGecMKxBwm4gZ4j4=
Subject: [PATCH v2] mshv: Fix large page unmap count in error path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 14:44:03 +0000
Message-ID: 
 <177730103437.21611.9595619835481065448.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index 7f91096f95a8e..ab210a7fcb8c3 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -255,8 +255,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 	if (ret && done) {
 		u32 unmap_flags = 0;
 
-		if (flags & HV_MAP_GPA_LARGE_PAGE)
+		if (flags & HV_MAP_GPA_LARGE_PAGE) {
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+			done <<= large_shift;
+		}
 		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
 	}
 


