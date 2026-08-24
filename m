Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86830EF97;
	Mon, 24 Aug 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578292; cv=none; b=p5YdJsRq4SLIum3Z2h4nHIL22ZUHI9ii9HxxQNG/fIYvPZ4O0iEfW00efjKM4vg53Yq4s7Yms1HE7oaGKFVmMjw9hbLrc/lLRU0YVQvDcUeV1BQCfp/DNcilMg3c8YSEE8YHhT0xtbAK9fdl/FLWh4bYrmSLZ5rRu5t7nw2V3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578292; c=relaxed/simple;
	bh=C3VQTMYaId5LgepmHAbEKuDGeUgvArAUmBK4okj9tI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hDJzLRgsE4IPtdI5JD37EjQr84g95qmHZiqkrVjH0DjAQ7EH4e35adnpyBYsWbd7p2H1gK5im3g3UdPT5iRsjdrZDAlQTThdkAmh0JX2qbr101dG5vKP1VN4rtLKJ297eqYRRg5rVLcVhwp6PitbkXG27FP0zWzxZmLI+2JkIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma9gwPyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma9gwPyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBEE1F000E9;
	Mon, 24 Aug 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578286;
	bh=u9T/h+lPActj6yEYerAGiMyBvLKieymUVCIpbzIXmnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ma9gwPyuayrlTBaKEXokmPN27o2yRo1CeDmyOyeBBIghi+KYvAH1qa4noYgVbTbBB
	 VInkBO4h//vF/oIzsj9pCva3a0Tf8nmx/uq6v9DhAUQm4uJtIkQh+hpzhrD1QlPSSU
	 mZul63v1E8dlAPWH37vRMt8EsRkutHSTSBBVc2h7k+/XMAZwkhUfMlXyC0mSVw3CQn
	 0Vf7/zQ68Tw8Bvvr+vkxibIVXP5dY9xNin+NVr6TxO3po+pcYpQzMwVzLB9HR0GSt0
	 jhUAcIYH+7diwbGvXP4NAICGTKjpbKRTD80Kx1mBvGmXKkhmCyHB6NlxbxZhJEaq0u
	 hKC3uOaws3OZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] drm/panic: Restrict to primary planes;
 unconditionally unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, ojeda@kernel.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com, linux-hyperv@vger.kernel.org
In-Reply-To: <20260824125201.218863-10-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:31:25 +0000
Message-Id: <20260824133125.BEBEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional calls to kmsg_dump_unregister() for all planes cau=
se severe delays during device teardown due to sequential synchronize_rcu()=
 calls.
- [Medium] drm_panic_is_enabled() was not updated to enforce the primary pl=
ane restriction, leading to inconsistent panic handler state.
--

--- Patch [9]: [PATCH v2 09/13] drm/panic: Restrict to primary planes; unco=
nditionally unregister ---
commit c3117dcbe59bcb2d0d31d68229c5ec24738e412e
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Restrict to primary planes; unconditionally unregister

Restrict panic handling to primary displays. Overlays and cursors
should not display panic output. If there are exceptions, they can
be registered by the driver itself.

For cleanup, unregister each plane unconditionally. The kmsg dumper
already keeps track of the registration status so DRM doesn't have
to.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 2048a3bf736f0..7dbbcc1c219ff 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -1079,6 +1079,8 @@ void drm_panic_register(struct drm_device *dev)
>  		return;
> =20
>  	drm_for_each_plane(plane, dev) {
> +		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> +			continue;

[Severity: Medium]
Was drm_panic_is_enabled() updated to match this new primary plane
restriction?

If a driver implements the panic callback on a non-primary plane but not on=
 a
primary plane, drm_panic_is_enabled() will return true since it lacks this
type check:

drivers/gpu/drm/drm_panic.c:drm_panic_is_enabled() {
...
	drm_for_each_plane(plane, dev)
		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
			return true;
...
}

Because drm_panic_register() skips the non-primary plane, it won't actually
be registered. Does this false positive in drm_panic_is_enabled() introduce=
 a
regression where drm_fb_helper disables its fallback panic handling, leaving
the system with no panic screen handler at all?

>  		if (!plane->helper_private || !plane->helper_private->get_scanout_buff=
er)
>  			continue;
>  		plane->kmsg_panic.dump =3D drm_panic;

[ ... ]

> @@ -1105,11 +1107,8 @@ void drm_panic_unregister(struct drm_device *dev)
>  	if (!dev->mode_config.num_total_plane)
>  		return;
> =20
> -	drm_for_each_plane(plane, dev) {
> -		if (!plane->helper_private || !plane->helper_private->get_scanout_buff=
er)
> -			continue;
> +	drm_for_each_plane(plane, dev)
>  		kmsg_dump_unregister(&plane->kmsg_panic);
> -	}
>  }

[Severity: Medium]
Does this unconditional loop cause severe delays during device teardown?

The function kmsg_dump_unregister() executes synchronize_rcu() at the end
regardless of the dumper's registration status:

kernel/printk/printk.c:kmsg_dump_unregister() {
...
	spin_unlock_irqrestore(&dump_list_lock, flags);
	synchronize_rcu();
...
}

Looping sequentially over all planes without checking if they were actually
registered forces the teardown path to block for multiple consecutive RCU
grace periods. Can this regression potentially add hundreds of milliseconds=
 to
several seconds of delay during driver unbind or hot-unplug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D9
