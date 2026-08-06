Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0FB456DE2
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026099; cv=pass; b=m3JQOhE3iOogaodvSBQm1pvuT3AdmujhjGV2fjkBYQcU4RaHxnzbS/NDFwc7JEUiD/R5oWimbht+hPP7k0ENI9tsSwNHJvwFiUKQJi0bfq1e2C4KPN19zxbu7Hzkg/feU3OlQcoFI4iIRrw9fpe++zloJR0N1QB36CAg+uoLGj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026099; c=relaxed/simple;
	bh=NJnlHbx5ums/pHJwAfA5NJTgMLRPgRhJttyosaU9C/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyGqjl5h7jhCg7ZOM9XK6ZRsXpELHoUTvsdux/hNLRaYlFfVXTaghxDJkiT6lxHgCpniwbBycEc72YMDtbu1vFzb/bCECMeQK9moh3fBDQQ6kZm0Ws2qPhEIhHV2h0PuduzDj61ejnddlyekHalIAbXsIOe+qa+voCcN1c5hDY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayNnZZz7; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayNnZZz7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso12891905ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 07:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786026094; cv=none;
        d=google.com; s=arc-20260327;
        b=D9fsByQynCp9wpo9iUf00RmFZyX7qEZUkyhaQFHpTq8QMmMmWIHGpQlvUYnIiueqwp
         8LWP/yn5uolQ4PGrP+qp7m4vQ/ImESe7HhsRGeg4g8q9+d9xqL66OdZP9ISLQ25RWgRJ
         c6Hg9aYuwBD5mSrDlxga0t29KCNCcUXCqOXniJ9X4pjlBJLD5qmBaBTA0enBz3D2EMXV
         C8UtHyNY8FXmNXhRYd8kQQ9Kd9hdAiM02bAd9WYvazcLVD58Ecpu9P3wkuYSDR/SOjib
         SRiPt4gcsjwti065odjzs2/a4I3vPz+Zvy3CvRxDSLKGCqYu78rWuPxt143w6gE6ZT6F
         ZptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tU9elFcDpyxIdODPTvVkrO/Vu4r00Ip0OHxuEo5dL5A=;
        fh=TGSZGnwbCHZOIn6JTARvm/rQkZEf7HlSOLPjdO1X3UU=;
        b=aLxLSCdxUuJ+0MTWJSw7IuOMRqwFCs2BDj6f/9c3lXOkd1ChuVGPXZcAq/8A8hG/SY
         07f1Bb/whrDAv5u8dxkMofA4VGh1BNhNp1RXYxj64DynI3OZvZg520PI8Krr+huhDdh1
         s8VKWeYhljXlIPg9pRxqvm4LRYouP3iqy3xk4vBysR9HmKDbyFOHMj+/A01jOlrwic7p
         rUKM3bs2V07ItLN+0arKftl7A0dhbx8vtrylmQ5uAd3vkL+klKdKTO5mUkj7DFBg9kb9
         pMJSF83IxYCCW+MMoZHAsbRpGa1zWQyBOES9Y5QXdV8SDtjY1eHwny4HqqZgPXhECp+Y
         Kr4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786026094; x=1786630894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tU9elFcDpyxIdODPTvVkrO/Vu4r00Ip0OHxuEo5dL5A=;
        b=ayNnZZz7kgzas7e16+bk/22s+c3X20TJIJskpwMR9gjlyJsyy3JcIK4ZmeBBabaJI6
         lsO8HDuSr0XtP9zGZTUsi7BUXsX1Aw/Y1iUu7AR64PD1h10/VBxCNrR8qdy0hns+YLQ7
         /yREuJlBrlFFLdAqgSJHf0lsT6kLp7ld3k73w6dOpDeZQEIOUgbCRTD1gCOFCYVX4Yll
         ZlTiKHbLMEiiWANxV7PbK8DHUmB8rps0wHigjlSYyYBT2bPJJQ68S3wcArmHURZpOaNB
         qUPToVIQYMstBBonLOcIB6d6oLnsdPXPUasJ7vhcEjq137cHaTSsfUM1wgbQ7PQ0tYk2
         /NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786026094; x=1786630894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tU9elFcDpyxIdODPTvVkrO/Vu4r00Ip0OHxuEo5dL5A=;
        b=PtEEelqT40Ih9Q7GQBrYoNCLQjWNHaBjePfJ9NpQIuoLARtaNz9yIW2481H7Xey2fr
         im0Ki6yYoz3nJrdxq+lrVoGJSprOjRHpACIhEQwOR3+RBrEXvhaCBgI0IfEFeCFxEAZU
         060NTjnPUQeNAkdu7AgcMHfSdcRa3ByoUDJdQ8F4akuK+O7GCjbMvalP0Qw3f/ojc6Dj
         WC673kgffE2l5aqSblgZfJtsL0jKeFUaGI5NfOBtiyg/Q4ymAWMGO0N9Co+OOUP0fT6i
         US80c0lvWziHy4u1lIq2xWjgXiwmVP7olkrB34skaJFbdy/PuK6ZkLXsVWqGzaohBZc5
         cZeA==
