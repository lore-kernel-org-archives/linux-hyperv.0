Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1564384CF0;
	Thu,  3 Sep 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460872; cv=none; b=NRfe22BXymytbV74r3MEFE4XIz42FakgQR6J5nczymvNIP5IgMTD3WD/rT1Kt9uIAdA4vO/LvIxrctoVbTmlpu4as63VgLq/BWaANvUgpmSUg5LKiywHgpGLFof28aPQY0YBnDR6ExmsMPAjeyZWHs1nDiQWJO+Nnz/OcDuK8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460872; c=relaxed/simple;
	bh=+PzclMIgZe0NdWndame8A3sdL7Ldw+s5lMs35AkM0gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c63z8KxQnqHUzJDNMpnlLpwjRWZM4oJE6gcYxl5oOFk70BMTSsSmUa0ynCOo1umFdwG9sGVxcuSi0k45zjAZoxpAHQX8BiENzdz6ZIdXyfOV4hw7eHVlbN6gSt6N8a0tp7IgknhMztGmIrSs7g1XcXcykAAb4FEl+N8YJPMJUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CRjNkYB6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CRjNkYB6"
Received: from CPC-mawas-YGKSX.redmond.corp.microsoft.com (unknown [70.37.26.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6CCED20B7166;
	Thu,  3 Sep 2026 11:40:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CCED20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788460829;
	bh=8ehV14msUmWPyxOL2eMc56Q2gGAmE2qAOheGl1l7As8=;
	h=From:To:Cc:Subject:Date:From;
	b=CRjNkYB6DbxCt9vKuQn3D5hVNeeRCNmWnN/Sh8lezTiDQ5myAfKTT6E6GYQ98zOiI
	 oeIFImk8BVPD+4EG0yD1hGZy4TtdFlwNgq+2KbRZR7lS2wEVgyN2GdWIn9IsjrXSK3
	 zwyt+MIfUN7HS8Dq4n4nmJ9Nu/LmNyk95q6mprXM=
From: Manish Awasthi <mawasthi@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	gargaditya@linux.microsoft.com,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	paulros@microsoft.com
Subject: [PATCH net-next] net: mana: Use the HWC destination queues reported by the hardware
Date: Thu,  3 Sep 2026 18:41:04 +0000
Message-ID: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_hwc_send_request() gates the HWC destination queue IDs on
gc->is_pf, which the PCI probe derives from the device ID.

The gate is not needed. hwc->pf_dest_vrq_id and hwc->pf_dest_vrcq_id
are only ever assigned from the HWC_INIT_DATA_PF_DEST_RQ_ID and
HWC_INIT_DATA_PF_DEST_CQ_ID init events, and the hardware always
reports values that are valid for the function it sends them to.

Signed-off-by: Manish Awasthi <mawasthi@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 263e7c4e2934..5d75c2478a8a 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -855,13 +855,12 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 			  const void *req, u32 resp_len, void *resp)
 {
-	struct gdma_context *gc = hwc->gdma_dev->gdma_context;
 	struct hwc_work_request *tx_wr;
 	struct hwc_wq *txq = hwc->txq;
 	struct gdma_req_hdr *req_msg;
 	struct hwc_caller_ctx *ctx;
-	u32 dest_vrcq = 0;
-	u32 dest_vrq = 0;
+	u32 dest_vrcq;
+	u32 dest_vrq;
 	u32 command;
 	u16 msg_id;
 	int err;
@@ -890,10 +889,13 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	tx_wr->msg_size = req_len;
 	command = req_msg->req.msg_type;
 
-	if (gc->is_pf) {
-		dest_vrq = hwc->pf_dest_vrq_id;
-		dest_vrcq = hwc->pf_dest_vrcq_id;
-	}
+	/* The hardware reports the HWC destination queues through
+	 * HWC_INIT_DATA_PF_DEST_RQ_ID and HWC_INIT_DATA_PF_DEST_CQ_ID, and
+	 * always supplies values that are valid for this function, so no
+	 * PF-specific handling is needed here.
+	 */
+	dest_vrq = hwc->pf_dest_vrq_id;
+	dest_vrcq = hwc->pf_dest_vrcq_id;
 
 	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
 	if (err) {

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.54.0

