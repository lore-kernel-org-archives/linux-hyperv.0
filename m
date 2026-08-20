Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C747DFA8
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Aug 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245507; cv=none; b=iPSkWsxVnGrDP0N96Hbi0ay47n0urwrZeak1Yvu7WkjCcfZPTROmz9GHAgvOBhOvKOQKuAMxv2tm5ZGg8ghs8yFlWd4tTjOzCfsPOG5oepjRWjfp3u7RrlxJr1ADQugN+VNcASX96dCFwayx8CLChSzOdNAfWStmhaW5TS3tUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245507; c=relaxed/simple;
	bh=OOvAhEjtRhOw0a+UjXxcotOqI4sqWEFsEYl3cZ0ejEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3puhz7r0WEsqfkYrY4/AYmKJFU5ODNtWNa4+A21nAHG0QY90/op90KQgC4ioM3QkhVeQh5gt4Sd+124keAFco9/TRs4cx3Tn6PgYwfziCU/kekCngRF2bDSrxlwRyZQoR/eY06F9k6dMb568NDfI61IVIBxOdU6sciIj0oomjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDoMONvZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNngpUhG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDoMONvZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNngpUhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787245504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
	b=EDoMONvZNkKJ8aU2NuNKwz5ixgLykNkMuc6tCR+7QydjEiYXVPzvu5HRgGXuZs2lhL1res
	MQ8EUqHHFyQdt3jwgiuysBHCFkrOiYzmkBdaLfcXGSzyzCNhVmQ7extwMxVMBItl2zKbbM
	sshOUrx7Ytil15L3NHbkNEf0Lk0Zq/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Z9gcO_3nPemWt4cx3YaM7A-1; Thu, 20 Aug 2026 13:05:00 -0400
X-MC-Unique: Z9gcO_3nPemWt4cx3YaM7A-1
X-Mimecast-MFC-AGG-ID: Z9gcO_3nPemWt4cx3YaM7A_1787245499
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499a8039ff5so331305e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Aug 2026 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787245499; x=1787850299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
        b=GNngpUhGw6LvGOZy9Q9TqjDH/Jo4/N0UbO4oLdHnx1bz2LLQR7bdoORWUXOO0MWywX
         we1MQuBsglWX4t3Kp4SbHafc05j1YigY9Q1GioUFTdzJ+frrO4CdStl7pGAbg4Aj5Y1j
         yjQFYfS2ilL23rAbgMHBZcptID7e3L+KmfjH9cyq2dzPTqsaCCxlzk+hn2LoakpWmt+r
         Lg8V+YDNGI87UIrkPlvZVvrlmVMJj0Pu8bIv5DxE/DqyfOthKbdzQokjPKampK9hvdkt
         ORgdaKC8BHMf6sFgvoUhtBE5lEqF9uAFXSkwtrxrxy5GI3vcyVlcmHAmZ9tNsgMOmrTa
         RFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245499; x=1787850299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
        b=KbFY9voLh4rWVL2RZtcHCUSs7ByhYF30K64bWBwnamq2lXJ+G5sQ0HVAVNQqHM0m5A
         72JoyR9jX4nQMhBz/nzp54howH1FUSOc1KhG3saOrxOl7eakV3MITjw5pVUSk5OVLe/D
         gimuyddlceFp3bp6wl5zZJn9EFGVB+Nyw2Z4i3qnN9/Ugd1I5oK6uHV6eC395f46PzRO
         9se1Xxz2SsvXh/m/3o9bMv1KcbwqU+NpaHR6C2T28JiaEEhc2LcTL3suAnQ81cDC0xcN
         9J4OggxPITHwQrntrV3Q+6YMkcss5Yi4ukFnDPg9W9gxjo0MImp+cOqk9rEekLRb1dBu
         JDdA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3XmhdMH35AQamewPYsqArABCzsxspOUwDzS9/FVMwaPc5Rv3EqMeRgKs2fAIKQB87M4Sr/gsKi4uZs0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMntXShkaLQhL5ttVwtF4/JtkJOHLdKgViRLYRwo6/M696c1x
	i8qEmDW3Ejf539rj7Y8RuLuQHv8IHmZL5K7K2CI1BokePcWn+S0tKnKu4MTLmRsmPH+8ptpMuG7
	jJjygHjzVyg00/2k9TZQHC9MpqWdNSMskdGTQc0PRx32u69G+7Byd3MOV3KvJN66wjg==
X-Gm-Gg: AR+sD12Jl+f13kJAEOVbFEJ1djPLWBIru3JNOUPVlP4P9KRfZ6lWJMN4wZu4fhlgKOf
	MaNYIhLjA2tvuOQ4aW+ejoIXoitzVye25ipSeStDAVWs3/O3KArbTyIdFTM1EdypKpcvqCILw4X
	BOWHOWrSQnVXjKEmUo0u44oVisUSUmaT+Pvrqo91+LL82kLtTpoIEguVT3Uw+vyUdVBVp04mutu
	tlzuJ0hdNXeKUlk3K0Lu82dTpNeUcQxicyyh3eOgKUFBi9MV0pt4YzfufM9V4vkKA6INFgAf2DO
	ehRPNCkNg2HRBg3AGNCTUoT6A1oRG7KVPDqPvnNMyythGnbyYIGZk7gyCAA+E+QcPjQgUh4x5Ka
	z9CWR5dikN70AEAhpxGlHDFAjozMtp+K5IvsaAWCzmSSHCQ==
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499b8465f7dmr5017125e9.10.1787245499112;
        Thu, 20 Aug 2026 10:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499b8465f7dmr5015695e9.10.1787245498659;
        Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm13157002f8f.27.2026.08.20.10.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Message-ID: <cb784cf6-f3d8-41aa-9f71-c197a5eba7f2@redhat.com>
Date: Thu, 20 Aug 2026 19:04:51 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] drm/panic: Return -EINVAL if font is not available
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
 <20260818125012.468092-4-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 705b72bf0d83..96d238bfceee 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -757,8 +757,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	int qr_width, qr_canvas_width, qr_pitch, v_margin;
>   	u8 *qr_image;
>   
> -	if (!font || !stream.workspace)
> +	if (!stream.workspace)
>   		return -ENOMEM;
> +	if (!font)
> +		return -EINVAL;
>   
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   

