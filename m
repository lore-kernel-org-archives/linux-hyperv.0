Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E3347C7;
	Wed, 11 Feb 2026 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788752; cv=none; b=FiYTS9Opn/pQHIaPmJSFBIRX8M2yFNYLtf+oMAA8a59krHwxqqKk+P6fHBnq71eDHCfLlQ1Z0veTR24TB9CplCAhYoPQaG6ZDKxQc6tRgsBuVt9eu/kEW/3lAcuvB0XsWpAHLky6SyTRP1n8LVRv4zZzkC+WebkK7F9n3E+gP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788752; c=relaxed/simple;
	bh=byKsVt5kfARyWMQ+Wys+3V1BZ1fFa9lghRODrpk5D0U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MRvECSB6p2feNmFxNId81z0Uy5now+PPtzEiaJMSblZg/IxSbvRuIwyt+J94BGc3LTkQCj1rWyVkPedZrtgfYbYp35Pr2p6gjA9Y2DQZiYs4shdqrljOMm2/REw6m3gmG7wOKGKbjJ0cVdAR8SrRhgup35X76Rl3a32I0o+Oln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r+OPFmYn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r+OPFmYn"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A670420B7167; Tue, 10 Feb 2026 21:45:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A670420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770788750;
	bh=eZZalm4VeHuSBsuld5iU0lfQTOovz3kt5YTDAVGflx4=;
	h=From:To:Subject:Date:From;
	b=r+OPFmYncNg9wIBAY0Kj+65oBPv4y0+KhMUlpS1rXSnXA+bzVmo7B/KBAnn80/8QH
	 e/Mx+jr73e3TjNZGbPLUIl0AqByLQJGottnJsU55+U57ZT4S34h+AYKkvp7lvBPuBE
	 em8pxJbDpizYkDKFVCQGfL7Kmmjj+B/We/oi7e+8=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: ernis@microsoft.com,
	kys@microsoft.com,
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
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: mana: Add MAC address to vPort logs and clarify error messages
Date: Tue, 10 Feb 2026 21:43:24 -0800
Message-ID: <20260211054335.8511-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MAC address to vPort configuration success message and update error
message to be more specific about HWC message errors in
mana_send_request and mana_hwc_send_request.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Remove the changes from v2 and Update commit message.
* Use "Enabled vPort ..." instead of "Configured vPort" in
  mana_cfg_vport.
* Update error logs in mana_hwc_send_request.
Changes in v2:
* Update commit message.
* Use "Enabled vPort ..." instead of "Configured vPort" in
  mana_cfg_vport.
* Add info log in mana_uncfg_vport, mana_gd_verify_vf_version,
  mana_gd_query_max_resources, mana_query_device_cfg and
  mana_query_vport_cfg.
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 19 +++++++++++--------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  8 ++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index aa4e2731e2ba..d4fd513dc1d6 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -853,6 +853,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	struct hwc_caller_ctx *ctx;
 	u32 dest_vrcq = 0;
 	u32 dest_vrq = 0;
+	u32 command;
 	u16 msg_id;
 	int err;
 
@@ -861,8 +862,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	tx_wr = &txq->msg_buf->reqs[msg_id];
 
 	if (req_len > tx_wr->buf_len) {
-		dev_err(hwc->dev, "HWC: req msg size: %d > %d\n", req_len,
-			tx_wr->buf_len);
+		dev_err(hwc->dev, "%s:%d: req msg size: %d > %d\n",
+			__func__, __LINE__, req_len, tx_wr->buf_len);
 		err = -EINVAL;
 		goto out;
 	}
@@ -878,6 +879,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	req_msg->req.hwc_msg_id = msg_id;
 
 	tx_wr->msg_size = req_len;
+	command = req_msg->req.msg_type;
 
 	if (gc->is_pf) {
 		dest_vrq = hwc->pf_dest_vrq_id;
@@ -886,15 +888,16 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 
 	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
 	if (err) {
-		dev_err(hwc->dev, "HWC: Failed to post send WQE: %d\n", err);
+		dev_err(hwc->dev, "%s:%d: Failed to post send WQE: %d\n",
+			__func__, __LINE__, err);
 		goto out;
 	}
 
 	if (!wait_for_completion_timeout(&ctx->comp_event,
 					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
 		if (hwc->hwc_timeout != 0)
-			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
-				hwc->hwc_timeout);
+			dev_err(hwc->dev, "%s:%d: Command 0x%x timed out: %u ms\n",
+				__func__, __LINE__, command, hwc->hwc_timeout);
 
 		/* Reduce further waiting if HWC no response */
 		if (hwc->hwc_timeout > 1)
@@ -914,9 +917,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 			err = -EOPNOTSUPP;
 			goto out;
 		}
-		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
-			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
-				ctx->status_code);
+		if (command != MANA_QUERY_PHY_STAT)
+			dev_err(hwc->dev, "%s:%d: Command 0x%x failed with status: 0x%x\n",
+				__func__, __LINE__, command, ctx->status_code);
 		err = -EPROTO;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9b5a72ada5c4..53f24244de75 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1023,8 +1023,8 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 
 		if (req->req.msg_type != MANA_QUERY_PHY_STAT &&
 		    mana_need_log(gc, err))
-			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
-				err, resp->status);
+			dev_err(dev, "Command 0x%x failed with status: 0x%x, err: %d\n",
+				req->req.msg_type, resp->status, err);
 		return err ? err : -EPROTO;
 	}
 
@@ -1337,8 +1337,8 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 	apc->tx_shortform_allowed = resp.short_form_allowed;
 	apc->tx_vp_offset = resp.tx_vport_offset;
 
-	netdev_info(apc->ndev, "Configured vPort %llu PD %u DB %u\n",
-		    apc->port_handle, protection_dom_id, doorbell_pg_id);
+	netdev_info(apc->ndev, "Enabled vPort %llu PD %u DB %u MAC %pM\n",
+		    apc->port_handle, protection_dom_id, doorbell_pg_id, apc->mac_addr);
 out:
 	if (err)
 		mana_uncfg_vport(apc);
-- 
2.34.1