X-Forwarded-Encrypted: i=1; AHgh+RrM6gYda+Dny0SdVNE68v/sVmQYcktCEWEPICtmxLauy6UewORDjIjjjTTnOhC9aT6wDKXQOndertn1v84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtX7de1B6JRWthB7WeFKAmPzYc/QHeDLZciY+/rk8+HVbBFGk
	4OzH3VQw26Q5raWc4ii5gn0Nf+4nANJd1OlqlbXsDcOeH6bqT0gpsyj45+XYTrrxgNRgnQtKjIX
	cn/kugF/F0cL/D+U+U+Y5KGiNglKtq28=
X-Gm-Gg: AR+sD10VjifVx0SWtYCqNjCUdIeKGRwxWBUIivn9K8N3ADQV4DSht+2WFl/K7N5yna6
	HrjaNEoaxagYd4nYuqWczVhKAMBVPtP1uDYpc2CLGGXcYu2zHmqg4TN925abxuD40oJiWw4s162
	FLuMa4UhVHSjYegSLiYX4Ubc1AA0pfNcvbZsWfUdOq2K4Pts64eq18AAzIza0YeUuzDfZzZP8kj
	cHDVgtpAD8/0xnCDJeOuyPfq5BBo4H7u4hAtgWMeguebERvDFflPJX2v3E65YjI5M2p3U6usD9u
	ncIDQdKNtwr3GeGHb4SekqbqOEz3OtetYh/PiLtgdjXc
X-Received: by 2002:a17:903:3846:b0:2cf:6e5d:23e9 with SMTP id
 d9443c01a7336-2d0f1c5f19dmr88794635ad.14.1786026094159; Thu, 06 Aug 2026
 07:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803033520.12930-1-tiala@microsoft.com> <yq5a8q6n4lsi.fsf@kernel.org>
 <CAMvTesAh=3r2ZgVn6Ka3fdj6fiXhKAnuKCcU6NkvbjMJfPobSw@mail.gmail.com> <yq5azez03mi2.fsf@kernel.org>
In-Reply-To: <yq5azez03mi2.fsf@kernel.org>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 6 Aug 2026 22:21:17 +0800
X-Gm-Features: AUfX_mwWcY4udzCdg_P0pjSjlRie8YeN9QziDmnhZsZzySlwom1xoAKYvE8Qi6g
Message-ID: <CAMvTesBMjFY-W0=uytdRcp8EBhaXB3-X4tFVErxuzGcFwcX=Ew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory in
 Coco VM
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, Tianyu Lan <tiala@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com, 
	hch@infradead.org, robin.murphy@arm.com, vdso@hexbites.dev, 
	mhklinux@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:11=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar@kerne=
