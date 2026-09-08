Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B456B87D;
	Tue,  8 Sep 2026 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906767; cv=none; b=D6doZEo3qRfDDLc/xLsb4IWJSmka48m03s5PjUQi6n6PbH0emO4pqB7oRzjc9qcFdeogAmh91WdYBbDkVeqRaC5FQOxrMv+jK2Fc1wjYIhhjcdc3yJVTOR6dIAASF3nyr3ws63Dtta4arUVpsYtaQ1P2tliKP9o9+HqgKK0Sczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906767; c=relaxed/simple;
	bh=285pUrJxX7SPGnneOHk7WSYOk3Ev+t2K6itdNEygxGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4KU6XOAKgQfUf1Jl2ST4Gvz09FWJMmBRwjeEykeIpttcYu9RXnRm93WvYZPNjmYDbFwGueJiRD4IShXsonQFzMME2Ai2QcPemn/wN984lDcwWimRNSz+mA5qkfZu+9us6v8FS68VE7ty8e6kZDlXj5z0MSmEfZV5NEUCbxyRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RJ0CQqQ6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RJ0CQqQ6"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 76E3B20B7128;
	Tue,  8 Sep 2026 15:32:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76E3B20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788906720;
	bh=NEMvveQgtPa7RYU7R5053wVJWAgYuyZGnqLjiZNBkpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RJ0CQqQ6M2fSy4nT6XP8qaltkEON7yEksvTyzDXNBW5CzvbzGMiVBSihvwfcS5vo/
	 EL+ZgZLJ6478WMN09PvtezR13ad3D6HvI8T97SGG7pNMjlcUADEMM8ZrRMV3VId8To
	 gf9YQzMZ5HIA2CiL9aUqhp0oeB95OIpcleuCE7VQ=
Message-ID: <f5836bf1-1baf-68c2-4ac7-b1a6459069ad@linux.microsoft.com>
Date: Tue, 8 Sep 2026 15:32:39 -0700
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
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157AB63EF3BA9E3BC560E19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 11:02, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 7, 2026 7:14 PM
>>
>> The current memory deposit implementation has a few issues and bugs:
>>   o It is very slow
>>   o Contiguous range requirement is broken, and is critical bug
>>   o An incorrect assumption is made that contiguous memory size would
>>     always be power of 2.
> 
> Is this HV_MAX_CONTIGUOUS_ALLOCATION_PAGES? That value is
> defined as a constant in hvhdk_mini.h. So is there a possibility that
> the constant will change in the future, or in some new variation of
> the overall environment?

Yes, I was told it could change in future. It is also not guaranteed to
be power of 2 (even tho it is currently).

>>   o Two pages are allocated, only one is really needed. This adds to
>>     overhead.
>>   o For a 512 page deposit, the allocation is split into two: one for 511
>>     and second for 1. Thus, an order 9 allocation never happens. A
>>     contiguous 2M range, if possible, significantly improves performance
>>     in the hypervisor.
>>   o Since a page is already allocated to collect the frames, there is
>>     not really a need to use per cpu input page, and hence avoid local
>>     irq disable.
>>   o In hv_call_deposit_pages(), in case of error, under err_free_allocations
>>     label, all pages are freed without checking status to see if some pages
>>     were deposited. This is a critical bug as it would free pages that hyp
>>     may be using.
>>
>> All of above is addressed by:
>>   o Allocate 2M by default, this is the recommendation from the hypervisor
>>     team, and greatly improves performance.
> 
> Can you be more specific about "improves performance"? Is the
> improvement on the guest side, or on the hypervisor side? And what's
> the key leverage point in improving performance, regardless of which
> side? It might be helpful to record this for future reference to prevent
> a change from being made that unknowingly hurts the key leverage
> point.

Well, overall improvement I'd say. Lesser HV_STATUS_INSUFFICIENT_MEMORY
means lesser interruptions means faster non-deposit hypercalls. With
larger deposits, it will not come back as often with insufficient memory.
If it only uses 1M say out of the 2, next time it will reuse the remaining
meg before coming back and asking for more. IOW, incomplete hypercalls
repeatedly coming back asking for more ram add lot of overhead.
Eg. the guest setup part reduces from 8 sec to 1 sec with this, I
don't have further breakdown of which ioctls.

