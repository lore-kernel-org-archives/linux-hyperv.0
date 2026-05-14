Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876439936B;
	Thu, 14 May 2026 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787838; cv=none; b=WRo7EiBNPTF+K/0gGHoNU+pCFup7vCqWTXG6m1NPI9asgvAt08yDGFKoRP9y21gBhp0g8/lrLqwQlqs//Q6MUH+gRDd0OVMWtRprOPa5P2hAsFRi1e4KVjWxCXlGDVLOENV4K3dLhwC1xs+ZTcJB+Jdt1Elx9uTL/HH5wCt94Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787838; c=relaxed/simple;
	bh=Jvb+Bny9I2KzDXoGW/N/AVXHM9xzHTPzcD3wL5yVBWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LlIqoZw/DnjyM/SwGoZTpP1zr4XCM07HMXOmRauBvzUka+uUpi+bYSjgXeRCsDrqkVmnbbXpUeMtXio0OG4D32lF9ZhfkV/GR0AG3LrdoBgM8TrWSEa0oJx9JXKyjCMbQbJaFU4iNTl4ITRE8mHLdqkUmHSieXEqkYWcHetwp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E1bbUNDB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E1bbUNDB"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 65C8920B7166; Thu, 14 May 2026 12:43:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65C8920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778787827;
	bh=p9hyrI1+brOWHOX6H20gpyhH3hzz6b6+p2S7tGRyUlk=;
	h=From:To:Subject:Date:From;
	b=E1bbUNDBFlhkkAM5eK83QPFwoZhKpqInY+yg/OssGKltPNxDk4+Ql7jSVVgcXUw7V
	 sb35oKN4kIx6TmlqJno2Lq2MqgRxPmV6VqLLcGoFo46Mkn/C71xa16h80T02GtNnJs
	 VsXXU20Ye/Uy+/UhgdHmoKmbS6GybpGZuQpsNk10=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dipayanroy@linux.microsoft.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer
Date: Thu, 14 May 2026 12:41:51 -0700
Message-ID: <20260514194156.466823-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mana_hwc_rx_event_handler(), resp->response.hwc_msg_id is read from
DMA-coherent memory and bounds-checked, then mana_hwc_handle_resp()
re-reads the same field from the same DMA buffer for test_bit() and
pointer arithmetic.

DMA-coherent memory is mapped uncacheable on x86 and is shared,
unencrypted, in Confidential VMs (SEV-SNP/TDX), so each load goes
directly to host-visible memory. A H/W can modify the value
between the check and the use, bypassing the bounds validation.

Fix this by reading hwc_msg_id exactly once using READ_ONCE() into a
stack-local variable in mana_hwc_rx_event_handler(), and passing the
validated value as a parameter to mana_hwc_handle_resp().

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index dbbde0fa57e7..fd8b324d7fb6 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -77,21 +77,19 @@ static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
 }
 
 static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
-				 struct hwc_work_request *rx_req)
+				 struct hwc_work_request *rx_req, u16 msg_id)
 {
 	const struct gdma_resp_hdr *resp_msg = rx_req->buf_va;
 	struct hwc_caller_ctx *ctx;
 	int err;
 
-	if (!test_bit(resp_msg->response.hwc_msg_id,
-		      hwc->inflight_msg_res.map)) {
-		dev_err(hwc->dev, "hwc_rx: invalid msg_id = %u\n",
-			resp_msg->response.hwc_msg_id);
+	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
+		dev_err(hwc->dev, "hwc_rx: invalid msg_id = %u\n", msg_id);
 		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
 		return;
 	}
 
-	ctx = hwc->caller_ctx + resp_msg->response.hwc_msg_id;
+	ctx = hwc->caller_ctx + msg_id;
 	err = mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
 	if (err)
 		goto out;
@@ -251,6 +249,7 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	struct gdma_sge *sge;
 	u64 rq_base_addr;
 	u64 rx_req_idx;
+	u16 msg_id;
 	u8 *wqe;
 
 	if (WARN_ON_ONCE(hwc_rxq->gdma_wq->id != gdma_rxq_id))
@@ -269,13 +268,17 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	rx_req = &hwc_rxq->msg_buf->reqs[rx_req_idx];
 	resp = (struct gdma_resp_hdr *)rx_req->buf_va;
 
-	if (resp->response.hwc_msg_id >= hwc->num_inflight_msg) {
-		dev_err(hwc->dev, "HWC RX: wrong msg_id=%u\n",
-			resp->response.hwc_msg_id);
+	/* Read msg_id once from DMA buffer to prevent TOCTOU:
+	 * DMA memory is shared/unencrypted in CVMs - host can
+	 * modify it between reads.
+	 */
+	msg_id = READ_ONCE(resp->response.hwc_msg_id);
+	if (msg_id >= hwc->num_inflight_msg) {
+		dev_err(hwc->dev, "HWC RX: wrong msg_id=%u\n", msg_id);
 		return;
 	}
 
-	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req);
+	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req, msg_id);
 
 	/* Can no longer use 'resp', because the buffer is posted to the HW
 	 * in mana_hwc_handle_resp() above.
-- 
2.34.1