l.org> wrote:
>
> Tianyu Lan <ltykernel@gmail.com> writes:
>
> > On Mon, Aug 3, 2026 at 5:04=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar@k=
ernel.org> wrote:
> >>
> >> Tianyu Lan <ltykernel@gmail.com> writes:
> >>
> >> > In CoCo VMs, system memory is encrypted by default.
> >> > Device drivers typically rely on the DMA core's
> >> > SWIOTLB as a bounce buffer for DMA operations, providing
> >> > decrypted memory that can be shared between the guest and
> >> > host.
> >> >
> >> > For PCI devices with T-Disp support and Confidential
> >> > VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
> >> > perform DMA transfers directly with private/encrypted
> >> > memory in a CoCo VM.
> >> >
> >> > To support DMA transfer with encrypted memory, Hyper-V
> >> > DMA ops are introduced and bypass some API which may
> >> > use swiotlb as bounce buffer.
> >> >
> >> > The DMA ops used is global data structure(see get_arch_
> >> > dma_ops() and get_dma_ops() for details). There is no
> >> > need to set up for each device individually.
> >> >
> >>
> >> Can we use __DMA_ATTR_ALLOC_CC_SHARED instead of checking
> >> hyperv_private_memory_dma(dev) directly? Also, would it be possible to
> >> encapsulate this logic in something like force_dma_encrypted(dev)?
> >>
> >
> > Hi Aneesh:
> >       Thanks for your review. I go through your patchset =E2=80=9Cdma-m=
apping: Use
> > DMA_ATTR_CC_SHARED=E2=80=9D=EF=BC=88https://lkml.org/lkml/2026/6/4/588)=
. This patch
> > is compatible with your DMA_ATTR_CC_SHARED attr work in dma-mapping
> > layer. Once dma ops callbacks get DMA_ATTR_CC_SHARED attr flag and
> > it may use the flag to replace hyperv_private_memory_dma().
> >
> >
> >> Looking at functions such as hyperv_dma_alloc_coherent(), how does thi=
s
> >> differ from dma_direct_alloc()?
> >>
> > hyperv_dma_alloc_coherent() is to allocate memory and returns encrypted
> > memory address directly when hyperv_private_memory_dma() is ture.
> > This change is to keep all changes under Hyper-V subsystem and it's
> > also compatible with existing solution which changes DMA core with mino=
r
> > changes.
>
>
> If we update force_dma_unencrypted(dev) to return false when an
> encrypted memory address is required, wouldn't the existing DMA-direct
> support handle this case? Or are there issues with the existing code? If
> so, could you explain them in more detail?
>

Hyper-V Coco VM with T-disp scenario is to run a paravior(lightweight L1
hypervisor) with normal guest (Detail please see 13.2. OpenHCL Architecture
https://openvmmdev/guide/user_guide/openhcl.html). The paravisor is in char=
ge
of talking with hardware to accept PCI devices for Normal guest.

When PCI device is assigned to normal guest, __device_cc_accepted() should
always return true for this device.  Then, DMA core will not use
bounce buffer and
unencrypted memory address for the device.

However, __device_cc_accepted() is based on TSM framework and Hyper-V
doesn't support it. This means normal guest will not use TSM guest driver
and so current code doesn't work. It's necessary to introduce an API for
platforms without TSM support to mask the PCI device to be "accepted".

>
> Can we rework this patch to use that=EF=BC=88DMA_ATTR_CC_SHARED =EF=BC=89=
?
>

I think the change is simple. The issue here is how to set the attr flag fo=
r
platforms without TSM support. This patch is to make Hyper-V T-Disp case
work without changing DMA core and PCI layer.

In parallel, we may co-work to add non-TSM platform support in your DMA
CC SHARED patchset and "PCI/TSM: Core infrastructure" patchset.

--
Thanks
Tianyu Lan