>>   o Always start with a full 2M range allocation, thus getting contiguous if
>>     available. In cases where possible, the deposits are much faster.
> 
> Is this faster because the hypervisor can consume the pages faster
> if they are contiguous?

I didn't ask but my guess is that it can map 2M page in its page
tables, so all the benefits of large pages: faster L2 mapping, less
tlb overhead, etc..

>>   o Allocate only one page in the deposit function and collect 511 pfns
>>     there. Just use a local variable for last pfn.
>>   o Use the page as input to hypercall. Since this page is locally allocated,
>>     irq disable can be avoided helping speed up the deposit.
>>   o Fix the physical contiguous memory requirement.
>>   o Lastly, remove pre-deposits hv_call_create_vp() and
>>     hv_call_initialize_partition() as they were removed internally while
>>     ago, most likely because they didn't help much.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/hv_proc.c           | 198 +++++++++++++++++++++++++++++----
>>   drivers/hv/mshv_root_hv_call.c |  10 +-
>>   include/asm-generic/mshyperv.h |   5 -
>>   3 files changed, 179 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>> index 57864bb5bcd8..0ebede0bc8b4 100644
>> --- a/drivers/hv/hv_proc.c
>> +++ b/drivers/hv/hv_proc.c
>> @@ -9,6 +9,184 @@
>>   #include <linux/export.h>
>>   #include <asm/mshyperv.h>
>>
>> +#define HV_DEPOSIT_MAX 512
>> +#define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
>> +	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
>> +
>> +/*
>> + * Allocate free pages for deposit to hypervisor. pfna[] must be large enough
>> + * to hold HV_DEPOSIT_INP_MAX (511) pages. If num_pages is 512, return last
>> + * pfn in lastpfn. If @single, then it must be a single allocation (not split
>> + * over multiple contiguous ranges).
>> + *
>> + * Returns: number of pages allocated or -ENOMEM
>> + */
>> +static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages,
>> +			      bool single)
>> +{
>> +	struct page *page;
>> +	int num_allocd, count = 0;
>> +
>> +	/* Published ABI, enforce its immutability. */
>> +	BUILD_BUG_ON(HV_DEPOSIT_INP_MAX != 511);
>> +
>> +	if (num_pages > HV_DEPOSIT_MAX ||
>> +	    (num_pages == HV_DEPOSIT_MAX && lastpfnp == NULL))
>> +		return -EINVAL;
>> +
>> +	while (num_pages) {
>> +		/* Find highest order we can actually allocate */
>> +		int order = 31 - __builtin_clz(num_pages);
> 
> Outside of the kernel source file da9062-regulator.c and the definition
> of fls(), there are only about 14 direct uses of __builtin_clz() in the
> kernel. By contrast fls() is used more than 700 times. Using __builtin_clz()
> works, but you might consider using fls() instead just to be on the more
> common path.

Well, i just used things from existing code in the current function
hv_call_deposit_pages()...  So, it's not new code. Frankly, i don't
want to risk changing something that works unless it is necessary.

>> +		gfp_t gfp_flags = GFP_KERNEL;
>> +
>> +		if (!single)
>> +			gfp_flags |= __GFP_NOWARN;
>> +
>> +		while (1) {
>> +			page = alloc_pages_node(node, gfp_flags, order);
>> +			if (page || order == 0 || single)
>> +				break;
>> +
>> +			order--;
>> +		}
>> +
>> +		if (page == NULL)
> 
> Nit: I've always thought kernel style has a slight preference for "!page"
> instead of "page == NULL". And indeed, a few lines above you test
> just "page". Not a big deal, but when there are inconsistencies I wonder
> if there's a reason ....

My aging eyes and brain prefer (x == NULL) :)... Earlier one  is existing
line from previous code.

>> +			break;
>> +
>> +		split_page(page, order);
>> +		num_allocd = 1 << order;
>> +		num_pages -= num_allocd;
>> +
>> +		while (num_allocd && count < HV_DEPOSIT_INP_MAX) {
>> +			pfna[count++] = page_to_pfn(page++);
>> +			num_allocd--;
>> +		}
>> +
>> +		if (num_allocd-- && count == HV_DEPOSIT_INP_MAX) {
>> +			*lastpfnp = page_to_pfn(page);
>> +			count++;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return count ? count : -ENOMEM;
>> +}
>> +
>> +/*
>> + * Deposit memory in the hypervisor. Even if @contiguous is false, a contiguous
>> + * 2M worth of pfns is utmost desired for performance reasons. But short of
>> + * that, we deposit whatever contiguous chunks we can get. If @contiguous is
>> + * true, then the entire range has to be physically contiguous. Note, in that
>> + * case, upon withdrawl, hypervisor could return any page in between the range,
>> + * so we must split that also. Lastly, HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is
>> + * not guaranteed to always be power of 2.
>> + */
>> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
>> +{
>> +	struct hv_deposit_memory *hc_input;
>> +	int i, rc, num_pages;
>> +	u64 status, *pfna, lastpfn = 0;
>> +	bool trunc_extra = false;
>> +
>> +	BUILD_BUG_ON(HV_MAX_CONTIGUOUS_ALLOCATION_PAGES > HV_DEPOSIT_MAX);
>> +
>> +	if (contiguous) {
>> +		num_pages = roundup_pow_of_two(
>> +				 HV_MAX_CONTIGUOUS_ALLOCATION_PAGES);
>> +		trunc_extra = num_pages != HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
>> +	} else {
>> +		num_pages = HV_DEPOSIT_MAX;
>> +	}
>> +
>> +	hc_input = (struct hv_deposit_memory *)get_zeroed_page(GFP_KERNEL);
> 
> Mike Rapoport has a kernel-wide effort underway to replace
> __get_free_page() with kmalloc() and get_zeroed_page() with kzalloc().
> See [1] for one example of the many patches he has submitted. The
> commit message has a short explanation. Going with kzalloc() here
> would probably avoid a future change.

There might be places where a get_page may not be strictly needed, but
in this case we do for the hypercall (we use it as input page), and
this hypercall can go upto exactly one page. I don't think an operating
system can ever get away without having a get_page() api :). kmalloc()
could add an aligntment parameter, but it would just call get_page
anyways for page aligned requests.

Thanks for the review, BTW, sashiko found a bug where wrong status is
used in an error case, so I'll be sending another version.

Thanks,
-Mukesh

> [1] https://lore.kernel.org/lkml/20260830-tty-v1-1-0cbe6170649b@kernel.org/
> 
>> +	if (hc_input == NULL)
>> +		return -ENOMEM;
>> +
>> +	hc_input->partition_id = partition_id;
>> +	pfna = hc_input->gpa_page_list;
>> +
>> +	rc = hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages, contiguous);
>> +	if (rc < 0)
>> +		goto out_free;
>> +
>> +	num_pages = rc;
>> +	if (num_pages > HV_DEPOSIT_INP_MAX)
>> +		num_pages = HV_DEPOSIT_INP_MAX;
>> +
>> +	if (contiguous && trunc_extra) {
>> +		for (i = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES; i < num_pages; i++)
>> +			__free_page(pfn_to_page(pfna[i]));
>> +
>> +		if (lastpfn) {
>> +			__free_page(pfn_to_page(lastpfn));
>> +			lastpfn = 0;
>> +		}
>> +
>> +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
>> +	}
>> +
>> +	/* We are not using hyperv_pcpu_input_arg, so no need to disable */
> 
> "disable interrupts"?
> 
>> +
>> +	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages,
>> +				     0, hc_input, NULL);
>> +	if (!hv_result_success(status))
>> +		goto err_free_dep_pages;
>> +
>> +	if (lastpfn) {
>> +		hc_input->gpa_page_list[0] = lastpfn;
>> +		status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
>> +					     hc_input, NULL);
> 
> So if a full 2 MiB contiguous is allocated, it's OK to deposit the
> first 511 pages and then do a 2nd hypercall to deposit the last
> page? Does the hypervisor figure out that the 2 MiB is contiguous
> and map it with a single 2 MiB PTE to get the mapping perf benefit?
> I realize there's not any other choice given the limitation of 1 page
> of hypercall input, but I just wondered.
> 
>> +
>> +		if (!hv_result_success(status)) {
>> +			if (contiguous)
>> +				goto err_free_dep_pages;
>> +
>> +			/* We deposited lot earlier, so give it a go */
>> +			__free_page(pfn_to_page(lastpfn));
>> +		}
>> +	}
>> +
>> +	free_page((unsigned long)hc_input);
>> +	return 0;
>> +
>> +err_free_dep_pages:
>> +	hv_status_err(status, "\n");
>> +	rc = hv_result_to_errno(status);
>> +
>> +	for (i = hv_repcomp(status); i < num_pages; i++)
>> +		__free_page(pfn_to_page(pfna[i]));
>> +	if (lastpfn)
>> +		__free_page(pfn_to_page(lastpfn));
>> +
>> +out_free:
>> +	free_page((unsigned long)hc_input);
>> +	return rc;
>> +}
>> +
>> +int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
>> +{
>> +	int result = hv_result(hv_status);
>> +	bool contiguous = false;
>> +
>> +	if (result == HV_STATUS_INSUFFICIENT_ROOT_MEMORY ||
>> +	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY) {
>> +		if (!hv_root_partition()) {
>> +			hv_status_err(hv_status,
>> +				      "Unexpected root memory deposit\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		pt_id = HV_PARTITION_ID_SELF;
>> +	}
>> +
>> +	if (result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY ||
>> +	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY)
>> +		contiguous = true;
>> +
>> +	return hv_call_deposit_pages(node, pt_id, contiguous);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>> +
>>   /*
>>    * See struct hv_deposit_memory. The first u64 is partition ID, the rest
>>    * are GPAs.
>> @@ -109,12 +287,6 @@ static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num_pages)
>>   	return ret;
>>   }
>>
>> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>> -{
>> -	return hv_call_deposit_pages_old(node, partition_id, num_pages);
>> -}
>> -EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>> -
>>   static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id, u64 hv_status)
>>   {
>>   	u32 num_pages = 1;
>> @@ -144,12 +316,6 @@ static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id,
>>   	return hv_call_deposit_pages_old(node, partition_id, num_pages);
>>   }
>>
>> -int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
>> -{
>> -	return hv_deposit_memory_node_old(node, partition_id, hv_status);
>> -}
>> -EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>> -
>>   bool hv_result_needs_memory(u64 status)
>>   {
>>   	switch (hv_result(status)) {
>> @@ -212,14 +378,6 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>>   	unsigned long irq_flags;
>>   	int ret = 0;
>>
>> -	/* Root VPs don't seem to need pages deposited */
>> -	if (partition_id != hv_current_partition_id) {
>> -		/* The value 90 is empirically determined. It may change. */
>> -		ret = hv_call_deposit_pages(node, partition_id, 90);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	do {
>>   		local_irq_save(irq_flags);
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index cb55d4d4be2e..b8d199f95299 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -15,8 +15,6 @@
>>   #include "mshv_root.h"
>>
>>   /* Determined empirically */
>> -#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>> -#define HV_MAP_GPA_DEPOSIT_PAGES	256
>>   #define HV_UMAP_GPA_PAGES		512
>>
>>   #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
>> @@ -140,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
>>
>>   	input.partition_id = partition_id;
>>
>> -	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
>> -				    HV_INIT_PARTITION_DEPOSIT_PAGES);
>> -	if (ret)
>> -		return ret;
>> -
>>   	do {
>>   		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
>>   					       *(u64 *)&input);
>> @@ -248,8 +241,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>>   		completed = hv_repcomp(status);
>>
>>   		if (hv_result_needs_memory(status)) {
>> -			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
>> -						    HV_MAP_GPA_DEPOSIT_PAGES);
>> +			ret = hv_deposit_memory(partition_id, status);
>>   			if (ret)
>>   				break;
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index bf601d67cecb..c16abaecb65e 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -345,7 +345,6 @@ static inline bool hv_parent_partition(void)
>>
>>   bool hv_result_needs_memory(u64 status);
>>   int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>>   int hv_call_notify_all_processors_started(void);
>>   bool hv_lp_exists(u32 lp_index);
>> @@ -360,10 +359,6 @@ static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> -static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>> -{
>> -	return -EOPNOTSUPP;
>> -}
>>   static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
>>   {
>>   	return -EOPNOTSUPP;
>> --
>> 2.51.2.vfs.0.1
>>

