Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9153939C8;
	Wed,  9 Sep 2026 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978166; cv=none; b=h8BP96AAbxVKV2nBju7ZDgK4axzSPngO/DUEgnpx1lgiAf1C+Izom8YWzUTxt7RD7s0YqlCxqN4LsrDErVVg9xAGIlweeA9ZKAsA5euymDwMmxP+n2F9uHkSuLxc6KwXICnu0H/tTN7hp3oCKLNI3ggDnf8YvIQjpxe6HFYoqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978166; c=relaxed/simple;
	bh=6V9Z+LF+27lb2JLVHJ/u+hYjEbOatlpGbOlbpMS9b7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jda5on8Wze351KWqSRHeKp9xD9PLhy+QXw0h1n76xtqR2XvybUKaJk+ok8cmu7PmLkkzOOVfa09aJEKpYiTHr7dVbHHwZo0CrdZ7XgTAwnMXQWMxfPmxzeRLhA2AQiJ/wkP/STb+CM2lal3ws9tz6+ktKH+KDNyNq1CXk2QmXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XGAZIjKg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XGAZIjKg"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id C7F2020B7169;
	Wed,  9 Sep 2026 11:22:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7F2020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788978123;
	bh=FmU6oA2HkXd8D1YiRe81FJ1My2bAxbr+XjLX7sQ/N4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XGAZIjKgYe+Vezs2mc1Hs2DEAim3HETc6qqbHSotSsg67/iGHdYQACvZ8FdZ8prlu
	 /1BpLqnujQbtejv5cl0wxtpxq8z9oIXh0d3wRneYGcqG88kvWyoNTybSirGZsqtG0C
	 LBZVibmfc1WxBp5HqvNPAnCGgmXsX6rEVbMqg3EA=
Message-ID: <9c22e90d-2bd8-04fe-22d5-0fe614253eaf@linux.microsoft.com>
Date: Wed, 9 Sep 2026 11:22:43 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 2/3] mshv: Redesign hypervisor memory deposit logic
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-3-mrathor@linux.microsoft.com>
 <SN6PR02MB4157AB63EF3BA9E3BC560E19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
 <f5836bf1-1baf-68c2-4ac7-b1a6459069ad@linux.microsoft.com>
 <SN6PR02MB415768481DC2DEB2C2690E1CD4B02@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415768481DC2DEB2C2690E1CD4B02@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 10:32, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 8, 2026 3:33 PM
