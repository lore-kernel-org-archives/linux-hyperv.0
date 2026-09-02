Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33EA25782D
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379280; cv=none; b=RrKx/LOTPA9yJjlyFb5YVui7C5qSuMhKhtR28O2h61I3d4Krs84CHKB5dPZ6Hu2VAEBd5wqKaYMvt5D+oqbaiMJ02qrz9KdEiJfuz7z6JUmQAWQ9zCkZ/g1XEu0YuTnt7+z0LHEF/PAf2wOUHUtiDHQEjkMATY1Xlflp7EonzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379280; c=relaxed/simple;
	bh=HpUbf663qQLlYcD768qAGx3Uh57DYEfg3uFgpd6WQ8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U0Jz1JZGqMWu9jMZRnNFZ6x5pbSujJzv6Vx/+KNCa84L4EilXbDNTqoznevvDvK4dAtwX8d7TSRtQcXUdPOrX883VtaNOuZDeMYfHveex0sluD5jFUfdaLLi/iPkCronC14CTg9oicCdoIZWblsIEx+gllumPNzVPOL8fRylLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF1UT7rE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF1UT7rE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F51F00A3A;
	Wed,  2 Sep 2026 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379278;
	bh=/9SF0vQoHrzeavm6sQBj//to6dm+fVNkb579qgs3jRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YF1UT7rEJShQeQRqS1E4MBPRoGC9hbFhHMGpZ3uUYg53cINCXfG2QHq/igBcdWeuc
	 XdyFgSqCbGB1+HTidKMpoEdy+Cj6HrbV5Bdqqrsl2DP9eds4wJhXVXCk1WkJeJYQjs
	 ryL6j0iCSq3Lf1AAvFYuEpGketvgSsks2YwTEqdB5IRH5K62ocnO+eNKpeR/dCTSvJ
	 ni9QHdfOUaE0osLAO7+iwUsw9SYxJm6LQvDvjb5O0dQe0S7LMKWiUj9aVl/jcMEtvx
	 feDMRnggHSAzxAyJk/p7MmVF1jxzG7YKcjZHAKMz6sGAf4mrVeWztTMmkZUwxyMSya
	 wQLzGp7nH5EFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: mana: add dynamic HWC queue depth
 with reinit path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901200018.3194525-5-longli@microsoft.com>
References: <20260901200018.3194525-1-longli@microsoft.com>
 <20260901200018.3194525-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:01:18 +0000
Message-Id: <20260902200118.793F51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-after-free of `hwc_cq->comp_buf` during queue teardown bec=
ause memory is freed before the EQ IRQ is deregistered.
- [High] NULL pointer dereference on `gc->cq_table` during HWC reinit fallb=
ack on error paths because `gc->max_num_cqs` is updated asynchronously befo=
re table allocation.
--

commit b3057022f465825e22d893f907cd5cd5dd291b2f
Author: Long Li <longli@microsoft.com>

net: mana: add dynamic HWC queue depth with reinit path

This patch dynamically adjusts the hardware channel (HWC) queue depth by
tearing down the bootstrap channel and rebuilding it at a device-supported
maximum depth. This allows more management commands to be in flight.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -872,13 +916,64 @@ static int mana_hwc_init_queues(struct hw_channel_c=
ontext *hwc, u16 q_depth,
[ ... ]
> +static void mana_hwc_destroy_queues(struct hw_channel_context *hwc)
> +{
> +	struct gdma_context *gc =3D hwc->gdma_dev->gdma_context;
> +
> +	/* Destroy CQ first to deregister the EQ from the interrupt
> +	 * handler list before freeing caller_ctx, TXQ, or RXQ memory.
> +	 * A pending interrupt handler could still reach handle_resp()
> +	 * which dereferences caller_ctx.
> +	 */
> +	if (hwc->cq) {
> +		mana_hwc_destroy_cq(gc, hwc->cq);

[Severity: Critical]
This is a pre-existing issue, but since this patch dynamically tears down a=
nd
reconstructs the active HWC queues on the main probe path, does it turn a
teardown race into a reachable use-after-free regression?

Inside mana_hwc_destroy_cq(), the memory for hwc_cq->comp_buf is freed
before the EQ interrupt is deregistered:

mana_hwc_destroy_cq() {
    kfree(hwc_cq->comp_buf);

    if (hwc_cq->gdma_cq)
        mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
    if (hwc_cq->gdma_eq)
        mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);=20
...

If an EQ interrupt fires concurrently (or a stray interrupt occurs), the
interrupt handler mana_gd_intr() calls the completion callback
mana_hwc_comp_event(). That callback will read the freed comp_buf pointer
and pass it to mana_gd_poll_cq(), causing out-of-bounds DMA completions to
be written into the freed memory.

> +		hwc->cq =3D NULL;
> +	}

[ ... ]

> @@ -926,8 +1021,200 @@ int mana_hwc_create_channel(struct gdma_context *g=
c)
[ ... ]
> +reinit_fallback:
> +	/* Restore bootstrap-depth channel so the device remains functional.
> +	 * Free cq_table if it was allocated by a partially successful
> +	 * establish attempt.
> +	 */
> +	dev_warn(hwc->dev, "HWC reinit failed, falling back to bootstrap depth\=
n");
> +
> +	mana_hwc_destroy_queues(hwc);

[Severity: High]
This is a pre-existing issue, but does this fallback path expose a null
pointer dereference on gc->cq_table?

If mana_hwc_establish_channel() fails after the firmware updates
gc->max_num_cqs (via an EQ event) but before gc->cq_table is allocated
(for example, if vcalloc fails or the doorbell is missing), we jump to
reinit_fallback.

In this path, mana_hwc_destroy_queues() is called before gc->max_num_cqs is
cleared. This calls down into mana_gd_destroy_cq(), which assumes
gc->cq_table is safely allocated if id < max_num_cqs:

mana_gd_destroy_cq() {
    if (id >=3D gc->max_num_cqs)
        return;
    if (!gc->cq_table[id])
        return;
...

This will dereference the null gc->cq_table pointer.

> +
> +	old_cq_table =3D gc->cq_table;
> +	gc->cq_table =3D NULL;
> +	/* Clear the bound with the table, as above. */
> +	gc->max_num_cqs =3D 0;
> +	synchronize_rcu();
> +	vfree(old_cq_table);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901200018.3194=
525-1-longli@microsoft.com?part=3D4
