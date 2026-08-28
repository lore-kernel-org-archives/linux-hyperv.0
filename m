Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E115350B
	for <linux-hyperv@vger.kernel.org>; Fri, 28 Aug 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875236; cv=none; b=oUCBgWH1mEXGiczWPakZrmh9Zze9BuviiL9rdxQGaU7bvfRaJrpVVKfrok8ucPu4H/EUV/iUgwjQ/AVFgKV0WWtJ7iGO7mVxizLNqjtORF1fvUUsVYR/W8IEndRzBqpiVbehFDzPR/UuLXi9jl7yMcgQ843ZTx72lVSSBB2NYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875236; c=relaxed/simple;
	bh=wPeH3Uvbsfyiulw7J1NoGoU/v/sNxFj5Eo8NtOQuZW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2G0FJ6oxE2SkgVSdhrX5PkTWAgZeUYKdPvoeSy/UG8ID09pXRZ2qaRGEAegZHYsFh3DEI4aR7UfY59zqQnMC2BX2KxArA0c5dUKJ16EfAivno3J/0sKYV/MrZ/WMvYzj8PM+VTfpJfLyYz0syapaq4yoG595lhg74FCLX5WZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3phvF2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3phvF2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC731F000E9;
	Fri, 28 Aug 2026 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787875233;
	bh=9EfavtZA3dNAQP7DpXNVrygcgsEoODRwi/gvC9nmVJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3phvF2hxYZzhXJhL/PlqalwNeFomY8PdpUvhxppusJdFuJs5CJb1mKXAIwImARhT
	 QZXeAKaQvE/d/cpQZzd/b4rMQm9w/kH4NAnMUm2/NzgN+LCvYowPzXZJfueSjg5dXY
	 RBJq8OIrbYmlNGfZKJoyUaWTd7uBj6gzFRwSNcFZ7xVHMj6u9njoRCHkwbo33k+hew
	 CNuUtzc1z4RQJzCDuh9XHEHhWWiYUvU5REQx1eKu+Ck/oZk0tZQg2FP4QvTB/qHc8L
	 uNINe0cgauknUGGLcV9AyXKWLBGOj1Y4fpd5hL7SrFE3EkFk1ZYURu8e9jLYHT5npX
	 RoD/Y1PiPvOEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: mana: Clear RDMA teardown and suspend state in
 mana_rdma_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260826235940.1869565-1-longli@microsoft.com>
References: <20260826235940.1869565-1-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 00:00:32 +0000
Message-Id: <20260828000033.2BC731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless access to `gd->adev` during probe causes hardware SUSPEND=
 events to be silently dropped, leading to a state mismatch between the hos=
t and hardware.
--

commit a413863cad4d3b91f96dce2e01b3fa3e47e6054e
Author: Long Li <longli@microsoft.com>

net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()

This commit clears gd->rdma_teardown and gd->is_suspended during
mana_rdma_probe() to allow servicing events to be handled again after a res=
et
cycle. It uses smp_store_release() to publish the state before adding the
auxiliary device.

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
Could clearing the teardown flag before the auxiliary device is fully
initialized cause hardware suspend events to be silently dropped?

If a GDMA_SERVICE_TYPE_RDMA_SUSPEND event arrives from hardware immediately
after smp_store_release() clears gd->rdma_teardown, the handler in
mana_rdma_service_handle() will be able to process it.

However, because add_adev() has not yet completed and published gd->adev,
the lockless check in mana_rdma_service_handle() will see a NULL pointer:

mana_rdma_service_handle() {
        ...
        switch (serv_work->event) {
        case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
                if (!gd->adev || gd->is_suspended)
                        break;
        ...
}

Will this result in the handler breaking out early and dropping the suspend
event locklessly, leading to a state mismatch between the host and hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826235940.1869=
565-1-longli@microsoft.com?part=3D1
