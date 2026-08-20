Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0C478846
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Aug 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245573; cv=none; b=rFTDZvnrLzzqabp9NhBvR5kBZY+kSdJMNk3EsK6xgGdiP34uc1wcPsoXxl/Qa1yNCo6pFnCvgEWvereRpVUoLBiQ7yffeC76X5/4J6D3Y59p5+soJLr6cKT2Ze9sVJRP/2k5WTrmlU5iHQX8pvsMAf0jLGGEOLfpX6RKaTD8Gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245573; c=relaxed/simple;
	bh=s2lcFnu/Uj7kZhM6peVZ6x6b+Y7c35+ltIcEtK5cUCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQdvGfMz94nFFvkFT29Q+3yLSnHFP/JVqmKGq8hG8JX2LoWvxFMtS0beo/8oX8h2Y53A6RVeHGRbuwnD6AGASpFfntaxWPvbqFhD29K5kQquy3hlfDqZAfM1zXqBpUVAUIaGKXYmQkxG49F1z2Jv9pQdC1k9soDieLetbhgqhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEH3jrbJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1xxlcb3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEH3jrbJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1xxlcb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787245571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4jxRAgmGu6qOONmDUji01BEYH0iTGQlpmgV/kwEyHw=;
	b=eEH3jrbJL1+9WTcL03crRDA1sThlLRXgrkHCclF76jBvWysZSa4d3fwlDpddG2W/yqnq+Y
	B1MDXiZDoAvpLny8FfKb70xiWqNaShRFQUzFtbuEff+UifJqczujYyRqWcBJe5G5GJf4qJ
	uLrmGMvOemoILpZkFgV55v/nyCE7I/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ziEjtfNVMDi9X7DuzEDEOA-1; Thu, 20 Aug 2026 13:06:03 -0400
X-MC-Unique: ziEjtfNVMDi9X7DuzEDEOA-1
X-Mimecast-MFC-AGG-ID: ziEjtfNVMDi9X7DuzEDEOA_1787245562
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-482a5e9400eso108241f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Aug 2026 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787245562; x=1787850362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4jxRAgmGu6qOONmDUji01BEYH0iTGQlpmgV/kwEyHw=;
        b=N1xxlcb3iQWekdVQPoW3Wlsgjye7E2yM3fkxE3mAcyYvX/Lm+AuONV7aaQjTqK3WRK
         DzFQ7pkbDV8jqPKP66HWcF0Z40fIOwKoTNV37wJDQrklUbW9HVWpmHuPCe7NdnHKn7RT
         81VBLWU8jTSclSCnGlXWlB/41LlyWFWGkVoEu/5/gramD8obBN0XvENvSfTaGVhTNIbY
         Y1w8fPpXVDV2wR65ckTEEeDuh6iM9ChHNR78dd66DVxphslvL5Jr+Mvk73WGDLYfZFMV
         I42RlHYqwb4ObMmRCbwqzg3WJ2+LPn89Snfw2FT23w92iD9sHEKQlVaRynEgFPHBVGZU
         5HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245562; x=1787850362;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4jxRAgmGu6qOONmDUji01BEYH0iTGQlpmgV/kwEyHw=;
        b=FcbfLjPmbR3FbIzB5Et1K1g072Oh1e18dRWQjnzWRQfLMsUqrD8pp99pfqRyn0wuRd
         TJDXN0OjCfP9VfHrU/9aAAs/kRoEt01ZbqG77vaksUkwKCPzEaVRTJtu5YhfL+h7+xp5
         AxdluLBXbWc5TMfztrbd47iRhiAgWo4v2CZBOF3i+yb3uGoohjJnzaQSgme3Hi13YTyT
         1yi7akI4qKVgv6RTbJmh0rFX11mPGbrqGHaIbfuBCTJ+fDhU583AAs59qRP1pR5ylXwZ
         HUmoObMZoW4j5lzixM42G5Y0mnQpt7G8uOm98NQUbGA4+LSrGXF3L8sWKj49cSAX4mdN
         bd7A==
