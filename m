Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B7282F01;
	Mon,  7 Sep 2026 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815319; cv=none; b=UWRnLgBsVkb3NazS1aIo3tZYHrCnhJ7jTs+T1EPzDXh3SpsO9LSqe0H9VXMR7R/Umto+ohbLxOIL/0TaAfqSX8RK4UBPC1nWx+KyvUitKNDGxPvCUTRIC0FOtnYDwpHuGUhZ5I2POv9YkpT4DKr9n2G3gUmgUFfn1HRB+9aYV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815319; c=relaxed/simple;
	bh=CRknQiozJQuLcNkSrtiRtM/kdCB8yooI2gbfGFTtfE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHlDuie9JCwnmqatpHbrvA79GkBCkjHQGSEoBigm5Jabiy1A+4NtAZp7nIdH9BCcAvp5iLVFafcTFVVk0qO2PbnDzIfjiGEsMGEhUDZ790G5m/kuPvD6NP7gT4aA+CJmxcebGX/uTg+X174UzT3w7z3nSv7D6yrARA8RmJkRoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gVyv5bPu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gVyv5bPu"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCAD820B6F01;
	Mon,  7 Sep 2026 14:07:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCAD820B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788815277;
	bh=kY/lfW05YvJHRzh3O0sx3RlULE7OXDqOdzjhtNx8jWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gVyv5bPuda4Xj5AdVX6X/uEViR9zPXkZjQ4CdjQ6i/hVtDSAsJNqWF2sMP+ELFkeo
	 ngypYO4qT9g25FiAV/jDoEwB1yyj3jKncLHmPBucrPQUVksocReCdFW62sV4eUzsSr
	 xW5x2ITYbMHUKS/pdh6FXQA3BluobC8AzAVN3OIU=
Message-ID: <421b3805-5b90-dfc9-b84c-ee58969f5e36@linux.microsoft.com>
Date: Mon, 7 Sep 2026 14:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Content-Language: en-US
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de,
 jgg@ziepe.ca, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
 tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
 <af047ef8-91ef-7786-c230-25e28b1c8c04@linux.microsoft.com>
 <re2lmz757bvtzbkylxtsj7zu2pjqz7ro752tcg7bpjaicuj6ml@mgsg6jnvgbyd>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <re2lmz757bvtzbkylxtsj7zu2pjqz7ro752tcg7bpjaicuj6ml@mgsg6jnvgbyd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 01:41, Yu Zhang wrote:
> <snip>
> 
>>> +{
>>> +	u64 status;
>>> +	u32 prefix;
>>> +	unsigned long flags;
>>> +	int ret;
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	struct hv_input_get_logical_device_property *input;
>>> +	struct hv_output_get_logical_device_property *output;
>>> +
>>> +	ret = hv_pci_lookup_dev_id(pci_domain_nr(pdev->bus), &prefix);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	local_irq_save(flags);
>>> +
>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>> +	output = (struct hv_output_get_logical_device_property *)(input + 1);
>>
>> Any reason for not using pcpu output arg like we do in all other places?
>> If there is a technical reason, please document it, otherwise when revisited
>> in future for re-design, anyone looking at this will be confused and
>> waste time investigating if there is anything different about this hypercall.
>>
>>
> 
> Thank you, Mukesh. I had also incorrectly assumed that output required
> a separate page, which is why the RFC included a separate output-page
> allocation patch. Michael clarified during that review [1] that input
> and output can share a page as long as their buffers do not overlap,
> so I dropped that patch latter.

They can share a page, but we don't enforce the sizes combined do
not overflow a page, and that could be an issue in future. There is
a tool on the hyp side i believe to check that input and output struct
sizes do not exceed page size.

Also, both the input and output pages are pre-allocated, so there is no
extra allocation (otherwise, we'd have changed all places by now). So
it's better to just follow the convention we've so far just to avoid
confusion during future redesign imo. We def need to revisit this in
near/medium future for all hypercalls.

Thanks,
-Mukesh

> Actually, there's nothing specific to this hypercall here - it follows
> the existing usage. E.g., hv_pci_read_mmio() already uses such arrangement,
> as Michael noted in [2]. pvIOMMU queries fit within the existing per-CPU
> page, with output placed after input, avoiding an unnecessary allocation.
>                                                                           
> [1] https://lore.kernel.org/all/SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com/
> [2] https://lore.kernel.org/all/SN6PR02MB4157BF936EBDA23AD1EC5183D480A@SN6PR02MB4157.namprd02.prod.outlook.com/
>                                                                                                                 
> B.R.
> Yu

