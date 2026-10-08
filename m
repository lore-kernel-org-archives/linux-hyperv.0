Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980123B05BD
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487466; cv=none; b=bgsiXMyaiw0MHXBa0T5Be8KFGNWI0mzTcoZkNlGsIjKFNm3Ov9sYWctWgrO4Yl3cR8N6ilqK8CkeuFuftxyZ/qvPX8q8yhvJcAtRblVZVF4C71NEwp8j3yXtbKixmbmRcMZXlTP9nxeVpUDF8gH/91Ixo3DxzZWYk0I/pjYdaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487466; c=relaxed/simple;
	bh=v2/G0vZEbEhuB2E5MYe+Vw2fAtDLcffJdYiAxEAeIZw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RFfLiFvxRbAmNqyjqclPXP9lWk2JJ9UAKwyvP4MqsLskv5XGXeAgihwFXyLBUKJIl24SlOPjaAPwEyrhuf779pND7WsCI4iA2ZbCIimHYtH/cGhA1Sh4K9poUhEuBt9+encWYrtSRosqXk105JrmVtCcpKpbVFGZTMuYWOu00IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZcPVIX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZcPVIX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3B01F000FF;
	Thu,  8 Oct 2026 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487465;
	bh=UkL1zcyt3/Fb3XK9EuvhGMRqk5QqsvDnO3rtBBX89as=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hZcPVIX28F9/zpjKX7NMOHu2qO0rayVeFrx9461FVjQLEgSzbOxP+shBugMHLAIiI
	 g2GHoy5p5oKQ8pnITu95pMmTOaKyIUPZ3mQBMhZ1+uKe6phZX/0hsoEVPqPrZUFBiy
	 8JQh9K3Nz1KrDqQwlm0dWe8LNN4iBr5qk5X+CvqTc0Q0ZvQIZQme0vYjG/iTcDBmhC
	 mPHV1jkREH6tP5sTS8KLipCvfYFW176iMMCosgF4JQxEsmmPcAzJ+J4ZlVL7Txa0EW
	 dR1aPpjEPoqw+PtHoPf6nPOEjfOx/id6ztEx/vQ1AQX1SSuvmO5R9xmdBOa0RsvOuU
	 FCIGNlq3iXOEw==
Message-ID: <sashiko-outbox-164512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 1/2] fbdev: hyperv_fb: Simplify hvfb_putmem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261008191309.98263-2-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
 <20261008191309.98263-2-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:24:24 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] fbdev: hyperv_fb: Use-After-Free in dma_free_coherent via deferred=
 fb_destroy
--

commit 5cd0184cceb2674876a9c7e3d72e937d61e3e2d8
Author: Saurabh Sengar <ssengar@linux.microsoft.com>

fbdev: hyperv_fb: Simplify hvfb_putmem

This commit simplifies hvfb_putmem() by removing its hdev parameter. It
derives the device from fb_info and passes it to hvfb_release_phymem()
instead.

Link: https://lore.kernel.org/r/1740845791-19977-2-git-send-email-ssengar@l=
inux.microsoft.com

> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 80e8ec36b7db2..80e6d96821795 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -973,7 +973,7 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *=
hdev,
>  }
> =20
>  /* Release contiguous physical memory */
> -static void hvfb_release_phymem(struct hv_device *hdev,
> +static void hvfb_release_phymem(struct device *device,
>  				phys_addr_t paddr, unsigned int size)
>  {
>  	unsigned int order =3D get_order(size);
> @@ -981,7 +981,7 @@ static void hvfb_release_phymem(struct hv_device *hde=
v,
>  	if (order <=3D MAX_ORDER)
>  		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
>  	else
> -		dma_free_coherent(&hdev->device,
> +		dma_free_coherent(device,
>  				  round_up(size, PAGE_SIZE),
>  				  phys_to_virt(paddr),
>  				  paddr);

[ ... ]

> @@ -1100,7 +1100,7 @@ static int hvfb_getmem(struct hv_device *hdev, stru=
ct fb_info *info)
>  }
> =20
>  /* Release the framebuffer */
> -static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
> +static void hvfb_putmem(struct fb_info *info)
>  {
>  	struct hvfb_par *par =3D info->par;
> =20
> @@ -1109,7 +1109,7 @@ static void hvfb_putmem(struct hv_device *hdev, str=
uct fb_info *info)
>  		iounmap(par->mmio_vp);
>  		vmbus_free_mmio(par->mem->start, screen_fb_size);
>  	} else {
> -		hvfb_release_phymem(hdev, info->fix.smem_start,
> +		hvfb_release_phymem(info->device, info->fix.smem_start,
>  				    screen_fb_size);
>  	}

[Severity: High]
Can this change lead to dma_free_coherent() in drivers/video/fbdev/hyperv_f=
b.c
dereferencing a freed device pointer when executed from a deferred fb_destr=
oy()
callback?

Moving framebuffer memory teardown, via hvfb_putmem(), to the asynchronous
fb_destroy() callback causes it to execute when the last userspace reference
is dropped.

If /dev/fb0 is held open by a user process when the Hyper-V device is remov=
ed
or unbound, the driver's remove() callback unregisters the framebuffer and
returns. At this point, the driver core drops the final reference to the
parent hv_device and frees it.

Later, when the user process closes the file descriptor, fb_destroy() invok=
es
hvfb_putmem(), which calls dma_free_coherent() using info->device. This poi=
nts
to the now-freed &hdev->device.

Because dma_free_coherent() dereferences this device pointer to access dma_=
ops,
does this result in a concrete use-after-free and likely a kernel panic?

Checking the final state of the series reveals no get_device(&hdev->device)
was added to ensure the device outlives the fb_info.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008191309.9826=
3-1-artem@trailofbits.com?part=3D1
