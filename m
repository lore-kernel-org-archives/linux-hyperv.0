Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC51DDC38
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113143; cv=pass; b=irMa6iXjyIarmwnNux4r8xZMb09U+DxfAzAvbn/PvMKiFP+0ooPCzjHqzhFdr81pxwFVKjgfrZlgp+IyMAhKxdEVLTdd96Q5bvwecl/O7IZ7qq5sE8vTek3WUDrdO4LRc9qcf8FVR01iKQbZ7QjrNl8ye4sv0NZG4rCWn6csoT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113143; c=relaxed/simple;
	bh=gfLrtnYHtAHil21EUR5tpTJU41lF+6+/i8EyMLUx65E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSQvi881N95aNipFH5csGbb04l5UuDdTmOYgG3IOX1OwVtPZAC9tZw82RVCbAjIEzSQUF3tzHnNKCVsWpbFbyfBp2OXkoovsy/s8d4k1q8K0/XcG/GMk2wToQhyo+SADEGQ8s6sS7yOw0w+v5UeUWKWI5Gp8a3sucRaPTCu0RYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBDHv3Q2; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBDHv3Q2"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3015423a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 07 Aug 2026 07:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113141; cv=none;
        d=google.com; s=arc-20260327;
        b=SS4dKp6AkDV7qGHxeLzpb+3tnRyoI4AW2/x24ZA5PioXJ6y6kuZoFEw0QuSUVQNdCJ
         zznn8TlLILWUNyZRRz03gsXyqyih7Y1Epe8n/wP5L2IoOPKIIYuB8+lxMYsn7UmpjWMP
         HESvEnOcvacF3G60TI0kjYCemutKE8xmUWuR3GmAzyAE7twxPqwKSMmRbRahjSv/g13o
         YdZdlPGNzEgygkj6HEoJnFwclJGCMqSKAVlhUOpcwHky8KgIYZmrqgPrqLFA8DvjhdzT
         NOI5y/BJhDx87d3MIWRHoP8sOIYY45LHyRYxsKhnKc0HB7VQMCG4tKoffxTXWDPfNqJS
         58OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sv0wzFVrpr0XCB01951zmfNbZfYZrI7iB5XnI+P2fOQ=;
        fh=E7caaUpm/eDDCgKuJcxelQd0qQJwHWKANrCQvVef1/w=;
        b=T1Rx+nXXtIb/28l4aRgSuisD9VIAqnxlcraJy5JH44tDTqMJcMkcu7A6vnHmDqUZ7H
         MDoUHh3CboN5ecrk/CKVpIzGusO8hW83wpAC2ouHhc8xdXO/OO6rJ17wfB5HPYeNjCp6
         B4mhu7LVOeaOlttT1ecjLM1nmKYEBBJgoA2xgNiZRR6CZ/zIrWHXYinu9hD219mp7dA1
         BYOBE0ileCOzEFPM9sC8i0pRORxd4Ouwy5m5O0tHf0OyhDBsEcpkAR0pu86OjC1N9RWY
         i57xb45nxdGfwBRT/ms8ET/ibirZfKy2d9dLirB33AySPe8H7xianyXJIQ4oq69rWy4Q
         oxkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113141; x=1786717941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sv0wzFVrpr0XCB01951zmfNbZfYZrI7iB5XnI+P2fOQ=;
        b=aBDHv3Q2P5QnhhzKPu5XfDgImXgQ2v8tRtPELHd7HJ0rvb3erx/lUKAJIXAMIdIfsp
         BCpoktr7R2pzzv8WCspm1qpgCp7y+Ce0YGDsEP1kaa1hYcbg4w+sUqKVp/OLh3bhPv3I
         JWvOSIfJmd7k1yGW4amlaSyWpVPJ1ZFvLGwH3oR6G/U9zDcT+KBKQfJ17zhuUsrBpa7t
         wOgOgntwTstFwIVZEpk7OHixvc7kDmFqJ9p15KXeIpn9cVNOQ52qTLEs6HW7HELNpVOb
         yZp0nNWhZCDKLT6fv3uKmgdmvnzUt1MZp9qdy/hoZzxOIdsVKoA/aw4JB+wefH5GJlAj
         oIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113141; x=1786717941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv0wzFVrpr0XCB01951zmfNbZfYZrI7iB5XnI+P2fOQ=;
        b=ZsBnzfJaJykcq1Ao5/NhHTq2FBZiRt58+LMFjDKYdTM77gyfUekQa39Js0FGpFL+rf
         0Z64RbMbV+W10MEt8Gy1GJxc5mXDXqx6JgkpvLRVCJ2p98gSBl7pia7MuSsFy1XVOfA+
         L/ueRaP33FAfrXdjwPKkGClnRgrBOyoSTtmL9RreXdoiSAIGDzjK4RFF6T2Zq1q15XGc
         mIf6fSB9E41ARjn4aAg1wchDCQ2kGEqedg0rWTc8JJTiRbW1hdljXezC5iQq5h9cRkRy
         Okhsp6U8eo+/XLhn3uzKR5ZTuumAme4qKCG4YDuZEJie8c8NXtNsnVBZ6uEJuRnCdmk0
         fZhw==
