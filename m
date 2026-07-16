Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458681A316E
	for <linux-hyperv@vger.kernel.org>; Thu, 16 Jul 2026 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172622; cv=none; b=QaY0zKrLqnPSlN9yOCnfv0G4cuTkFyp0TK1nOpqsMDLyvya/fCBCWmv/pryuP5PAvgVtv+ivDoL4KsxayfH/MYKem01OM60UxuxpDjIJ09pp//zcUSWXEeGPLlyLMJvc9oaShmpMUFWQER9bsKUvbXqxMx5PvJ6ZKnMIE+hVXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172622; c=relaxed/simple;
	bh=ZiUgnAVWvnmpT3uZCr3CIM95+YTeD+cGkNhZyEcyWJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uf36WKLRcvGHc/sl+e3yurUHQDdoHkrR8+74s4v2cZWp1R4eODlg+9ldb6KAc5XbrjJ0s3gRROWVU6wg+blMeWNJOS3Ndp3ViYWghMTuoxrPQNeUN9e0kWzrbXsrIjzpVNoM2GvhRGO57Bmvajt3d/HXoXNSaC6gHldnDtA30sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h954Whq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h954Whq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1B61F000E9;
	Thu, 16 Jul 2026 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784172620;
	bh=BNGLSdERFTGN3dRXeVPHNaiU7bASFiXWH/Ik5CXYoMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h954Whq/MVgucrWwTdq4gOVueb7Iyvmx864xNLx7NJo6cx0sZ9sDGOvq1JpaQnJLz
	 9WYHwgTx3Ih674r92N394YyBPoamEWvY0gxPMzV3U5GdyUeWhbUgSB9sqGv+DR4Dwc
	 WDWlYPtze4qH7QuyFxFQqNatNTgylsQg/oYYS5NZGS2zomPUVOgu7hC65RGFH6Xkvl
	 mbS+pG1xWi8D3KjmSXA1aOv3WBL49q85J9egCeJjtKqVFBY5LP4w8VOcxIcwUigdmk
	 ghDhqZioN70XjJQpafnEUsW5guuXc4Glpvhtpa7wBBYDI4iE6a15BZv7ZSiKL5RNp4
	 sAIwxz/AetlIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/7] net: mana: support concurrent HWC requests
 with proper synchronization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260715032942.3945317-7-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
 <20260715032942.3945317-7-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:30:19 +0000
Message-Id: <20260716033020.CC1B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free and waitqueue data corruption involving `gc->hwc_dr=
ain_waitq` due to flawed teardown logic and a race condition.
--

--- Patch [6]: [PATCH net-next 6/7] net: mana: support concurrent HWC reque=
sts with proper synchronization ---
commit c7a2831143a0268564f0b676313bc28bfee068e7
Author: Long Li <longli@microsoft.com>

net: mana: support concurrent HWC requests with proper synchronization

This patch replaces the depth-1 semaphore in the HWC with a waitqueue and
bitmap scheme to allow multiple in-flight requests. It introduces per-slot
synchronization, queue locks, and active sender tracking to serialize
channel teardown against concurrent requests.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -367,9 +371,25 @@ static int mana_gd_detect_devices(struct pci_dev *pd=
ev)
>  int mana_gd_send_request(struct gdma_context *gc, u32 req_len, const voi=
d *req,
>  			 u32 resp_len, void *resp)
>  {
> -	struct hw_channel_context *hwc =3D gc->hwc.driver_data;
> +	struct hw_channel_context *hwc;
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&gc->hwc_lock, flags);
> +	hwc =3D gc->hwc.driver_data;
> +	if (!hwc) {
> +		spin_unlock_irqrestore(&gc->hwc_lock, flags);
> +		return -ENODEV;
> +	}
> +	atomic_inc(&hwc->active_senders);
> +	spin_unlock_irqrestore(&gc->hwc_lock, flags);
> +
> +	err =3D mana_hwc_send_request(hwc, req_len, req, resp_len, resp);
> =20
> -	return mana_hwc_send_request(hwc, req_len, req, resp_len, resp);
> +	if (atomic_dec_and_test(&hwc->active_senders))
> +		wake_up(&gc->hwc_drain_waitq);

[Severity: High]
Could this cause a use-after-free of the gdma_context (gc) structure?=20

If atomic_dec_and_test() drops the last reference and returns true, it=20
immediately unblocks the wait_event() in mana_hwc_destroy_channel(). The=20
teardown thread can then proceed and the caller (mana_gd_remove) might free=
=20
gc before this sender thread executes the wake_up() call on=20
gc->hwc_drain_waitq.

> +	return err;
>  }

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -950,11 +1060,49 @@ void mana_hwc_destroy_channel(struct gdma_context =
*gc)
>  		hwc->setup_active =3D false;
>  	}
> =20
> +	/* After SMC teardown, no more hardware events should arrive.
> +	 * Force-complete any remaining in-flight senders so they can
> +	 * exit and drop their refs.
> +	 */
> +	if (hwc->caller_ctx) {
[ ... ]
> +	}
> +
> +	/* Wait for all sender threads to finish and drop their refs.
> +	 * After this, only slots held by timed-out senders whose
> +	 * handle_resp() never ran remain in the bitmap.
> +	 */
> +	wait_event(gc->hwc_drain_waitq,
> +		   atomic_read(&hwc->active_senders) =3D=3D 0);

[Severity: High]
What happens if the function level reset (FLR) fails during teardown?=20

Looking at mana_hwc_destroy_channel(), if pcie_flr() fails, it prints a=20
warning and returns early from the function. Because this early return=20
bypasses the newly added wait_event() logic above, any active sender=20
threads are abandoned.=20

When mana_gd_remove() subsequently frees gc, wouldn't these stranded=20
senders cause a use-after-free when they eventually time out and access=20
the freed gc->hwc_drain_waitq?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715032942.3945=
317-1-longli@microsoft.com?part=3D6
