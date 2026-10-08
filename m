Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A35F4ACC93;
	Thu,  8 Oct 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473094; cv=none; b=js3RLwWEeHoG1T7Iimekvr0zwIoUSvtiJcnU8bXatidDqOp/Y/eDM8rJ4Qz8R19MQ5aEKs1ktraW5t4RWNFSRBkvx626GuRNauNoE0ix67m7Lep6xczzEqANaoCrQ6oK8g8GFk6TbZxD63NY+SseEo6RpM3KzNpVviV/wB0tdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473094; c=relaxed/simple;
	bh=FUPMSkx953zcMOD6YfhawZkPGLVfzGd1LnQyAeM8RZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgKP7a1uA7PcpaFnuIqiSJiq9T9dW8Ib337ilDVylxKGkPGA4yBEx1MZJtfkO4OQWVfzwgBx+WClIyrrOR3SkgB13Nq85QAZFxxGBaUm+vVjKRmpnlXeweamiqGF1Ul3iuYJdrGoPdudEZNwvvEpSYBS9r4Akan0jl7jzXyBPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YOD6sPN6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YOD6sPN6"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 54A6F20B7166; Thu,  8 Oct 2026 08:23:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54A6F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791473033;
	bh=GuE3fBNvvw/lypqoRPqiOAe7SHRjcBYe8FTnpFTNPYo=;
	h=From:To:Cc:Subject:Date:From;
	b=YOD6sPN6vrbVDjuMEyTeEeoL51dY4H5SOIjNsZR4p+OwnxywEzwptmwArbV+mJcMq
	 SGpZ3ZMym7pzaU4dTXAxYqI+7gF5vWJ92cst1bc5pi+pBsNUEoCDXufwJLP1X9Qal9
	 CJGowG8eco7rP5MIpqyiESHxqmcS7PRq0xw15XXk=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: netdev@vger.kernel.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH net-next] net: mana: add BQL support
Date: Thu,  8 Oct 2026 11:23:02 -0400
Message-ID: <20261008152302.3192778-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MANA doesn't support byte queue limits, so each TX queue can hold 256
WQEs by default, and up to 16384, of up to 64 KB TSO packets, before
the qdisc layer sees any backpressure. This adds latency to all the
flows sharing a queue, and defeats AQM qdiscs such as fq_codel, which
rely on BQL to keep the driver queues short.

Report the bytes queued and completed to BQL. XDP_TX and XDP_REDIRECT
packets go through the same SQs, so they are accounted too. BQL doesn't
drop or delay them, since the XDP paths send even when the queue is
stopped; it only holds back the stack's packets.

Reset the BQL state when destroying the queues, once their NAPI is
disabled, since the SKBs still pending after a drain timeout are freed
without being completed.

Lost TX completions can now stop a queue sooner: it also stops when the
bytes in flight exceed the BQL limit, not only when the SQ is full. The
TX watchdog covers the queues stopped by BQL, and its handler resets the
queues along with their BQL state.

Tested on two Standard_D16ds_v6 Azure VMs in a proximity placement
group, where the throughput is capped at 10.6 Gbps, with the DUT
alternately booting net-next (c1c1f0a31712) with and without this
patch applied.

The throughput stays at the cap with 1, 8 and 64 TCP flows, and the
idle TCP_RR latency doesn't change (p50 of 47 us with vs. without the
patch). With 16 senders of 64-byte UDP packets, the DUT sends 3.7 to
4.0 Mpps without the patch and 3.7 to 4.1 Mpps with it. With bulk TCP
flows sharing the queues, the netperf TCP_RR latency drops (medians of
6 runs):

  16 queues, 64 flows: p50 4649 -> 2182 us, p99 5621 -> 2677 us
  1 queue, 8 flows:    p50 2554 ->  418 us, p99 2723 ->  624 us

The standing queue moves from the SQs to fq_codel, which now drops
packets: about 2500 qdisc drops and 88K TCP retransmissions per 48 s
run with 64 flows, against at most 29 retransmissions before. The
retransmissions are about 0.2% of the segments sent. The TCP_RR flows
lose no packets, and the packets of the bulk flows are dropped before
they reach the wire, so the goodput changes by less than 0.01%.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 2ba48a1c4b15..67048fe64d63 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -543,6 +543,11 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	err = NETDEV_TX_OK;
 	atomic_inc(&txq->pending_sends);
 
+	/* Account the skb in BQL before the doorbell lets the hardware
+	 * complete it.
+	 */
+	netdev_tx_sent_queue(net_txq, len);
+
 	mana_gd_wq_ring_doorbell(gd->gdma_context, gdma_sq);
 
 	/* skb may be freed after mana_gd_post_work_request. Do not use it. */
@@ -2009,10 +2014,12 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
 	gdma_wq = txq->gdma_sq;
 	avail_space = mana_gd_wq_avail_space(gdma_wq);
 
+	net_txq = txq->net_txq;
+	netdev_tx_completed_queue(net_txq, pkt_transmitted, tx_bytes);
+
 	/* Ensure tail updated before checking q stop */
 	smp_mb();
 
-	net_txq = txq->net_txq;
 	txq_stopped = netif_tx_queue_stopped(net_txq);
 
 	/* Ensure checking txq_stopped before apc->port_is_up. */
@@ -2665,6 +2672,13 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
 
+		/* Forget the SKBs freed without being completed after a drain
+		 * timeout, now that NAPI can't complete any. Doing it here also
+		 * covers the queues that a lower channel count won't recreate,
+		 * which could otherwise stay stopped.
+		 */
+		netdev_tx_reset_queue(apc->tx_qp[i]->txq.net_txq);
+
 		if (apc->tx_qp[i]->tx_object != INVALID_MANA_HANDLE)
 			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 
-- 
2.56.0

