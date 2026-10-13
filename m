Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042434B1B0
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Oct 2026 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927221; cv=none; b=h17lxxiYaf+WC9ozdNxCaKXTOR0wyDM9CqPDs9tN6b1JTFSRlmhMfmiW7d3v+m3BNunXt/4MsN6rgqvYShH5SEuIklmp5NH32UMyPVOeYiIV01YSPB9jqIhQhH65befTLBvQ6nR91BL02mZ/K4u/RCIaosBFVbumX1EdGcXKu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927221; c=relaxed/simple;
	bh=57xzde7LKVyT+5dEhJ3U9H7Qvgs5czE/fqoC5+UI7Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omk/km53smKV1z1jQhD3ImnOFmuTLiXWAXIi7rF8QxlTL657T7k7wRu5FXylM/zJcvJ/5D1j2LRb8RvdNWSd/PnIifS1KzCG5JnvJuWENeM466zdHQd+xaEKSzWoMzxepz4mGmHybmchv07yrJd1YdnP4RCqYusBJpMe4KPJsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b0GswWpG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b0GswWpG"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 7218920B7166; Tue, 13 Oct 2026 14:33:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7218920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791927216;
	bh=NHHcpzSsvfNUuPz0eZVfWMSfnqUEPcgsZ5z4/sE2fKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0GswWpG6bz8CT+CHM08RfAT9Ufu6dOAF5SbUUaasGOtewB7/5s/0/rRt//imN67U
	 04WDqBsDm2OkIyzCC1HT2u0RmEGzjTa1guwyQRR7HoObr/Y4U98a7Ml4fXNVvx0qwm
	 QNihCuX//V0TpmBbvURjpXPFUl8+VdZwX9PqOdFE=
Date: Tue, 13 Oct 2026 17:33:36 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: add BQL support
Message-ID: <as6jsPc+D3EJIMQT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com>
 <sashiko-outbox-170395@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170395@kernel.org>

On Tue, Oct 13, 2026 at 07:35:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] mana: false positive TX watchdog timeout on XDP due to bypassed trans_start
> - [High] net: mana: missing memory barrier allows Dekker's algorithm race stalling TX queue
> --
> 
> commit 9321c04ed33bbb92ceb52c62c2cef3faad2705da
> Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> net: mana: add BQL support
> 
> The patch introduces Byte Queue Limits (BQL) support to the MANA network
> driver to prevent high latency and improve AQM interactions.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 489558176a5de..7f081c2d16d03 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -543,6 +543,16 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  	err = NETDEV_TX_OK;
> >  	atomic_inc(&txq->pending_sends);
> >  
> > +	/* Account the skb in BQL before the doorbell lets the hardware
> > +	 * complete it. The XDP paths send even when the queue is stopped,
> > +	 * only count the bytes then, since stopping the queue again would
> > +	 * refresh its trans_start and keep the TX watchdog from firing.
> > +	 */
> > +	if (netif_xmit_stopped(net_txq))
> > +		__netdev_tx_sent_queue(net_txq, len, true);
> > +	else
> > +		netdev_tx_sent_queue(net_txq, len);
> > +
> 
> [Severity: High]
> Could this logic cause a false positive TX watchdog timeout on XDP workloads?
> 
> When XDP traffic pushes packets directly, it ignores BQL limits. If the
> traffic sustains without hitting the physical queue limit, trans_start is
> never updated here since __netdev_tx_sent_queue(net_txq, len, true) is
> called.
> 
> Because the physical limit isn't hit, netif_tx_stop_queue() is also never
> called, leaving trans_start entirely frozen. Will this trigger a watchdog
> timeout after 5 seconds?
> 

Ya, this does seem founded, I'm siding with just keeping XDP out of the
BQL equation entirely.

> >  	mana_gd_wq_ring_doorbell(gd->gdma_context, gdma_sq);
> >  
> >  	/* skb may be freed after mana_gd_post_work_request. Do not use it. */
> 
> [ ... ]
> 
> > @@ -2038,10 +2048,12 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
> >  	gdma_wq = txq->gdma_sq;
> >  	avail_space = mana_gd_wq_avail_space(gdma_wq);
> >  
> > +	net_txq = txq->net_txq;
> > +	netdev_tx_completed_queue(net_txq, pkt_transmitted, tx_bytes);
> > +
> >  	/* Ensure tail updated before checking q stop */
> >  	smp_mb();
> >  
> > -	net_txq = txq->net_txq;
> >  	txq_stopped = netif_tx_queue_stopped(net_txq);
> 
> [Severity: High]
> Does this memory barrier fully prevent a Dekker's algorithm race with the TX
> thread?
> 
> In mana_start_xmit(), netif_tx_stop_queue() stops the queue using set_bit(),
> which is atomic but doesn't imply a memory ordering barrier. It then checks
> hardware space again:
> 
> mana_start_xmit()
>     if (!mana_can_tx(gdma_sq)) {
>         netif_tx_stop_queue(net_txq);
>         ...
>     }
>     ...
>     if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
>         netif_tx_wake_queue(net_txq);
>         ...
>     }
> 
> Because the TX thread lacks an smp_mb() or smp_mb__after_atomic(),
> architectures with relaxed memory ordering could reorder the read of the tail
> pointer before the store to the queue state.
> 
> If that read is hoisted, both threads could miss each other's updates:
> 
> - TX thread sees an old full queue.
> - CQ thread sees an unstopped queue.
> 
> Could this leave the queue permanently stopped?

No, the patch doesn't modify the driver's stop and wake logic, and
BQL stops and wakes the queue with its own barriers, in
netdev_tx_sent_queue() and netdev_tx_completed_queue().

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com?part=1
