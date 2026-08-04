Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFC40A940
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835371; cv=pass; b=TdPDPiQhBcmmWmruOdKaKf4KsNoOE7j4gQNOn7qPATRqHSUFh3oWugP4PBR9+q/xqUz0Jj3NfRzomvUpKU34zDr8U1IiwM+AgLbW7LznnO6rZxE7qqGWh3lV743aiDYzICsrUiuGf3szcEmWgW9DcsLBRrWR3AQup10bUai65LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835371; c=relaxed/simple;
	bh=bIeRI4Vbg4UNC/ELndMwUAkfW8I6u79Gt5Q/nQ26i0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgErdfMq8gufB0PkczKczIZKNGQxM9KXpGqep/izy2ZCPQgeQDX1i0NCcFJbfJ9aOQ+rwNqb4otjhwUxrvUmbrQF87bwYb2tncrfyVt9yCmczGgcyJQlZMHHZK5lgTUA6giPM5yWdl+6pJixmLshntixspX2aBrPlRihX32S25M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6O4ubTX; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6O4ubTX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f620399a0so3481184a91.2
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Aug 2026 02:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785835370; cv=none;
        d=google.com; s=arc-20260327;
        b=EsF51ZCMVhyqoCQzUQ3C9LeHpU9nUBHl3qWRbsgXXP6pSobiLljXCY09AnqTBpxdBe
         xMxolUdvsxSPvA+op6RVG6FXB9khc7vO1byepaUPGLhUByJ+gNjj42EZ22Luoh1GTw68
         FMxstB1qd7f3ccXkrycnvWYAueazm4WU4r77at8FWFGP+A124aKvOKNbQ/bvqaINKQRX
         7ssYOXUp1aqSgTrl9k4EQAP0yApjXKl1t6/FVi9ftngz5P2BrshdRHC+/Y6SE/DMqL2H
         wV+a4qq0q1UhzZ2nca2CUWYDhPA7a11rY3d5DTYK8sNgT5puD7XwOsHb/RqdKtXq5mFs
         5ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qarJ9JE6x0oUK0k81d1N47cWzh0vg4/Xy/QZ2WFGxXA=;
        fh=QKaWiiXjFXgZjOpaTa2vcwy+42rIt+76//H6lcgZglU=;
        b=MstKSnKESSmxG+S5btop6Lgqe6HCYsDfMXZd6YwbRxXjbVmw5O0y+tkZEZGp4h4+8k
         oOCePG7Mnmo4VhoOKk6l/fhvh7xGZS4hIoBc+s0p0B+66LtuKAz8yOkXOO++UB9EYX/a
         ZwivwHpkCOw73uJR23dJfWbEhRN4WwnzaSD+pDk5/1YcRogjafzwVviv2SG3DwDZWznT
         MjA+lnT3RfMQAocNMIH9eRDtkfLD4O9qzbSTHo5vlFyDjpVUuIYDpMNG6QiHBI1oA0sE
         cxULhzTz9ZvCmLrDBtoWK+8nH04g3GV0slC1bxMsr+idlsMQw/9K0SYYGftCOAudJ8a+
         e80Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785835370; x=1786440170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qarJ9JE6x0oUK0k81d1N47cWzh0vg4/Xy/QZ2WFGxXA=;
        b=J6O4ubTXlxb5rh6XbAA3VRr0cgfAJ6mQczJCB7mmtL+EOkWTBw+khw4ccCV8ydYSEG
         ox+wbc6kJCkb217KlEcjDbS55fp/oO6ZbfjzwrmE6PqsyuZ03VEpJjGtbTtQ6Su6YDpq
         cROr8nu5qBOh72VXCL2Lxp0++VUgUm2byiTD+tgk68wkJH7gLE+XFOxg7Bs4rt5idjs+
         jl0LM+k/Rg1PczlfGcRuI9EwdOaogPwQ8bFUbtBRttdzna2k0djr/kVirUqL3EFgV+Cm
         Qua6MWyutPQHl52FT+1rBM3BOl0ZhsA7JXf/wabJiQJtu9X8LLHvWPdYRTWrxAbtlEPN
         xlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835370; x=1786440170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qarJ9JE6x0oUK0k81d1N47cWzh0vg4/Xy/QZ2WFGxXA=;
        b=ZGCCdciEXNLhpr2CXqgzi5psj3ZjwEHiLt7ph0xqWXtzvoghswcJtO6qCxX8eSitqZ
         DMdCfJScFUkm50WPnTqM9/l/xqKdlGcXb4nzuqPxowGX1XeJuHfKEvfzjRWsAfTdrX/0
         7+P8tuDCwO3f4XfZQhju341r3Jlu3yTJq8Lz1wb1BusafRbQUwPXgHdIjf7W5kFDqXPo
         LIBjaWxpY/yPhP8NCbaURN6oS1+9I9TjiAs/w+YxIqGtgwpEvoWsK5H6mMAP/y904yxD
         SYN/hzILlkSd9Ep8/wq7lyUPq9ryZICn4pcHY8uuv5xYUcVCtoofes/OYszD2KgxtyF2
         qmog==
