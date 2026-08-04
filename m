Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE333E558E
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887078; cv=none; b=BFbtwtHhTChSvDHBejMLjo9obUC5Vg8LwlozcuCFmRVT9AC72k/+N2+Tyz+OgrBIKJDsYDYnpW8K7Aphkl65GRW8jnhOU4/UFAzBQ000SgCWDVBIzNG3DsUuNiVI6xaBcJ9WpD4A2CVRe4JUJYG29vSEozY4R/WmWoBoGfnvDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887078; c=relaxed/simple;
	bh=B0g5faq55Zm/yqfUcP1e6qRS2181MyslclwEVcKy6m0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wf3zi7znlS6qpsdQJ0rz97OxQ9naGj+lNOOLuSwNYRaC2qMcaEsMFoJwfjGU481TGtPl17xq06mEom4mkkw9V6bWW34NgyIOVyzWiKMuKCCj5Lbkk3BH3TqQ6CencnHd5r7wT5jS9iSk/xhJ7NygjJUYuzx6AvmMgPqepyHHuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV6a897S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV6a897S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927E21F000E9;
	Tue,  4 Aug 2026 23:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887076;
	bh=Jb5gXCzvpXdINoZjC2FLeSkBXSbbkXnZOzJratRXyDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eV6a897SIw+lwJXmoR0CRJSau/BJBASO6DHbj9VYtJz2gNefZuhyvbhnNnY35ooHU
	 SuiA15OXcSlTKd50A07BDYluhpKAZ0Ne7Wr8yo3tJgEjPiLLidCtcTJF2XX5YeUqjX
	 od6oGUFgctkdvzMHYHS6nSW8u2tML8uEdCv/k6nspZlbsmcjV6iq4pcKz0sJbstQvh
	 12O4xy4BLCOpti+wU0B8ZLWq8gRUkUQeLpFyXMJR0AHmdVVwaCKXVOVtU92tvE/kCx
	 IC2XKqOX+NUTc0nY5Ywhz7EmAI6xlysaGIE0mjJy7IAoBsl8HE5PuvcgtebfX6alB/
	 8oIjdOgP2SNww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/6] net: mana: RCU-protect gc->cq_table lookups
 against concurrent CQ destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803234355.636038-2-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260803234355.636038-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:44:36 +0000
Message-Id: <20260804234436.927E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A malicious host can trigger out-of-bounds array accesses in `=
cq_table` by dynamically inflating `gc->max_num_cqs`.
- [High] Pre-existing Use-After-Free in HWC channel teardown due to inverte=
d destruction order.
--

--- Patch [1]: [PATCH net v3 1/6] net: mana: RCU-protect gc->cq_table looku=
ps against concurrent CQ destroy ---
commit cb0751713ea0ba0da37493fd77c4af52cc7a9bc2
Author: Long Li <longli@microsoft.com>

net: mana: RCU-protect gc->cq_table lookups against concurrent CQ destroy

This commit fixes a use-after-free by placing the cq_table under RCU
protection, synchronizing the fast-path EQ interrupt handlers against CQ
teardown on other CPUs.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index e3c24d50dad07..409e20caeccdc 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -818,10 +824,8 @@ void mana_hwc_destroy_channel(struct gdma_context *g=
c)
>  	/* gc->max_num_cqs is set in mana_hwc_init_event_handler(). If it's
>  	 * non-zero, the HWC worked and we should tear down the HWC here.
>  	 */
> -	if (gc->max_num_cqs > 0) {
> +	if (gc->max_num_cqs > 0)
>  		mana_smc_teardown_hwc(&gc->shm_channel, false);
> -		gc->max_num_cqs =3D 0;
> -	}
> =20
>  	if (hwc->txq)
>  		mana_hwc_destroy_wq(hwc, hwc->txq);
> @@ -832,6 +836,14 @@ void mana_hwc_destroy_channel(struct gdma_context *g=
c)
>  	if (hwc->cq)
>  		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for an
in-flight EQ handler to access freed memory during teardown?

In mana_hwc_destroy_channel(), the work queues are destroyed and their
memory freed via mana_hwc_destroy_wq() before the completion queue and
event queue are torn down. The hwc->txq pointer is not cleared.

If a hardware interrupt fires or an in-flight EQ handler processes a
completion during this window, the handler might look up the still-valid
CQ and invoke mana_hwc_tx_event_handler().

Could mana_hwc_tx_event_handler() then dereference the freed hwc->txq
pointer?

    struct hwc_wq *hwc_txq =3D hwc->txq;

    WARN_ON_ONCE(!hwc_txq || hwc_txq->gdma_wq->id !=3D gdma_txq_id);

Since the race window is open until mana_hwc_destroy_cq() runs, it seems
this could lead to a use-after-free.

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 92bb55935c1c4..65b025e8f211c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -2905,12 +2913,18 @@ static struct mana_rxq *mana_create_rxq(struct ma=
na_port_context *apc,
>  	if (err)
>  		goto out;
> =20
> -	if (WARN_ON(cq->gdma_id >=3D gc->max_num_cqs)) {
> +	/* No rcu_read_lock(): mana_create_rxq runs under RTNL during netdev
> +	 * bring-up, inside the netdev lifetime that mana_remove() drains
> +	 * before the base cq_table can be freed.  See gdma_context::cq_table
> +	 * in gdma.h for why "true" is sound.
> +	 */
> +	cq_table =3D rcu_dereference_protected(gc->cq_table, true);
> +	if (WARN_ON(!cq_table || cq->gdma_id >=3D gc->max_num_cqs)) {
>  		err =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	gc->cq_table[cq->gdma_id] =3D cq->gdma_cq;
> +	rcu_assign_pointer(cq_table[cq->gdma_id], cq->gdma_cq);

[Severity: Critical]
This is a pre-existing issue, but could a malicious host trigger an
out-of-bounds write here by dynamically inflating gc->max_num_cqs?

If a compromised or malicious host sends a spoofed GDMA_EQE_HWC_INIT_DATA
event with HWC_INIT_DATA_MAX_NUM_CQS, mana_hwc_init_event_handler()
blindly updates gc->max_num_cqs at runtime without reallocating the
cq_table array:

    case HWC_INIT_DATA_MAX_NUM_CQS:
            gd->gdma_context->max_num_cqs =3D val;
            break;

When mana_create_rxq() creates a new queue later, the host could return
an out-of-bounds queue_index for cq->gdma_id.

Because gc->max_num_cqs was artificially inflated, the bounds check
cq->gdma_id >=3D gc->max_num_cqs would incorrectly pass. Does this allow
an attacker to write a kernel pointer past the end of the cq_table
allocation, potentially leading to guest kernel memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D1
