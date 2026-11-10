Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269306;
	b=ThzVa7rEpC6mvFcPBtycw7TWCx9+qzGWkWhCHwCKky45VRDiKQvMPduDn/6wZN+rNqTk
	 8nU/qnnLc9+H8NslJPuqPu2bIlvi1/GfLyt566+5HgW56Oq2oDZkrj6gyMia8nRATxhLW
	 UWEIpfq7Ta7d2saNChA3myd2kqTH/MTb8FqwKVkUj00lcYbSVcQS5P0V72wUy63FiF/zP
	 OXl1KNj5eX56LhlA7++hzioNjg8BdWFk76XGUDYK567aHado226tXlD4BSSRgJyfXa9ER
	 AqzB4Y7M/s/eX1QcjpskZ8pPvZzK552/RcQZmWblwCVPYkFodt+W5bNmDJ7RqxmfcdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269306;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=ZAlmiMbCs5Fxt/OX69COOKdAVsxWJrbxSKZq5I1sz6M=;
	b=4ks55z7AiLF0euiF9dfBULoCigxo9ys2y/5wrWNiplHlw31V28KgvnBWMpb7tpOMK/Qv
	 qhtm2BKrKPNDQzc6Bai7FfhACsHEqdvXgjfGZ1VuH/ivHZHFeUBjVJsC7k1Yu3WUOQJOC
	 FVObGV51vbG9wnqtsUJ7ZVAkkk8FowZWew2gQ51ttOdXzbxOfuR01FStF95Fjl4zq6yH5
	 Pgo2WqxXjN2RfRJ/y1ylL1nkydRPG5oEsq3yDlhWCUhR/UfC5WPEx3vHrposcyhzsiNmH
	 1QSOeQcN9n2yVkBHpkUIpWiXH8W7baNFahaWub6Ee3Ghub1GrQLiOlRYhmhxXvONyog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=W3mBhVmc;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E12606A335
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 00:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E12606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=W3mBhVmc
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A6FB20B7169;
	Mon,  9 Nov 2026 16:08:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A6FB20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794269303;
	bh=ZAlmiMbCs5Fxt/OX69COOKdAVsxWJrbxSKZq5I1sz6M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=W3mBhVmczKwT2hIXaXm9J6i+d+EfIroi2E6ePq3guXRBSuLA98TUZHgxQE273Ivl3
	 pbpJwWVly/0bIzjOQ8ocqLrnAMtyLWYYwQoxBUFdXeIf2lMrv7pQ8aPeDdjwd2qB6u
	 cpWgadfKQAxcjLqjoBZv2ln9vvObbflSFOy5SNVg=
Message-ID: <15b3d0f2-fb44-c1cd-0a77-9c286e97a745@linux.microsoft.com>
Date: Mon, 9 Nov 2026 16:08:25 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Do pre-commit before mapping a guest VM GPA
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev, linux-hyperv@vger.kernel.org
References: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
 <sashiko-outbox-202522@kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <sashiko-outbox-202522@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 19:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mshv: GFP_KERNEL allocation in hv_pre_commit_gpa() during MMU
