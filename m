Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB203C0A09;
	Wed, 26 Aug 2026 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745482; cv=none; b=O+c94dmqgyyGGiGFhe1DkVQkARgZhHmPG7nWsIJgEdK0uV32xEBnJAbJ7tliDTQZI+OjT1TWXkEZRl+y9R5t9HG12YnONa3qYR681KbA3xLRl8oFDzUxDa3HyNNyXcCzTJazf/3yO0a2YWEDCbVgeHByYp4PClr2muup1CouzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745482; c=relaxed/simple;
	bh=lmX74p8d3ynOXzqORD1lxz9geHT6/Pbj3Vr/880Q0HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h8vxMzuq+1p4BZIbDV03Pqos5BR5nAvHGm94DkEoWhPR+yRxFBfrg9F9CmO9wn6wBe7CoYEBmXHDhztyMQGAIzhrbNP+ZZyH6GihihbDI/znzmyNAtfM9ZKGKw5MoV4Xc2f4nJ06na+cTib9QUL9UAJyT+NJt/IaC/EwJWeZMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N0EHOdLi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gOpleUyF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yt7xCblz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AAL2lKdr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N0EHOdLi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gOpleUyF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yt7xCblz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AAL2lKdr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D82998713F;
	Wed, 26 Aug 2026 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787745473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5O0RPXAHTDpM4rhxaVkOk5x9IzoUZQIeJ+6XMym/P3Q=;
	b=N0EHOdLiLsQf7oNkD3MraUJh2eQ2G9MuvqeD2gZPFCxawKgeOpgIbsIRqBGWF4th9Qmw9P
	eesmnvnRY+R0y49/CzxieKHz8pyqOkzjhgBXET/JUSfLmGvQwgBedfIjYd7mTM1gdNGGdS
	/KgGeNimwRlPjJZ9rbBPI2EFB3JvW6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787745473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5O0RPXAHTDpM4rhxaVkOk5x9IzoUZQIeJ+6XMym/P3Q=;
	b=gOpleUyF7vHVloBZC+nKuPaCQww3l/uyz1nG9hGKIe+eZt/Ybz4vZhfROmkqn4YU22Zc9d
	oAFJ6FSolRvNlSAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787745468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5O0RPXAHTDpM4rhxaVkOk5x9IzoUZQIeJ+6XMym/P3Q=;
	b=yt7xCblzLvo9PG8DGW8T+Ft+C4Cpn0s7uaFUufcko4blInxS3odwCzY0Gh/TN/Um4Je+jT
	aIHj0yHhuyg2308ECwBMg3pJR7blxs8DmYsUEmWDUUfQ5jRBSvpdJ1qCsR1WIzCNysyBtw
	jepZdrkZbmMGjZmu41GzG4ekKc7En1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787745468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5O0RPXAHTDpM4rhxaVkOk5x9IzoUZQIeJ+6XMym/P3Q=;
	b=AAL2lKdrpXuSacDQY6b9q8i5AVvJFZVSE7Wm7NB81dVidWfpMndJN2u7+QuCoNBr4qDq/2
	umv0qPzck7EJzlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49E9613354;
	Wed, 26 Aug 2026 11:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IDXELzUjmpjDAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Aug 2026 11:57:48 +0000
Message-ID: <23ffe7db-5657-444a-9963-a5715d40658d@suse.de>
Date: Wed, 26 Aug 2026 13:57:47 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/vblank: Remove num_crtcs argument from
 drm_vblank_init()
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-sunxi@lists.linux.dev, asahi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev
References: <20260814203542.1405135-1-lyude@redhat.com>
 <20260814203542.1405135-4-lyude@redhat.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260814203542.1405135-4-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.971];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

Hi

