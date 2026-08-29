Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009412B94
	for <linux-hyperv@vger.kernel.org>; Sat, 29 Aug 2026 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787962369; cv=none; b=iDGxzbnK8phPBruiIiGAWEuVOcSbmwpjngh5djByBeVsAk47HGR4X5ZFuzRfgSXK/ftLUl78HXTkY7HtVOWD/TYyaWZBo8+5MUNWB1dINUwf/c5vLVLtsC4L6hfMOZ8WldQ/Dfop9YvENlL4k7O2XGLAfRtr40p1zs/vkgj66MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787962369; c=relaxed/simple;
	bh=T/hdb81cGZu2sDWpbdXZf16NDrF6Mb3k8U8UicOL7p4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwSWVyA+O+JNKj+dsanaDqBGQ1dlwP9mr+dkTl+84czp8Qr2XXBjYqv7N2x2vl5YDD3D5H3tddSZ2Pn93C1a9buqHRIx1f0raTeFvWPOlnaQbzfeopvjjMtb4/a/jOq92HvEpw6pJ0xv26rssJ54azKlu1/6XNl4brdBW33lS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkdO6RiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkdO6RiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A71F000E9;
	Sat, 29 Aug 2026 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787962367;
	bh=BHvmXYr+WtOZ3J8/j54cUCl0APIiWma7bkOxPlT1l4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkdO6RiHg7X0557oar8LTJwphLX0dN2+/tipVqlfFVQCl+5NyiDR0IclfysVSev9l
	 o/ip5jBkWS51EobPv7AuGf3B+jchdH1qZhbTV49oLPL1+KuQrlBFlbxYuAchbiHq+T
	 pkEs0PPQiUNFfPUoElKA4QaBVy62ske53PJ1ootnTheCYRciY1RAuRRfq6scx+Phar
	 x18K3D7K/tT7cfeV1RqlWAkYej4ajed2HcKAWA+l0jJ6PtBa2FsZD3jkXsjw29W5VX
	 Orb8qbS4ooFsYRAV+aagrtbkdi7cG3vWifcdygJvO09N9T6H715PumyxfSn2YRFKuN
	 aMyAxOSuqNgag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: mana: Clear RDMA teardown and suspend state
 in mana_rdma_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260828001202.2110938-1-longli@microsoft.com>
References: <20260828001202.2110938-1-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 00:12:47 +0000
Message-Id: <20260829001247.A56A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless gate reopening in `mana_rdma_probe()` exposes a race wind=
ow that can silently drop hardware service events.
--

commit 92507b04de784a341e9ea7d0275d9b3dbe00e839
Author: Long Li <longli@microsoft.com>

net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()

This commit clears the rdma_teardown and is_suspended flags during probe
to ensure hardware service events are handled correctly after a reset cycle.

Link: https://lore.kernel.org/all/20260826235940.1869565-1-longli@microsoft=
.com/

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 7a1ac853e3abc..56f426da72864 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -4279,6 +4280,17 @@ int mana_rdma_probe(struct gdma_dev *gd)
>  	if (err)
>  		return err;
> =20
> +	/* Clear the state left by a previous mana_rdma_remove() so servicing
> +	 * events are handled again after a reset cycle.
> +	 */
> +	gd->is_suspended =3D false;
> +
> +	/* Publish is_suspended before re-opening the gate, so the handler
> +	 * cannot act on a stale value.  Pairs with the smp_load_acquire()
> +	 * in mana_rdma_service_handle().
> +	 */
> +	smp_store_release(&gd->rdma_teardown, false);
> +
>  	err =3D add_adev(gd, "rdma");

[Severity: High]
Does opening the rdma_teardown gate here create a race window where hardware
service events can be silently dropped?

Because mana_gd_register_device(gd) was called earlier in this function,
the hardware can now generate events. If an event like
GDMA_SERVICE_TYPE_RDMA_SUSPEND fires immediately after smp_store_release()
clears rdma_teardown, the ordered workqueue will run mana_rdma_service_hand=
le().

The handler will pass the rdma_teardown check but evaluate !gd->adev as true
because add_adev() hasn't completed yet:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_rdma_service_handle() {
	...
	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
		if (!gd->adev || gd->is_suspended)
			break;
	...
}

This causes the event to be dropped, which could create a permanent state
inconsistency between the OS and the hardware. Should the gate be opened
after add_adev() successfully assigns gd->adev?

>  	if (err)
>  		mana_gd_deregister_device(gd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828001202.2110=
938-1-longli@microsoft.com?part=3D1
