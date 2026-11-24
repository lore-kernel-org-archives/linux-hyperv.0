Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550502;
	b=rLuR0nJGPeOu+ILNnKGVF+0H4PEp/PjeLWf+1pzRbWNCY4ZC7M6fOovW3nZ++QtOC8lR
	 4Dx1pwnOt4j+o5GY18pfwRgUXFGp+mFccFQj1+e29kCcuZrI4E961LfniTIIsUpelQjWt
	 AaC3D4u4HWFuim7fnN1wxMTCxCM0yGVux6p47WaiY/lxU1tyRWQQmVLr660EY9RX8AXPo
	 OeM7aiGv0421DEe5JsZQArb7Vcx1n2IIgWy8F2Feapg384l7LeoNO34BO8n2BaRszjQip
	 OQwIOjKv/giZST7PXlR0EQOhA0cmfuMd+btUDxNYutYYtqqGrV/9rWPIWNIEOPpGG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550502;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=BKxJ3DLnHYuksjtfFxPxSiba8snVNcLGK7Pf4JdVJJc=;
	b=2T021Yoliv4vupqlYFClKrQ96p2xdBEk6a5B6aPwoCZB0P/5DCPo3t3B9mNlMpc8sUOB
	 RTG4gfS74wHKgYMOrDgtqyMudWFqD39D6Zu9WQ278Fes3a3uhFJ59M4OxFMCt6OXcRtLh
	 WYnwEOpGHIdh+Yb/KgJArP/Flpz1Vjlt+7FDciw6HPHp4SedT5Qi7Wv6pDSF3ATB75W9t
	 TKxb5ywWts/4mN6XjCaECZpZnOnUVu00P9deCRLLek0g3Zj+rLDKXFWMoCPvtxI0xape8
	 TO2PXOEv3bCK+jzOEeQh2zYhIeu5ApHQfT0JBQhVhwP5kfCOSVHag/Wy522IRw9mbVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ajCIUu4n;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE441606A337;
	Tue, 24 Nov 2026 20:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE441606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ajCIUu4n
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A456320B7166;
	Tue, 24 Nov 2026 12:01:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A456320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795550496;
	bh=BKxJ3DLnHYuksjtfFxPxSiba8snVNcLGK7Pf4JdVJJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ajCIUu4ngw7n9+d9FShh/4Wfuo3Y0DClajy5njeq5j0kmIq53dptDbdydLCmIgzDS
	 +J4l3GrILuyTbk43mLr46CNYZPvcz35rhW9ZhHHN87a9/YTWHR9Lmsvzv7rxapCUkr
	 f4rq8h30qpg/R2lohFaSS9tCCGxr1XKk2GCECzyg=
Message-ID: <825a1398-afbb-8b54-1d76-90a5e4aabb55@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:01:40 -0800
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
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>
References: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
 <MN2PR02MB6863E6A55A9C64B4C30CAA2CD4462@MN2PR02MB6863.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863E6A55A9C64B4C30CAA2CD4462@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/26 20:24, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, November 6, 2026 6:49 PM
>>
>> Pre commit reduces TLB flush overheads in the hypervisor. On systems
>> with large number of CPUs, there is signficant advantage to doing
>> this. Pre-commit allows the hypervisor to build all data structs needed
>> in anticipation of the map gpa hypercall, thus reducing or eliminating
>> deposit page returns from the map gpa hypercall, and as a result reducing
>> TLB flushes. In some performance benchmarks, it made the maps of large
>> ranges almost 30% faster.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root_hv_call.c | 52 ++++++++++++++++++++++++++++++++++
>>   include/asm-generic/mshyperv.h |  3 ++
>>   include/hyperv/hvgdk_mini.h    |  1 +
>>   include/hyperv/hvhdk.h         |  7 +++++
>>   4 files changed, 63 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index bf0f90515dad..5c44ba8f72b0 100644
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
>> +
> 
> The pre-commit call uses the original GFN and page struct count, so
> evidently the pre-commit functionality in the hypervisor does not need
> to know if the follow-on MAP_GPA_PAGES hypercall will be specifying
> large pages. I don't know anything about the pre-commit functionality,
> but my guess would have been that it is allocating page table pages, and
> that the large page flag would let it know that only PMD level is needed.
> Do you know those details?  Just curious ....
> 
>>   	while (done < page_count) {
>>   		ulong i, completed, remain = page_count - done;
>>   		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 4c9f3353074a..a3d497d99b0b 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -28,6 +28,9 @@
>>
>>   #define VTPM_BASE_ADDRESS 0xfed40000
>>
>> +#define HV_REP_COUNT_MAX        \
>> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
>> +
>>   enum hv_partition_type {
>>   	HV_PARTITION_TYPE_GUEST,
>>   	HV_PARTITION_TYPE_ROOT,
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 966945f0504f..16c41ee5079a 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -489,6 +489,7 @@ union hv_vp_assist_msr_contents {	 /*
>> HV_REGISTER_VP_ASSIST_PAGE */
>>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>>   #define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
>>   #define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
>> +#define HVCALL_PRECOMMIT_GPA_PAGES			0x00be
>>   #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>>   #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>>   #define HVCALL_DISPATCH_VP				0x00c2
>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>> index 0c89c62c9706..3944e51d0a2d 100644
>> --- a/include/hyperv/hvhdk.h
>> +++ b/include/hyperv/hvhdk.h
>> @@ -953,4 +953,11 @@ struct hv_input_modify_sparse_spa_page_host_access {
>>   #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
>>   #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
>>
>> +struct hv_input_precommit_gpa_pages {	/*
>> HV_INPUT_PRECOMMIT_GPA_PAGES */
>> +	u64 partition_id;
>> +	u32 flags;
>> +	u32 reserved;
>> +	u64 target_gpa_base;
>> +} __packed;
> 
> Does Windows put this struct in hvhdk.h? Its close relative from
> a functional standpoint, struct hv_input_map_gpa_pages, is in
> hvhdk_mini.h, so that would seem to be a more natural place for
> this. But I never have understood the criteria for being in one vs.
> the other.

Correct, it is in hvhdk.h of the hypervisor exported headers.

Yeah, what I understand is: hvhdk and hvgdk are actually generated
headers from bunch of internal headers that chooses to export certain
structs, not my preferred way, but I am sure there were/are good
reasons like the many versions of windows that consume these.
The h and g in hvHdk and hvGdk indicate the intended target: host
or guest... but I think over time it got little mixed up...

Thanks,
-Mukesh

