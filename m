Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D137C0EB
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Aug 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246138; cv=none; b=tJQlFW7b5nVleW1Cuf508SRpvfoWfgFrpejH0EDzYf9zOsYy1VRXJ0RiLkVLmvzv+z7MGiGxtuZb0Z0Ct+cceYRPuyZhSPzS7rWJ7ESIYK/dGQs1+xxmM8mlZrWrTV17P1v5Ey0EL9BRTAAMFrVTeigzleNYXyMet9bg2U/P7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246138; c=relaxed/simple;
	bh=9tk8Sl/tU+k06lyjB+gI117CsAuIPPkNt46ArevX/WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blI5Q6qMRvWVk8IPoQsEhcjDY/5q4Zr7+Z3env0nznEZy2dmTURJDmauxVgpGnXncCVfl5mYNSu/FETO7OoJ4kKbz0YH8vfOT5RzbPjokTN9C6v1cbOO+AcaSDLTFmlrNrcAWfOslSj8xlzriXJnM7vxglUERkAf17i0GPTDKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbvYlM8g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYRy9Gkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbvYlM8g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYRy9Gkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787246134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
	b=UbvYlM8gQtehnb+mJGkZ770E/RZPmqF7CxIfe6OtQD1aXeTxWjauf90zkThNzXxe/GMf6K
	I+ZvgdL++BwfrJT/09BAzQsqQduEKSt233ECNbiRaAwkOIcxcZY//S9Gan+BnvSQycveDi
	paV+t9bEqZxR9/MWTVQ7mkPqYgd4HLA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-whFRKuKPM4W3pmnu3wukWA-1; Thu, 20 Aug 2026 13:15:31 -0400
X-MC-Unique: whFRKuKPM4W3pmnu3wukWA-1
X-Mimecast-MFC-AGG-ID: whFRKuKPM4W3pmnu3wukWA_1787246131
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so437255e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Aug 2026 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787246130; x=1787850930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
        b=WYRy9Gkb1rjGQdmeEiCJfgTY1e93MBXxbD8jBmNBGWmP9btJUyY9cr9P11CMu8zJ2d
         9cAcL4SbipaIgiFRWbX6Zpkmr/waNWWVYviq3jcv+4P2ixnL85ea1JG3+K4OgUe15BD8
         6YATsaMHrRXyuIIYSOyx5GX7twQGXlz/te0WwX339foKU8MR9A+6q1vEltQW4UPVdcN+
         x8I6uraitVE19u7fss1phx9n+q59ABq0qN1pHPdCst/2CKbX0JbhF9HWrfPZRzSPoOwp
         vPAlNpqL10o6c//qFjogQ7YWQyqArMm9hl9fHDK34rEl4ird0a0bFpW0nG4bIiF+RR9N
         Jy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246130; x=1787850930;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
        b=mXaM8EMY4G98Je3bORtOeNHpqs7v+pJ14aVurgH1cYHiBYRC0M0bLWWYTusQ3B4ISV
         jjDu5ojj8P/1XrNmSXtPGupVDTujJf0F7vTHYz3B1FJvQDAopoObcBK+gQsUGtYbDuFj
         8bE4LEwy9anQ+RY1FL0j2qfx3jbFIz8qKFrFDhdiNhWM07OZcHqSXtszlq/iKuYKW2z0
         1DOS7laQ9qee6SS00DkUu+ZEoTwRBkQppBmimAA2Ur03egyOp+XvWy3J/3GJN/OOkuCI
         pFAVO1lhur6+3VC+aWWOMd+RGjMTmsUGySRJdaZold7UEmYMonQ70tt/VpV/YtfYGa0u
         ML2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpzRCnWdqW5uqywB+F455yl9Q/oLCWf7d1JBfYEQZ2LtBFBQWLqkZLMeBM+0rqQLs5vHYfMN6TX8Kl6oUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7u3QThQG+Wdggh6TswhJCZcJo0j2O35FVECe2w6LTHc94B6Hh
	U54AW4svMh4fYwU7lUPnZS64UfnMRfEBw/+pqeHrjyrHR+QJnr86F/WGfC3wtZHro/zv9rTi0o2
	eokbaD1dbLayyi/3Kv5aL77iX43gJWADgGUCeBRtHHkTLd4vXMQooBUE728GPlIlvSA==
X-Gm-Gg: AR+sD10cDcS8YA1q1Shh+x8lzs0znbMa3IyFTmSWJh5WWJfRX+6dr3Kswyxk1CBvkYT
	MxxIBqER2e8GXEdQRTs2qa4BF46C4wj/DpZ+8E6GH5iiO/lmpzxJgsWMLwaTRXCy0kIufsg0hfE
	QriDCQ76v+BeMSZ3Ep5JJIvkQouvWQD2nlIDaIfo14KOsbBQIBb6pMk7/LlwlPRE35LjoQwPZo2
	4fBMlg0HK4o54UiedKwW3c6GObE0QFpmfKf5CajU/EMf5czfiW1ngTUXWhsrmls6czxrKVx28NC
	LfL1iWqkYI8D7fq7jRX0n/mo6dQPGQ/2MxQMplR3pjkV2sMfuNNL041akoupETGkNJ1ik480Qk8
	13zr17fzcTajWc6qa/vPXaypRXW0KdS+7UJi+YAvmPWBVqg==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499b845c184mr6845865e9.15.1787246130469;
        Thu, 20 Aug 2026 10:15:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499b845c184mr6843265e9.15.1787246129216;
        Thu, 20 Aug 2026 10:15:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14514d5sm14505430f8f.10.2026.08.20.10.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:15:28 -0700 (PDT)
Message-ID: <dd1da602-675f-4b63-ace3-a23e55ce549b@redhat.com>
Date: Thu, 20 Aug 2026 19:15:24 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panic: Retry in dispatch function if panic
 output fails
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
 <20260818125012.468092-8-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
> 
> Also pass module parameter drm_panic_type as a parameter to
> drm_panic_dispatch(). This simpifies the implementation. It will later
> allow for moving the function into a helper library.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 12c39217cbcb..0960750bfce2 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -746,9 +746,9 @@ static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
> -static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				      u32 fg_color, u32 bg_color,
> -				      unsigned int qr_version)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> +				     u32 fg_color, u32 bg_color,
> +				     unsigned int qr_version)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> @@ -816,15 +816,6 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>   	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>   	return 0;
>   }
> -
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				     u32 fg_color, u32 bg_color,
> -				     unsigned int qr_version)
> -{
> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
> -		draw_panic_screen_user(sb, fg_color, bg_color);
> -	return 0;
> -}
>   #else
>   static void drm_panic_qr_init(void) {};
>   static void drm_panic_qr_exit(void) {};
> @@ -899,13 +890,22 @@ static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_typ
>   {
>   	int ret;
>   
> +retry:
>   	switch (panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
>   		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
>   		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #endif
>   	case DRM_PANIC_TYPE_USER:

