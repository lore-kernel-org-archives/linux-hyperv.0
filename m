Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9333B05BD
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487492; cv=none; b=MU22fQfEDI723+/847qBNITsyG4A47VYdmUUUnRvHb4dhMGe4VcysVE+dcjvYcShyZYksjnc88uku17rPvzYz+NTPlKm4sQphQnMA0acoKqmoEVfM8fyfRn4QYSI0QqsYPQ9CZsLlkgPEkHDS2n7AvaNgPJ2tUrkGe2BiSlwU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487492; c=relaxed/simple;
	bh=8sv9WBKT56J/LWBESsS3b4ENVavAnSDi6ohariK1jIY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EE7uk1bNW+Gek2bjxZjHiCvHmQ/vV0nSUn/m/8jEerOgiA4r6IDKnl4Fwzn6SXO9P5ZBIY14DHZmGuii/slRi+YC+e9311/Wq6tiG9E0tozXGc6PtMJmWX0EFj2f4fmnT2ySN+MaYnTUTH+CDzB2DX7h+KKG9c66hFAHyU5IFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzkQPal1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzkQPal1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3C71F000FF;
	Thu,  8 Oct 2026 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487490;
	bh=WWMld5exAZyPa0TOFgh8+ncEtCLh50FA3ZcYga1irsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PzkQPal1GiC3cQVu4fgrD4XADrcHStIlMWe7nKklDnqIhx5SePeuIfGch+PhDLr37
	 PJjqdK1zJ86LCZWiPljVGgXMQAUmJagugyWD0arT8y2JjVqlsydhrxEdzLzkU/qnmK
	 X26sp8XtN7ZwxTRhIwoh1rjOa+/Gpd7QHDGiJWbwa3jiREfVob6N3tVMnKXwXlyh3P
	 wZbwSnz4ugLauUhIjDcwRPMEmIsg2DOVU1I/7zFXUABtygRv0XAsF9AU/hjMvpE8Xt
	 EsDq8IBPjD8SrWu0xeb8W/qgXGWKDql+K2veQGUAN6X9cOhWGqCUJU8JUznfoR9vNj
	 U3/+SLcihigmg==
Message-ID: <sashiko-outbox-164513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 2/2] fbdev: hyperv_fb: Allow graceful removal of
 framebuffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261008191309.98263-3-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
 <20261008191309.98263-3-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:24:50 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] workqueue: UAF of delayed work due to re-arming during teardown
- [High] vmbus: NULL pointer dereference on closed channel during fbdev ioc=
tl
- [High] fbdev: UAF of parent device pointer in hvfb_destroy()
--

commit 0b97ae630048a0b4a041222965b966a2373daa70
Author: Saurabh Sengar <ssengar@linux.microsoft.com>

fbdev: hyperv_fb: Allow graceful removal of framebuffer

This commit defers the release of the framebuffer memory to the fb_ops
fb_destroy callback to prevent warnings when unbinding an in-use
framebuffer. It also moves the unregister_framebuffer call to the end of
hvfb_remove() and places it after vmbus_close().

Link: https://lore.kernel.org/r/1740845791-19977-3-git-send-email-ssengar@l=
inux.microsoft.com

> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 80e6d96821795..e0d68953aa1ac 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
[ ... ]
> @@ -887,6 +889,17 @@ static void hvfb_cfb_imageblit(struct fb_info *p,
>  					       image->width, image->height);
>  }
> =20
> +/*
> + * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
> + * of unregister_framebuffer() or fb_release(). Do any cleanup related to
> + * framebuffer here.
> + */
> +static void hvfb_destroy(struct fb_info *info)
> +{
> +	hvfb_putmem(info);

[Severity: High]
Is it safe to defer hvfb_putmem() to the fb_destroy callback?

hvfb_putmem() calls hvfb_release_phymem(info->device, ...), but info->device
points to the hdev->device. The VMBus core unregisters and frees the hv_dev=
ice
(hdev) when hvfb_remove() completes.

If userspace keeps the framebuffer file descriptor open, hvfb_destroy() will
execute later. Does this mean info->device will be a dangling pointer when
passed to dma_free_coherent() in hvfb_release_phymem(), causing a
Use-After-Free?

> +	framebuffer_release(info);
> +}
> +
>  static const struct fb_ops hvfb_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	.fb_check_var =3D hvfb_check_var,
[ ... ]
> @@ -1246,14 +1260,11 @@ static void hvfb_remove(struct hv_device *hdev)
> =20
>  	fb_deferred_io_cleanup(info);
> =20
> -	unregister_framebuffer(info);
>  	cancel_delayed_work_sync(&par->dwork);

[Severity: High]
Since unregister_framebuffer() is called after this point, is it possible f=
or
concurrent fbcon console updates or user operations to re-arm the work item?

For instance, could a call to hvfb_cfb_fillrect() ->
hvfb_ondemand_refresh_throttle() unconditionally re-arm the delayed work wh=
ile
the device is shutting down, leading to a Use-After-Free of the par structu=
re
when the delayed work eventually executes?

> =20
>  	vmbus_close(hdev->channel);

[Severity: High]
Does moving vmbus_close() before unregister_framebuffer() expose a race
condition where the VMBus channel and its ring buffers are freed while the
framebuffer interface is still fully active?

A concurrent user ioctl(FBIOPUT_VSCREENINFO) or active fbcon operation could
invoke synthvid_send() -> vmbus_sendpacket(). If vmbus_sendpacket() tries to
access the closed channel and its NULL ring_buffer structure, would this re=
sult
in a NULL pointer dereference?

>  	hv_set_drvdata(hdev, NULL);
> -
> -	hvfb_putmem(info);
> -	framebuffer_release(info);
> +	unregister_framebuffer(info);
>  }
> =20
>  static int hvfb_suspend(struct hv_device *hdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008191309.9826=
3-1-artem@trailofbits.com?part=3D2
