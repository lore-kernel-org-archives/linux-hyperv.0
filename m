Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EF3D301D
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042543; cv=none; b=khok0+IZqmPUD7kcMLI0VRWqUoCp0mKMZqChE9ASxgBsRvxi8dieNKSbOEp/rYeEzx1YDiQldfT77DfObpcCFRmTjnu9ozeaLgcMcAkcQzcUTQ+nStc7KtlyD4n8aHxfvMz4Xyen28JwfuIYIb1xSiy2qRDhz1O4ZDAXMpYJFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042543; c=relaxed/simple;
	bh=170UlcaQ38dZhrgp9di10e3tBWByfXORmUXkrDEonLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWHk+kiOTrODVx1omQ9y4TsiLuiBDUnFg2V3W0fudLdXWTZSKkuNRjHYdopDsA0podTcMyl2Wy7H/spygKeifSGZs1a3UnzrbHzeJejcCuqP1EQP3LTRCuQR18vndyuOOb/RABtjqwsekRsxnZSxxLT/mFUdSoUgNqLGB9xQupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBdLHtrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBdLHtrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA61F000E9;
	Thu,  6 Aug 2026 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786042536;
	bh=YXohdDrS99aeIjhamBRpIF1tlUhe1BvEZLYc9n6tPIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBdLHtrDvXtQzj51SLQ83MyO8sM9VHJwVu+0O53py0snwS95rDl5CWa2XJyYB0mLn
	 ymQARufBzGMJ65SDIppM0KYiKCojkfmRDDTJ8DoFMFWE6CcKcmO7s5QAiEB8OR0Yzq
	 HIjcBsG4fMSoQdjzy73SJ7xA7fRjtXyzWrSpdfoxNc6GZBFCLbEv5Fz6BWRuRgOLVE
	 6h19O2Wy4oS3JT7+7vRQjp+4UXrOBN2WVpcehTYfWsrghybp7qd/YGoQw+kYifYdbd
	 S0A9W3e4Y64DOHcMiVIhrPjeKHSpBSy7QlaG9RiDH7iivBh1JfF7jlTw/dcRR4wkQv
	 MIfjEchHHVgrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] net: mana: Extend RX CQE coalescing up to 8
 packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805185404.1052177-1-haiyangz@linux.microsoft.com>
References: <20260805185404.1052177-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 18:55:35 +0000
Message-Id: <20260806185536.52EA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The RX NAPI polling function completely ignores the NAPI `budget`,=
 potentially processing up to 4096 packets in a single poll iteration, whic=
h causes severe latency spikes and violates NAPI fairness rules.
--

--- Patch [1]: [PATCH net-next v3] net: mana: Extend RX CQE coalescing up t=
o 8 packets ---
commit dbd47242aa242a736726a34fdaa26e55adbdfab1
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Extend RX CQE coalescing up to 8 packets

To support up to 8 packets per CQE, update related CQE processing code and
structures. This updates ethtool handlers to set this feature and per queue
stats to show the coalesced CQE counters.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 2519a98ad00b0..3c96e6fc3d81d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -2304,54 +2354,48 @@ static void mana_process_rx_cqe(struct mana_rxq *=
rxq, struct mana_cq *cq,
>  		return;
>  	}
> =20
> +	pkt_i =3D 0;
>  	for (i =3D 0; i < MANA_RXCOMP_OOB_NUM_PPI; i++) {
> -		old_buf =3D NULL;
> -		pktlen =3D oob->ppi[i].pkt_len;
> -		if (pktlen =3D=3D 0)
> -			break;
> -
> -		curr =3D rxq->buf_index;
> -		rxbuf_oob =3D &rxq->rx_oobs[curr];
> -		WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu !=3D 1);
> -
> -		if (unlikely(pktlen > rxq->datasize)) {
> -			/* Increase it even if mana_rx_skb() isn't called. */
> -			rxq->rx_cq.work_done++;
> +		u32 pkt_hash;
> =20
> -			++ndev->stats.rx_dropped;
> -			netdev_warn_once(ndev,
> -				"Dropped oversized RX packet: len=3D%u, datasize=3D%u\n",
> -				pktlen, rxq->datasize);
> -
> -			/* Reuse the RX buffer since rxbuf_oob is unchanged. */
> +		if (coalesced_8) {
> +			/* 8-pkt mode: 2 packets per PPI entry */
> +			pktlen =3D oob->ppi[i].pkt_len0;
> +			pkt_hash =3D oob->ppi[i].pkt_hash0;
>  		} else {
> -
> -			mana_refill_rx_oob(dev, rxq, rxbuf_oob, pktlen,
> -					   &old_buf, &old_fp);
> -
> -			/* Unsuccessful refill will have old_buf =3D=3D NULL.
> -			 * In this case, mana_rx_skb() will drop the packet.
> -			 */
> -			mana_rx_skb(old_buf, old_fp, oob, rxq, i);
> +			pktlen =3D oob->ppi[i].pkt_len;
> +			pkt_hash =3D oob->ppi[i].pkt_hash;
>  		}
> +		if (pktlen =3D=3D 0)
> +			break;
> =20
> -		mana_move_wq_tail(rxq->gdma_rq,
> -				  rxbuf_oob->wqe_inf.wqe_size_in_bu);
> -
> -		mana_post_pkt_rxq(rxq);
> +		mana_process_one_rx_pkt(dev, rxq, oob, pktlen, pkt_hash);
> +		pkt_i++;
> =20
>  		if (!coalesced)
>  			break;
> +
> +		/* Process 2nd packet from the same PPI in 8-pkt mode */
> +		if (coalesced_8) {
> +			pktlen =3D oob->ppi[i].pkt_len1;
> +			pkt_hash =3D oob->ppi[i].pkt_hash1;
> +			if (pktlen =3D=3D 0)
> +				break;
> +
> +			mana_process_one_rx_pkt(dev, rxq, oob, pktlen,
> +						pkt_hash);
> +			pkt_i++;
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but does extending coalescing to 8 packets per
CQE severely worsen an existing NAPI budget violation?

Looking at the caller mana_poll_rx_cq(), it pulls up to 512 CQEs from the
hardware and processes them all in a loop without checking the NAPI budget:

    comp_read =3D mana_gd_poll_cq(cq->gdma_cq, comp,
                    min((cq->gdma_cq->queue_size /
                          COMP_ENTRY_SIZE) * 4,
                         CQE_POLLING_BUFFER));
    ...
    for (i =3D 0; i < comp_read; i++) {
        ...
        mana_process_rx_cqe(rxq, cq, &comp[i]);
    }

Then in mana_poll(), the driver bounds the returned work done to the NAPI
budget, hiding the over-processing from the core network stack:

    w =3D mana_cq_handler(cq, cq->gdma_cq);

    return min(w, budget);

Since mana_process_rx_cqe() does not check if the packets processed exceed
the budget and can now process up to 8 packets per CQE, a single poll
iteration could process up to 4096 packets (8 packets * 512 CQEs) while
ignoring the budget.

Can this cause softirq starvation, latency jitter, or RCU stalls on busy
networks by blocking the CPU for long periods?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805185404.1052=
177-1-haiyangz@linux.microsoft.com?part=3D1
