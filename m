Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAC15A85A;
	Sat, 12 Sep 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171417; cv=none; b=ZfsWjhxswwuAq5MYxsUnO0uMQ13gVU089e9UpBY745OTjNsTok8cE+q+wBOeG2QN6AaISPzk0BS3h356FtsBrPfoQjLX19wW+pSvtNiQJNlstXEljbSa4XdmREXYWLX3Tek41muhN9yseVxsgg6QqzQTbEBIDtfaIIO9qm4SjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171417; c=relaxed/simple;
	bh=31WjxIO6unFBqWpeLRL8/RN7E7l5HJ7SyVkC9K2p1us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Odwjy8hwDwhW6uJB2aCAbAKxDXA9qvv9TUNc/+hxWOLKSwSrGnX33ptFY4xUR+eX+KyRSRJh/DgP7hD9pvCZBCsIaonPie1Fd+GH3BM5m8yH1WU7BH5OXZgwUGCAl6ysZjDsx7he5bnDtW0CLRKwGdx6LiX7uK8SQOSOQf8nRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aepcA5MP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aepcA5MP"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA76C20B7167;
	Fri, 11 Sep 2026 17:02:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA76C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789171373;
	bh=PJalcYvX+YQhx71OB34l2znmtmW8ubFuHXXlew4BXOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aepcA5MPPQ3enqzUInPV4ULKLPVk6jb5E0zmI0Ebam9kML1DUcVdbvVLciLWDXNy4
	 Nhx//MyeAYObpx2FUqJIb8Nbl3zD2WH1ZQ9XZl+idaOfB2bjaQET7udHbvRFnF7Q7j
	 dbGsg4yrsU05DKMaj2WCovgnm3qz/SakbaHt15Cw=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V2 1/3] mshv: Rename memory deposit memory functions to _old
Date: Fri, 11 Sep 2026 17:03:16 -0700
Message-ID: <20260912000318.2959621-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
References: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename hv_call_deposit_pages() and hv_deposit_memory_node() to _old
to make reviewing the new functions much easier.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_proc.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 57b2c64197cb..57864bb5bcd8 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -13,10 +13,10 @@
  * See struct hv_deposit_memory. The first u64 is partition ID, the rest
  * are GPAs.
  */
-#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
+#define HV_DEPOSIT_MAX_OLD (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
 
 /* Deposits exact number of pages. Must be called with interrupts enabled.  */
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num_pages)
 {
 	struct page **pages, *page;
 	int *counts;
@@ -29,7 +29,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	struct hv_deposit_memory *input_page;
 	unsigned long flags;
 
-	if (num_pages > HV_DEPOSIT_MAX)
+	if (num_pages > HV_DEPOSIT_MAX_OLD)
 		return -E2BIG;
 	if (!num_pages)
 		return 0;
@@ -40,7 +40,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		return -ENOMEM;
 	pages = page_address(page);
 
-	counts = kzalloc_objs(int, HV_DEPOSIT_MAX);
+	counts = kzalloc_objs(int, HV_DEPOSIT_MAX_OLD);
 	if (!counts) {
 		free_page((unsigned long)pages);
 		return -ENOMEM;
@@ -108,10 +108,14 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	kfree(counts);
 	return ret;
 }
+
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+{
+	return hv_call_deposit_pages_old(node, partition_id, num_pages);
+}
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
-int hv_deposit_memory_node(int node, u64 partition_id,
-			   u64 hv_status)
+static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id, u64 hv_status)
 {
 	u32 num_pages = 1;
 
@@ -137,7 +141,12 @@ int hv_deposit_memory_node(int node, u64 partition_id,
 		hv_status_err(hv_status, "Unexpected!\n");
 		return -ENOMEM;
 	}
-	return hv_call_deposit_pages(node, partition_id, num_pages);
+	return hv_call_deposit_pages_old(node, partition_id, num_pages);
+}
+
+int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
+{
+	return hv_deposit_memory_node_old(node, partition_id, hv_status);
 }
 EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
 
-- 
2.51.2.vfs.0.1

