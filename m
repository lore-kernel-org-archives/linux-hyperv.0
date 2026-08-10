Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93E43BDD3
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388505; cv=none; b=g6Cf6Af5CmNLXNxtTSN+8f69cTvrEg5GdUCh5ooLG00grBOpVRpmrVxvRZiZGZI3VIIdhE3Z2H6kVGyz3jM4JnqbGMLQTZX7xc+5X3HutptOT0KtfJssXzmkgIfyHYe3g09Fs8UqJgcms3RcDGAhDeZRQY/W+2cmGMBH6gUBViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388505; c=relaxed/simple;
	bh=Z+9RmSBD4BdGOQYj6XfhH7qSpGteEi98/YwIn4urDgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bNaR/kh6lS3pmg8BZD+O3CmvKTS5f5Eom01VIjKYBsOO7zcscM/o9piRXD3KzpjiyajZEK4yuiKa/CD1d16W/AcktAkA2RXXkyFBzjDKFEyl8+D9BtffVvywlbYqUQR3vvM34FCuOhqHF+oBDTZsG+ccoay4/iwg8Zq+TILESgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om9XJ2tX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om9XJ2tX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482891F000E9;
	Mon, 10 Aug 2026 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388503;
	bh=nTixLo0qab4gCuZKjQAI0psjcplI278pO0yWyDGy2WQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Om9XJ2tX1R/Oo1B89KUgJpwSZBFtwNxlOQod4+rboRNsqpnzNBxNY3cdmpNmAxUN+
	 NfKaZ27WAyD0P/rkVDxKpC8B3h7pevPf+tjWhPkk34ddT+Q4Q3LmUaxBevW9l+444p
	 wmXq3+9PUynHQMtO+zrujiYJltVBdlWebLixGsdbOCKzRWMHUNOuOryLaLsOofeMXZ
	 4Rn3o0CUIpC1HlxHV9lmWTvr4wQe7j7gTmCVoejJEuqB1xjnBnlcwqowg/8VRc7tGs
	 BdO25l9oQPT3RgrxSaxAOi98TVWqY/r61Bx42OtqPs9IkyzuuOkmUWwzRnSsPeRHBQ
	 uX7YNMloK+qjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 7/7] net: mana: keep max_num_cqs immutable once
 cq_table is allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260809190047.2086368-8-longli@microsoft.com>
References: <20260809190047.2086368-1-longli@microsoft.com>
 <20260809190047.2086368-8-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:01:42 +0000
Message-Id: <20260810190143.482891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A spoofed GDMA_EQE_HWC_INIT_EQ_ID_DB event changes gd->doorbel=
l without bounds checking, leading to an out-of-bounds MMIO write.
--

--- Patch [7]: [PATCH net v5 7/7] net: mana: keep max_num_cqs immutable onc=
e cq_table is allocated ---
commit e3524562bdca9a596ad21cc819f86df8b083a5c4
Author: Long Li <longli@microsoft.com>
Subject: net: mana: keep max_num_cqs immutable once cq_table is allocated

This commit prevents a spoofed HWC_INIT_DATA_MAX_NUM_CQS event from bypassi=
ng
allocation bounds checks. It modifies the initialization event handler to s=
tore
the reported value rather than applying it directly, committing it only once
when sizing the table.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 2f0dae3539552..03b5e2f02e352 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -246,7 +246,15 @@ static void mana_hwc_init_event_handler(void *ctx, s=
truct gdma_queue *q_self,
>  			break;
> =20
>  		case HWC_INIT_DATA_MAX_NUM_CQS:
> -			gd->gdma_context->max_num_cqs =3D val;
> +			/* Store, don't apply: mana_hwc_establish_channel()
> +			 * commits this to gc->max_num_cqs once, together
> +			 * with sizing cq_table, so a spoofed post-init event
> +			 * cannot inflate the bound past the allocation.
> +			 * WRITE_ONCE() pairs with the READ_ONCE() there:
> +			 * this store runs in EQ interrupt context,
> +			 * concurrently with that process-context read.
> +			 */
> +			WRITE_ONCE(hwc->hwc_init_max_num_cqs, val);
>  			break;

[Severity: Critical]
This is a pre-existing issue, but while this patch protects against spoofed
CQ counts from untrusted environments, could a similar out-of-bounds memory
access happen with the doorbell index?

Looking earlier in mana_hwc_init_event_handler(), a spoofed doorbell index
appears to be accepted blindly:

mana_hwc_init_event_handler() {
    ...
    switch (event->type) {
    case GDMA_EQE_HWC_INIT_EQ_ID_DB:
        eq_db.as_uint32 =3D event->details[0];
        hwc->cq->gdma_eq->id =3D eq_db.eq_id;
        gd->doorbell =3D eq_db.doorbell;
        break;
    ...
}

If a malicious host sends a GDMA_EQE_HWC_INIT_EQ_ID_DB event with an
arbitrarily large doorbell index, it is updated without bounds validation
against gc->bar0_size.

Would this lead to an out-of-bounds MMIO write when later ringing the
doorbell?

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_ring_doorbell() {
    ...
    void __iomem *addr =3D gc->db_page_base + gc->db_page_size * db_index;
    ...
    writeq(e.as_uint64, addr);
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809190047.2086=
368-1-longli@microsoft.com?part=3D7
