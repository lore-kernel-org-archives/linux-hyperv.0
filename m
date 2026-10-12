Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418573B8BB9;
	Mon, 12 Oct 2026 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833716; cv=none; b=hZXzsejW3/bGgOyimZvxCYEicRvpSAr1xFKbZbmBePpCvX72rJPk99pVdJO/m4FITFqUeFZlpJFb2EnJogpY+cg++LMRNGcR2+ce8aRtCO9e/QDeFzhG6nyscLWa3rVJCxbUeaQjVP05eTBjE3mYxp964+f5MOjErM/agGPzKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833716; c=relaxed/simple;
	bh=89/NnPsfwuCkv8ZB6AdQ4JRQdoqo21JdqqusKN4QNPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqLEo3Ec/Jx2RSOtQl2sTNCfj4z0G2JIIwKE/8uzqxaPEmJ2sMaiWa0zTW5qBCKkOEmKcu0QPeWZL/GXNYZQ2z1RuemMIOXWqMlEf+esyk6zIbJ2VXVqnnqqmzWyWRgvSv1DwvtxTOC8euQI8Q6YVUSQElG2ej9OF7yJGnQZ5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cY6jEMhN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cY6jEMhN"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4334B20B7166; Mon, 12 Oct 2026 12:35:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4334B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791833712;
	bh=tJkueSXegGJXKDCj/TsWJrVg8sccm8K33NEo8WI4FeY=;
	h=From:To:Cc:Subject:Date:From;
	b=cY6jEMhNTknS+40Ilj4ehtKrii/6wZISBW8JvpoDin5txzeG/0I1etLEmxalUEs5M
	 NvNVAFUnFtLqYsFnpxlS/2QaPi+DCnEV7YBpjgmA7tMctbqkMYRjFdwq84V6/gVvxy
	 RF3uonJ8OTELKxiCw4DbH1kwD4dP/gWhCrmFoV7E=
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
Subject: [PATCH net-next v2] net: mana: add BQL support
Date: Mon, 12 Oct 2026 15:33:25 -0400
Message-ID: <20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MANA doesn't support byte queue limits, so each TX queue can hold 256
WQEs by default, and up to 16384, of up to 64 KB TSO packets, before the
qdisc layer sees any backpressure. This adds latency to all the flows
sharing a queue, and defeats AQM qdiscs such as fq_codel, which rely on
BQL to keep the driver queues short.

Report the bytes queued and completed to BQL. XDP_TX and XDP_REDIRECT
packets go through the same SQs, so they are accounted too. BQL doesn't
drop or delay them, since the XDP paths send even when the queue is
stopped, it only holds back the stack's packets. For the packets sent on
a stopped queue, only count the bytes: stopping the queue again would
refresh its trans_start, so XDP traffic would keep the TX watchdog from
firing.

Reset the BQL state when destroying the queues, once their NAPI is
disabled, since the SKBs still pending after a drain timeout are freed
without being completed.

Lost TX completions can now stop a queue sooner: it also stops when the
bytes in flight exceed the BQL limit, not only when the SQ is full, and
the limit may never grow enough to cover the lost bytes. The TX watchdog
covers the queues stopped by BQL, and its handler resets the queues
along with their BQL state.

Tested on two Standard_D16ds_v6 Azure VMs in a proximity placement
group, where the throughput is capped at 10.6 Gbps, with the DUT
alternately booting net-next (c1c1f0a31712) with and without this patch
applied.

The throughput stays at the cap with 1, 8 and 64 TCP flows, and the idle
TCP_RR latency doesn't change (p50 of 47 us with vs. without the patch).
With 16 senders of 64-byte UDP packets, the DUT sends 3.7 to 4.0 Mpps
without the patch and 3.7 to 4.1 Mpps with it. With bulk TCP flows
sharing the queues, the netperf TCP_RR latency drops (medians of 6
runs):

  16 queues, 64 flows: p50 4649 -> 2182 us, p99 5621 -> 2677 us
  1 queue, 8 flows:    p50 2554 ->  418 us, p99 2723 ->  624 us

The standing queue moves from the SQs to fq_codel, which now drops
packets: about 2500 qdisc drops and 88K TCP retransmissions per 48 s run
with 64 flows, against at most 29 retransmissions before. The
retransmissions are about 0.2% of the segments sent. The TCP_RR flows
lose no packets, and the packets of the bulk flows are dropped before
they reach the wire, so the goodput changes by less than 0.01%.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2: Only count the bytes of the packets sent on a stopped queue, so that
    XDP traffic doesn't keep the TX watchdog from firing on a queue
    stopped by BQL. (Sashiko)
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 489558176a5d..7f081c2d16d0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -543,6 +543,16 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	err = NETDEV_TX_OK;
 	atomic_inc(&txq->pending_sends);
 
+	/* Account the skb in BQL before the doorbell lets the hardware
+	 * complete it. The XDP paths send even when the queue is stopped,
+	 * only count the bytes then, since stopping the queue again would
+	 * refresh its trans_start and keep the TX watchdog from firing.
+	 */
+	if (netif_xmit_stopped(net_txq))
+		__netdev_tx_sent_queue(net_txq, len, true);
+	else
+		netdev_tx_sent_queue(net_txq, len);
+
 	mana_gd_wq_ring_doorbell(gd->gdma_context, gdma_sq);
 
 	/* skb may be freed after mana_gd_post_work_request. Do not use it. */
@@ -2038,10 +2048,12 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
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
@@ -2694,6 +2706,13 @@ static void mana_destroy_txq(struct mana_port_context *apc)
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

