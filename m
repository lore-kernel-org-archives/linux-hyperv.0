Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCB33B6F9;
	Fri, 14 Aug 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741721; cv=none; b=dU4/PaoSZhlyuJNDP3LZ08/KY1LtC71eJEk+ebvgqsIqhTlMvqwVN7QVLjPnNA5l5l372KZi3V0VUVl0MGLpCr3T1uDX+9rfjpnCL2//mGd8g/Q9m7WGldkU3G6cZf3Q4xQUQnAL/JALTvqCCFhQ0qHmZY6k7yzby6CbfMULBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741721; c=relaxed/simple;
	bh=KAHmtB+58FXU+8Sxf+Zi7TAueMbt8Iu7uRo5PKlfHnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyXLNWDPSjVajnL2OmsNZy5l/fHKcGYFQiaiVlDlCczpHwjy+ZLM+w1j6Dy3BcrPadKPXTzTA7uAfRtZX5sHU8vUWqY/lRzV/RvbvF9/4XpB0c+Jv0wolD0Tzm7S5KDQIQIzhAKGJdHH3ITvZ0YnoyASoEmJdiD3CYrXqCbZJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtTGAkW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtTGAkW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6AF1F000E9;
	Fri, 14 Aug 2026 21:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786741720;
	bh=rMcM0lBlPoPh1FiorELQJDBDv6Kiof5qqVa1jsW625k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mtTGAkW50fZxxenfAzuyu0UFNDw/J7doURQ0Dhd69su0npvC2IZfOSmYnBXGgduBj
	 uIFl07kEDemyqgFsMBYLtsmyW5VWVxcWj7S7uNo99a7LIHSqsSxtoiTotSuscuYfRr
	 ETiTqR6xt2MGNSSod9Cyijd1FS6mIMY/kyHbgNxQIXDsJ4G7AqnVwGCT57fV96XrQf
	 /mdaz6NwfF/9/pYWV+BZYPVmbBQgUtFhfz02eSLoAyqm+pOniop5tNQ44ZU2PvwZ87
	 r0sieZCZBgD87zLv6yjNgKRjwon6SBH9rxwCKE/y0UFm+dVlRvNS+pOkitiqDclJPC
	 wQr5iu3OlO7FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/vblank: Require all CRTCs implement vblank
 support in drm_vblank_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-hyperv@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, wsa+renesas@sang-engineering.com, intel-xe@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260814203542.1405135-6-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
 <20260814203542.1405135-6-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 21:08:39 +0000
Message-Id: <20260814210839.AC6AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm_vblank_init() causes a NULL pointer dereference or driver prob=
e failure due to accessing uninitialized or empty crtc_list
--

--- Patch [5]: [PATCH 5/5] drm/vblank: Require all CRTCs implement vblank s=
upport in drm_vblank_init() ---
commit 178bbb448a16663eaad60425c62b446801e0f387
Author: Lyude Paul <lyude@redhat.com>

drm/vblank: Require all CRTCs implement vblank support in drm_vblank_init()

This commit modifies drm_vblank_init() to verify that all CRTCs implement
vblank support, ensuring an all-or-nothing configuration. It returns -EINVAL
if support is mixed, and -ENODEV if no CRTCs support vblank.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index d57405050554f..17affae23e7a6 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -542,12 +542,31 @@ static void drm_vblank_init_release(struct drm_devi=
ce *dev, void *ptr)
>   * drmm_add_action_or_reset().
>   *
>   * Returns:
> - * Zero on success or a negative error code on failure.
> + * Zero on success or a negative error code on failure. If no CRTCs with=
 vblank
> + * support implemented were found, -ENODEV will be returned.
>   */
>  int drm_vblank_init(struct drm_device *dev)
>  {
>  	int ret;
>  	struct drm_crtc *crtc;
> +	bool found_vbl_crtc =3D false, found_non_vbl_crtc =3D false;
> +
> +	/* Vblank hooks are per-CRTC, not per-device - which is contrary to how
> +	 * the vblank core was written. Since hardware that only has vblank
> +	 * support on some CRTCs but not all is non-existent and would likely
> +	 * lead to UB, ensure that vblank support is all or nothing.
> +	 */
> +	drm_for_each_crtc(crtc, dev) {

[Severity: High]
Can iterating over dev->mode_config.crtc_list here cause a NULL pointer
dereference or a false -ENODEV return during driver probe?

Several DRM drivers call drm_vblank_init() before initializing mode_config
or creating CRTCs. For example:

In i915, intel_display_driver_probe_noirq() calls drm_vblank_init() before
intel_mode_config_init() sets up the crtc_list, meaning the list head is
uninitialized.

In vkms, vkms_create() calls drm_vblank_init() before vkms_modeset_init()
initializes the crtc_list.

In zynqmp_kms, zynqmp_dpsub_drm_init() initializes the list but calls
drm_vblank_init() before any CRTCs are created, meaning the list is empty
and this function will unconditionally return -ENODEV.

Does drm_vblank_init() need to support being called before CRTCs are
registered?

> +		if (crtc->funcs->enable_vblank)
> +			found_vbl_crtc =3D true;
> +		else
> +			found_non_vbl_crtc =3D true;
> +
> +		if (drm_WARN_ON(dev, found_vbl_crtc && found_non_vbl_crtc))
> +			return -EINVAL;
> +	}
> +	if (!found_vbl_crtc)
> +		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814203542.1405=
135-1-lyude@redhat.com?part=3D5
