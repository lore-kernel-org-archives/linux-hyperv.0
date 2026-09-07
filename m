Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C30369208
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815486; cv=none; b=gw2/RPusggC2qPluG3yykHV4zZD+fzxKdeaXviI41CVZKECirjK8PbOuOoFIb4+UJuLoOwSHy9pMj1ePWRcDqWAKNLKWA5QejFktykMVKHZqTtPiO65qqqOIFMBjC21ptm64+8T47Sp38OZnF61TwE8ulUk+ZfPVXwSlJnb1hjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815486; c=relaxed/simple;
	bh=WTSjkWf/gMwDD0G9Jxdz3k7VPH7hTuAGBNjTqgsI5l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS+8EV6NG7joY4qqm6S23enkzczyndUHwuhVeNOsKClRpXsLMr/ZDNMRQXq96Uu8QMtA4HQylGcxt4lGm/4iPYA8SxdQMeAQeauwee5dtZUvyiyAZ5ITijObDStdZbi1BdDtJBIlxRZSP3kjX4y/T/DKovZ3nZzlQQrb6v5fs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dN9UNKOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN9UNKOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788815483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXVQhrGkg3lXBqNlBJkrZ/ldyJ2zR16o0mRFm8tzu8Q=;
	b=dN9UNKOv/rjvOof4R9gY/vBppNX/TdYtFSkoT6ACZzfOfPzZnfODkHG5y+zGf2UTjqTjfp
	6lmldKTeUQNcWkUShTDwAQl7GShcyObDzfpQX4m1aK8y2mCpyDXwvHbKf2nJDXVxPaKI6S
	Be9LwJuw41Ef8G8LeWpo5hM0xxl3zik=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-7Wm3Qa-DPQqcit3Nac4qSg-1; Mon,
 07 Sep 2026 17:11:20 -0400
X-MC-Unique: 7Wm3Qa-DPQqcit3Nac4qSg-1
X-Mimecast-MFC-AGG-ID: 7Wm3Qa-DPQqcit3Nac4qSg_1788815477
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C2351964CFC;
	Mon,  7 Sep 2026 21:11:16 +0000 (UTC)
Received: from [100.91.157.188] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5075A362;
	Mon,  7 Sep 2026 21:11:11 +0000 (UTC)
Message-ID: <30966123-4b2d-470f-9344-7719bcc9ab3f@redhat.com>
Date: Mon, 7 Sep 2026 23:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] drm/panic: Split draw_panic_plane()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260902121930.597222-1-tzimmermann@suse.de>
 <20260902121930.597222-10-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260902121930.597222-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 9/2/26 14:13, Thomas Zimmermann wrote:
> Move locking and parameters from draw_panic_plane() into the new
> helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
> there.
> 
> The new helper drm_panic_display_panic_screen() is now the DRM core's
> interface for displaying a panic screen. The code remaining in
> draw_panic_plane() still does all the heavy lifting. It will become a
> plane helper for DRM drivers.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> v2:
> - use panic_type argument in draw_panic_plane() (Sashiko)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 62 ++++++++++++++++++++-----------------
>   1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 690e96e8f1f9..624042c42a7f 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -936,42 +936,25 @@ static void drm_panic_clear_description(void)
>   	desc_line->txt = NULL;
>   }
>   
> -static void draw_panic_plane(struct drm_plane *plane, const char *description)
> +static void draw_panic_plane(struct drm_plane *plane, const char *description,
> +			     enum drm_panic_type panic_type, u32 fg_color, u32 bg_color,
> +			     unsigned int qr_version)
>   {
>   	struct drm_scanout_buffer sb = { };
>   	int ret;
> -	unsigned long flags;
> -#if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
> -	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
> -#else
> -	u32 fg_color = 0x00ffffff;
> -#endif
> -#if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
> -	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
> -#else
> -	u32 bg_color = 0x00000000;
> -#endif
> -#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> -	unsigned int qr_version = panic_qr_version;
> -#else
> -	unsigned int qr_version = 0;
> -#endif
> -
> -	if (!drm_panic_trylock(plane->dev, flags))
> -		return;
>   
>   	ret = plane->helper_private->get_scanout_buffer(plane, &sb);
>   
>   	if (ret || !drm_panic_is_format_supported(sb.format))
> -		goto unlock;
> +		return;
>   
>   	/* One of these should be set, or it can't draw pixels */
>   	if (!sb.set_pixel && !sb.pages && iosys_map_is_null(&sb.map[0]))
> -		goto unlock;
> +		return;
>   
>   	drm_panic_set_description(description);
>   
> -	ret = draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr_version);
> +	ret = draw_panic_dispatch(&sb, panic_type, fg_color, bg_color, qr_version);
>   	if (!ret) {
>   		/*
>   		 * Only flush if we have a panic screen to display. Otherwise
> @@ -982,9 +965,33 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>   	}
>   
>   	drm_panic_clear_description();
> +}
>   
> -unlock:
> -	drm_panic_unlock(plane->dev, flags);
> +static void drm_panic_display_panic_screen(struct drm_plane *plane, const char *description)
> +{
> +#if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
> +	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
> +#else
> +	u32 fg_color = 0x00ffffff;
> +#endif
> +#if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
> +	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
> +#else
> +	u32 bg_color = 0x00000000;
> +#endif
> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +	unsigned int qr_version = panic_qr_version;
> +#else
> +	unsigned int qr_version = 0;
> +#endif
> +	struct drm_device *dev = plane->dev;
> +	unsigned long flags;
> +
> +	if (drm_panic_trylock(dev, flags)) {
> +		draw_panic_plane(plane, description, drm_panic_type,
> +				 fg_color, bg_color, qr_version);
> +		drm_panic_unlock(dev, flags);
> +	}
>   }
>   
>   static struct drm_plane *to_drm_plane(struct kmsg_dumper *kd)
> @@ -997,10 +1004,9 @@ static void drm_panic(struct kmsg_dumper *dumper, struct kmsg_dump_detail *detai
>   	struct drm_plane *plane = to_drm_plane(dumper);
>   
>   	if (detail->reason == KMSG_DUMP_PANIC)
> -		draw_panic_plane(plane, detail->description);
> +		drm_panic_display_panic_screen(plane, detail->description);
>   }
>   
> -
>   /*
>    * DEBUG FS, This is currently unsafe.
>    * Create one file per plane, so it's possible to debug one plane at a time.
> @@ -1017,7 +1023,7 @@ static ssize_t debugfs_trigger_write(struct file *file, const char __user *user_
>   	if (kstrtobool_from_user(user_buf, count, &run) == 0 && run) {
>   		struct drm_plane *plane = file->private_data;
>   
> -		draw_panic_plane(plane, "Test from debugfs");
> +		drm_panic_display_panic_screen(plane, "Test from debugfs");
>   	}
>   	return count;
>   }