X-Forwarded-Encrypted: i=1; AHgh+RpA5XEB85KFyf+7xVrXoP08FqTGIpH9uZIRGmWZB6ttx1zvnItfs20cIjqzM84+sZleCFO6v9n7GSTNvAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZplEWOy/6shokBEtRulh60V2Jp/xo9oizqAEB/stZMX8hgKfK
	FfRcXcoiM8Th1CnFJskPaMP/HSEUvMTBTP++AbPalyBHGNS4pzsT7XMF1d3EORvzvqtniad2O4n
	hpqp93uM7pU45FY8xnteeSwR3vT9MDso=
X-Gm-Gg: AR+sD13dwGScPbj5T3tfelXVNcod3rb4LInufm+T4OwtlVOtaiQPtLUbIXJkerl7aNH
	QCoUnFaUPdq/3lrMs3SbpELQGVnKkrSzk8EmQjd31ADSPFyr4bwCyGXHwuH3ISojQigsBK+u9ea
	MIa6EhPnixs4k+gL8fZ5J1ykzmO7BD75R2/l3j4tunjNP6zxPHc3k8bSAoCRm2dx4rh/uguiTTt
	MikMyJxmo8TS0Pw4pgyJcHARmkFjUMrBt2r0lPO2gLhAiaOhOzmbf72KabRYdWJrb6Fs2lt+Ggx
	t5AghKRjfZr7Dz6Hnk4GePERxHKTkkc+IIUplgH9EYKt/ruPZ1uGeZc=
X-Received: by 2002:a05:6a21:a247:b0:3c3:89cf:f43 with SMTP id
 adf61e73a8af0-3c92a796d9dmr13171998637.30.1785835369800; Tue, 04 Aug 2026
 02:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803033520.12930-1-tiala@microsoft.com> <yq5a8q6n4lsi.fsf@kernel.org>
In-Reply-To: <yq5a8q6n4lsi.fsf@kernel.org>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Tue, 4 Aug 2026 17:22:34 +0800
X-Gm-Features: AUfX_my-JxP-6NsyvYh4MNTA70UICqCNqTvvU1e-fABIQPOylgkO2cNXp4B0YDI
Message-ID: <CAMvTesAh=3r2ZgVn6Ka3fdj6fiXhKAnuKCcU6NkvbjMJfPobSw@mail.gmail.com>
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

On Mon, Aug 3, 2026 at 5:04=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar@kerne=
l.org> wrote:
>
> Tianyu Lan <ltykernel@gmail.com> writes:
>
> > In CoCo VMs, system memory is encrypted by default.
> > Device drivers typically rely on the DMA core's
> > SWIOTLB as a bounce buffer for DMA operations, providing
> > decrypted memory that can be shared between the guest and
> > host.
> >
> > For PCI devices with T-Disp support and Confidential
> > VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
> > perform DMA transfers directly with private/encrypted
> > memory in a CoCo VM.
> >
> > To support DMA transfer with encrypted memory, Hyper-V
> > DMA ops are introduced and bypass some API which may
> > use swiotlb as bounce buffer.
> >
> > The DMA ops used is global data structure(see get_arch_
> > dma_ops() and get_dma_ops() for details). There is no
> > need to set up for each device individually.
> >
>
> Can we use __DMA_ATTR_ALLOC_CC_SHARED instead of checking
> hyperv_private_memory_dma(dev) directly? Also, would it be possible to
> encapsulate this logic in something like force_dma_encrypted(dev)?
>

Hi Aneesh:
      Thanks for your review. I go through your patchset =E2=80=9Cdma-mappi=
ng: Use
DMA_ATTR_CC_SHARED=E2=80=9D=EF=BC=88https://lkml.org/lkml/2026/6/4/588). Th=
is patch
is compatible with your DMA_ATTR_CC_SHARED attr work in dma-mapping
layer. Once dma ops callbacks get DMA_ATTR_CC_SHARED attr flag and
it may use the flag to replace hyperv_private_memory_dma().

> Looking at functions such as hyperv_dma_alloc_coherent(), how does this
> differ from dma_direct_alloc()?
>
hyperv_dma_alloc_coherent() is to allocate memory and returns encrypted
memory address directly when hyperv_private_memory_dma() is ture.
This change is to keep all changes under Hyper-V subsystem and it's
also compatible with existing solution which changes DMA core with minor
changes.
--
Thanks


Tianyu Lan
