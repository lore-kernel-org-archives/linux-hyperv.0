Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255980;
	b=JKbvdLdhEUrW6PTBoLEd4cj6cJpSAJ1Uw9/zoQAhfQJMNuyTP3WErHMUXQ1qilV946Dv
	 8Tg+LAklyjwFzT9gd8o7zQb/yqu4e5ipCu/M6KVaIDwV9LTvg2jnJPTOeaZEGy6pwLnCL
	 mvRLxOVx3588El1q8NECAbEBZk72s/B3tHNeQEy8ZM3HQs5A/XMMAspEwa0xyQMas8puk
	 5IJNRubAOjXaOD9of1WIcEOKoCGbLKiCbsfDyJb+lzPDJTndC6OO3F4TDIKcssKemt/sn
	 JU/a+ENq3myZSHRcYTic+pfCPwIwcp8f3Q0bY1VvA0jSRFHHz1oifgNfpcIcpjV9dWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255980;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6oVC6TlSW49evvo/kbKCUsTSKF4CkZi4bQpeFDkkmaI=;
	b=RNJzc3ypgPTqb3F/j8s53Df3nP3IF4+Uk5ys1FxhvHREfornxwMmJOSbRaca5It1oVBO
	 Ewuwb67uq3I635UxNyMXUdQ3NqgJncnpjGL1OLoIZSm/MqGxDnQiKulDuIQkfF96d9AdK
	 aTJ0Gc1I/F4ExG5mVyOBUEhHglf0kfm69HTO/1faKxniCpq8hiEKaV5XUiZ+kEv3l6tnn
	 rO3fLH3AOH0QIMi4OGe/4TIo0fOV/avUMYwmPxByR7QMUppbd1+wdhfJNCrdAEhjIh1Oa
	 y3mzzlcyGS7PGbS7nLQ2AWhoycMrrUMi1s7fz7J0zXeetxNGBzBR73qUv9oFTSLkv4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/8vrOeJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46358606A31A
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Oct 2026 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/8vrOeJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5FF1F01825;
	Thu, 29 Oct 2026 06:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793255980;
	bh=6oVC6TlSW49evvo/kbKCUsTSKF4CkZi4bQpeFDkkmaI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=H/8vrOeJqWyU/vyhRSX4zQ0kljPrS4rKyOJvKbRe7X3x3tu4byojgT+9WtKlBOYFy
	 tkxLDWgKgn7iJOwp2ZUdAXBg4q6A3PPq+28VWmwV/1No/NavuGy6ZLoeGODqW66uh0
	 iUiKbfo0j3ls47UkhJeA/rwjPwrzJ8qMjNN1MuQOZoNvipWW0Zo1jfPERZHjFor9Sx
	 cTsWYlUDHj5ROvT3TsZJcCtsJ89yX+6lX6R7B3t0C0esBA46hxXQuNHzK9zdFFG8g2
	 F3XRfuyw5PJuOuq8WQvvPsF6jtnVPPL77GZPsb18//vpYUBqOFcALu1LuWxAF9reH4
	 E+t8a3VSLZdTw==
Message-ID: <sashiko-outbox-188826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv: Add an ioctl to scrub partition state
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org, "Linux on Hyper-V List" <linux-hyperv@vger.kernel.org>
In-Reply-To: <20261029062801.28598-2-wei.liu@kernel.org>
References: <20261029062801.28598-2-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:39:39 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mshv: false WARN_ONCE() in mshv_run_vp_with_root_scheduler() aft=
er scrub
--

commit 1f05bee845772dade9b43bed66085850115eb2ca
Author: John Starks <jostarks@microsoft.com>

mshv: Add an ioctl to scrub partition state

This commit adds the MSHV_SCRUB_PARTITION partition-fd ioctl to invoke
HvCallScrubPartition while holding the partition and VP mutexes, and clears
cached intercept_suspend state on all VPs so the next run clears explicit
suspend.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefdb..9f21855b8518b 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1648,6 +1648,53 @@ mshv_partition_ioctl_initialize(struct mshv_partit=
ion *partition)
>  	return ret;
>  }
> =20
> +static int mshv_partition_ioctl_scrub(struct mshv_partition *partition)
> +{
> +	unsigned int i, vps_locked =3D 0;
> +	int ret;
> +
> +	lockdep_assert_held(&partition->pt_mutex);
> +
> +	/*
> +	 * Run ioctls may wait indefinitely. Userspace must stop its run
> +	 * threads; never wait for a VP while holding the others. The
> +	 * partition mutex stabilizes even a sparse VP array.
> +	 */
> +	for (; vps_locked < MSHV_MAX_VPS; vps_locked++) {
> +		struct mshv_vp *vp =3D partition->pt_vp_array[vps_locked];
> +
> +		if (vp && !mutex_trylock_nest_lock(&vp->vp_mutex,
> +						  &partition->pt_mutex)) {
> +			ret =3D -EBUSY;
> +			goto unlock;
> +		}
> +	}
> +
> +	ret =3D hv_call_scrub_partition(partition->pt_id);
> +	if (ret)
> +		goto unlock;
> +
> +	/*
> +	 * Scrub clears intercept suspend and sets explicit suspend.
> +	 * Retain deferred waits and lifetime notification accounting.
> +	 */
> +	for (i =3D 0; i < MSHV_MAX_VPS; i++) {
> +		struct mshv_vp *vp =3D partition->pt_vp_array[i];
> +
> +		if (vp)
> +			vp->run.flags.intercept_suspend =3D 0;
> +	}

[Severity: Medium]
When a previously dispatched VP is run again under HV_SCHEDULER_TYPE_ROOT
after MSHV_SCRUB_PARTITION, will mshv_run_vp_with_root_scheduler() trigger
its WARN_ONCE()?

During the first MSHV_RUN_VP before scrub, clearing the initial explicit
suspend causes the hypervisor to signal the VP via kick_vp() in
drivers/hv/mshv_synic.c:

static void kick_vp(struct mshv_vp *vp)
{
	atomic64_inc(&vp->run.vp_signaled_count);
	vp->run.kicked_by_hv =3D 1;
	wake_up(&vp->run.vp_suspend_queue);
}

This increments vp->run.vp_signaled_count to a non-zero value, which
mshv_partition_ioctl_scrub() retains across the scrub while resetting
vp->run.flags.intercept_suspend =3D 0 and leaving the VP in explicit suspen=
d.

On the next MSHV_RUN_VP call after scrub, mshv_run_vp_with_root_scheduler()
in drivers/hv/mshv_root_main.c dispatches the VP and enters the
HV_VP_DISPATCH_EVENT_SUSPEND branch to clear explicit suspend:

		if (output.dispatch_state =3D=3D HV_VP_DISPATCH_STATE_BLOCKED) {
			if (output.dispatch_event =3D=3D
						HV_VP_DISPATCH_EVENT_SUSPEND) {
				/*
				 * TODO: remove the warning once VP canceling
				 *	 is supported
				 */
				WARN_ONCE(atomic64_read(&vp->run.vp_signaled_count),
					  "%s: vp#%d: unexpected explicit suspend\n",
					  __func__, vp->vp_index);
				...
				ret =3D mshv_vp_clear_explicit_suspend(vp);

Because vp->run.vp_signaled_count is already non-zero from the pre-scrub ru=
n,
doesn't resuming a VP after MSHV_SCRUB_PARTITION unconditionally hit this
WARN_ONCE()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029062801.2859=
8-2-wei.liu@kernel.org?part=3D1
