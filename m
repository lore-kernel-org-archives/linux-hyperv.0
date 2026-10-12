Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B714DAFAA;
	Mon, 12 Oct 2026 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830714; cv=none; b=qZEB49t9Irh6u1cgM8v0JKwKuC22kzN6H8XBtLQQH2+NmoK9rmUQeFIf9Kg8Fg4xsVRaeNPeHnDzXN2q5dqTL153x9uAf+HjLasBm2f8P1YcmaOdNa1xL9Bg+/0Zv4Jd9TY1ZDNiqdXVuhlKqVFs4R/HArL/VYWlm9Y2sjfuryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830714; c=relaxed/simple;
	bh=moux0RdaQOg9oAn2omKHKdRwyFUKoL7usBjJzvOq3aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giqC91BnoRCgEMskejbQd9qFkO6pc00x9d+c6UdcvQ+Ho36ib+o3apRzDBpRA0DlI/kE0IyOZ7nOJqe5WPXpmclhRLNw1A0jU8LCgNgPNXUaeudo7757Erxe9X7Agatih2aGZMwn9VW2YIMBEmg6rtMOxgZexninWKp4p1OaylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ofJTV+zA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ofJTV+zA"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 3D07120B7166; Mon, 12 Oct 2026 11:45:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D07120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791830710;
	bh=aV/lGjTgFzjmi1GzusTJEogclUVFMsaWVMcBG2jRLsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofJTV+zAcILUHPvuxvsigZInR4BrwsNh2/ETsurQRBgkE83ooKEkswKTFlyT/g1hw
	 lVxCFSIpfyq+LQ9B+DbJlakrftSOx/AUpY95xryMhhXntr0T8pZQ8eRzMa/rMOpZjr
	 5Rassvh93Lw5h9P+EgbeeQ2DHY1P1nTsqIuZa5/U=
Date: Mon, 12 Oct 2026 14:45:10 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ernis@linux.microsoft.com,
	gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: add BQL support
Message-ID: <as0qticPN9LPaaNU@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261008152302.3192778-1-hamzamahfooz@linux.microsoft.com>
 <179182066558.434549.8621824405062801385@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179182066558.434549.8621824405062801385@kernel.org>

On Mon, Oct 12, 2026 at 03:57:45PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 0 � Medium: 1 � Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] If TX completions are lost, XDP traffic can keep a BQL-stopped
>   MANA queue from ever being recovered by the TX watchdog.
> 
> --
> 
> net: mana: add BQL support
> 
> This patch adds byte queue limit accounting to MANA. Queued bytes are
> reported in mana_start_xmit() and completed bytes in mana_poll_tx_cq().
> XDP_TX and XDP_REDIRECT sends are counted through the same path, and the
> BQL state is reset in mana_destroy_txq() after NAPI is disabled.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 2ba48a1c4b15e..67048fe64d63e 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -543,6 +543,11 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  	err = NETDEV_TX_OK;
> >  	atomic_inc(&txq->pending_sends);
> >  
> > +	/* Account the skb in BQL before the doorbell lets the hardware
> > +	 * complete it.
> > +	 */
> > +	netdev_tx_sent_queue(net_txq, len);
> > +
> 
> [Severity: Medium]
> Can XDP traffic stop the TX watchdog from ever recovering a queue that
> BQL has stopped? The commit message says:
> 
>   The TX watchdog covers the queues stopped by BQL, and its handler resets
>   the queues along with their BQL state.
> 
> XDP_TX and XDP_REDIRECT (mana_xdp_xmit()->mana_xdp_xmit_fm()) both reach
> mana_start_xmit() through mana_xdp_tx(). That function does not check
> whether the queue is stopped:
> 
> drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_tx() {
>     ...
> 	__netif_tx_lock(ndevtxq, smp_processor_id());
> 
> 	rc = mana_start_xmit(skb, ndev);
>     ...
> }
> 
> With this patch, each of those sends now calls netdev_tx_sent_queue().
> If the queue is over its limit, netdev_tx_sent_queue() always refreshes
> trans_start, even when __QUEUE_STATE_STACK_XOFF is already set:
> 
> include/linux/netdevice.h:netdev_tx_sent_queue() {
>     ...
> 	/* Paired with READ_ONCE() from dev_watchdog() */
> 	WRITE_ONCE(dev_queue->trans_start, jiffies);
>     ...
> 	set_bit(__QUEUE_STATE_STACK_XOFF, &dev_queue->state);
>     ...
> }
> 
> dev_watchdog() only fires when trans_start is older than watchdog_timeo.
> MANA sets watchdog_timeo to 15 * HZ. One XDP packet every 15 seconds on
> that queue seems to be enough to stop mana_tx_timeout() from ever
> running.
> 
> In that state, what clears STACK_XOFF? mana_poll_tx_cq() matches CQEs to
> SKBs in FIFO order with skb_dequeue(). If completions are lost, the lost
> bytes become a permanent debt D in num_queued - num_completed.
> netdev_tx_completed_queue() only clears STACK_XOFF when dql_avail() >= 0,
> so the limit would have to reach D.
> 
> In dql_completed(), the limit only grows here:
> 
> 	if ((ovlimit && !inprogress) ||
> 	    (dql->prev_ovlimit && all_prev_completed)) {
> 
> The first condition can't be true while inprogress >= D. The second
> needs one poll to complete at least the bytes that were in flight at the
> previous poll. A low-rate XDP flow with one completion per poll won't
> meet that.
> 
> For example, take equal R-byte packets, a learned limit of R, and two
> lost completions (D = 2R). The limit never grows, and the decrease
> branch can shrink it further.
> 
> netif_tx_wake_queue() only clears DRV_XOFF. The only
> netdev_tx_reset_queue() call is in mana_destroy_txq().
> 
> Would stack traffic on that queue then stay blocked indefinitely while
> XDP traffic keeps flowing?
> 

Ack, I'll spin up a v2 to address this.

> Hardware faults are not the only source of lost completions. The early
> returns in mana_poll_tx_cq() exit after some SKBs have already been
> dequeued and freed, but before netdev_tx_completed_queue() runs:
> 

The early returns are all WARN_ON_ONCE() paths (for completions that
shouldn't happen). mana_gd_poll_cq() has already consumed the rest of
the batch (by the time we hit one of those paths), so the SKBs can't be
matched back to completions anymore. Completing the SKBs already dequeued
wouldn't avoid that, so I think it makes more sense to leave those paths
as they are and rely on the watchdog reset to recover the queue.

pw-bot: cr

> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_poll_tx_cq() {
>     ...
> 		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))
> 			return;
> 
> 		skb = skb_dequeue(&txq->pending_skbs);
> 		if (WARN_ON_ONCE(!skb))
> 			return;
>     ...
> }
> 
> Before this patch, a few leaked WQEs did not block stack traffic on the
> queue as long as the SQ was not full.
> 
> [ ... ]
> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008152302.3192778-1-hamzamahfooz%40linux.microsoft.com
