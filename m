Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325280;
	b=S+3ZPvuULhD1CAoFIZqeDZdjl/NVzXQBg1Gymzr1ZMToGK2dmHrviY67NLS23hW/kq7i
	 TSSTw0jAGYd+1Q5B5s5VdWeoAwtX+3A5y+885znGyvpX2KpURZ5byMXDFaUNOxStikqF+
	 MrFFpdMCiuBgvU/L30Zn9Z/EoYGUHlBXtBezIwOZQ0kiXjtGgrifBn3r07PpVUWFZfVRs
	 P1FgTOAkaKWqGcGYK2/1e4u92vUWTOinfu6SIZBYB2LA54vivU4ATrSEh8dEypimgCl/P
	 Np2kUYRqkA+USNqevkxvUTrzCOcJtidsJf0cgiRi52DlaQk9dcJFS8T5/xxSJWemXRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325280;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=QHx7C/AerpPhdwsuFtDPfcaly8BfFFQVyiFbTns4uE8=;
	b=CzyMnqR1XJsF2XAW4HzXWXhg0IW0xZ1rqlBdM1oe2IME82GrImEnAwVJLom9fMjhWR4v
	 XBMWcPUJsY7Lxh3+Z7SNRHc9I19eWlLuLoKZmwQ4WrWD5NXOL95/OxUzzYJFocAKkz2si
	 zpNy5Qk4/Uxb3YxazR8zttZ96R4sY4Ej7GXWXw62tpEIi1tDkFS6Re1Cdo3fPdl1/d+Ui
	 wjLweQKbOsDoTF+q+6tFpxn5qrFQ0C8CT1nnboxkGje48D4GQlLbih+hKu7p1TU6x8Kkh
	 K4JSvx9q/wy8Hx9VrhpItjqY4qcyIfa5ALix8QIWhBB6xxAnPMx4MjsS3CcG9qE0t/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=b5mRhHJu;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F20560A261B
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 15:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F20560A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=b5mRhHJu
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id E091020B7168; Tue, 10 Nov 2026 07:41:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E091020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794325269;
	bh=QHx7C/AerpPhdwsuFtDPfcaly8BfFFQVyiFbTns4uE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5mRhHJubjI7FLZIOHtOvKCOdufAiqKmhGC15RsGRKNWkiwH7lLDbXpAG3MzKLkFM
	 hUuXZmyzqtIGTDoj0dRdSQo+iO1qMvjV663S7ZN4wRI8MRdWGWvFO0a6xy9EAHXaWG
	 Hl0xp9r/NLdwO1M9b2pd/xonQjxJPB+nf4i/uyaQ=
Date: Tue, 10 Nov 2026 10:41:09 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] net: mana: report RX checksum offload for IPv6
Message-ID: <avM7FRuRZaod1wqk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
 <sashiko-outbox-207192@kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-207192@kernel.org>

On Tue, Nov 10, 2026 at 02:29:17PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] net: mana: memory leak on XDP drop path in mana_rx_skb() [1]
> --
> 
> commit 44321b6481b9b9f9a70166beb9fc63a817e238f6
> Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> net: mana: report RX checksum offload for IPv6
> 
> This commit removes the rx_iphdr_csum_succeed check in mana_rx_skb() so
> that IPv6 TCP and UDP packets with validated L4 checksums receive
> CHECKSUM_UNNECESSARY.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index e6d494df22e4d..05bd4b4b8349e 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -2179,10 +2179,9 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
> >  	skb_checksum_none_assert(skb);
> >  	skb_record_rx_queue(skb, rxq_idx);
> >  
> > -	if ((ndev->features & NETIF_F_RXCSUM) && cqe->rx_iphdr_csum_succeed) {
> > -		if (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed)
> > -			skb->ip_summed = CHECKSUM_UNNECESSARY;
> > -	}
> > +	if ((ndev->features & NETIF_F_RXCSUM) &&
> > +	    (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed))
> > +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can mana_rx_skb() leak
> rxq->xdp_save_va [1] on its drop path when rxq->frag_count > 1?
> 
> When a pre-allocated buffer (from_pool == false) is dropped, mana_rx_skb()
> stores buf_va in rxq->xdp_save_va for reuse:
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_rx_skb() {
> 	...
> drop:
> 	if (from_pool) {
> 		...
> 	} else {
> 		WARN_ON_ONCE(rxq->xdp_save_va);
> 		/* Save for reuse */
> 		rxq->xdp_save_va = buf_va;
> 	}
> }
> 
> However, mana_get_rxfrag() only checks and reclaims rxq->xdp_save_va when
> rxq->frag_count == 1:
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_get_rxfrag() {
> 	...
> 	if (rxq->frag_count == 1) {
> 		/* Reuse XDP dropped page if available */
> 		if (rxq->xdp_save_va) {
> 			va = rxq->xdp_save_va;
> 			page = virt_to_head_page(va);
> 			rxq->xdp_save_va = NULL;
> 		...
> 		return va;
> 	}
> 
> 	page =  page_pool_dev_alloc_frag(rxq->page_pool, &offset,
> 					 rxq->alloc_size);
> }
> 
> When rxq->frag_count > 1, mana_get_rxfrag() ignores rxq->xdp_save_va and
> allocates a new fragment from the page pool, so a subsequent drop of a
> pre-allocated buffer triggers the WARN_ON_ONCE() and overwrites
> rxq->xdp_save_va, leaking the saved page.
> 

Since, this is an existing issue, I will fix it in it's own patch.

> [1] https://sashiko.dev/#/bug/linux-2ba39e78-7dc4-4027-a76e-f2d315147bad
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109142856.779955-1-hamzamahfooz@linux.microsoft.com?part=1
