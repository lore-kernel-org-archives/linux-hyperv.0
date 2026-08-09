Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496B1531E8
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242904; cv=none; b=qZ1kbOpZKxJ7IMJBuiWnq9aYodrm6PYGnPoLuHd8Kh6AmXqIaUnUWSRAE3sqzlCw6HeyWriTC7Vm2/oTyvHldnuyGBrL42f2Y1Qdk8L8cF8dL+gwI5mT/phKaL6DzJ3jJqF1pAQUhGsHaX5jLdubzO1lTFbIVaKaLm4VZn1TdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242904; c=relaxed/simple;
	bh=00gMgkR7Rx2vJrfRGP6cJ7Hutbll3YWPu2PThwp5Tek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PBAL4Fz+5k8jG6EMJirQ2Fxw3/V9JSTM9j5+b/HZdlOlM3UPt6/qK6q5Ggkq/k6zQ5UVGmrpaRXoqPv0wTrhPAG3H44FT/BQpQxTk6DZ7cn8A8er5AAzMfl+iBoLQa4Dq0/AJrYo2DWWeUiGkeHqUbU6Az9La1TdBISuk8NKlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAN+HD57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAN+HD57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E581F000E9;
	Sun,  9 Aug 2026 02:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242903;
	bh=1331tLPlRFRCdrv0LFcn5xKtGM3yGUXTjJEHM9Zhf80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAN+HD577EHm0WUMD8+z/9zhC+sCczdb54pSj3exJLA0L2wH7luMEbsVhXu0uo4EJ
	 aNlNucpWiNWJdT4HLUBVorWxbYrKlX9Zyc0xMS7ZKQ9+3tSIArkAO2bFsGwPpzqJyc
	 O8iFx5KIAlKirQu3jKMFfoMe3ZYdJY2ECKPfTvvCxii5ZeCgQ5SOeBEagrr1JG324Y
	 ugBji1ViE1nc97W+zBWQ5fkI6VjJ6MGPwRNZCMTk4aOSNJdYfB2h/7BuBnNA+eNP2q
	 RiDrguALIHKcMHChA3LbYVISISa6Szi7NTnt7Lz0hFGmbjFHgTI79i5Ye3bi1buN/p
	 FvKyDaTQ3jjeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 7/7] net: mana: keep max_num_cqs immutable once
 cq_table is allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260808023417.1746886-8-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260808023417.1746886-8-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 02:35:01 +0000
Message-Id: <20260809023503.10E581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing reader-side acquire barrier and missing reset of `gc->max_=
num_cqs` on teardown allows a malicious host to bypass the `cq_table` bound=
s check on resume, leading to an out-of-bounds read and potential control f=
low hijack.
- [High] A spoofed `GDMA_EQE_HWC_INIT_EQ_ID_DB` event overwrites the hardwa=
re channel doorbell ID without bounds checking, leading to a guest kernel p=
anic.
--

--- Patch [7]: [PATCH net v4 7/7] net: mana: keep max_num_cqs immutable onc=
e cq_table is allocated ---
commit cb30244d24849d9dc1bb09cc690c55b40f642e06
Author: Long Li <longli@microsoft.com>

net: mana: keep max_num_cqs immutable once cq_table is allocated

This commit prevents post-init HWC events from inflating the CQ count
bound past the cq_table allocation size. It stores the reported max_num_cqs=
=20
in the channel context and commits it once during channel establishment.=20
This ensures the allocation size and the bounds check remain consistent.

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

[Severity: High]
This is a pre-existing issue, but can a spoofed GDMA_EQE_HWC_INIT_EQ_ID_DB
event cause an out-of-bounds MMIO write?

Looking at mana_hwc_init_event_handler(), it blindly trusts the doorbell ID
provided by the host:

    case GDMA_EQE_HWC_INIT_EQ_ID_DB:
        eq_db.as_uint32 =3D event->details[0];
        hwc->cq->gdma_eq->id =3D eq_db.eq_id;
        gd->doorbell =3D eq_db.doorbell;
        break;

The next time the driver rings the doorbell in mana_gd_ring_doorbell(), it
uses this unvalidated spoofed ID to calculate the MMIO address:

    void __iomem *addr =3D gc->db_page_base + gc->db_page_size * db_index;
    ...
    writeq(e.as_uint64, addr);

Could this result in writing outside the mapped bar0_va region and cause a
guest kernel panic?

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

[ ... ]

> @@ -881,15 +891,29 @@ static int mana_hwc_establish_channel(struct gdma_c=
ontext *gc, u16 *q_depth,
>  	*max_req_msg_size =3D hwc->hwc_init_max_req_msg_size;
>  	*max_resp_msg_size =3D hwc->hwc_init_max_resp_msg_size;
> =20
> -	/* Both were set in mana_hwc_init_event_handler(). */
> -	if (WARN_ON(cq->id >=3D gc->max_num_cqs))
> +	/* Snapshot the device-reported CQ count and CQ id into locals and
> +	 * use only the locals below, so the same value that sizes cq_table
> +	 * also bounds and indexes it -- even across the sleeping vcalloc().
> +	 * Both fields are written by mana_hwc_init_event_handler() from EQ
> +	 * interrupt context: hwc_init_max_num_cqs under WRITE_ONCE() (paired
> +	 * here), and cq->id as an ordinary store.  READ_ONCE() keeps each
> +	 * read tear-free and, crucially, non-reloadable, so a spoofed
> +	 * post-init event cannot make the WARN_ON() pass against one value
> +	 * while the allocation or the index uses another.
> +	 */
> +	num_cqs =3D READ_ONCE(hwc->hwc_init_max_num_cqs);
> +	cq_id =3D READ_ONCE(cq->id);
> +
> +	if (WARN_ON(cq_id >=3D num_cqs))
>  		return -EPROTO;
> =20
> -	cq_table =3D vcalloc(gc->max_num_cqs, sizeof(*cq_table));
> +	cq_table =3D vcalloc(num_cqs, sizeof(*cq_table));
>  	if (!cq_table)
>  		return -ENOMEM;
> =20
> -	rcu_assign_pointer(cq_table[cq->id], cq);
> +	gc->max_num_cqs =3D num_cqs;
> +

[Severity: High]
This is a pre-existing issue, but does teardown leave gc->max_num_cqs at a=
=20
stale value?

Looking at mana_hwc_destroy_channel() in
drivers/net/ethernet/microsoft/mana/hw_channel.c, it replaces the
cq_table pointer but doesn't reset gc->max_num_cqs:

    old_cq_table =3D rcu_replace_pointer(gc->cq_table, NULL, true);
    synchronize_rcu();

During a device resume, mana_hwc_establish_channel() will publish a new,
potentially smaller cq_table and update gc->max_num_cqs.=20

If a malicious host sends a GDMA_EQE_COMPLETION event concurrently, the
reader in mana_gd_process_eqe() in
drivers/net/ethernet/microsoft/mana/gdma_main.c checks the bounds:

    cq_table =3D rcu_dereference(gc->cq_table);
    if (WARN_ON_ONCE(cq_id >=3D gc->max_num_cqs || !cq_table))
        break;

Since there is no acquire barrier between reading gc->cq_table and
gc->max_num_cqs, could weakly ordered CPUs read the stale, large
max_num_cqs bound and the new, smaller cq_table pointer?

This seems like it could allow a crafted cq_id to pass the bounds
check and cause an out-of-bounds memory read.

> +	rcu_assign_pointer(cq_table[cq_id], cq);
>  	/* Publish the fully-initialised table last; pairs with the
>  	 * rcu_dereference(gc->cq_table) in mana_gd_process_eqe().
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D7
