Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0C38D3F8;
	Thu,  6 Aug 2026 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029285; cv=none; b=TYR4L+iSGeJDhirhm3pD2wX7ZTF5WqynS8wZRYSPRJ01EgWp63mLfR7ERi2xv1L/pOgeAOp1BWmHK8u9N05uxqJLORSZEV3CJjF5QFhFy+xP5S7VEla0YYyR+2s/MgukBpsiSyv3OQAvSplPIalVabnAo55WxM+G8/oJx+H9D2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029285; c=relaxed/simple;
	bh=Fx5yJ8jEXb5AvayHBY8JDhvUDbEOLd2vy0/hhkVymro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdL5V+EluF7M/H9vuFa0SlXafNn47Ie10gNOtIymPrgAfTBtS/cndtit7g0c8/W00xBJb89WiPvnMdwluRaOeMD0ZPqo+Z4ID2LmYSI720rkQoXO+upkJQtGE+wVWf2gAPMXrxSoX2Zlkts0lvq+gNoQUpe9uO8RFms8FujBtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rFEolI4G; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rFEolI4G"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DEA153B;
	Thu,  6 Aug 2026 08:14:36 -0700 (PDT)
Received: from [10.57.42.103] (unknown [10.57.42.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10E343F632;
	Thu,  6 Aug 2026 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786029280; bh=Fx5yJ8jEXb5AvayHBY8JDhvUDbEOLd2vy0/hhkVymro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rFEolI4GRCyhQbUlgvFE02W9SuObqiSscBMGmmmAer4WLRvAl3R7VBJaVbIOpk3fZ
	 tHNr6WEc8AkJk21ZjcgbphgVsFLJNq+nyDuZr3qlxRskvXkVUKn1HwilHjaJ9O1yxN
	 2Ii8uDoUwfjOEZanqM7I5n69WZeq81iekYDzO+ok=
Message-ID: <3abb072a-4ce1-41d1-a20c-e08f7c594c91@arm.com>
Date: Thu, 6 Aug 2026 16:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory in
 Coco VM
To: Tianyu Lan <ltykernel@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
 hch@infradead.org, vdso@hexbites.dev, mhklinux@outlook.com
References: <20260803033520.12930-1-tiala@microsoft.com>
 <yq5a8q6n4lsi.fsf@kernel.org>
 <CAMvTesAh=3r2ZgVn6Ka3fdj6fiXhKAnuKCcU6NkvbjMJfPobSw@mail.gmail.com>
 <yq5azez03mi2.fsf@kernel.org>
 <CAMvTesBMjFY-W0=uytdRcp8EBhaXB3-X4tFVErxuzGcFwcX=Ew@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAMvTesBMjFY-W0=uytdRcp8EBhaXB3-X4tFVErxuzGcFwcX=Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-06 3:21 pm, Tianyu Lan wrote:
> On Wed, Aug 5, 2026 at 6:11 PM Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:
>>
>> Tianyu Lan <ltykernel@gmail.com> writes:
>>
>>> On Mon, Aug 3, 2026 at 5:04 PM Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:
>>>>
>>>> Tianyu Lan <ltykernel@gmail.com> writes:
>>>>
>>>>> In CoCo VMs, system memory is encrypted by default.
>>>>> Device drivers typically rely on the DMA core's
>>>>> SWIOTLB as a bounce buffer for DMA operations, providing
>>>>> decrypted memory that can be shared between the guest and
>>>>> host.
>>>>>
>>>>> For PCI devices with T-Disp support and Confidential
>>>>> VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
>>>>> perform DMA transfers directly with private/encrypted
>>>>> memory in a CoCo VM.
>>>>>
>>>>> To support DMA transfer with encrypted memory, Hyper-V
>>>>> DMA ops are introduced and bypass some API which may
>>>>> use swiotlb as bounce buffer.
>>>>>
>>>>> The DMA ops used is global data structure(see get_arch_
>>>>> dma_ops() and get_dma_ops() for details). There is no
>>>>> need to set up for each device individually.
>>>>>
>>>>
>>>> Can we use __DMA_ATTR_ALLOC_CC_SHARED instead of checking
>>>> hyperv_private_memory_dma(dev) directly? Also, would it be possible to
>>>> encapsulate this logic in something like force_dma_encrypted(dev)?
>>>>
>>>
>>> Hi Aneesh:
>>>        Thanks for your review. I go through your patchset “dma-mapping: Use
>>> DMA_ATTR_CC_SHARED”（https://lkml.org/lkml/2026/6/4/588). This patch
>>> is compatible with your DMA_ATTR_CC_SHARED attr work in dma-mapping
>>> layer. Once dma ops callbacks get DMA_ATTR_CC_SHARED attr flag and
>>> it may use the flag to replace hyperv_private_memory_dma().
>>>
>>>
>>>> Looking at functions such as hyperv_dma_alloc_coherent(), how does this
>>>> differ from dma_direct_alloc()?
>>>>
>>> hyperv_dma_alloc_coherent() is to allocate memory and returns encrypted
>>> memory address directly when hyperv_private_memory_dma() is ture.
>>> This change is to keep all changes under Hyper-V subsystem and it's
>>> also compatible with existing solution which changes DMA core with minor
>>> changes.
>>
>>
>> If we update force_dma_unencrypted(dev) to return false when an
>> encrypted memory address is required, wouldn't the existing DMA-direct
>> support handle this case? Or are there issues with the existing code? If
>> so, could you explain them in more detail?
>>
> 
> Hyper-V Coco VM with T-disp scenario is to run a paravior(lightweight L1
> hypervisor) with normal guest (Detail please see 13.2. OpenHCL Architecture
> https://openvmmdev/guide/user_guide/openhcl.html). The paravisor is in charge
> of talking with hardware to accept PCI devices for Normal guest.
> 
> When PCI device is assigned to normal guest, __device_cc_accepted() should
> always return true for this device.  Then, DMA core will not use
> bounce buffer and
> unencrypted memory address for the device.
> 
> However, __device_cc_accepted() is based on TSM framework and Hyper-V
> doesn't support it. This means normal guest will not use TSM guest driver
> and so current code doesn't work. It's necessary to introduce an API for
> platforms without TSM support to mask the PCI device to be "accepted".
> 
>>
>> Can we rework this patch to use that（DMA_ATTR_CC_SHARED ）?
>>
> 
> I think the change is simple. The issue here is how to set the attr flag for
> platforms without TSM support. This patch is to make Hyper-V T-Disp case
> work without changing DMA core and PCI layer.

I don't see why Hyper-V would need to change any other layer. We're 
proposing a generic notion of device_cc_accepted() which requires the 
bus code to decide what it means to "accept" a device - TSM will be 
PCI's standard way to do that; meanwhile VMbus should be free to call 
device_cc_accept() for whatever VMbus devices it fancies. That would be 
this patch done already.

And similarly if you also want to auto-accept PCI devices via some 
Hyper-V-specific non-TDISP mechanism, I'd expect there to be some way of 
doing that from the pci-hyperv driver without needing to hack or 
reimplement common code.

Thanks,
Robin.

> In parallel, we may co-work to add non-TSM platform support in your DMA
> CC SHARED patchset and "PCI/TSM: Core infrastructure" patchset.
> 
> --
> Thanks
> Tianyu Lan