X-Forwarded-Encrypted: i=1; AHgh+Rq9br2Luyyp9fP7/kVluag1ofCPc0rvj2TLZxhakL2d4pvdqW/ZyIs4kUdKsNOA6nxMFX6larpf72selV8=@vger.kernel.org
X-Gm-Message-State: AFuF++njYZpWHBrf4cZY2VZRFqDetSPAkdTYPNle93oqDuEMOH7KZJCw
	cbWEphr+kz2Yj6MECijU8ct2GgdY70tI48ae8fuIZCQxdM1lLB7lphnQMBXJNzozOQuwq9Za2CM
	hlmncZJK+RbTTIQlwKtBZ0ImCeSwZO9PtfsNge3mbNZOV9psTdQkox5CX5rgcGM5EDg==
X-Gm-Gg: AR+sD11yJDl+5BA6g1YieWvGwCOdLVtYSuAh+v6Zn97VVBFr/dfAkB+5gk7w2ZuHreB
	+EwUYNvPwYbzWCNDuTysHhJW2G5xjbSeuVP8kK+17Yob6AMuZNG8Ng6qA9N1LV2S8ROA6wqD0Ef
	s8Kh7dricLt+JcmBXIlPD0AuGLJOwdlXzTbYKktwSfn03wUtdDlVbhz6v3ZIBsizH7ZeLGS9YRc
	M4TctCnfMLu4pFlFVWrAfbA6SdOeFA7pkjIPnuj2v7siLCt9f8qiC0W898I44patkRNzvns5svt
	jijjYgoBLLMdrHvF2nKuHYlKsezGMcJeovFFoGJbYolOP6Y8raCMho9ZZl3BBmiCf3qu1R4YVem
	fI3x35T5+C5bNenA9RKSiSURBVRN8jtG0IKa3IWvyWz0upw==
X-Received: by 2002:a05:6000:25fe:b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-482c0ba220fmr134369f8f.22.1787245562177;
        Thu, 20 Aug 2026 10:06:02 -0700 (PDT)
X-Received: by 2002:a05:6000:25fe:b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-482c0ba220fmr134240f8f.22.1787245561785;
        Thu, 20 Aug 2026 10:06:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14cf0a3sm13674489f8f.32.2026.08.20.10.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:06:01 -0700 (PDT)
