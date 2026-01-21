Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DEB345753;
	Wed, 21 Jan 2026 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978627; cv=none; b=HX/rOADL5/NVbWSe0o0H//3i58s8ZNCc6jHM0ml+kvc/HPRpCWknJhV26rP3JxMMx525QrybGHPQ8RMSGlm6T/ItT5m5O/Oc4MYVLuRxCF6T36J/dfgTRvNiB0AHcTmyLqU1Ga2NEdNulfMeBu9Ghqmr9YdA+Roybf+XpO/ZCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978627; c=relaxed/simple;
	bh=AJUBvzyfUyr6MfMUlTjBVwweSnUK0dpns8p84dQGWS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jSpMfeJiQr9N/OiTcGqIkoM2XZGcuiskEF0U5tcRZzJoB3s929l6uPsrP1Qr9cHclgXpGtnBoHkn0mYgH5V5ko5ZeGzk1g1KVu4fbEiuMnSWO/XC9bDtSMN5+nZFObLezirFNBA7LWja/TQV0yD8Y7X9wdGcWuUqQyEDKIhWSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f7bcWhC6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f7bcWhC6"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B439120B7167; Tue, 20 Jan 2026 22:56:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B439120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768978618;
	bh=6qm2Z1st83nm1z41Pvq6Stoxjnaqb/vwxE+6a3Vupf0=;
	h=From:To:Subject:Date:From;
	b=f7bcWhC6qGyI4+TjkLcJL/19foEP5AqSzhp++fx9Nsurz7pEmcxujQFdcjOBYDJ+G
	 XqajTrVx+10Ziko6K7dzqM7lkMrGaU0CKJsoE57eGGYMZ14OdCxUuz4II8Sv5aKuBa
	 yCTuBrscD92IOXIFFTqy6T6iYohCk4ZF/n5ODHpo=
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
	leon@kernel.org,
	kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com,
	ernis@linux.microsoft.com,
	yury.norov@gmail.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	ssengar@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: Improve diagnostic logging for better debuggability
Date: Tue, 20 Jan 2026 22:56:55 -0800
Message-ID: <20260121065655.18249-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance MANA driver logging to provide better visibility into
hardware configuration and error states during driver initialization
and runtime operations.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Update commit message.
* Use "Enabled vPort ..." instead of "Configured vPort" in
  mana_cfg_vport.
* Add info log in mana_uncfg_vport, mana_gd_verify_vf_version,
  mana_gd_query_max_resources, mana_query_device_cfg and
  mana_query_vport_cfg.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  6 +++++
 .../net/ethernet/microsoft/mana/hw_channel.c  | 12 ++++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 23 ++++++++++++++-----
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0055c231acf6..c7b65ddea651 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -152,6 +152,9 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues > gc->num_msix_usable - 1)
 		gc->max_num_queues = gc->num_msix_usable - 1;
 
+	dev_info(gc->dev, "Max Resources: msix_usable=%u max_queues=%u\n",
+		 gc->num_msix_usable, gc->max_num_queues);
+
 	return 0;
 }
 
@@ -1229,6 +1232,9 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
 		}
 		dev_dbg(gc->dev, "set the hwc timeout to %u\n", hwc->hwc_timeout);
 	}
