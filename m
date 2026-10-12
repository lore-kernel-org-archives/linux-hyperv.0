Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065F4A8A1C;
	Mon, 12 Oct 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820669; cv=none; b=GDLne6CahC5BUsDbHLVQ6d9AJlEDZCyRgKe3yUiq2FtFzckQJunFpaSpuKDMI0UxGG4cqFB0mqGKduFInC3GmSbBujVrIozS+mRagfj8ldSSkVnep+OjscwGNVqk3TLQStzhAFUFJ/AsvpZNB9XjPZW0xlvdewI8btgjt4cXQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820669; c=relaxed/simple;
	bh=UUhQv3nVMfweD/qT1z6SGS1pgu38m5L/e2GWgurkOws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSDWLjE7Hlz0cI4HWxYEaBfJVvZtofUtSpuoKsTml6U5wcmo18BU67Rk9CnOwVDOiJA1RATgC6h5oCXsULZZfUuyl6XEhwg5zcime0JuQcVG6HgN5T8kBlxVNMsDxTuK1vf1EEouzHA+QEtU1zsH9cyxBNp6UdsWRntqUAb7oKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdeT2zBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdeT2zBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ADD1F0089B;
	Mon, 12 Oct 2026 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820666;
	bh=WGnRlIgO15cV7Kc1vnVRCYiwYBnTlCpmWUly2qpyHQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IdeT2zBbLP4inijI5zTN3WQaDAGI3EycYHi0xUSHTW7/Z4hTOcfTFTRKLSeuTsjtD
	 qmvq2Sq5/rneL6hJA298VOoTMMoIrGdPBjVhzIk99C6U5VdqlECwIqcE3Q0g+SNVBX
	 /SHziRhzB3D3im8z204WOwdKHq919vTgxEmQjOc8314pHXNAYVqwRPCZ2aJkWUQHGa
	 vhd76spWbqtm5PT2MZvASQ3BZ0CYGm+rQsaR0vg9Ws65Dy93S5dKpCUkhtAo5thY4q
	 RS2dwCPSEMk/hcer33qix95/UcMMa6di0CPrJf5hKZbAEckyH2jaxZcFHJOFO/z+vq
	 LB9iFeUvsyung==
Subject: Re: [PATCH net-next] net: mana: add BQL support
From: netdev-bot+sashiko@kernel.org
To: hamzamahfooz@linux.microsoft.com
Cc: netdev@vger.kernel.org, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ernis@linux.microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 15:57:45 +0000
Message-ID: <179182066558.434549.8621824405062801385@kernel.org>
In-Reply-To: <20261008152302.3192778-1-hamzamahfooz@linux.microsoft.com>
References: <20261008152302.3192778-1-hamzamahfooz@linux.microsoft.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] If TX completions are lost, XDP traffic can keep a BQL-stopped
  MANA queue from ever being recovered by the TX watchdog.

--

net: mana: add BQL support

This patch adds byte queue limit accounting to MANA. Queued bytes are
reported in mana_start_xmit() and completed bytes in mana_poll_tx_cq().
XDP_TX and XDP_REDIRECT sends are counted through the same path, and the
BQL state is reset in mana_destroy_txq() after NAPI is disabled.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2ba48a1c4b15e..67048fe64d63e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -543,6 +543,11 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	err = NETDEV_TX_OK;
>  	atomic_inc(&txq->pending_sends);
>  
> +	/* Account the skb in BQL before the doorbell lets the hardware
> +	 * complete it.
> +	 */
> +	netdev_tx_sent_queue(net_txq, len);
> +

[Severity: Medium]
Can XDP traffic stop the TX watchdog from ever recovering a queue that
BQL has stopped? The commit message says:

  The TX watchdog covers the queues stopped by BQL, and its handler resets
  the queues along with their BQL state.

XDP_TX and XDP_REDIRECT (mana_xdp_xmit()->mana_xdp_xmit_fm()) both reach
mana_start_xmit() through mana_xdp_tx(). That function does not check
whether the queue is stopped:

drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_tx() {
    ...
	__netif_tx_lock(ndevtxq, smp_processor_id());

	rc = mana_start_xmit(skb, ndev);
    ...
}

With this patch, each of those sends now calls netdev_tx_sent_queue().
If the queue is over its limit, netdev_tx_sent_queue() always refreshes
trans_start, even when __QUEUE_STATE_STACK_XOFF is already set:

include/linux/netdevice.h:netdev_tx_sent_queue() {
    ...
	/* Paired with READ_ONCE() from dev_watchdog() */
	WRITE_ONCE(dev_queue->trans_start, jiffies);
    ...
	set_bit(__QUEUE_STATE_STACK_XOFF, &dev_queue->state);
    ...
}

dev_watchdog() only fires when trans_start is older than watchdog_timeo.
MANA sets watchdog_timeo to 15 * HZ. One XDP packet every 15 seconds on
that queue seems to be enough to stop mana_tx_timeout() from ever
running.

In that state, what clears STACK_XOFF? mana_poll_tx_cq() matches CQEs to
SKBs in FIFO order with skb_dequeue(). If completions are lost, the lost
bytes become a permanent debt D in num_queued - num_completed.
netdev_tx_completed_queue() only clears STACK_XOFF when dql_avail() >= 0,
so the limit would have to reach D.

In dql_completed(), the limit only grows here:

	if ((ovlimit && !inprogress) ||
	    (dql->prev_ovlimit && all_prev_completed)) {

The first condition can't be true while inprogress >= D. The second
needs one poll to complete at least the bytes that were in flight at the
previous poll. A low-rate XDP flow with one completion per poll won't
meet that.

For example, take equal R-byte packets, a learned limit of R, and two
lost completions (D = 2R). The limit never grows, and the decrease
branch can shrink it further.

netif_tx_wake_queue() only clears DRV_XOFF. The only
netdev_tx_reset_queue() call is in mana_destroy_txq().

Would stack traffic on that queue then stay blocked indefinitely while
XDP traffic keeps flowing?

Hardware faults are not the only source of lost completions. The early
returns in mana_poll_tx_cq() exit after some SKBs have already been
dequeued and freed, but before netdev_tx_completed_queue() runs:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_poll_tx_cq() {
    ...
		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))
			return;

		skb = skb_dequeue(&txq->pending_skbs);
		if (WARN_ON_ONCE(!skb))
			return;
    ...
}

Before this patch, a few leaked WQEs did not block stack traffic on the
queue as long as the SQ was not full.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008152302.3192778-1-hamzamahfooz%40linux.microsoft.com
