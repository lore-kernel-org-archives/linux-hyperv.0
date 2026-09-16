Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE228852E
	for <linux-hyperv@vger.kernel.org>; Wed, 16 Sep 2026 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551007; cv=pass; b=OEK1uo9tTXfRLiB8V4LJEgWlDVJvuHoBz+2bYCxoF8XRzG0iwgLyI5OCR7kf/flLKG2QBCOa8NWQiyGJCfHvqGq4R5c8czzmzl6audyznTC5wofo4YrdH2qZjO15hkTrSjfc9hP0wNtIwmsd5GsG39C1RigMeE6cu7DpzJZgGAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551007; c=relaxed/simple;
	bh=rVlNPjI4P2z37o7qE9/JXBSWEwGmZChcHXGnM7D9n6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6itYEVudPdwvkGfQtN1L25BwJ5u4H0XTmSkUTRqmYqPrId1J7AkawSMoW0JNlNFS8W9tWvFgEK1XbhZMN5qUKnyRnKdT1LcYgSDuJQo1n1r0isAEb981OQedbon3KNPes2Y43dDij6UrXbpf2B/COfSkF4ROAzEBe2RnIWKI8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCaIdDCy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRnBBIGW; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCaIdDCy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRnBBIGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789550997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
	b=YCaIdDCyoE93yZmBAfESVoajo49TPwa7hyUImgklXjgAUauE0Chzl86f50GNoG1YHkECbX
	uKOo7D/Pns4ekjXFNcSGeDA73JAlN9XoMn0nntR3B7692bbvQVsqyPCtGxslQ+DCgKEJnz
	UEYk9QAiKvMY6GLKrQa4HtfSFvVHLhs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-CDoXXIcCMo-xJXfeNU1lQw-1; Wed, 16 Sep 2026 05:29:56 -0400
X-MC-Unique: CDoXXIcCMo-xJXfeNU1lQw-1
X-Mimecast-MFC-AGG-ID: CDoXXIcCMo-xJXfeNU1lQw_1789550995
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so21891455ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Sep 2026 02:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789550995; cv=none;
        d=google.com; s=arc-20260327;
        b=NuxFu+vTr7bHPtODKcUKDK+dVEA1L2Hcr/zlxCgV4Zs+G1YUbS79EFNsCp3VEaximn
         Ev4NYRFblEBLfkQY9vDl45xb/G1Tae7Ubu3NmA1R3bNRRDdgCIO4asVgKtS5AfBJBs/q
         nqfVTn8sCRaH8yBxcDLKifroOoxZFaurOhwVH8qaG7dMgiz42qOD9yJBVzNqx1b65cGh
         UgoardAGGx+9CJGYPp08KvpVMlqjPTGEjv7fOZ1mgje/26ONORi5Zpq2rxEFelJISLyQ
         8zXuRCtiazaBwdaQNPJNoRMjcATZNjTr2e84Yza4UrSqrZIGPZhQgkD4PTziCxL2B/S8
         9+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        fh=13AG41wfI4AH1D19CE0piQhSGFdaF1d4qfPfBqMUDEs=;
        b=aHHMSbg6jQkRY3XgxR9lpZQLY2yczHa7JguvmHuxVQfOGPz5B1iujUoYxDIkE5qPk1
         LsUMHPA0jn/zrgxlO0Xvq0Mk13GFjQvo+fIG+UoIXtbftDERah7ez1Lb1PXcqKv6L/ZK
         EZBjywt1tvVIgbO7klR7o16olfMIU9Tt6jlFQ+BmB7P77719EmB9vOYRTsIREP7XI/9F
         xcMgu9jBXo1ifGstDDQhCwfHgGsxfe+fxkNpq4fTr07hqfeDj3wW3Me7cPV8tx7FaGRa
         aB1UnhbWmhS2UVjEMTvk8mE87us+Y39qhvZpQ6SvJE3GZIPBpfMmOwTsWpoWR9S/8/1U
         FDiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789550995; x=1790155795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        b=WRnBBIGWZwHMn0ZjkwESc0vAF9AHz6MKg5a+Le6ugPl2SpFowsXuhEonCafP6F+ZjS
         W0qMM4kk5aqErx/gFDyI3fCZvELr9KMvk0bjPR25BsIwqMIPUiCxlChn6VbCIGc8Hr8x
         P/l7JkuNt+enKPxChzh6cIms67RaPlFkSL/Z066e2tEsw+Uwc9bnKUAAbowsgS2leZRA
         OgzKAvyMwJprx4UXVctmV8jAdbojb3Py6EnFTTziuHf4d+aVJMrjh+5ZCUuLooOyDPkz
         pgiYOkdl6i/0sf1bBnzYeUh4vWE1OorhRxF4143F35mg7tBnNp2s1cEAK0jCLZDswaS7
         lZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550995; x=1790155795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        b=xN08HgAjtHfcoBENSTA08Ni5AkuWuEcVprsDgBjqrnRAqJey5QaluNx3dsq1ut610o
         Mpn3PFkU0SO3BCynoX64dqg5BtpP05RHEED86CDK/S7j7zuF/zupBY1WRjBtGmLLE7Gy
         NnHlHoWSsB2ew4CiMKm1XLuP3rT/3bYbxRsGeqdYTFEE92PGM5j3i0kHqmSyRwHeDymW
         x9fYByWuGQog0z5RFbfVs6/6SXF2ytxocYdTDHSvFDwno0cz5ihpyCm62f6WsjOq9OvC
         OvGgY8Xkm3EblElQ4Bn9sf70dfU5ANIrguGEO5kMpyhYyOT3oCLMGGJeWTEw2hMHCODR
         6FHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwG5xXc3dr6uyEkqWOOW2XQ9yzzWg6q4DtzdjvkurnXKrjNU3FTFn9PZxqIZTwznPcP6s+Y41R3EMLn7aw=@vger.kernel.org
