Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4F41D113;
	Wed,  5 Aug 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924702; cv=none; b=FizmIA1TASCYCcdNPVS0wpv6hMU42QKpzRHFD6o4QgAwd9F5wVNENb/ubWtolAkreiWsD40x8zk4ITL3iTfdutVP3ZBDb382ApRsVlfRJJJd8iFV6BhmiLiom5JGzpZqWbCRwMxLqtychGXWxgcK9doouxtPkQbSWlD2X56iT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924702; c=relaxed/simple;
	bh=yW0m8hSqMhc0ISFNlsY5nQNaPtS/jMRiNtaR+E2POqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ap4IwTCMXyYGWDUqKAbVC/Ok9L4bfFAlx/AhEvfB4o8CB3jjJiNuaSJOB9BLal9J3nIHxawY0AkD83R7ygJW7Z1v88NO/YHhWC2Kp7WNrMest7rjulCRYj/8KflbP1fafuho5jUu4cav8iSNCtBdZRrXnSB9ZMaXD7qHnoIUNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrIDADPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrIDADPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9F01F00A3A;
	Wed,  5 Aug 2026 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924700;
	bh=Ok1Ew0R/KQu7dLziFb0txy0YA3nnijzdbRR/jSy7YjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RrIDADPnjJI5iGk87v5p0qTvDFWRd1eOfnW8q8XhXHsbUw2/T5TzW/J+BGwhDiKMZ
	 hToXwwQ2oXO80kiOdl5yPMY7543SoIrJsp1zqfgUqoOHrxg0okB+dNcf00k2+cpqqf
	 KIjDU7yeHL5+0adbTano+2NYkoDTd8IB3yEJocDSxrIBGg53TAuVnldfhToGBg/+y2
	 J/z2n8Z5Bz7r7wohSR/N2PGVr0ph4gUiY44Hi4zA6CbkDETXgDzcyk9HB5OiER/iuU
	 UCv+aaLQRtFZ0+c13lgmpjX+MFR4cQwc14xNDNxaA5mxTKudWuSzxChsanwPdBBSeA
	 wXTNHyUKFBolg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, hch@infradead.org,
	robin.murphy@arm.com, vdso@hexbites.dev, mhklinux@outlook.com
Subject: Re: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory
 in Coco VM
In-Reply-To: <CAMvTesAh=3r2ZgVn6Ka3fdj6fiXhKAnuKCcU6NkvbjMJfPobSw@mail.gmail.com>
References: <20260803033520.12930-1-tiala@microsoft.com>
 <yq5a8q6n4lsi.fsf@kernel.org>
 <CAMvTesAh=3r2ZgVn6Ka3fdj6fiXhKAnuKCcU6NkvbjMJfPobSw@mail.gmail.com>
Date: Wed, 05 Aug 2026 15:41:33 +0530
Message-ID: <yq5azez03mi2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tianyu Lan <ltykernel@gmail.com> writes:

> On Mon, Aug 3, 2026 at 5:04=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar@ker=
nel.org> wrote:
>>
>> Tianyu Lan <ltykernel@gmail.com> writes:
>>
>> > In CoCo VMs, system memory is encrypted by default.
>> > Device drivers typically rely on the DMA core's
>> > SWIOTLB as a bounce buffer for DMA operations, providing
>> > decrypted memory that can be shared between the guest and
>> > host.
>> >
>> > For PCI devices with T-Disp support and Confidential
>> > VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
>> > perform DMA transfers directly with private/encrypted
>> > memory in a CoCo VM.
>> >
>> > To support DMA transfer with encrypted memory, Hyper-V
>> > DMA ops are introduced and bypass some API which may
>> > use swiotlb as bounce buffer.
>> >
>> > The DMA ops used is global data structure(see get_arch_
>> > dma_ops() and get_dma_ops() for details). There is no
>> > need to set up for each device individually.
>> >
>>
>> Can we use __DMA_ATTR_ALLOC_CC_SHARED instead of checking
>> hyperv_private_memory_dma(dev) directly? Also, would it be possible to
>> encapsulate this logic in something like force_dma_encrypted(dev)?
>>
>
> Hi Aneesh:
>       Thanks for your review. I go through your patchset =E2=80=9Cdma-map=
ping: Use
> DMA_ATTR_CC_SHARED=E2=80=9D=EF=BC=88https://lkml.org/lkml/2026/6/4/588). =
This patch
> is compatible with your DMA_ATTR_CC_SHARED attr work in dma-mapping
> layer. Once dma ops callbacks get DMA_ATTR_CC_SHARED attr flag and
> it may use the flag to replace hyperv_private_memory_dma().
>

Can we rework this patch to use that?=20

>
>> Looking at functions such as hyperv_dma_alloc_coherent(), how does this
>> differ from dma_direct_alloc()?
>>
> hyperv_dma_alloc_coherent() is to allocate memory and returns encrypted
> memory address directly when hyperv_private_memory_dma() is ture.
> This change is to keep all changes under Hyper-V subsystem and it's
> also compatible with existing solution which changes DMA core with minor
> changes.


If we update force_dma_unencrypted(dev) to return false when an
encrypted memory address is required, wouldn't the existing DMA-direct
support handle this case? Or are there issues with the existing code? If
so, could you explain them in more detail?

-aneesh
