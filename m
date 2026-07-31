Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6F45C6F1
	for <linux-hyperv@vger.kernel.org>; Fri, 31 Jul 2026 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540897; cv=none; b=HRjkKzQOlDen11tKaq42MEwNDxaaEUhjDqJIhYTWCaa+s0Fx6SqI/im1TEfzz3i7dOELDF0b5zU8GJ6l5gto1EO93LweigaqkMXCg2HahP7uYmb5oLF2QzdDPCTGOI+8wtLCCuMTN+gGcXgXxyesHPbPt92/KO4zQ7e0ydnfNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540897; c=relaxed/simple;
	bh=JfTwIL7O+d7lb3sgQ8IyVpc0CvKiFCpo6zD6DpPdsH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s46/aTPcaUZcR7dHrC8Mdai4R+uOIMJYYLoptsU/veH1oDc7ebpeRq5RpbLZbEObUDV8rwF972U0cDm/7N6VkEZPi0jJveK40a0r9cyT1O973+m23o1B5xwLpMxyUyCAiFFPXQ8jwanZhcRxnR9UoWguTge3rAYGUAL04F0w3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4a/XxsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4a/XxsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BC71F00AC4;
	Fri, 31 Jul 2026 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785540896;
	bh=h3OTKhcbWP/XI3NKpWOVE4EeGdIjGhOc1ZEUjGhIfNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f4a/XxsC3vBD90cz9KfFQxum8px1YCs6jhuZ2DUVx6GYuD13vCbk7O3iKJ2jb8nnt
	 iLaYZAMV1mY9HVkeNDsXBpiWSVjJOlEWXQFr1lfzWRXTg/HFpPkDMPk6n54z8imKFo
	 1DT5mu9h7PDtmdesaavgR0t0AvXDN0ZAkSS+R2TwisxNCAUh+4FfZE8Fl8tdYxHdbe
	 P9UpXe7muq+wRtanXeBxfB7hbOcvXyRngeQ8q88BLRfrwrfs+H5L8xyNR4LYoSdmS/
	 HGLpR/95xq9li4RSbum5XaCOxPGn/i2T2B3lF22dOh8oPEB8WxPw/6aVKZ/7+Xn836
	 /BTlZVU5U0DXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260730233359.3850612-2-kameroncarr@linux.microsoft.com>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
 <20260730233359.3850612-2-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:34:56 +0000
Message-Id: <20260731233456.95BC71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `vmbus_teardown_gpadl()`, if `vmbus_post_msg()` fails, the resu=
lting error code is unconditionally overwritten, causing the function to si=
lently return success instead of propagating the failure.
--

--- Patch [1]: [PATCH v2 1/2] Drivers: hv: vmbus: add vmbus_establish_gpadl=
_caller_decrypted() ---
commit aab401fb7e15b1b2168ba8341d7d172ef6d0525f
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()

This commit introduces a new function for callers to establish a GPADL for a
buffer they have already decrypted themselves. It adds a new GPADL type
HV_GPADL_BUFFER_DECRYPTED to track this decryption status. Existing callers
are unaffected by this change.

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6821f225248b1..4782f5070bba9 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c

[ ... ]

> @@ -460,7 +462,8 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  	}
> =20
>  	gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D HV_G=
PADL_BUFFER) ||
> -		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> +		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING) ||
> +		(type =3D=3D HV_GPADL_BUFFER_DECRYPTED));
>  	if (gpadl->decrypted) {
>  		/*
>  		 * The "decrypted" flag being true assumes that set_memory_decrypted()=
 succeeds.

[Severity: High]
This is a pre-existing issue, but I noticed a potential regression in how
GPADL teardowns are handled.

Looking at drivers/hv/channel.c in vmbus_teardown_gpadl(), if the call to
vmbus_post_msg() fails (for example, returning -ENOBUFS due to transient
hypervisor resource exhaustion), the code jumps to the post_msg_err label.
However, the error code in ret is unconditionally overwritten at the end of
the function:

post_msg_err:
    ...
    if (gpadl->decrypted)
        ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
                    PFN_UP(gpadl->size));
    else
        ret =3D 0;

Can this mask the communication failure with the hypervisor?

Because the failure is masked, the caller incorrectly assumes the hypervisor
has successfully torn down the GPADL and frees the memory back to the guest
page allocator, but the hypervisor still retains the GPADL mapping and may
continue to write to it.

Could this lead to guest memory corruption or a use-after-free when the
hypervisor accesses the released memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730233359.3850=
612-1-kameroncarr@linux.microsoft.com?part=3D1
