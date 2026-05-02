Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130F1A9B24;
	Sat,  2 May 2026 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696050; cv=none; b=ObSx07rbZk2gB21WE3s8PdqR9kXcIBx3TByUvFKdRHMCQlKnZvkXkTT/bk0o0yMv8dEpXCWdh++UAJaf+146klBgFMVAAtT1Ypwgk8rIxtpaiys3T09oe0pKmI87GS9K3EU/4DcDvYhSV4g8Kjz0rMpYhpm+Vpu41Si2zdf3Df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696050; c=relaxed/simple;
	bh=4qpOtRvzoCMH24MJ5Uc1kqhNVRU/useCs1qPy2tRJ9U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTHQ35wQleLl5RKzxQuEHLJ8iY3jdCbcpi/3C6xrBFWgArrZ81WL55Pw/NrURmqO6AhdeKUeSzr03uBEvF2B8eKivO2AHlQLvlS3HBhNBzACEk3gGBiQG+vIZUTi3rrBd030RV8ZSxDPZvCSXyYRs/hxT4o9tVEzvMMurCkQXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZXABOaBR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZXABOaBR"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9338C20B7168;
	Fri,  1 May 2026 21:27:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9338C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696048;
	bh=Nh/8jwLz5YWQ5OQBnCopWkMu2jWiadfKLIxLkqGPLw8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZXABOaBRoDQmakLt7OKmxNzZWGS3oO6zxDQeDbf60HuhZUQ73jTSuqdK4BWZ3+xlC
	 bHhpXzAp+EG1JV0Coe0xTKl5NO+/knXpdtAuJnBChzLFO2xOl/F/rHe2oBiZF1YBAy
	 mYj8kf40rsXgFydicUZ6lB6uUm/xxELfCcAnDx64=
Subject: [PATCH v2 03/18] mshv: Fix mshv_prepare_pinned_region error path for
 unencrypted partitions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:28 +0000
Message-ID: 
 <177769604862.222166.6253043006863845516.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 8bit

mshv_prepare_pinned_region() returns 0 (success) when mshv_region_map()
fails on an unencrypted partition. The condition on the error path:

    if (ret && mshv_partition_encrypted(partition))

only handles map failures for encrypted partitions — if the partition is
not encrypted and the map fails, execution falls through to 'return 0',
silently ignoring the error.

Fix by returning immediately on success and falling through to the
cleanup path on failure. For encrypted partitions, attempt to re-share
the region before invalidating. For unencrypted partitions, proceed
directly to invalidation and error return.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 665d565899c15..aa0f452aa17c1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1365,7 +1365,13 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
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
@@ -1381,9 +1387,6 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 		 */
 		goto err_out;
 	}
-
-	return 0;
-
 invalidate_region:
 	mshv_region_invalidate(region);
 err_out:


