Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0F292918;
	Sat,  2 May 2026 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696126; cv=none; b=fRq6r/HPzACUxufReKlGOuMMH0eefFTjw3KecLgBHBbOQYdl4tfLY0XZ7wXeDAKBW+vsPj3VAzdQ8XqLOhIsczjnGqHgeknRkSbXMR7D7tIKEub039jfTIO7tjMU4YS+G6hgf3bc6P1V0ftQ/dOgYrz13klZsGnBxUjJlX2xWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696126; c=relaxed/simple;
	bh=EMODK99wo0wCLR+7ZA07tyhnLGGaTvVGquQRKL2sibM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+0Kc8LUa8QXNyHN3bSl0q7InFJzNgFM99j815RT+yO1tJrUhyNYmbM9V7mZxIyskzH1+BBkIIQ38to+Q8lbZ1MsNxaR+xGtmj6wvGbI6a29dpxu/vbmuBErPLaga2e89NFvCFfkbATmciabrw8uXM/xjiFsifq0UkcAMvDeigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KEHONEqv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KEHONEqv"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6AB9E20B7168;
	Fri,  1 May 2026 21:28:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AB9E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696124;
	bh=bHeeYThvxP0vmCQ0u8mR501Q9KBiS5cOCDl8QHdMnbs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KEHONEqvFwTckaMLgzfMTpMBEJ+NX4hp2lFgFZBfgOq+zBLC8WTTPEQVw/bM9eVVU
	 QTp3To+VL4qYPY+WiuYvfycamKQhrtsfFBromK0bqRRYwoO5fgdKzjHULOFPcHGbI5
	 YYWtoYYtH1/+gsOGEoIIH0kKOj3glRmYQhxTS0jU=
Subject: [PATCH v2 17/18] mshv: Validate scheduler message bounds from
 hypervisor
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:44 +0000
Message-ID: 
 <177769612446.222166.14336379794122816500.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

handle_pair_message() iterates up to msg->vp_count without verifying it
against HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT. Since vp_count is read
from untrusted hypervisor data, a malformed message with a large value
would cause out-of-bounds reads from the partition_ids and vp_indexes
arrays.

handle_bitset_message() iterates over set bits in valid_bank_mask (up to
64) and advances bank_contents for each one. However, the payload buffer
only has space for 16 bank entries. A valid_bank_mask with more than 16
bits set causes bank_contents to read beyond the message buffer.

Fix both by adding bounds validation:
- Clamp vp_count to HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT
- Track banks consumed and stop before exceeding buffer capacity

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 5333b3889a408..3a71682ffe048 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -187,7 +187,9 @@ static void kick_vp(struct mshv_vp *vp)
 static void
 handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 {
-	int bank_idx, vps_signaled = 0, bank_mask_size;
+	int bank_idx, vps_signaled = 0, bank_mask_size, banks_used = 0;
+	const int max_banks = sizeof(msg->vp_bitset.bitset_buffer) /
+			      sizeof(u64) - 2; /* subtract format + mask */
 	struct mshv_partition *partition;
 	const struct hv_vpset *vpset;
 	const u64 *bank_contents;
@@ -227,6 +229,11 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 		if (bank_idx == bank_mask_size)
 			break;
 
+		if (unlikely(banks_used >= max_banks)) {
+			pr_debug("valid_bank_mask exceeds buffer capacity\n");
+			goto unlock_out;
+		}
+
 		while (true) {
 			struct mshv_vp *vp;
 
@@ -255,6 +262,7 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 		}
 
 		bank_contents++;
+		banks_used++;
 	}
 
 unlock_out:
@@ -271,10 +279,18 @@ handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
 	struct mshv_partition *partition = NULL;
 	struct mshv_vp *vp;
 	int idx;
+	u8 vp_count = msg->vp_count;
+
+	if (unlikely(vp_count > HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT)) {
+		pr_debug("pair message vp_count %u exceeds max %lu\n",
+			 vp_count,
+			 (unsigned long)HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT);
+		return;
+	}
 
 	rcu_read_lock();
 
-	for (idx = 0; idx < msg->vp_count; idx++) {
+	for (idx = 0; idx < vp_count; idx++) {
 		u64 partition_id = msg->partition_ids[idx];
 		u32 vp_index = msg->vp_indexes[idx];
 