Am 14.08.26 um 22:35 schrieb Lyude Paul:
> As it turns out: the entire reason we ever asked for the number of CRTCs as
> a parameter for drm_vblank_init() is because that function was previously
> in charge of setting up the legacy drm_device.num_crtcs variable, which
> itself was also used to keep track of whether or not drm_vblank_init() was
> called. And, that number was kept in addition to a properly maintained
> drm_device->mode_config.num_crtc.
>
> Now that we've removed that legacy variable entirely, let's stop requiring
> the num_crtc argument for drm_vblank_init() entirely. The main motivation
> for this is the fact that at the moment, we've had to workaround this
> oddity in the Rust kernel bindings for a few reasons:
>
> * We can't know the number of CRTCs until they've all been created, which
>    meant that we had to keep track of that.
> * Additionally, we also had to keep track of which CRTCs did and did not
>    have vblank support. This is especially silly, because I am not aware of
>    any physical hardware that only supports vblank interrupts on certain
>    heads - and I can't think of any reasonable explanation for any hardware
>    manufacturer making a design choice like that.
> * This also implies that drivers could, with the current C API, register
>    that they have a different number of CRTCs then they have actually
>    created. This appears to be an edge case that could easily lead to UB
>    since it's not obvious and as such has likely never really been tested.
>    And we can't have that in Rust!
>
> While the last point could technically still be an issue if a driver
> doesn't fill out the vblank handling callbacks for all CRTCs, this is a
> good start at cleaning this strange behavior up.
>
> So, just get rid of this parameter entirely and start using the DRM's
> internal count of CRTCs. We apply this change across the tree using this
> coccinelle patch:

I had been working on better support for software-timer vblank events. 
And for user space, we wanted to distinguish between real HW support and 
the software-based implementation.

Therefore, could we keep the parameter, but re-designate it to be a 
flags argument? All drivers with software vblank timers would flag them 
as such.

Best regards
Thomas


