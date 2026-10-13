Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD135172E9;
	Tue, 13 Oct 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923887; cv=none; b=FsevxVsrIJrDsybTEA8Iv/I/TGFGl39x8u2Ncxj2Yu+MZsiteSkwjzf99eXOdDpBzjL0nw+BveDt6htv7pemIUNO7gEOROluWOzKytG+HzCoZJxvZit/r34RMaFuC9jGfWKwmy9S7dW+gZqIQ/q35BNla4SAc5HgI1S7tD3+aF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923887; c=relaxed/simple;
	bh=187hDUtdFS4EHgN7OE03HwzqllHVYYNXEcU3Ewt4VkM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwJGTB0gaMmEBUcrWV8ca7K+BDXjxatfocnV/4KSR8VYAq1LjcGNwMdSsykwaxIcetGTloLxmSMOcfhB9y45IV6XgTwung4HxC9TxAdLXXxX0KdlDBeac5axmrqmvl7CNPwwQ5KzVAYvbcK/IlBnRaaZNWjFueShBlzMbyCd6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEI+hMxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEI+hMxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA2E1F000FF;
	Tue, 13 Oct 2026 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923884;
	bh=Zbk+3wO+wBQbRvc0Gk1CKBJPfi2gLOEKuwAx50SQHdc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oEI+hMxAvPRd+k9lP1g+RhlHxkdfPA6KgruHo8zZuhw/2uuT7pXylt7Wn7GzIaIJL
	 dmF+R7vzwIOFbOIOrn3nBRmxS8pDY623dR2/RR1+v3UIPyhr4FqaFGIWK9WF9B/R92
	 PpI40vQXcT4Aix0amOEHbhTQP1YcRjieVNO21u4N9i7UhRARQcL7p2nqjUfEC20VMV
	 a8jt9AeG8Kb2LGP0M6Eniv7BmXEAiLacnw5tHJ+dqQ2DNEuDwwhFQuJHobi+bBovZ6
	 HTdudNnb/BUax3e8Pd4yP3fm5YKLqPzFXJbZ0sG+lTuj9Sfh8U2P0HvDQbA2UH9TCk
	 CuLKS2fWdgbfg==
Subject: Re: [PATCH net-next v2] net: mana: add BQL support
From: netdev-bot+sashiko@kernel.org
To: hamzamahfooz@linux.microsoft.com
Cc: netdev@vger.kernel.org, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ernis@linux.microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 20:38:03 +0000
Message-ID: <179192388340.434549.533077235115770364@kernel.org>
In-Reply-To: <20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com>
References: <20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mana: false positive TX watchdog timeout on XDP due to bypassed
  trans_start
- [Medium] The v2 change says it keeps XDP traffic from holding off the
  TX watchdog on a queue stopped by BQL, but XDP traffic can still do so…
- [Low] The bytes-only BQL branch in mana_start_xmit() is meant for XDP
  sends on an already-stopped queue, but it also catches the stack…
- [Low] mana_poll_tx_cq() has WARN_ON_ONCE() early returns inside its
  completion loop: !completions[i].is_sq (line 1984), a bad client_type…

--

net: mana: add BQL support

This adds byte queue limits support to the mana driver. Bytes are reported
as queued in mana_start_xmit() and as completed in mana_poll_tx_cq(). On
an already stopped queue only the bytes are counted, and the BQL state is
reset in mana_destroy_txq() after NAPI is disabled.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 489558176a5de..7f081c2d16d03 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -543,6 +543,16 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	err = NETDEV_TX_OK;
>  	atomic_inc(&txq->pending_sends);
>  
> +	/* Account the skb in BQL before the doorbell lets the hardware
> +	 * complete it. The XDP paths send even when the queue is stopped,
> +	 * only count the bytes then, since stopping the queue again would
> +	 * refresh its trans_start and keep the TX watchdog from firing.
> +	 */

[Severity: Medium]
Does this fully stop XDP traffic from holding off the TX watchdog?

A few lines earlier in mana_start_xmit(), the driver stops the queue
whenever the SQ is low. It doesn't check whether the queue is already
stopped, and it runs before the post error is checked:

	err = mana_gd_post_work_request(gdma_sq, &pkg.wqe_req,
					(struct gdma_posted_wqe_info *)skb->cb);
	if (!mana_can_tx(gdma_sq)) {
		netif_tx_stop_queue(net_txq);
		apc->eth_stats.stop_queue++;
	}

netif_tx_stop_queue() always does:

	WRITE_ONCE(dev_queue->trans_start, jiffies);

Say TX completions stop arriving. BQL sets STACK_XOFF, but XDP_TX and
XDP_REDIRECT frames keep reaching mana_start_xmit() through mana_xdp_tx().
mana_move_wq_tail() never runs, so XDP fills the SQ.

After that, each XDP attempt either takes the last slot or fails with
-ENOSPC in mana_gd_post_work_request(), since monitor_avl_buf is set. Both
cases go through netif_tx_stop_queue() and refresh trans_start, so
dev_watchdog() never sees:

	time_after(jiffies, trans_start + dev->watchdog_timeo)

Then mana_tx_timeout() never schedules the reset that clears the BQL
state. Stack traffic on that queue stays stopped as long as XDP frames
keep arriving.