X-Gm-Message-State: AFuF++lYHX9JEtbZEZTYl7si8EfIDgAEumBKHv5gpF0c6Y6oSLg0vboh
	Krc938Dmdybe6x9zkevF8TRr6dnH+QGWumpHV7y5pc6XrVH9fJyT2NbUx6fno+nyM4nQw4KDYC5
	6wTXp/s5QJNISLkyYU/cA7Rk9t0fKE7NcSocUqpMhbAJpeNvPQHH6uHL2lGSlYctCuQoqnwDI7Q
	DFVVMgtSjZnYsj+k+dGgD3Un3/hYUyv+hyO8VhnHza
X-Gm-Gg: AYBFou3Dsfv5J3yOITZueHV9MAYvecx6a8N3+VberjcoQit25UMyjYTmNyl51/ewY2u
	ScmzsXBuFFp9Uu+ppEw5a3gbnEFQsRHAzwqNCjziOnvFsCrsKcyyWvBmROb+VVqvCMS9s5iK6dF
	KT7Oztt88G9SFEesesI23mOuiSxZUZe3u95/he8ebYxMaQp1qITjLwaoTJ
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id d9443c01a7336-2dd8ea1cd1dmr23798575ad.10.1789550995049;
        Wed, 16 Sep 2026 02:29:55 -0700 (PDT)
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id
 d9443c01a7336-2dd8ea1cd1dmr23798155ad.10.1789550994573; Wed, 16 Sep 2026
 02:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911124540.279841-1-tzimmermann@suse.de> <20260911124540.279841-3-tzimmermann@suse.de>
In-Reply-To: <20260911124540.279841-3-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 16 Sep 2026 11:29:42 +0200
X-Gm-Features: AcwNN1VjQRR608PaSU5v9yXg9eP7o3aE9lu55JInhqrDujLUhvS3kxSMIUXF4N0
Message-ID: <CAFOAJEfWX09ZvnQvn1+SBeW4_MaSRO2JNLfoJRGYS4jXGr-09w@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] drm/panic: Test address from kmap op for NULL
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, airlied@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Fri, Sep 11, 2026 at 2:46=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
> not likely to hapen, as the previous page from the same memory area
> has been mapped successfully.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 23437509a694 ("drm/panic: Fix 24bit pixel crossing page boundaries=
")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.18+
> ---
>  drivers/gpu/drm/drm_panic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ba21df4be338..d28ce8878e05 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr=
, struct page *next_page,
>         u8 *p =3D vaddr + offset;
>
>         vaddr2 =3D kmap_local_page_try_from_panic(next_page);
> +       if (!vaddr2)
> +               return;
>
>         *p++ =3D color & 0xff;
>         color >>=3D 8;
> --
> 2.55.0
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

