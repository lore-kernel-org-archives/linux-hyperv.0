Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646B429019
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132351; cv=none; b=pa3g3BU91AkprOhgilQkcsT5PMfdZ5/4i5pkL2CvTECwGwC2dF9cJ1wg9V1CapfmbEvEAtIswb3C0DhBzeLpJKtzEuHx2gnCrYIy5Aplda6JA3Lp/WBR/B1IXxaZC8PGj9DVGb1iy+DU+WDuSFj/O+R4qgw85+EF4+RqI1aAqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132351; c=relaxed/simple;
	bh=zlErMMR25SYOsUd3S/0AwpVYnof7u7gBjzWgLBfix9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmERO9tfLHHZ1L4TUhWGBkI38ZhpP/L90aqMnqixwfOCwA4broPOe/XFO88oVmlLLd419yKjjqUcqFXCVykUM346YcFSCJEq+0frPzbQLfL9ILe0e6t4pjM1xVhQuULyxS0EPCKGUD+UBc/YgJq8Iv4agRUKjguoQPWAY1YraMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97bf8e865c0so198951241.0
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 02:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132347; x=1787737147;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dIMgKn9ssmwMdJVgg9MfbDylpozJGdyvq0xNOf3CW1Q=;
        b=UOp+vbhPE19974O/tVzCLXGx39xPOkUcetrOVyZMFt+na6RIKlM6Ufg5Ki9Xi1TAZv
         Y1Yw7zwdJ5Ak8WlDfXVKFm1WMut6T/tFFH8naeNeVA1mLZHKoWJS/xoY/XKN9BjG/66x
         wDWTyWju4Lk1QRtsV8nnmMSLiVrNcfgq8X8QRjPkL6m/pvs+oIF/qNG/dqOLktNK73Y8
         2e1iOASmx7oV+pQC5L1F71eqS7YoB/u+E4VIzNfYkc+AbMFpijMppgpKo+kc+5uTvkEd
         p5rte76tE/1gWr+jcIlOYFblVNa4pJBe0PawKlL5fqFMeBTLIJru2DxzklTwVOtxc8rb
         u94w==
X-Forwarded-Encrypted: i=1; AHgh+Rpg7hrpwsw1dl+kXSUkeYNmaVdDyHxkdZwBT7kOHJlmIy3s07Se1EfA0yoA4Yy9hwE85W6aOu4pK+vXZ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0j+Rt9AH+eM3raSyIkVBJC5+JsP/540EBgzZIPCLl4LTa7CR
	2MT0AzdDnu7yW4Ba9lQa/Pp7DltkcQ/mYALOAzKB9dLiZizVkuusYXNoTkD0SXL2rtQ=
X-Gm-Gg: AR+sD10Virga8R7gUgKXxNPqdTO58U1Js2+eO9dDZK6n0r4Bqtp7wm/tGlsUfjp3F1o
	9nWmEL0k0da8QiUaN16UXtp1VQnv0CA+VvF0kYFuocz/fwFcRze6EdCFNRFBx1fGRb6uxQ1aKSz
	5j7gRw0zvRg6UT5SX1eQf0ucVkSbKLIrSykDbngw7ZsoRLaWz21/BpFn9HSnC8A2s/UA+WUBzLc
	oTu0bonSNPxWr/QbeUlM8V8AoiGxruSSNM4tf+XSYiU4CZ6nII60fTRKYRJzCQ2L/tjhGjKTjrv
	onoZuR9avGpl7usW28NYEKQRhcl9lsdyAmWVIVptBMA4TGfuFfTRYPHr2ip2kiQb3Q/ZU8EogOd
	diyMdMpNAbR1Usm4U4pFwACDoMkdWXPjXvGP25PVONf3x3sTw+O5CcmKt+p2QYgCBqShSX8wy8A
	xqLFj1YBy4MUZ1LcCla7oZZQTyep6sSSUS8kFgINPXZxKksobUD6G41knVBTG9n2gAh4fh+T//I
	yzMACEjL9YwWI6NRRF+xpFXwvwEndq/8L17
X-Received: by 2002:a05:6102:1611:b0:76b:12e9:a442 with SMTP id ada2fe7eead31-777f897e746mr894296137.1.1787132347629;
        Wed, 19 Aug 2026 02:39:07 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777dd4a721esm1604805137.9.2026.08.19.02.39.06
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 02:39:06 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-96944741eaeso261137241.1
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 02:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWITX0KoNbuxxyzD4VHncI29C3n/O3yJxMfYz2PkbVtNS9Av/4VpNzOhaRSetS8+QheEpfq68WsBbXGew=@vger.kernel.org
X-Received: by 2002:a67:e04e:0:b0:777:ffe0:a10b with SMTP id
 ada2fe7eead31-777ffe0a6b7mr539021137.4.1787132346344; Wed, 19 Aug 2026
 02:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818125012.468092-1-tzimmermann@suse.de> <20260818125012.468092-2-tzimmermann@suse.de>
In-Reply-To: <20260818125012.468092-2-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 11:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
X-Gm-Features: AcwNN1Uwr-MWNK1wEAyEr8Z9JNVhxk4jrnSNE7dazUpWIvLo30uHHQJP967oerw
Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, javierm@redhat.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Tue, 18 Aug 2026 at 15:00, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Declare qrbuf1 and qrbuf2 as static arrays so that the module loader
> allocates them for us. Avoids the kmalloc later on. Also allows for
> using sizeof() to get the number of bytes in each array. Access the
> arrays once with memset, so that the physical pages are available on
> a panic.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -628,24 +628,23 @@ MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
>  #define WINDOW_BITS 12
>  #define MEM_LEVEL 4
>
> -static char *qrbuf1;
> -static char *qrbuf2;
> +static u8 qrbuf1[QR_BUFFER1_SIZE];
> +static u8 qrbuf2[QR_BUFFER2_SIZE];

I am not a big fan of increasing kernel size like this.
You may run (faster) into boot loader limitations.

>  static struct z_stream_s stream;
>
>  static void __init drm_panic_qr_init(void)
>  {
> -       qrbuf1 = kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
> -       qrbuf2 = kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
> +       /* best-effort allocation; can be NULL */
>         stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>                                    GFP_KERNEL);

<ironic>Why not use a static array for this, too?</ironic>

> +
> +       /* touch memory so that pages are there in the case of a panic */
> +       memset(qrbuf1, 0, sizeof(qrbuf1));
> +       memset(qrbuf2, 0, sizeof(qrbuf2));

Please clarify "there"?
In cache? Not all systems have sufficient data cache, so it may be
evicted at any time.
In RAM? AFAIK kernel and module memory is not demand-paged.
In TLB? Like cache, it may be evicted at any time.

So IMHO this is futile.

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