>    invalidation
> --
> 
> commit 326d99247cfb889e00e7b24f8217bcbc574b15e8
> Author: Mukesh R <mrathor@linux.microsoft.com>
> 
> mshv: Do pre-commit before mapping a guest VM GPA
> 
> This commit adds an HVCALL_PRECOMMIT_GPA_PAGES step before mapping guest
> GPAs in hv_do_map_gpa_hcall() to pre-allocate hypervisor data structures
> and reduce TLB flushes.
> 
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index e761addda50e1..595d044fb9264 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -181,6 +181,54 @@ int hv_call_delete_partition(u64 partition_id)
>>   	return hv_result_to_errno(status);
>>   }
>>   
>> +/*
>> + * Pre commit to reduce TLB flush overheads in the hypervisor. On systems with
>> + * large CPUs, there is signficant advantage to doing this. Pre-commit allows
>> + * the hypervisor to build all data structs needed in anticipation of the map
>> + * gpa hypercall, thus reducing or eliminating deposit page returns from the
>> + * map gpa hypercall, and as a result reducing TLB flushes.
>> + */
>> +static int hv_pre_commit_gpa(u64 pt_id, u64 gfn, u64 num_pages)
>> +{
>> +	ulong irq_flags;
>> +	struct hv_input_precommit_gpa_pages *input_page;
>> +	int rc = 0;
>> +	u64 status, done = 0;
>> +
>> +	while (done < num_pages) {
>> +		u16 rep_count = min(num_pages - done, HV_REP_COUNT_MAX);
>> +
>> +		local_irq_save(irq_flags);
>> +		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +		memset(input_page, 0, sizeof(*input_page));
>> +
>> +		input_page->partition_id = pt_id;
>> +		input_page->target_gpa_base = gfn;
>> +
>> +		status = hv_do_rep_hypercall(HVCALL_PRECOMMIT_GPA_PAGES,
>> +					     rep_count, 0, input_page, NULL);
>> +		local_irq_restore(irq_flags);
>> +
>> +		done += hv_repcomp(status);
>> +		gfn += hv_repcomp(status);
>> +
>> +		if (hv_result_needs_memory(status)) {
>> +			rc = hv_deposit_memory(pt_id, status);
>> +			if (rc)
>> +				break;
>> +
>> +		} else if (!hv_result_success(status)) {
>> +			pr_err("%s: failed to pre commit for gfn %#llx done %llu/%llu, status=%#llx (%s)\n",
>> +			       __func__, gfn, done, num_pages, status,
>> +			       hv_result_to_string(hv_result(status)));
>> +			rc = hv_result_to_errno(status);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>   /* Ask the hypervisor to map guest ram pages or the guest mmio space */
>>   static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>>   			       u32 flags, struct page **pages, u64 mmio_spa)
>> @@ -205,6 +253,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>>   		page_count >>= large_shift;
>>   	}
>>   
>> +	ret = hv_pre_commit_gpa(partition_id, gfn, page_struct_count);
>> +	if (ret)
>> +		return ret;
> 
> [Severity: High]
> Can calling hv_pre_commit_gpa() unconditionally here sleep and enter
> direct reclaim from an MMU notifier invalidation callback?
> 
> mshv_region_interval_invalidate() calls mshv_region_remap_pages() with
> HV_MAP_GPA_NO_ACCESS while holding region->mreg_mutex inside
> mmu_notifier_invalidate_range_start(), including when
> !mmu_notifier_range_blockable(range):
> 
> drivers/hv/mshv_regions.c:mshv_region_interval_invalidate() {
> 	...
> 	if (mmu_notifier_range_blockable(range))
> 		mutex_lock(&region->mreg_mutex);
> 	else if (!mutex_trylock(&region->mreg_mutex))
> 		goto out_fail;
> 
> 	mmu_interval_set_seq(mni, cur_seq);
> 
> 	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> 				      page_offset, page_count);
> 	...
> }
> 
> That reaches hv_do_map_gpa_hcall(), which now calls hv_pre_commit_gpa()
> with page_struct_count (4K pages, with input_page->flags = 0 even when the
> region was mapped with HV_MAP_GPA_LARGE_PAGE).  If the hypervisor asks for
> more memory (for example to shatter a 2M SLAT entry into 4K entries),
> hv_deposit_memory() -> hv_call_deposit_pages() allocates pages with
> GFP_KERNEL.  This sleeps in non-blockable MMU notifier context, triggers a
> lockdep splat on __mmu_notifier_invalidate_range_start_map in
> fs_reclaim_acquire(), and can deadlock if direct reclaim re-enters
> mshv_region_interval_invalidate() on region->mreg_mutex.
> 

All pre-commit does is pre-deposit pages, so map hypercall right below
doesn't keep coming back with insufficient memory. So there is no
regression here... As for the reclaim notifier issue, it needs to
be addressed for movable pages, or rather, movable pages needs to
be re-assessed to resolve such issues.

Thanks,
-Mukesh