X-Forwarded-Encrypted: i=1; AHgh+Rr4eXmw59n7y5Co/ZYX0YoxASLpvyvGEIs3HoqcjDrcqmkGJYh6MQqspgublJ5uJrsxHgT6dO2rhkeqK1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUN3RZyCmQSQ4ygw8RBIMxNEWDLEANfUA8t5VoIFj4uWuW653p
	gkyT60WMnoAqOAKJ16lQZqXZm5ZxODH73BG9gK1A3m75M0+47vWh5Sxo9oHHtM5ep15Pk7KNwmb
	SfKey22vY/kTNhpbIlr330YSKJMkY9Yw=
X-Gm-Gg: AR+sD11WM0b1a5c6Q0eE2CcuhEOd+/DetA+36iUHdyMCtyaxey784IxMpdsvfwjNtgQ
	jB7+hfkfpJ7vIve1PfM+7Rd/4ft/KRsvPzM8IilA2CUsfvdVAX/7rwUStOs8XJ/s1IqlKB+rZra
	Q7pL49XqS10xTTnol5UiftKrDaM2c8AzyMo42PWvnJlFxdXLhv/TQTnTPxkwh9T/Ftb4MuhuPC9
	B1x3nfaJzGbCfJFGgeFIZTgs2RI30br1NuoT8c8Vie2jxY2mSe6RPSs0RCboDOCuFRORc/bGWHV
	KEgcnErrRTgjj5Pqo9Oq1FF4JHk6Sz1GoJI4PhYi/CGSKzbpyXneYcMOzTTIm2k=
X-Received: by 2002:a05:6a21:10a:b0:3cb:b5f6:43d4 with SMTP id
 adf61e73a8af0-3cbce8e53f4mr980699637.23.1786113140670; Fri, 07 Aug 2026
 07:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803033520.12930-1-tiala@microsoft.com> <yq5a8q6n4lsi.fsf@kernel.org>
 <CAMvTesAh=3r2ZgVn6Ka3fdj6fiXhKAnuKCcU6NkvbjMJfPobSw@mail.gmail.com>
 <yq5azez03mi2.fsf@kernel.org> <CAMvTesBMjFY-W0=uytdRcp8EBhaXB3-X4tFVErxuzGcFwcX=Ew@mail.gmail.com>
 <3abb072a-4ce1-41d1-a20c-e08f7c594c91@arm.com>
In-Reply-To: <3abb072a-4ce1-41d1-a20c-e08f7c594c91@arm.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 7 Aug 2026 22:32:03 +0800
X-Gm-Features: AUfX_mxh5hqMFxTdO4cbTmWgjGxa8dgKvgkK-tB_Qx9ck8lhTcy_7Ass6aNiaK4
Message-ID: <CAMvTesArYucCT-_+29zcGt+xLDnef_BwX_xK8gUz33YxJzQOkA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory in
 Coco VM
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com, 
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aik@amd.com, hch@infradead.org, 
	vdso@hexbites.dev, mhklinux@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:14=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2026-08-06 3:21 pm, Tianyu Lan wrote:
