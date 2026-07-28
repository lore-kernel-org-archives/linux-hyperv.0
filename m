Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CA3B14D8
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Jul 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238701; cv=none; b=N58z1ujrO7kFGLEKtfLfMyrGafjw4PEbxlEDY5LhFPLRhDC1p4NfcR/GKJwaqXSTYVL9guy7nqs9Y3j9zq8fsMi0b1IEe7ebTAvrEsDIOuWsn0ecq+XXV8Qe9V74zMxAWOgUaZRfk52baDg+wsljLdOyakAWv172aZxF/AKp4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238701; c=relaxed/simple;
	bh=ZWp0kSoqwrFvgJX2VRizf5mre8nA3Glv5ovtI8phPpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzP1hMgPvkyn5WEhSSRZLpe6XyoifEZQIYkBFKol5CrWhEgfnf6LTxvnjYOgtYG3dfMhaEgFLRW6LWtUBs5PMD4mpA+sT23DAfjejNelOJ8goYNCY6tgv34Q+rZMve76O05FKbRKp+1KqIdWq2KM8X9zE0QA9PkhElKJoldW+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYErtfUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYErtfUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABF41F000E9;
	Tue, 28 Jul 2026 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238699;
	bh=chc/1VAtCUGXhhVJsMaAXbEhadu2eZb4lEmkWPWDl3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYErtfUdJll1Bv0esZVFDh16x2cKMkPgnBNNn6mCHBvPCGcrvFD8VHGtanKUxKTX+
	 M/s3L0GYcTBIKl0aKV+Ko3wJX9s3A5kM8cxkXY4BNZ9gnhjd3ykpg4rbJq3gDaKIku
	 Mq+5SR+tZpZZPp+ypn6SCmIwc9Dc1gmhxeQ7h2m/CULvhqXAEVA0r4JKVVots5NvPY
	 4gDsKVZr5F5KLBcHoC5ZgsgP7PaSZKcaykVN7ULSRCw4VNSaHCkjGZsDr3RWfRWru1
	 sy3fyzkC8guWqcFZC++KFT6VXTpMGyxW4epKcBGKHmpyqhPVVhTp5KcqSJElR0r8Fn
	 dtQydOhcOlWSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: mana: Return error code from
 mana_create_rxq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>
References: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 11:38:19 +0000
Message-Id: <20260728113819.AABF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race and Use-After-Free in mana_get_stats64() and mana_xdp_=
xmit() due to lockless access of queues.
--

--- Patch [1]: [PATCH net v2] net: mana: Return error code from mana_create=
_rxq() ---
commit 61de155c59ba6f86af33fcadf7943152726f385f
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: Return error code from mana_create_rxq()
   =20
mana_create_rxq() returns a struct mana_rxq pointer and returns NULL on
any failure. The caller, mana_add_rx_queues(), cannot tell what went
wrong and hardcodes the error as -ENOMEM. As a result the actual failure
reported by the lower layers is masked.

Link: https://lore.kernel.org/all/20260718024818.560552-1-gargaditya@linux.=
microsoft.com/

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9d9bfd116dabc..92bb55935c1c4 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -2964,8 +2964,8 @@ static int mana_add_rx_queues(struct mana_port_cont=
ext *apc,
> =20
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		rxq =3D mana_create_rxq(apc, i, &apc->eqs[i], ndev);
> -		if (!rxq) {
> -			err =3D -ENOMEM;
> +		if (IS_ERR(rxq)) {
> +			err =3D PTR_ERR(rxq);
>  			netdev_err(ndev, "Failed to create rxq %d : %d\n", i, err);
>  			goto out;
>  		}

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race and Use-After-Free
in mana_get_stats64() and mana_xdp_xmit() due to lockless access of queues?

If an administrator changes the MTU or closes the interface, mana_detach()
is triggered. It locklessly clears apc->port_is_up, disables TX, and then
frees the RX and TX queues using kvfree() directly via mana_dealloc_queues(=
),
without an RCU grace period:

mana_detach()
	apc->port_is_up =3D false;

	/* Ensure port state updated before txq state */
	smp_wmb();

	netif_tx_disable(ndev);

	if (apc->port_st_save) {
		err =3D mana_dealloc_queues(ndev);

Concurrently, can unprivileged userspace reading /proc/net/dev (triggering
mana_get_stats64()) check apc->port_is_up, evaluate it as true, and then
access the freed queues?

mana_get_stats64()
	if (!apc->port_is_up)
		return;
...
	for (q =3D 0; q < num_queues; q++) {
		rx_stats =3D &apc->rxqs[q]->stats;

Similarly, in mana_xdp_xmit(), the TX lock is temporarily acquired and
dropped for each packet in the loop, allowing mana_detach() to complete
netif_tx_disable() and proceed with freeing the queue before
mana_xdp_xmit() updates the stats:

mana_xdp_xmit()
	for (i =3D 0; i < n; i++) {
		if (mana_xdp_xmit_fm(ndev, frames[i], q_idx))
			break;

		count++;
	}

	tx_stats =3D &apc->tx_qp[q_idx]->txq.stats;

	u64_stats_update_begin(&tx_stats->syncp);

Can this lead to a Use-After-Free where memory corruption or a kernel
panic occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727113759.2881=
500-1-gargaditya@linux.microsoft.com?part=3D1
