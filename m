Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F1218592;
	Mon, 28 Sep 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634808; cv=none; b=VeH5kFNm+8NVDBWMlWdSPU8PvpIsRvIEKOh4FNiN3Tegic3zLKu+8m8YoCczFO52s45lYDcxEVoOXzLE9jtkSq0YIH94Z/PJvJwyISx2ZqBPpqd5OCkyg+Fd5fYz0eR+To7okoOkAd5lbagYXN124IicJzZxZX4LZfCoDqV3qQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634808; c=relaxed/simple;
	bh=cz8rbxJONsY2x4jrMJgyEjXBr9ziZ1HR7nWQzwcwDr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIfr6KXogdpYiRzAmNf26thBrYvRUrc6i9pjsFRrlPkVqB1NjHbA27bcYVB70BKHXrhiaLgkN7Wb0OeDJ5aQzybjmp/yVy9vMIs2AswUWQmiCzspsx1cl68aGdKJ0WCRLkezqBvmx+PAsGvWQjNI8l7cxRj+gZPhQjYlAdc6tTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CcnPidtU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CcnPidtU"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD99620B7166;
	Mon, 28 Sep 2026 15:32:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD99620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790634755;
	bh=V3GoQAUmSzqBfz/Zu+bg0/ZemXC8i/dcC7ud7QqbcuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CcnPidtUjTTkteuVjRzu5f8AFAcT89Ig+4rm2wifwBXFcFdlA+7qsnCNN180z1a+Y
	 yb3j2q+AEuBkPd7PciSovFaSWM1+z3DhERaaF/dqEDM4pZifPYkL1ls3tXC7B5VYlY
	 XICO8t7eZJUTgwuWFL9u/fqzZD4WBlPetdXC338M=
Message-ID: <27f49fd8-a95e-9812-c996-53d9eb27a148@linux.microsoft.com>
Date: Mon, 28 Sep 2026 15:33:25 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Content-Language: en-US
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
 <arUkaFhYGxaYwL0L@8bytes.org>
 <329027b5-3110-8362-ccee-080c14ed9b3e@linux.microsoft.com>
 <arYcFJYOvKf-A6xt@8bytes.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <arYcFJYOvKf-A6xt@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 00:13, J?rg R?del wrote:
> On Thu, Sep 24, 2026 at 05:14:12PM -0700, Mukesh R wrote:
>> So, I'm at a bit of loss. I could go back to V0 which did what what you
>> suggested above, but it can also leave stale mappings when map hypercall
>> succeeds partially and we delete the entire tree node in cleanup (but
>> we could add to the tree back whatever succeeded, but that could fail
>> also, but then we could unmap whatever was mapped, but that could fail
>> also.. see :)...).
>>
> 
> The root-problem seems to be that every operation in the step can fail,
> inluding the unmap operation. This makes it really hard to maintain a
> consistent state. Are there any guarantees Hyper-V gives on the unmap
> operation, e.g under which circumstances it can fail? It would really help if
> the code could assume that it will never fail, or treat a failure as a hard
> error.

I talked to the hyp dev, and unmap is guaranteed to succeed unless
the input is bad, even suggesting i could put a bug there. But i know
there is aversion to putting lot of BUG()s, so i'll just leave the WARN
there.

> If there are no guarantees HV can give, a solution might be to add a
> mapping-resize operation to the internal tree (which can not fail) to correctly
> update the tree structure on partially successful unmaps.

Yeah, perhaps we could do that in future to benefit all drivers.

> I still believe that the internal tree structure should be updated before the
> HV map operation takes place.

Yes, i'll move that before map.

Thanks again,
-Mukesh

>>>> +static int __init hv_iommu_init(void)
>>>> +{
>>>> +	int rc;
>>>> +	struct iommu_device *iommup = &hv_virt_iommu;
>>>> +	struct hv_output_get_iommu_capabilities caps;
>>>> +
>>>> +	if (!hv_is_hyperv_initialized())
>>>> +		return -ENODEV;
>>>> +
>>>> +	rc = hv_iommu_get_caps(&caps);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>
>>> The capabilities returned need more checking. I think at least it needs a check
>>> for HV_IOMMU_CAP_PRESENT and that PAGE_SIZE is set in the pgsize_bitmap.
>>
>> In general this caps hypercall is not available to root partitions,
>> our only agreement is for hyp to provide max_iova_width. But, we check
>> HV_DEVICE_DOMAIN_AVAILABLE in hv_iommu_detect() which sorta supersedes
>> HV_IOMMU_CAP_PRESENT. As for page size, hyp owns the iommu and can chose
>> the page size, meaning it can automatically use larger page size when
>> possible. But the hypercall HVCALL_MAP_DEVICE_GPA_PAGES will only take
>> 4k pfns as input, hence:
>>
>> #define HV_IOMMU_PGSIZES SZ_4K        /* for now, to be enhanced */
> 
> Okay, so this deserves a comment in the code to make it clear why there is no
> additional checking and what the hyper-v to guest contract for feature
> detection is.
> 
>> Ok, I can change it back to DMA_BIT_MASK. (I removed after comment
>> on V0 that this is not dma address).
> 
> An IOVA is a DMA address by definition :)
> 
> -Joerg