> > On Wed, Aug 5, 2026 at 6:11=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar@k=
ernel.org> wrote:
> >>
> >> Tianyu Lan <ltykernel@gmail.com> writes:
> >>
> >>> On Mon, Aug 3, 2026 at 5:04=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar=
@kernel.org> wrote:
> >>>>
> >>>> Tianyu Lan <ltykernel@gmail.com> writes:
> >>>>
> >>>>> In CoCo VMs, system memory is encrypted by default.
> >>>>> Device drivers typically rely on the DMA core's
> >>>>> SWIOTLB as a bounce buffer for DMA operations, providing
> >>>>> decrypted memory that can be shared between the guest and
> >>>>> host.
> >>>>>
> >>>>> For PCI devices with T-Disp support and Confidential
> >>>>> VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
> >>>>> perform DMA transfers directly with private/encrypted
> >>>>> memory in a CoCo VM.
> >>>>>
> >>>>> To support DMA transfer with encrypted memory, Hyper-V
> >>>>> DMA ops are introduced and bypass some API which may
> >>>>> use swiotlb as bounce buffer.
> >>>>>
> >>>>> The DMA ops used is global data structure(see get_arch_
> >>>>> dma_ops() and get_dma_ops() for details). There is no
> >>>>> need to set up for each device individually.
> >>>>>
> >>>>
> >>>> Can we use __DMA_ATTR_ALLOC_CC_SHARED instead of checking
> >>>> hyperv_private_memory_dma(dev) directly? Also, would it be possible =
to
> >>>> encapsulate this logic in something like force_dma_encrypted(dev)?
> >>>>
> >>>
> >>> Hi Aneesh:
> >>>        Thanks for your review. I go through your patchset =E2=80=9Cdm=
a-mapping: Use
> >>> DMA_ATTR_CC_SHARED=E2=80=9D=EF=BC=88https://lkml.org/lkml/2026/6/4/58=
8). This patch
> >>> is compatible with your DMA_ATTR_CC_SHARED attr work in dma-mapping
> >>> layer. Once dma ops callbacks get DMA_ATTR_CC_SHARED attr flag and
> >>> it may use the flag to replace hyperv_private_memory_dma().
> >>>
> >>>
> >>>> Looking at functions such as hyperv_dma_alloc_coherent(), how does t=
his
> >>>> differ from dma_direct_alloc()?
> >>>>
> >>> hyperv_dma_alloc_coherent() is to allocate memory and returns encrypt=
ed
> >>> memory address directly when hyperv_private_memory_dma() is ture.
> >>> This change is to keep all changes under Hyper-V subsystem and it's
> >>> also compatible with existing solution which changes DMA core with mi=
nor
> >>> changes.
> >>
> >>
> >> If we update force_dma_unencrypted(dev) to return false when an
> >> encrypted memory address is required, wouldn't the existing DMA-direct
> >> support handle this case? Or are there issues with the existing code? =
If
> >> so, could you explain them in more detail?
> >>
> >
> > Hyper-V Coco VM with T-disp scenario is to run a paravior(lightweight L=
1
> > hypervisor) with normal guest (Detail please see 13.2. OpenHCL Architec=
ture
> > https://openvmmdev/guide/user_guide/openhcl.html). The paravisor is in =
charge
> > of talking with hardware to accept PCI devices for Normal guest.
> >
> > When PCI device is assigned to normal guest, __device_cc_accepted() sho=
uld
> > always return true for this device.  Then, DMA core will not use
> > bounce buffer and
> > unencrypted memory address for the device.
> >
> > However, __device_cc_accepted() is based on TSM framework and Hyper-V
> > doesn't support it. This means normal guest will not use TSM guest driv=
er
> > and so current code doesn't work. It's necessary to introduce an API fo=
r
> > platforms without TSM support to mask the PCI device to be "accepted".
> >
> >>
> >> Can we rework this patch to use that=EF=BC=88DMA_ATTR_CC_SHARED =EF=BC=
=89?
> >>
> >
> > I think the change is simple. The issue here is how to set the attr fla=
g for
> > platforms without TSM support. This patch is to make Hyper-V T-Disp cas=
e
> > work without changing DMA core and PCI layer.
>
> I don't see why Hyper-V would need to change any other layer. We're
> proposing a generic notion of device_cc_accepted() which requires the
> bus code to decide what it means to "accept" a device - TSM will be
> PCI's standard way to do that; meanwhile VMbus should be free to call
> device_cc_accept() for whatever VMbus devices it fancies. That would be
> this patch done already.
>

Hi Robin:
      Thanks for your review. For Confidential VMBus device, we may call
device_cc_accept() in VMBus driver code directly to mark the device "accept=
ed"
when it's enumerated..

> And similarly if you also want to auto-accept PCI devices via some
> Hyper-V-specific non-TDISP mechanism, I'd expect there to be some way of
> doing that from the pci-hyperv driver without needing to hack or
> reimplement common code.
>

For PCI devices with T-Disp, Hyper-V case will be different and the T-Disp
code(e.g, TSM) will be in the paravior. So it will not run TSM code in
the normal
guest. I think it may work via registering a PCI bus notification
event in Hyper-V
PCI driver and mark the device to be "accepted" when get a new device event=
.
I will have a try.

These changes will depend on "DMA CC SHARED" and "PCI/TSM: Core
infrastructure" patchset. device_cc_accept() seems to be reworked in the
latest TSM patch.

Hyper-V dma ops patch is to keep all changes in Hyper-V subsystem and
may combine with "PCI/TSM: Core infrastructure" and "PCI/TSM: Core
infrastructure" according to the upstream process. The dma ops call also ma=
y
device->p->tcb/accept field to choose bounce buffer or encrypt memory.
--
Thanks
Tianyu Lan