>>
>> On 9/8/26 11:02, Michael Kelley wrote:
>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 7, 2026 7:14 PM
>>>>
>>>> The current memory deposit implementation has a few issues and bugs:
>>>>    o It is very slow
>>>>    o Contiguous range requirement is broken, and is critical bug
>>>>    o An incorrect assumption is made that contiguous memory size would
>>>>      always be power of 2.
>>>
>>> Is this HV_MAX_CONTIGUOUS_ALLOCATION_PAGES? That value is
>>> defined as a constant in hvhdk_mini.h. So is there a possibility that
>>> the constant will change in the future, or in some new variation of
>>> the overall environment?
>>
>> Yes, I was told it could change in future. It is also not guaranteed to
>> be power of 2 (even tho it is currently).
>>
>>>>    o Two pages are allocated, only one is really needed. This adds to
>>>>      overhead.
>>>>    o For a 512 page deposit, the allocation is split into two: one for 511
>>>>      and second for 1. Thus, an order 9 allocation never happens. A
>>>>      contiguous 2M range, if possible, significantly improves performance
>>>>      in the hypervisor.
>>>>    o Since a page is already allocated to collect the frames, there is
>>>>      not really a need to use per cpu input page, and hence avoid local
>>>>      irq disable.
>>>>    o In hv_call_deposit_pages(), in case of error, under err_free_allocations
>>>>      label, all pages are freed without checking status to see if some pages
>>>>      were deposited. This is a critical bug as it would free pages that hyp
>>>>      may be using.
>>>>
>>>> All of above is addressed by:
>>>>    o Allocate 2M by default, this is the recommendation from the hypervisor
>>>>      team, and greatly improves performance.
>>>
>>> Can you be more specific about "improves performance"? Is the
>>> improvement on the guest side, or on the hypervisor side? And what's
>>> the key leverage point in improving performance, regardless of which
>>> side? It might be helpful to record this for future reference to prevent
>>> a change from being made that unknowingly hurts the key leverage
>>> point.
>>
>> Well, overall improvement I'd say. Lesser HV_STATUS_INSUFFICIENT_MEMORY
>> means lesser interruptions means faster non-deposit hypercalls. With
>> larger deposits, it will not come back as often with insufficient memory.
>> If it only uses 1M say out of the 2, next time it will reuse the remaining
>> meg before coming back and asking for more. IOW, incomplete hypercalls
>> repeatedly coming back asking for more ram add lot of overhead.
>> Eg. the guest setup part reduces from 8 sec to 1 sec with this, I
>> don't have further breakdown of which ioctls.
> 
> OK -- this part wasn't clear to me from reading the commit message.
> The primary goal is to reduce hypercall failures due to insufficient
> memory, followed by the cycle of adding memory and trying again. By
> adding memory in larger chunks in the first place, you reduce those
> cycles. Improving the performance of the code for doing the deposit
> helps, but that's probably not where you get the most noticeable
> benefit. Could you clarify this in the commit message?
> 
>>
>>>>    o Always start with a full 2M range allocation, thus getting contiguous if
>>>>      available. In cases where possible, the deposits are much faster.
>>>
>>> Is this faster because the hypervisor can consume the pages faster
>>> if they are contiguous?
>>
>> I didn't ask but my guess is that it can map 2M page in its page
>> tables, so all the benefits of large pages: faster L2 mapping, less
>> tlb overhead, etc..
> 
> Makes sense. This seems like it is probably a 2nd order benefit
> after reducing hypercall failures due to insufficient memory.
> 
>>
>>>>    o Allocate only one page in the deposit function and collect 511 pfns
>>>>      there. Just use a local variable for last pfn.
>>>>    o Use the page as input to hypercall. Since this page is locally allocated,
>>>>      irq disable can be avoided helping speed up the deposit.
> 
> Again, seems like a 2nd order perf improvement in the code
> for doing the memory deposit.
> 
>>>>    o Fix the physical contiguous memory requirement.
>>>>    o Lastly, remove pre-deposits hv_call_create_vp() and
>>>>      hv_call_initialize_partition() as they were removed internally while
>>>>      ago, most likely because they didn't help much.
>>>>
>>>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>>>> ---
>>>>    drivers/hv/hv_proc.c           | 198 +++++++++++++++++++++++++++++----
>>>>    drivers/hv/mshv_root_hv_call.c |  10 +-
>>>>    include/asm-generic/mshyperv.h |   5 -
>>>>    3 files changed, 179 insertions(+), 34 deletions(-)
>>>>
> 
> [snip]
> 
>>>> +/*
>>>> + * Deposit memory in the hypervisor. Even if @contiguous is false, a contiguous
>>>> + * 2M worth of pfns is utmost desired for performance reasons. But short of
> 
> Again, this comment isn't clear on *why* the 2M helps performance.

It can be mapped as large page in hyp page tables.

>>>> + * that, we deposit whatever contiguous chunks we can get. If @contiguous is
>>>> + * true, then the entire range has to be physically contiguous. Note, in that
>>>> + * case, upon withdrawl, hypervisor could return any page in between the range,
>>>> + * so we must split that also. Lastly, HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is
>>>> + * not guaranteed to always be power of 2.
>>>> + */
>>>> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
>>>> +{
>>>> +	struct hv_deposit_memory *hc_input;
>>>> +	int i, rc, num_pages;
>>>> +	u64 status, *pfna, lastpfn = 0;
>>>> +	bool trunc_extra = false;
>>>> +
>>>> +	BUILD_BUG_ON(HV_MAX_CONTIGUOUS_ALLOCATION_PAGES > HV_DEPOSIT_MAX);
>>>> +
>>>> +	if (contiguous) {
>>>> +		num_pages = roundup_pow_of_two(
>>>> +				 HV_MAX_CONTIGUOUS_ALLOCATION_PAGES);
>>>> +		trunc_extra = num_pages != HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
>>>> +	} else {
>>>> +		num_pages = HV_DEPOSIT_MAX;
>>>> +	}
>>>> +
>>>> +	hc_input = (struct hv_deposit_memory *)get_zeroed_page(GFP_KERNEL);
>>>
>>> Mike Rapoport has a kernel-wide effort underway to replace
>>> __get_free_page() with kmalloc() and get_zeroed_page() with kzalloc().
>>> See [1] for one example of the many patches he has submitted. The
>>> commit message has a short explanation. Going with kzalloc() here
>>> would probably avoid a future change.
>>
>> There might be places where a get_page may not be strictly needed, but
>> in this case we do for the hypercall (we use it as input page), and
>> this hypercall can go upto exactly one page. I don't think an operating
>> system can ever get away without having a get_page() api :). kmalloc()
>> could add an aligntment parameter, but it would just call get_page
>> anyways for page aligned requests.
>>
> 
> What Mike wants to do is:
> 
> 	hc_input = kzalloc(PAGE_SIZE, GFP_KERNEL);
> 
> This is guaranteed to provide page-aligned memory, just like
> get_zeroed_page(). See 2nd paragraph under "Description" at [1].

Confusing... the first line after Description also says:

"kmalloc is the normal method of allocating memory for objects smaller
  than page size in the kernel."

I think it is clearer to keep get_page, it also helps keep common code
with earlier versions

Thanks,
-Mukesh



> Michael
> 
> [1] https://www.kernel.org/doc/html/latest/core-api/mm-api.html#c.kmalloc

