Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791A484236;
	Tue,  8 Sep 2026 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911095; cv=none; b=DTrc7XFKtKFHAR5ZWphv3k8QXjoT1LkyXN2ElLyWJFqmfAvRsaS9Tg731x/bq3Ba0NqUM8vA9h0xOk+zeaiWnyD+A5cj7xvN2/DI4UgHxYIU7wUq3lceWC0I0SG29SEncgsj2aZlV/NpW2J/csFKw87xZ5zpW8rvf0xfqZ5qo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911095; c=relaxed/simple;
	bh=VeMzhWQ6IE68U3WO3O4kVsqDVBYXVw/9y69DWxi4g/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXvfpvsS2B6nsmaGy1KnBoFQDaHDGyMiD3RVngkUrVX9P+dlllHGS2kXbdlP5B4twArDDULvnxZnM3fi8GKymVBKGAAjXG92tWKZ7xf7bR+rgWOnqlSeZjq3OKlXnELMflkzd5QqpQ37HYlw9UmqB/etxMiww+/P05VKYYlDm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sKOzwmEB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sKOzwmEB"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40BA820B7166;
	Tue,  8 Sep 2026 16:44:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40BA820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788911053;
	bh=P8fD+5o8YxUE5iDfnpfEVckIqMObSoRj7VJ+1ocXu8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sKOzwmEBhqCQgmpsX9iDct6oTbNDC8WVWCVhIuonMYsSgK4ZV7fd8M+wFxmpnaO3J
	 jA8KHnWcqdb4nsPgxFmTqm8jEJ1Akr1b/s+qfLuUz0IrhACbSens8hJxvueNpX7Ym2
	 XO8iQ9EQWC5kNtgGUq59n4hKxD4kOqMiCk+vYGF8=
Message-ID: <8a526d96-c116-5e54-ebc1-941e12a08506@linux.microsoft.com>
Date: Tue, 8 Sep 2026 16:44:51 -0700
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
 <421b3805-5b90-dfc9-b84c-ee58969f5e36@linux.microsoft.com>
 <mjwk6raf75lpd3wjotii5lnxmnlt4c474tu55ezrwsvr2rbfmx@krnwg7yoifes>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <mjwk6raf75lpd3wjotii5lnxmnlt4c474tu55ezrwsvr2rbfmx@krnwg7yoifes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 20:16, Yu Zhang wrote:
> On Mon, Sep 07, 2026 at 02:08:35PM -0700, Mukesh R wrote:
>> On 9/7/26 01:41, Yu Zhang wrote:
>>> <snip>
>>>
>>>>> +{
>>>>> +	u64 status;
>>>>> +	u32 prefix;
>>>>> +	unsigned long flags;
>>>>> +	int ret;
>>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>>> +	struct hv_input_get_logical_device_property *input;
>>>>> +	struct hv_output_get_logical_device_property *output;
>>>>> +
>>>>> +	ret = hv_pci_lookup_dev_id(pci_domain_nr(pdev->bus), &prefix);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	local_irq_save(flags);
>>>>> +
>>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>> +	output = (struct hv_output_get_logical_device_property *)(input + 1);
>>>>
>>>> Any reason for not using pcpu output arg like we do in all other places?
>>>> If there is a technical reason, please document it, otherwise when revisited
>>>> in future for re-design, anyone looking at this will be confused and
>>>> waste time investigating if there is anything different about this hypercall.
>>>>
>>>>
>>>
>>> Thank you, Mukesh. I had also incorrectly assumed that output required
>>> a separate page, which is why the RFC included a separate output-page
>>> allocation patch. Michael clarified during that review [1] that input
>>> and output can share a page as long as their buffers do not overlap,
>>> so I dropped that patch latter.
>>
>> They can share a page, but we don't enforce the sizes combined do
>> not overflow a page, and that could be an issue in future. There is
> 
> The two hypercalls (HVCALL_GET_IOMMU_CAPABILITIES and
> HVCALL_GET_LOGICAL_DEVICE_PROPERTY) each currently use only 40 bytes of
> combined input and output. No concrete requirement has been identified
> that would make either approach 4 KB. A hypothetical future expansion
> is not sufficient reason to allocate another per-CPU page now.

Understood and obvious. But just like you are pointing at
hv_pci_read_mmio(), someone could point at this and may not be using
small structs. When almost all hyperalls use a certain way, that is
the convention. I see that outpage is not always allocated for guest
VMs, and if you don't wanna check if it is and just share intput page,
that's fine. Like I said earlier, add a comment so that when one
looks at redoing all hypercalls that use input and output page, this
one doesn't get missed because they might think there is something
special about this. It would be ludicrous on my part to suggest
that we fix all hypercalls as part of this series.

In a nutshell, a simple comment like this would help:

         /*
          * This hyperall has small input and output parameters. So to avoid
          * checking if output page has been allocated, we just use the input
          * page for output. Using the output page would also be correct.
          */

Thanks,
-Mukesh


>> a tool on the hyp side i believe to check that input and output struct
>> sizes do not exceed page size.
>>
>> Also, both the input and output pages are pre-allocated, so there is no
>> extra allocation (otherwise, we'd have changed all places by now). So
>> it's better to just follow the convention we've so far just to avoid
>> confusion during future redesign imo. We def need to revisit this in
>> near/medium future for all hypercalls.
>>
> 
> Well, output page is NOT pre-allocated ordinary child partitions. Please
> see hv_output_page_exists() in hv_common.c.
>                                                                                                                                                          
> My RFC included a separate allocation because I had incorrectly assumed
> that output required its own page. Like I mentioned earlier, this was
> already discussed during the RFC review [1], and that allocation patch
> was dropped following the discussion.
> 
> Using separate pages is NOT a *convention* either: hv_pci_read_mmio()
> already places input and output in non-overlapping regions of the same
> page.
> 
> We can certainly reassess which hypercalls need separate output pages
> in a broader review. I would keep that separate from this series,
> rather than reopen the RFC discussion without a concrete issue in
> the current implementation.
> 
> [1] https://lore.kernel.org/all/SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> B.R.
> Yu

