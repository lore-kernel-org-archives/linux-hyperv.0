Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE8327C08;
	Fri, 11 Sep 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139939; cv=none; b=j/QrPJO4qsiWnSj8CCCcHPLnPnyP3opQfkcKRDqkhe8LdP0OVasECo1aIG1nqQavcLRKe7v2z7NXzKO5ngaeFrJHQVyGrlk8WXtp66KAE2A8E05iL8Dvbha/m1iKa1uDVZ1vuWwrNf8GUj7Bob1vpEWHAoR2LFzqFVc5Td3dc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139939; c=relaxed/simple;
	bh=bI8u4HrrpuXxdBeBsnuOY99g7VSyogN9yG9H/ZTvBCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDnsAoV/TBoFRptjB4zQ+H8FI56bwtvLjeKw1C6kf76zbWS2QOFQOLrB2grnyhvCGFvJoazzaDL5OVwKycwGvJok8nimi6jgPtUdoqgwNrKOv7IFbSOg+x0cKJ+mkgx1BbAzOu2iDUPhXcH46SMAjhZrXdv21zXI45qWqCBjKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIud03vl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIud03vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5835B1F000FF;
	Fri, 11 Sep 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139938;
	bh=r6ofjwgxcQlev3mQDjvqEpmStxJ3qB6+1/brwgypw9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIud03vlzZtl2jMPbS8GzPiT1G5CBN2iZy4vPiRd0WMOZVUt0Rtt5qlAxZ2bJlBLT
	 mst+BiservAiRBcOQ7wiZHXno1BkAgjsY/N42W32M29zT5BCqeGB0mcUgPlgvQw7uG
	 WogRDe+n4mO97YHeYPOKYt2BU1PD8hH4ZTMx8maUdUHYZBpCQBIrNm47YuES7jItLV
	 QR2xvq55CZbwQw9RBfcWL5+qfvMsJnGuJPyG7u470TTqwsAGQqnTUnRsWSH+DZbFO+
	 LYJMw+pk5zxEjY3BvMNic8TJ7WJZDU4Z6Z7DCurG18FicygQItEdKqM8NM0xjQMWiF
	 iW1USeXzETWCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: never hand a non-page_pool buffer to XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gunter Woytowitz" <gunter@vcinity.io>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260910-mana-xdp-pagepool-v1-1-dab140d91fed@vcinity.io>
References: <20260910-mana-xdp-pagepool-v1-1-dab140d91fed@vcinity.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:18:57 +0000
Message-Id: <20260911151858.5835B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Bypassing pre-allocated buffers when XDP is attached defeats anti-=
OOM protections, risking permanent interface disablement.

Pre-existing issues:
- [Critical] Dangling pointer in apc->bpf_prog leading to Use-After-Free an=
d Double Free if mana_pre_alloc_rxbufs fails.
--

commit 47baeb3edbb2306dafb469762d4ed1350e2c78f3
Author: Gunter Woytowitz <gunter@vcinity.io>

net: mana: never hand a non-page_pool buffer to XDP

This commit ensures that all buffers handled by XDP are allocated from
the page_pool to prevent warnings when __xdp_return() frees them. It
bypasses the pre-allocated buffers when an XDP program is attached,
falling back to dynamic allocation. Unused pre-allocated buffers are
safely freed by existing cleanup paths.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 7a1ac853e3abc..a2cb667530a06 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2925,7 +2925,14 @@ static int mana_fill_rx_oob(struct mana_recv_buf_o=
ob *rx_oob, u32 mem_key,
>  	dma_addr_t da;
>  	void *va;
> =20
> -	if (mpc->rxbufs_pre)
> +	/* The pre-allocated buffers come from dev_alloc_pages(), not from the
> +	 * rxq's page_pool. With a program attached any buffer can reach
> +	 * __xdp_return(), which returns it to the pool the rxq registered, so
> +	 * fill from the pool instead. The unused pre-allocated buffers are
> +	 * released by the mana_pre_dealloc_rxbufs() every caller already runs
> +	 * after mana_attach().
> +	 */
> +	if (mpc->rxbufs_pre && !mana_xdp_get(mpc))
>  		va =3D mana_get_rxbuf_pre(rxq, &da);
>  	else
>  		va =3D mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,

[Severity: High]
Does bypassing the pre-allocated buffers when XDP is attached defeat the
anti-OOM protections?

When attaching an XDP program under memory pressure, mana_pre_alloc_rxbufs()
succeeds, but the dynamic page_pool allocations in mana_fill_rx_oob()
can now fail.

If mana_attach() fails halfway through due to these allocation failures:

drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_set() {
    ...
		err =3D mana_attach(ndev);
		if (err) {
			netdev_err(ndev,
				   "mana_attach failed at xdp set: %d\n", err);
			NL_SET_ERR_MSG_MOD(extack,
					   "XDP: Re-config failed at attach");
			goto err_dealloc_rxbuffs;
		}
    ...
}

Could this leave the network interface permanently detached until manually
reset, effectively doubling the peak memory requirement during the XDP atta=
ch
process?


[Severity: Critical]
This is a pre-existing issue, but I noticed a potential use-after-free
in mana_xdp_set() during error handling.

drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_set() {
    ...
	apc->bpf_prog =3D prog;

	if (apc->port_is_up) {
		/* Pre-allocate buffers to prevent failure in mana_attach */
		err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
		if (err) {
			NL_SET_ERR_MSG_MOD(extack,
					   "XDP: Insufficient memory for tx/rx re-config");
			return err;
		}
    ...
}

If mana_pre_alloc_rxbufs() fails, we return early without restoring
apc->bpf_prog to old_prog.

Can this leave a dangling pointer in apc->bpf_prog?

The caller dev_xdp_attach() in net/core/dev.c drops the reference to the
program on error, freeing it. A subsequent call to mana_xdp_set() will read
this pointer as old_prog and call bpf_prog_put(old_prog).

Will this result in a double-free of the BPF program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-mana-xdp-p=
agepool-v1-1-dab140d91fed@vcinity.io?part=3D1