+
+	dev_info(gc->dev, "VF Version: protocol=0x%llx pf_caps=[0x%llx]\n",
+		 resp.gdma_protocol_ver, gc->pf_cap_flags1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index aa4e2731e2ba..71a18c70ecaf 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -853,6 +853,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	struct hwc_caller_ctx *ctx;
 	u32 dest_vrcq = 0;
 	u32 dest_vrq = 0;
+	u32 command;
 	u16 msg_id;
 	int err;
 
@@ -877,6 +878,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 
 	req_msg->req.hwc_msg_id = msg_id;
 
+	command = req_msg->req.msg_type;
 	tx_wr->msg_size = req_len;
 
 	if (gc->is_pf) {
@@ -893,8 +895,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	if (!wait_for_completion_timeout(&ctx->comp_event,
 					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
 		if (hwc->hwc_timeout != 0)
-			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
-				hwc->hwc_timeout);
+			dev_err(hwc->dev, "HWC: Request timed out: %u ms for command 0x%x\n",
+				hwc->hwc_timeout, command);
 
 		/* Reduce further waiting if HWC no response */
 		if (hwc->hwc_timeout > 1)
@@ -914,9 +916,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 			err = -EOPNOTSUPP;
 			goto out;
 		}
-		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
-			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
-				ctx->status_code);
+		if (command != MANA_QUERY_PHY_STAT)
+			dev_err(hwc->dev, "hw_channel command 0x%x failed with status: 0x%x\n",
+				command, ctx->status_code);
 		err = -EPROTO;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 91c418097284..09064f9706b8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1026,8 +1026,8 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 
 		if (req->req.msg_type != MANA_QUERY_PHY_STAT &&
 		    mana_need_log(gc, err))
-			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
-				err, resp->status);
+			dev_err(dev, "Command 0x%x failed with status: 0x%x, err: %d\n",
+				req->req.msg_type, resp->status, err);
 		return err ? err : -EPROTO;
 	}
 
@@ -1222,6 +1222,9 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	else
 		*bm_hostmode = 0;
 
+	dev_info(dev, "Device Config: max_vports=%u adapter_mtu=%u bm_hostmode=%u\n",
+		 *max_num_vports, gc->adapter_mtu, *bm_hostmode);
+
 	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
 
 	return 0;
@@ -1268,6 +1271,9 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
 	apc->port_handle = resp.vport;
 	ether_addr_copy(apc->mac_addr, resp.mac_addr);
 
+	netdev_info(apc->ndev, "VPort Config: vport=0x%llx max_sq=%u max_rq=%u indir_ent=%u MAC=%pM",
+		    apc->port_handle, *max_sq, *max_rq, *num_indir_entry, apc->mac_addr);
+
 	return 0;
 }
 
@@ -1277,6 +1283,9 @@ void mana_uncfg_vport(struct mana_port_context *apc)
 	apc->vport_use_count--;
 	WARN_ON(apc->vport_use_count < 0);
 	mutex_unlock(&apc->vport_mutex);
+
+	netdev_info(apc->ndev, "Disabled vPort %llu MAC %pM\n",
+		    apc->port_handle, apc->mac_addr);
 }
 EXPORT_SYMBOL_NS(mana_uncfg_vport, "NET_MANA");
 
@@ -1340,8 +1349,8 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 	apc->tx_shortform_allowed = resp.short_form_allowed;
 	apc->tx_vp_offset = resp.tx_vport_offset;
 
-	netdev_info(apc->ndev, "Configured vPort %llu PD %u DB %u\n",
-		    apc->port_handle, protection_dom_id, doorbell_pg_id);
+	netdev_info(apc->ndev, "Enabled vPort %llu PD %u DB %u MAC %pM\n",
+		    apc->port_handle, protection_dom_id, doorbell_pg_id, apc->mac_addr);
 out:
 	if (err)
 		mana_uncfg_vport(apc);
@@ -1412,8 +1421,10 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 		err = -EPROTO;
 	}
 
-	netdev_info(ndev, "Configured steering vPort %llu entries %u\n",
-		    apc->port_handle, apc->indir_table_sz);
+	netdev_info(ndev,
+		    "Configured steering vPort %llu entries %u MAC %pM [rx:%u rss:%u update_indirection_table:%u cqe_coalescing:%u]\n",
+		    apc->port_handle, apc->indir_table_sz, apc->mac_addr,
+		    rx, apc->rss_state, update_tab, req->cqe_coalescing_enable);
 out:
 	kfree(req);
 	return err;
-- 
2.34.1