Message-ID: <5e7e0d9c-2fe2-4c0f-a854-1b1a495b1a7f@redhat.com>
Date: Thu, 20 Aug 2026 19:05:57 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/panic: Return errno codes if panic output fails
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-5-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> Return errno codes from the panic output helpers to detect invalid
> panic handling. Avoid flushing the display if an error ocured. The
> unflushed display output might be helpful in debugging.
> 
> For now, test the result values in the panic test cases. A later patch
> will add support for retrying failed panic output.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c            | 41 +++++++++++++++++---------
>   drivers/gpu/drm/tests/drm_panic_test.c | 16 ++++++----
>   2 files changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 96d238bfceee..594235661710 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -478,7 +478,7 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
>   				   fg_color);
>   }
>   
> -static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
>   {
>   	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
>   						    sb->format->format);
> @@ -489,7 +489,7 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
>   	unsigned int msg_width, msg_height;
>   
>   	if (!font)
> -		return;
> +		return -EINVAL;
>   
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	drm_panic_logo_rect(&r_logo, font);
> @@ -508,6 +508,8 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
>   		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
>   
>   	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
> +
> +	return 0;
>   }
>   
>   /*
> @@ -547,7 +549,7 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
>    * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
>    * and going up until reaching the top of the screen.
>    */
> -static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   {
>   	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
>   						    sb->format->format);
> @@ -562,7 +564,7 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   	int yoffset;
>   
>   	if (!font || font->width > sb->width)
> -		return;
> +		return -EINVAL;
>   
>   	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
>   
> @@ -589,6 +591,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   			start--;
>   		}
>   	}
> +
> +	return 0;
>   }
>   
>   #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> @@ -814,10 +818,11 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	return 0;
>   }
>   
> -static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   {
>   	if (_draw_panic_screen_qr_code(sb))
>   		draw_panic_screen_user(sb);
> +	return 0;
>   }
>   #else
>   static void drm_panic_qr_init(void) {};
> @@ -888,23 +893,25 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
>   	return drm_draw_can_convert_from_xrgb8888(format->format);
>   }
>   
> -static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
> +static int draw_panic_dispatch(struct drm_scanout_buffer *sb)
>   {
> +	int ret;
> +
>   	switch (drm_panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
> -		draw_panic_screen_kmsg(sb);
> +		ret = draw_panic_screen_kmsg(sb);
>   		break;
> -
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
> -		draw_panic_screen_qr_code(sb);
> +		ret = draw_panic_screen_qr_code(sb);
>   		break;
>   #endif
> -
>   	case DRM_PANIC_TYPE_USER:
>   	default:
> -		draw_panic_screen_user(sb);
> +		ret = draw_panic_screen_user(sb);
>   	}
> +
> +	return ret;
>   }
>   
>   static void drm_panic_set_description(const char *description)
> @@ -951,9 +958,15 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>   
>   	drm_panic_set_description(description);
>   
> -	draw_panic_dispatch(&sb);
> -	if (plane->helper_private->panic_flush)
> -		plane->helper_private->panic_flush(plane);
> +	ret = draw_panic_dispatch(&sb);
> +	if (!ret) {
> +		/*
> +		 * Only flush if we have a panic screen to display. Otherwise
> +		 * it's probably better to leave the display output as-is.
> +		 */
> +		if (plane->helper_private->panic_flush)
> +			plane->helper_private->panic_flush(plane);
> +	}
>   
>   	drm_panic_clear_description();
>   
> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
> index ad2f3a2f93b6..fdd77b0cc54c 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
> @@ -30,7 +30,7 @@ struct drm_test_mode {
>   	const int width;
>   	const int height;
>   	const u32 format;
> -	void (*draw_screen)(struct drm_scanout_buffer *sb);
> +	int (*draw_screen)(struct drm_scanout_buffer *sb);
>   	const char *fname;
>   };
>   
> @@ -87,7 +87,7 @@ static void drm_test_panic_screen_user_map(struct kunit *test)
>   	const struct drm_test_mode *params = test->param_value;
>   	char *fb;
>   	int fb_size;
> -	int i;
> +	int i, ret;
>   
>   	sb->format = drm_format_info(params->format);
>   	fb_size = params->width * params->height * sb->format->cpp[0];
> @@ -102,7 +102,8 @@ static void drm_test_panic_screen_user_map(struct kunit *test)
>   	sb->height = params->height;
>   	sb->pitch[0] = params->width * sb->format->cpp[0];
>   
> -	params->draw_screen(sb);
> +	ret = params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	for (i = 0; i < fb_size; i++)
>   		drm_panic_check_color_byte(test, fb[i]);
> @@ -119,7 +120,7 @@ static void drm_test_panic_screen_user_page(struct kunit *test)
>   {
>   	struct drm_scanout_buffer *sb = test->priv;
>   	const struct drm_test_mode *params = test->param_value;
> -	int fb_size, p, i, npages;
> +	int fb_size, p, i, npages, ret;
>   	struct page **pages;
>   	u8 *vaddr;
>   
> @@ -146,7 +147,8 @@ static void drm_test_panic_screen_user_page(struct kunit *test)
>   	sb->height = params->height;
>   	sb->pitch[0] = params->width * sb->format->cpp[0];
>   
> -	params->draw_screen(sb);
> +	ret = params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	for (p = 0; p < npages; p++) {
>   		int bytes_in_page = (p == npages - 1) ? fb_size - p * PAGE_SIZE : PAGE_SIZE;
> @@ -182,6 +184,7 @@ static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
>   {
>   	struct drm_scanout_buffer *sb = test->priv;
>   	const struct drm_test_mode *params = test->param_value;
> +	int ret;
>   
>   	sb->format = drm_format_info(params->format);
>   	sb->set_pixel = drm_test_panic_set_pixel;
> @@ -189,7 +192,8 @@ static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
>   	sb->height = params->height;
>   	sb->private = test;
>   
> -	params->draw_screen(sb);
> +	ret = params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>   }
>   
>   static void drm_test_panic_desc(const struct drm_test_mode *t, char *desc)