The pre-patch driver had the same DRV_XOFF refresh when completions were
lost entirely. Still, the commit message says "The TX watchdog covers the
queues stopped by BQL", and the v2 note says "so that XDP traffic doesn't
keep the TX watchdog from firing on a queue stopped by BQL".

Does that only hold until the SQ fills? Should the stop and its
trans_start refresh also be skipped when the queue is already stopped or
the post failed?

> +	if (netif_xmit_stopped(net_txq))
> +		__netdev_tx_sent_queue(net_txq, len, true);
> +	else
> +		netdev_tx_sent_queue(net_txq, len);

[Severity: High]
Can this branch make dev_watchdog() fire on a queue whose completions
are still arriving normally?

XDP_TX and XDP_REDIRECT frames reach mana_start_xmit() without looking
at STACK_XOFF. Under sustained XDP load they can keep the dql in-flight
count above its limit.

Once a stack packet crosses the limit, netdev_tx_sent_queue() writes
trans_start and sets __QUEUE_STATE_STACK_XOFF. From then on
netif_xmit_stopped() is true, so every XDP frame takes this branch and
only calls dql_queued(). trans_start is never refreshed.

The netdev_tx_completed_queue() call in mana_poll_tx_cq() does not
clear STACK_XOFF either. While XDP keeps refilling the queue,
dql_avail() stays negative after each completion batch.

If the SQ is large enough, for example after a larger ring is set with
ethtool -G, mana_can_tx() never goes false. Then netif_tx_stop_queue()
is never called, and nothing else touches trans_start.

The hardware is fine and completions keep coming. Still, after
watchdog_timeo, dev_watchdog() sees a stopped queue with a stale
trans_start and calls mana_tx_timeout(). The queue reset tears down and
recreates the port. As long as the XDP load continues, the same thing
happens again on the next timeout.

This is the other side of the trade-off made in v2. Refreshing
trans_start on every XDP send hides a real stall. Never refreshing it
turns a queue that is only kept over the BQL limit by XDP into a false
timeout. Stack traffic on that queue is also held off by STACK_XOFF the
whole time, so the reset is only the visible symptom.

Should XDP frames be kept out of the BQL accounting on both the sent
and completed side, for example by marking them when they are posted
and skipping their bytes in mana_poll_tx_cq()? Or is there another way
to tell a queue that BQL keeps stopped because of XDP from one whose
completions were lost?

[Severity: Low]
Is this branch only reached by XDP sends on a queue that was already
stopped?

Take a stack packet whose post leaves the SQ low. The
netif_tx_stop_queue() earlier in the same mana_start_xmit() call has just
set DRV_XOFF. QUEUE_STATE_ANY_XOFF includes DRV_XOFF, so
netif_xmit_stopped() returns true here.

That packet then goes through __netdev_tx_sent_queue(net_txq, len, true),
which only calls dql_queued(). It skips the over-limit check in
netdev_tx_sent_queue() that sets __QUEUE_STATE_STACK_XOFF.

If that packet pushed BQL over its limit, STACK_XOFF is never set. On the
next completion, netdev_tx_completed_queue() returns early because
dql_avail() < 0. The DRV_XOFF wake path in mana_poll_tx_cq() then restarts
the queue while BQL is still over its limit.

So each time the SQ fills, one extra stack packet gets past the BQL limit,
even though the comment above describes this branch as XDP-only. Could the
stopped state be checked before the driver's own netif_tx_stop_queue()
call?

> +
>  	mana_gd_wq_ring_doorbell(gd->gdma_context, gdma_sq);
>  
>  	/* skb may be freed after mana_gd_post_work_request. Do not use it. */
> @@ -2038,10 +2048,12 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>  	gdma_wq = txq->gdma_sq;
>  	avail_space = mana_gd_wq_avail_space(gdma_wq);
>  
> +	net_txq = txq->net_txq;
> +	netdev_tx_completed_queue(net_txq, pkt_transmitted, tx_bytes);

[Severity: Low]
Can BQL's in-flight byte count leak when mana_poll_tx_cq() returns early?
The completion loop has several WARN_ON_ONCE() early returns:

		if (WARN_ON_ONCE(!completions[i].is_sq))
			return;
		...
		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))
			return;

		skb = skb_dequeue(&txq->pending_skbs);
		if (WARN_ON_ONCE(!skb))
			return;

There is also the client_type check inside the loop and the
wqe_unit_cnt == 0 check after it.

When one of these fires at iteration k, the earlier iterations have
already added their lengths to tx_bytes and freed their SKBs with
napi_consume_skb(). This netdev_tx_completed_queue() call is skipped.

Those bytes then count as in flight in the dql until
netdev_tx_reset_queue() runs in mana_destroy_txq(). That shrinks the
usable BQL budget and can set STACK_XOFF while the SQ still has room,
leaving recovery to the watchdog and a port reset.

Before this patch, these early returns already skipped mana_move_wq_tail()
and the pending_sends decrement, but the dql imbalance is new. Would
calling netdev_tx_completed_queue() for the SKBs already freed, for
example from a common exit label, keep BQL balanced?

> +
>  	/* Ensure tail updated before checking q stop */
>  	smp_mb();
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012193325.4071665-1-hamzamahfooz%40linux.microsoft.com
