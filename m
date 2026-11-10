Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320958;
	b=yLmEKi3PWNJN8qBZtkAGPH/Ru8hhUGLwmU2VFQBgJX9SEr2ozM7UiE2jT1Sw0AQ44I7J
	 0J8Qp62X9N8v5pyv56270NoZdlAyFNKOHds3WW4GgEoZMU2zDeYD2/gEAX09d3Jek5e7q
	 J/XvA3yTSx7Xi7fH9LBBlLNem62MZE/Hns/7k72/w3C9ekdwh2UfRHtPgB583hE3xbVEK
	 Wq1AMhKxs2F8r0/qMnmCJr61lEQB/kz/FCklfyIuh2AZ6un7eRacVTNn7evJuADDd9oVQ
	 aOTTGikgj/AY1MMq3dwqfrn4Ux8T83v9jDaN4HA67GppeUYQF0DT8HIHQBHNsekzmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lBEQ13unEC0GA3XpCnbl3+2VUgp3oF0b8vFgVNdPqFg=;
	b=fU2Ye+5jgNdI/NW4Z3e5NKlvrKZBNwnrZrKk0I4AUDI1rLPrdUCCw3pBY9hGwh4DCAfD
	 ab0wSNWmUNbIT/Koxzj/z0gsXVcMECSpzUAJQOeQtXOCpv6gxYhhd4MMQdc5P58oI+Eyt
	 +NlxGx4ZsK3SsPuoCI9if+++frdpEgrjZFOSkVXWtKrLza9NN/URLil7L3dRS21tjIUPr
	 lGLylSgfHjcelKUAZ+dAIMi5howd0FLFIWcZerbHOgE467ZI6sjsArRhJD/iXyVSI+kMl
	 SjWrzJCrMWRulh7k97dwDskvFknzZhKxIvkeYIC0OmNxj5offTrUrq2kx3s2nFR5/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSbLqguo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CD606A325
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSbLqguo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8351F0089F;
	Tue, 10 Nov 2026 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320958;
	bh=lBEQ13unEC0GA3XpCnbl3+2VUgp3oF0b8vFgVNdPqFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSbLqguo2NwYXy5nKPD141SUibBlv636au3ip7m9jQ0LoO90bXZf7CiyPMoRpcWb3
	 pkLXiVpFByYFfKnsBd/XzSDD0HT08Gs2iWHnjRu9dlWvF388fn7NzmdtmGHslRFTRe
	 3/3aoPfHmZUVqltJWV95DSOHtm+BIYLIhOGfpzdIxeejISmwdLtp5cOh745jpoXVgG
	 h9gVruXzmmWecE4HLUd/WFD9EUsRNX5SXkaWBQcuESuoN8BwJpSH1+Jq4rrzMxM+cp
	 j1DCMB3i6yXbsugp0T1Id/sgmd6Jln/Mav1B4qA7oqurIgKm+bA3vnVYsHHPPf21mw
	 r6pfxrW3/zGJw==
Message-ID: <sashiko-outbox-207192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: report RX checksum offload for IPv6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
References: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:29:17 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] net: mana: memory leak on XDP drop path in mana_rx_skb() [1]
--

commit 44321b6481b9b9f9a70166beb9fc63a817e238f6
Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

net: mana: report RX checksum offload for IPv6

This commit removes the rx_iphdr_csum_succeed check in mana_rx_skb() so
that IPv6 TCP and UDP packets with validated L4 checksums receive
CHECKSUM_UNNECESSARY.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index e6d494df22e4d..05bd4b4b8349e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2179,10 +2179,9 @@ static void mana_rx_skb(void *buf_va, bool from_po=
ol,
>  	skb_checksum_none_assert(skb);
>  	skb_record_rx_queue(skb, rxq_idx);
> =20
> -	if ((ndev->features & NETIF_F_RXCSUM) && cqe->rx_iphdr_csum_succeed) {
> -		if (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed)
> -			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> -	}
> +	if ((ndev->features & NETIF_F_RXCSUM) &&
> +	    (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed))
> +		skb->ip_summed =3D CHECKSUM_UNNECESSARY;

[Severity: High]
This problem wasn't introduced by this patch, but can mana_rx_skb() leak
rxq->xdp_save_va [1] on its drop path when rxq->frag_count > 1?

When a pre-allocated buffer (from_pool =3D=3D false) is dropped, mana_rx_sk=
b()
stores buf_va in rxq->xdp_save_va for reuse:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_rx_skb() {
	...
drop:
	if (from_pool) {
		...
	} else {
		WARN_ON_ONCE(rxq->xdp_save_va);
		/* Save for reuse */
		rxq->xdp_save_va =3D buf_va;
	}
}

However, mana_get_rxfrag() only checks and reclaims rxq->xdp_save_va when
rxq->frag_count =3D=3D 1:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_get_rxfrag() {
	...
	if (rxq->frag_count =3D=3D 1) {
		/* Reuse XDP dropped page if available */
		if (rxq->xdp_save_va) {
			va =3D rxq->xdp_save_va;
			page =3D virt_to_head_page(va);
			rxq->xdp_save_va =3D NULL;
		...
		return va;
	}

	page =3D  page_pool_dev_alloc_frag(rxq->page_pool, &offset,
					 rxq->alloc_size);
}

When rxq->frag_count > 1, mana_get_rxfrag() ignores rxq->xdp_save_va and
allocates a new fragment from the page pool, so a subsequent drop of a
pre-allocated buffer triggers the WARN_ON_ONCE() and overwrites
rxq->xdp_save_va, leaking the saved page.

[1] https://sashiko.dev/#/bug/linux-2ba39e78-7dc4-4027-a76e-f2d315147bad

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109142856.7799=
55-1-hamzamahfooz@linux.microsoft.com?part=3D1
