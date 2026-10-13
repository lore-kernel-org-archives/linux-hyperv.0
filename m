Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED75349D8
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Oct 2026 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920129; cv=none; b=hGGErLy1cgAJ+cCVppPqeGiv1vBWao7NxBRz8D6DN+yPr9M3m2WBKV9DkgtWtYjuPyiutlFZRt+6MYNg3Jk20NVeBY5q59TdSJ6fnza6bP0lfzgt6LGpLWcCMHmkuja5JZ1FhjxPHYf4sc4ysYQ646khhFvjKqAVCTQ4kncvM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920129; c=relaxed/simple;
	bh=esncB+jadMyquQWN3ZyTgzMcFOhJBjY482gaQ9nigAI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c6jitaqs+2y7SOdFJu1yT0cEb28wJU3jrfKPAOAV7eAowmHwq2utUF53JloCw3pSLR5fY0lOhNBygzHQd5VBzEzJFiAS1qFJVcgs0USgwKrLo4TssXRahaxEG/IIdZ3OkFgOhanQCibgSGBB2J7fCN0C2iE9Hnx2ZgJjgl6kxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM2nSRGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM2nSRGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7B1F000FF;
	Tue, 13 Oct 2026 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791920128;
	bh=WGO7Rso4+WRz8saW3uQ62Nq7HV69Ds3UMaOIJRn2SUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hM2nSRGtFRFuIDBc+nqmqX0QHah7SfovhyJMsrK7bERxCP606B1PhVg8DuCyGNhtY
	 6C6e0jfDCojItVnjcrScYoh6nTosE4+mT9/62JovLKeoL4Jj7f6ySdVzUBdXgqXCBa
	 jd2UhCmb1FovRI8Y+TMMyVqL9IM07tcftGu7o1uhw8B56J4Kieyg/Sd42dM2DRBDpe
	 f65Y7D+LSFY/ad4i+WrrYrzwodIe2o3BfLXXdJViUvVcz/COb1V//JcXah3mMFgucV
	 DeHitHzbl8GMuHbzN3qb/QtE8VNIkpqi/95+bTfirIxV0M84iQyoTyPP/wqUO4Km20
	 2he9mkVKzYPeQ==
Message-ID: <sashiko-outbox-170395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: mana: add BQL support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com>
References: <20261012193325.4071665-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 19:35:27 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mana: false positive TX watchdog timeout on XDP due to bypassed tr=
ans_start
- [High] net: mana: missing memory barrier allows Dekker's algorithm race s=
talling TX queue
--

commit 9321c04ed33bbb92ceb52c62c2cef3faad2705da
Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

net: mana: add BQL support

The patch introduces Byte Queue Limits (BQL) support to the MANA network
driver to prevent high latency and improve AQM interactions.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 489558176a5de..7f081c2d16d03 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -543,6 +543,16 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, str=
uct net_device *ndev)
>  	err =3D NETDEV_TX_OK;
>  	atomic_inc(&txq->pending_sends);
> =20
> +	/* Account the skb in BQL before the doorbell lets the hardware
> +	 * complete it. The XDP paths send even when the queue is stopped,
> +	 * only count the bytes then, since stopping the queue again would
> +	 * refresh its trans_start and keep the TX watchdog from firing.
> +	 */
> +	if (netif_xmit_stopped(net_txq))
> +		__netdev_tx_sent_queue(net_txq, len, true);
> +	else
> +		netdev_tx_sent_queue(net_txq, len);
> +

[Severity: High]
Could this logic cause a false positive TX watchdog timeout on XDP workload=
s?

When XDP traffic pushes packets directly, it ignores BQL limits. If the
traffic sustains without hitting the physical queue limit, trans_start is
never updated here since __netdev_tx_sent_queue(net_txq, len, true) is
called.

Because the physical limit isn't hit, netif_tx_stop_queue() is also never
called, leaving trans_start entirely frozen. Will this trigger a watchdog
timeout after 5 seconds?

>  	mana_gd_wq_ring_doorbell(gd->gdma_context, gdma_sq);
> =20
>  	/* skb may be freed after mana_gd_post_work_request. Do not use it. */

[ ... ]

> @@ -2038,10 +2048,12 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>  	gdma_wq =3D txq->gdma_sq;
>  	avail_space =3D mana_gd_wq_avail_space(gdma_wq);
> =20
> +	net_txq =3D txq->net_txq;
> +	netdev_tx_completed_queue(net_txq, pkt_transmitted, tx_bytes);
> +
>  	/* Ensure tail updated before checking q stop */
>  	smp_mb();
> =20
> -	net_txq =3D txq->net_txq;
>  	txq_stopped =3D netif_tx_queue_stopped(net_txq);

[Severity: High]
Does this memory barrier fully prevent a Dekker's algorithm race with the TX
thread?

In mana_start_xmit(), netif_tx_stop_queue() stops the queue using set_bit(),
which is atomic but doesn't imply a memory ordering barrier. It then checks
hardware space again:

mana_start_xmit()
    if (!mana_can_tx(gdma_sq)) {
        netif_tx_stop_queue(net_txq);
        ...
    }
    ...
    if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
        netif_tx_wake_queue(net_txq);
        ...
    }

Because the TX thread lacks an smp_mb() or smp_mb__after_atomic(),
architectures with relaxed memory ordering could reorder the read of the ta=
il
pointer before the store to the queue state.

If that read is hoisted, both threads could miss each other's updates:

- TX thread sees an old full queue.
- CQ thread sees an unstopped queue.

Could this leave the queue permanently stopped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012193325.4071=
665-1-hamzamahfooz@linux.microsoft.com?part=3D1