>
>    virtual patch
>
>    @depends on patch@
>    expression dev;
>    @@
>
>    - drm_vblank_init(dev, ...)
>    + drm_vblank_init(dev)
>
> And then fixup some of the funky whitespace errors that introduces by hand.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Assisted-by: Coccinelle
> ---
>   drivers/gpu/drm/adp/adp_drv.c                       | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c            | 2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c              | 2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c               | 2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c               | 2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
>   drivers/gpu/drm/arm/display/komeda/komeda_kms.c     | 2 +-
>   drivers/gpu/drm/arm/hdlcd_drv.c                     | 2 +-
>   drivers/gpu/drm/arm/malidp_drv.c                    | 2 +-
>   drivers/gpu/drm/armada/armada_drv.c                 | 2 +-
>   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c             | 2 +-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c        | 2 +-
>   drivers/gpu/drm/drm_vblank.c                        | 6 +++---
>   drivers/gpu/drm/exynos/exynos_drm_drv.c             | 2 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c           | 2 +-
>   drivers/gpu/drm/gma500/psb_drv.c                    | 2 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c     | 2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c     | 2 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c         | 2 +-
>   drivers/gpu/drm/i915/display/intel_display_driver.c | 3 +--
>   drivers/gpu/drm/imx/dc/dc-kms.c                     | 2 +-
>   drivers/gpu/drm/imx/dcss/dcss-kms.c                 | 2 +-
>   drivers/gpu/drm/imx/ipuv3/imx-drm-core.c            | 2 +-
>   drivers/gpu/drm/imx/lcdc/imx-lcdc.c                 | 2 +-
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c           | 2 +-
>   drivers/gpu/drm/kmb/kmb_drv.c                       | 2 +-
>   drivers/gpu/drm/logicvc/logicvc_mode.c              | 2 +-
>   drivers/gpu/drm/loongson/lsdc_drv.c                 | 2 +-
>   drivers/gpu/drm/mcde/mcde_drv.c                     | 2 +-
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c              | 2 +-
>   drivers/gpu/drm/meson/meson_drv.c                   | 2 +-
>   drivers/gpu/drm/msm/msm_kms.c                       | 2 +-
>   drivers/gpu/drm/mxsfb/lcdif_drv.c                   | 2 +-
>   drivers/gpu/drm/mxsfb/mxsfb_drv.c                   | 2 +-
>   drivers/gpu/drm/nouveau/nouveau_display.c           | 2 +-
>   drivers/gpu/drm/omapdrm/omap_drv.c                  | 2 +-
>   drivers/gpu/drm/pl111/pl111_drv.c                   | 2 +-
>   drivers/gpu/drm/qxl/qxl_display.c                   | 2 +-
>   drivers/gpu/drm/radeon/radeon_irq_kms.c             | 2 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c       | 2 +-
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c        | 2 +-
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c    | 2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c         | 2 +-
>   drivers/gpu/drm/sprd/sprd_drm.c                     | 2 +-
>   drivers/gpu/drm/sti/sti_compositor.c                | 2 +-
>   drivers/gpu/drm/stm/ltdc.c                          | 2 +-
>   drivers/gpu/drm/sun4i/sun4i_drv.c                   | 2 +-
>   drivers/gpu/drm/tegra/drm.c                         | 2 +-
>   drivers/gpu/drm/tidss/tidss_kms.c                   | 2 +-
>   drivers/gpu/drm/tilcdc/tilcdc_drv.c                 | 2 +-
>   drivers/gpu/drm/tiny/bochs.c                        | 2 +-
>   drivers/gpu/drm/tiny/cirrus-qemu.c                  | 2 +-
>   drivers/gpu/drm/tve200/tve200_drv.c                 | 2 +-
>   drivers/gpu/drm/vc4/vc4_kms.c                       | 2 +-
>   drivers/gpu/drm/verisilicon/vs_drm.c                | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_display.c            | 2 +-
>   drivers/gpu/drm/vkms/vkms_drv.c                     | 3 +--
>   drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c                | 2 +-
>   drivers/gpu/drm/xlnx/zynqmp_kms.c                   | 2 +-
>   include/drm/drm_vblank.h                            | 2 +-
>   60 files changed, 62 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
> index ce9dd6222634d..cc1ed68806cf1 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -444,7 +444,7 @@ static int adp_setup_mode_config(struct adp_drv_private *adp)
>   	if (IS_ERR(adp->connector))
>   		return PTR_ERR(adp->connector);
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		drm_err(drm, "failed to initialize vblank");
>   		return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 170adaf7e76ab..79aaa9d8fcdaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -413,7 +413,7 @@ static int amdgpu_vkms_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
> +	r = drm_vblank_init(adev_to_drm(adev));
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index f2977fe6d8242..649d331973280 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -2809,7 +2809,7 @@ static int dce_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	/* XXX: can this be enabled for DC? */
>   	adev_to_drm(adev)->vblank_disable_immediate = true;
>   
> -	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
> +	r = drm_vblank_init(adev_to_drm(adev));
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index c68de0fe1d7d3..d82272ca3b33d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -2759,7 +2759,7 @@ static int dce_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	/* XXX: can this be enabled for DC? */
>   	adev_to_drm(adev)->vblank_disable_immediate = true;
>   
> -	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
> +	r = drm_vblank_init(adev_to_drm(adev));
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index c3906270f25ef..76d6db1959643 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -2728,7 +2728,7 @@ static int dce_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	/* XXX: can this be enabled for DC? */
>   	adev_to_drm(adev)->vblank_disable_immediate = true;
>   
> -	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
> +	r = drm_vblank_init(adev_to_drm(adev));
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 38cffe1279896..07b83584c7a9d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -893,7 +893,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	adev_to_drm(adev)->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
>   	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
>   
> -	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
> +	if (drm_vblank_init(adev_to_drm(adev))) {
>   		drm_err(adev_to_drm(adev),
>   		"failed to initialize vblank for display support.\n");
>   		goto error;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index faa8b041373a7..02e7037c9b46e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -297,7 +297,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>   	if (err)
>   		goto cleanup_mode_config;
>   
> -	err = drm_vblank_init(drm, kms->n_crtcs);
> +	err = drm_vblank_init(drm);
>   	if (err)
>   		goto cleanup_mode_config;
>   
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 81d45f2dd6a70..f353406d0f7fd 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -275,7 +275,7 @@ static int hdlcd_drm_bind(struct device *dev)
>   
>   	pm_runtime_enable(dev);
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		DRM_ERROR("failed to initialise vblank\n");
>   		goto err_vblank;
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 23fa942ae4bbe..96df6790444fe 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -849,7 +849,7 @@ static int malidp_bind(struct device *dev)
>   	if (ret < 0)
>   		goto irq_init_fail;
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		DRM_ERROR("failed to initialise vblank\n");
>   		goto vblank_fail;
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index cae25ad66c749..3638b13d0cee9 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -122,7 +122,7 @@ static int armada_drm_bind(struct device *dev)
>   	if (ret)
>   		goto err_kms;
>   
> -	ret = drm_vblank_init(&priv->drm, priv->drm.mode_config.num_crtc);
> +	ret = drm_vblank_init(&priv->drm);
>   	if (ret)
>   		goto err_comp;
>   
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index d4577663a1f0e..ba78695d1015c 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -205,7 +205,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		dev_err(drm->dev, "Failed to initialise vblank\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 2f41bce574dc5..1a5f273527bb4 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -867,7 +867,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>   
>   	pm_runtime_enable(dev->dev);
>   
> -	ret = drm_vblank_init(dev, 1);
> +	ret = drm_vblank_init(dev);
>   	if (ret < 0) {
>   		drm_err(dev, "failed to initialize vblank\n");
>   		goto err_periph_clk_disable;
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index c6f61a39b5d16..17283e8920378 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -536,18 +536,18 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
>   /**
>    * drm_vblank_init - initialize vblank support
>    * @dev: DRM device
> - * @num_crtcs: number of CRTCs supported by @dev
>    *
> - * This function initializes vblank support for @num_crtcs display pipelines.
> + * This function initializes vblank support for display pipelines.
>    * Cleanup is handled automatically through a cleanup function added with
>    * drmm_add_action_or_reset().
>    *
>    * Returns:
>    * Zero on success or a negative error code on failure.
>    */
> -int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
> +int drm_vblank_init(struct drm_device *dev)
>   {
>   	int ret;
> +	unsigned int num_crtcs = dev->mode_config.num_crtc;
>   	unsigned int i;
>   
>   	spin_lock_init(&dev->vbl_lock);
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index 9ee30086879f9..42c6053cdc9ec 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -273,7 +273,7 @@ static int exynos_drm_bind(struct device *dev)
>   	if (ret)
>   		goto err_mode_config_cleanup;
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		goto err_unbind_all;
>   
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index 3bbfc1b56a655..39768565b437e 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -122,7 +122,7 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
>   			return dev_err_probe(dev->dev, ret, "failed to enable pixclk\n");
>   	}
>   
> -	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> +	ret = drm_vblank_init(dev);
>   	if (ret < 0) {
>   		dev_err(dev->dev, "failed to initialize vblank\n");
>   		goto done_vblank;
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index d17cb5b4a4bf2..bef32d29046df 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -364,7 +364,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>   	acpi_video_register();
>   
>   	/* Setup vertical blanking handling */
> -	ret = drm_vblank_init(dev, dev_priv->num_pipe);
> +	ret = drm_vblank_init(dev);
>   	if (ret)
>   		goto out_err;
>   
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 4d85c89f3f882..8f622732830e6 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -398,7 +398,7 @@ static int hibmc_load(struct drm_device *dev)
>   	if (ret)
>   		goto err;
>   
> -	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> +	ret = drm_vblank_init(dev);
>   	if (ret) {
>   		drm_err(dev, "failed to initialize vblank: %d\n", ret);
>   		goto err;
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index 8a11c2df5b886..617d8884ef649 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -181,7 +181,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
>   	}
>   
>   	/* vblank init */
> -	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> +	ret = drm_vblank_init(dev);
>   	if (ret) {
>   		DRM_ERROR("failed to initialize vblank.\n");
>   		goto err_unbind_all;
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 1855749c1e41f..99833f5ce3610 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -330,7 +330,7 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
>   		return ret;
>   	}
>   
> -	ret = drm_vblank_init(dev, 1);
> +	ret = drm_vblank_init(dev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
> index bb5301b90231a..501a4bc9dfd50 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -217,8 +217,7 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
>   	intel_bw_init_hw(display);
>   
>   	if (HAS_DISPLAY(display)) {
> -		ret = drm_vblank_init(display->drm,
> -				      INTEL_NUM_PIPES(display));
> +		ret = drm_vblank_init(display->drm);
>   		if (ret)
>   			goto cleanup_opregion;
>   	}
> diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
> index 0f8cfaf4c4d15..fbff307c87240 100644
> --- a/drivers/gpu/drm/imx/dc/dc-kms.c
> +++ b/drivers/gpu/drm/imx/dc/dc-kms.c
> @@ -118,7 +118,7 @@ int dc_kms_init(struct dc_drm_device *dc_drm)
>   			return ret;
>   	}
>   
> -	ret = drm_vblank_init(drm, DC_DISPLAYS);
> +	ret = drm_vblank_init(drm);
>   	if (ret) {
>   		dev_err(drm->dev, "failed to init vblank support: %d\n", ret);
>   		return ret;
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> index 7c5a6e2bc89ac..d3b9d69254273 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> @@ -129,7 +129,7 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
>   
>   	dcss_kms_mode_config_init(kms);
>   
> -	ret = drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		goto cleanup_mode_config;
>   
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> index 51a0ec0432484..53ea896d53353 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> @@ -233,7 +233,7 @@ static int imx_drm_bind(struct device *dev)
>   	if (ret)
>   		goto err_kms;
>   
> -	ret = drm_vblank_init(drm, MAX_CRTC);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		goto err_kms;
>   
> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> index c67fe80b8115e..cc2a2c386730a 100644
> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> @@ -435,7 +435,7 @@ static int imx_lcdc_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return dev_err_probe(drm->dev, ret, "Cannot setup simple display pipe\n");
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0)
>   		return dev_err_probe(drm->dev, ret, "Failed to initialize vblank\n");
>   
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..4e17f5707e708 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1348,7 +1348,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
>   		goto err_drvdata;
>   	}
>   
> -	ret = drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm);
>   	if (ret) {
>   		dev_err(dev, "Failed calling drm_vblank_init()\n");
>   		goto err_drvdata;
> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
> index 7c2eb1152fc2f..6026702fa31f9 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
> @@ -191,7 +191,7 @@ static int kmb_setup_mode_config(struct drm_device *drm)
>   	ret = kmb_dsi_encoder_init(drm, kmb->kmb_dsi);
>   	/* Set the CRTC's port so that the encoder component can find it */
>   	kmb->crtc.port = of_graph_get_port_by_id(drm->dev->of_node, 0);
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		drm_err(drm, "failed to initialize vblank\n");
>   		pm_runtime_disable(drm->dev);
> diff --git a/drivers/gpu/drm/logicvc/logicvc_mode.c b/drivers/gpu/drm/logicvc/logicvc_mode.c
> index 3cf04b70bd271..9b67f12f32757 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_mode.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_mode.c
> @@ -36,7 +36,7 @@ int logicvc_mode_init(struct logicvc_drm *logicvc)
>   	uint32_t preferred_depth;
>   	int ret;
>   
> -	ret = drm_vblank_init(drm_dev, mode_config->num_crtc);
> +	ret = drm_vblank_init(drm_dev);
>   	if (ret) {
>   		drm_err(drm_dev, "Failed to initialize vblank\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
> index 3fd828d23271c..19a7e98e6cd04 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -296,7 +296,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	drmm_kms_helper_poll_init(ddev);
>   
>   	if (loongson_vblank) {
> -		ret = drm_vblank_init(ddev, descp->num_of_crtc);
> +		ret = drm_vblank_init(ddev);
>   		if (ret)
>   			return ret;
>   
> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
> index 53275b575f0cb..f94750d93fd55 100644
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c
> @@ -174,7 +174,7 @@ static int mcde_modeset_init(struct drm_device *drm)
>   	mode_config->min_height = 1;
>   	mode_config->max_height = 1080;
>   
> -	ret = drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm);
>   	if (ret) {
>   		dev_err(drm->dev, "failed to init vblank\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index c86a3f54f35bc..40b3877350fd9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -574,7 +574,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>   	 */
>   	dma_set_max_seg_size(dma_dev, UINT_MAX);
>   
> -	ret = drm_vblank_init(drm, MAX_CRTC);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0)
>   		goto err_component_unbind;
>   
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 49ff9f1f16d32..d87a91135ecb3 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -262,7 +262,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>   
>   	priv->vsync_irq = platform_get_irq(pdev, 0);
>   
> -	ret = drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		goto free_canvas_vd1_2;
>   
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index e5d0ea6294484..23f0f2a25ea68 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -317,7 +317,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
>   		sched_set_fifo(ev_thread->worker->task);
>   	}
>   
> -	ret = drm_vblank_init(ddev, ddev->mode_config.num_crtc);
> +	ret = drm_vblank_init(ddev);
>   	if (ret < 0) {
>   		DRM_DEV_ERROR(dev, "failed to initialize vblank\n");
>   		goto err_msm_uninit;
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index e2173c4d6fc28..7fa1591a74bdd 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -175,7 +175,7 @@ static int lcdif_load(struct drm_device *drm)
>   		return ret;
>   	}
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		dev_err(drm->dev, "Failed to initialise vblank\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 8b4a500347fbd..87d38a84ed169 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -257,7 +257,7 @@ static int mxsfb_load(struct drm_device *drm,
>   		goto err_vblank;
>   	}
>   
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret < 0) {
>   		dev_err(drm->dev, "Failed to initialise vblank\n");
>   		goto err_vblank;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
> index d71dcfc6ee66b..9305876bdad33 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -713,7 +713,7 @@ nouveau_display_create(struct drm_device *dev)
>   	drm_mode_config_reset(dev);
>   
>   	if (dev->mode_config.num_crtc) {
> -		ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> +		ret = drm_vblank_init(dev);
>   		if (ret)
>   			goto vblank_err;
>   
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 92d6a1f9c0a1a..aad57533780cd 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -731,7 +731,7 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
>   	}
>   
>   	/* Initialize vblank handling, start with all CRTCs disabled. */
> -	ret = drm_vblank_init(ddev, priv->num_pipes);
> +	ret = drm_vblank_init(ddev);
>   	if (ret) {
>   		dev_err(priv->dev, "could not init vblank\n");
>   		goto err_cleanup_modeset;
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index 8ec659b3c08eb..e20a63ad1a0e1 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -175,7 +175,7 @@ static int pl111_modeset_init(struct drm_device *dev)
>   		return ret;
>   
>   	if (!priv->variant->broken_vblank) {
> -		ret = drm_vblank_init(dev, 1);
> +		ret = drm_vblank_init(dev);
>   		if (ret != 0) {
>   			drm_err(dev, "Failed to init vblank\n");
>   			goto out_bridge;
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 7f4178800afd7..0ed93be0439f1 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1304,7 +1304,7 @@ int qxl_modeset_init(struct qxl_device *qdev)
>   
>   	qxl_display_read_client_monitors_config(qdev);
>   
> -	ret = drm_vblank_init(&qdev->ddev, qxl_num_crtc);
> +	ret = drm_vblank_init(&qdev->ddev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> index 839d619e5602b..e6880d3f665ee 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -314,7 +314,7 @@ int radeon_irq_kms_init(struct radeon_device *rdev)
>   	/* Disable vblank irqs aggressively for power-saving */
>   	rdev_to_drm(rdev)->vblank_disable_immediate = true;
>   
> -	r = drm_vblank_init(rdev_to_drm(rdev), rdev->num_crtc);
> +	r = drm_vblank_init(rdev_to_drm(rdev));
>   	if (r) {
>   		return r;
>   	}
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> index 9228a7ad0dfa4..c9e29da53d056 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> @@ -888,7 +888,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
>   	 * Initialize vertical blanking interrupts handling. Start with vblank
>   	 * disabled for all CRTCs.
>   	 */
> -	ret = drm_vblank_init(dev, rcdu->num_crtcs);
> +	ret = drm_vblank_init(dev);
>   	if (ret < 0)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> index 87f171145a230..497f3891c586a 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> @@ -430,7 +430,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
>   	 * Initialize vertical blanking interrupts handling. Start with vblank
>   	 * disabled for all CRTCs.
>   	 */
> -	ret = drm_vblank_init(dev, rcdu->num_crtcs);
> +	ret = drm_vblank_init(dev);
>   	if (ret < 0)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index 2f31822b22458..713a1abb364b9 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -228,7 +228,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = drm_vblank_init(ddev, 1);
> +	ret = drm_vblank_init(ddev);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to initialize vblank\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 3099408e9d050..6e14c3832abff 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -186,7 +186,7 @@ static int rockchip_drm_bind(struct device *dev)
>   	if (ret)
>   		goto err_unbind_all;
>   
> -	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm_dev);
>   	if (ret)
>   		goto err_iommu_cleanup;
>   
> diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
> index c2fd5380a834f..a49247a6cc25d 100644
> --- a/drivers/gpu/drm/sprd/sprd_drm.c
> +++ b/drivers/gpu/drm/sprd/sprd_drm.c
> @@ -89,7 +89,7 @@ static int sprd_drm_bind(struct device *dev)
>   	}
>   
>   	/* vblank init */
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret) {
>   		drm_err(drm, "failed to initialize vblank.\n");
>   		goto err_unbind_all;
> diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
> index 8c529b0cca8b4..5478826aeb420 100644
> --- a/drivers/gpu/drm/sti/sti_compositor.c
> +++ b/drivers/gpu/drm/sti/sti_compositor.c
> @@ -145,7 +145,7 @@ static int sti_compositor_bind(struct device *dev,
>   		}
>   	}
>   
> -	drm_vblank_init(drm_dev, crtc_id);
> +	drm_vblank_init(drm_dev);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 8818dcf98da79..1e8ac7bbbea5c 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -2076,7 +2076,7 @@ int ltdc_load(struct drm_device *ddev)
>   		goto err;
>   	}
>   
> -	ret = drm_vblank_init(ddev, NB_CRTC);
> +	ret = drm_vblank_init(ddev);
>   	if (ret) {
>   		drm_err(ddev, "Failed calling drm_vblank_init()\n");
>   		goto err;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index e9baca360160b..b74ab1bcb41ee 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -95,7 +95,7 @@ static int sun4i_drv_bind(struct device *dev)
>   	}
>   
>   	/* drm_vblank_init calls kcalloc, which can fail */
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		goto unbind_all;
>   
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 324480c87fb1f..d5fe8f35107e9 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -1241,7 +1241,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
>   	/* syncpoints are used for full 32-bit hardware VBLANK counters */
>   	drm->max_vblank_count = 0xffffffff;
>   
> -	err = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	err = drm_vblank_init(drm);
>   	if (err < 0)
>   		goto hub;
>   
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
> index 70c14c3be10d5..8b45ac6a5e704 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -289,7 +289,7 @@ int tidss_modeset_init(struct tidss_device *tidss)
>   	if (ret)
>   		return ret;
>   
> -	ret = drm_vblank_init(ddev, tidss->num_crtcs);
> +	ret = drm_vblank_init(ddev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 1d6c9a423a410..37508fcd261c0 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -405,7 +405,7 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
>   		goto unregister_cpufreq_notif;
>   	}
>   
> -	ret = drm_vblank_init(ddev, 1);
> +	ret = drm_vblank_init(ddev);
>   	if (ret < 0) {
>   		drm_err(ddev, "failed to initialize vblank\n");
>   		goto unregister_cpufreq_notif;
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index e2d957e51505c..36196682ace2f 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -677,7 +677,7 @@ static int bochs_kms_init(struct bochs_device *bochs)
>   	drm_connector_attach_edid_property(connector);
>   	drm_connector_attach_encoder(connector, encoder);
>   
> -	ret = drm_vblank_init(dev, 1);
> +	ret = drm_vblank_init(dev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
> index 075221b431d37..d6730763acade 100644
> --- a/drivers/gpu/drm/tiny/cirrus-qemu.c
> +++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
> @@ -501,7 +501,7 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
>   	if (ret)
>   		return ret;
>   
> -	ret = drm_vblank_init(dev, 1);
> +	ret = drm_vblank_init(dev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
> index 8d0e7c7c82e84..f41748436ac5a 100644
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> @@ -120,7 +120,7 @@ static int tve200_modeset_init(struct drm_device *dev)
>   	dev_info(dev->dev, "attached to panel %s\n",
>   		 dev_name(panel->dev));
>   
> -	ret = drm_vblank_init(dev, 1);
> +	ret = drm_vblank_init(dev);
>   	if (ret) {
>   		dev_err(dev->dev, "failed to init vblank\n");
>   		goto out_bridge;
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 8f08567d28fc6..2c1c479494b12 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -1151,7 +1151,7 @@ int vc4_kms_load(struct drm_device *dev)
>   	/* Set support for vblank irq fast disable, before drm_vblank_init() */
>   	dev->vblank_disable_immediate = true;
>   
> -	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> +	ret = drm_vblank_init(dev);
>   	if (ret < 0) {
>   		dev_err(dev->dev, "failed to initialize vblank\n");
>   		return ret;
> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c b/drivers/gpu/drm/verisilicon/vs_drm.c
> index fd259d53f49f1..3e4944eb745c4 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drm.c
> +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
> @@ -121,7 +121,7 @@ int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev)
>   		vdrm->crtcs[i] = crtc;
>   	}
>   
> -	ret = drm_vblank_init(drm, dc->identity.display_count);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 44ffffec550fd..971c5a7424b37 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -381,7 +381,7 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
>   	for (i = 0 ; i < vgdev->num_scanouts; ++i)
>   		vgdev_output_init(vgdev, i);
>   
> -	ret = drm_vblank_init(vgdev->ddev, vgdev->num_scanouts);
> +	ret = drm_vblank_init(vgdev->ddev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 5a640b531d88f..5a830cee7fe9b 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -192,8 +192,7 @@ int vkms_create(struct vkms_config *config)
>   		goto out_devres;
>   	}
>   
> -	ret = drm_vblank_init(&vkms_device->drm,
> -			      vkms_config_get_num_crtcs(config));
> +	ret = drm_vblank_init(&vkms_device->drm);
>   	if (ret) {
>   		DRM_ERROR("Failed to vblank\n");
>   		goto out_devres;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> index 7b8163b5e5014..22601060727fb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -212,7 +212,7 @@ vmw_vkms_init(struct vmw_private *vmw)
>   
>   	ret = kstrtobool(buffer, &vmw->vkms_enabled);
>   	if (!ret && vmw->vkms_enabled) {
> -		ret = drm_vblank_init(&vmw->drm, VMWGFX_NUM_DISPLAY_UNITS);
> +		ret = drm_vblank_init(&vmw->drm);
>   		vmw->vkms_enabled = (ret == 0);
>   	}
>   
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index d5f9224505655..c5209df46afe5 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -504,7 +504,7 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
>   	drm->mode_config.max_width = ZYNQMP_DISP_MAX_WIDTH;
>   	drm->mode_config.max_height = ZYNQMP_DISP_MAX_HEIGHT;
>   
> -	ret = drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm);
>   	if (ret)
>   		return ret;
>   
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index 2fcef9c0f5b1b..d78f40d3a85be 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -285,7 +285,7 @@ struct drm_vblank_crtc {
>   };
>   
>   struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
> -int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
> +int drm_vblank_init(struct drm_device *dev);
>   bool drm_dev_has_vblank(const struct drm_device *dev);
>   u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
>   u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


