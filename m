Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793332849;
	b=QGtJwhIJckAzAXDVpvqOs1c1N5NIu/TJ66ti6fZkpjweOhFPTjjn3fVEXJ/s/koh+x70
	 XumOfDh4+E3rlW5LNvE5og14Sm6fBb8p+PTC46pgjgOKSoAd0L76C8wKDUe1ZvXE8e/ud
	 HdAUqizgoH3muApufZnht9sw3f59DiUL/EFhzgU+JCau4qtPnjPyVSxq4G86abr6/yYG7
	 QP107VWTmNyqeTeQXSl4Bx+oANVHBVqDopl7EvTwPlk3gyZFOe0VnbPC4xI2Gpd1ciHxl
	 hZ4bEL7FDCm1+AjHsqJf+CaEXeu+o3AqSvZqKzWpEz7iU9vXWHUxKVHFTqHRCG7YwVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332849;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=ZymhCZv4QhfyzB3ebHwIZug3V/c78mQ4jnj3xtengqc=;
	b=HJw6FWvDkV0ys4K0XIe8KDJ3vSlOKQUJor6mLol3bkGay1nnlge5waeK94qS6AAYuj4d
	 d4QyLarwAqkj+MIOUlVYKzzJvxVEI6w41XGIsjYLPT66uMZN4GShPrDNRTdX6Yf1gWTdB
	 sq6smKjTNUlMcsUz0GVH8oTzQ5mXs5mDON9VGpOjTxHXyMhISsgVQr+XFRa3ywuQ2bMwV
	 5KYQBeM34fkNAm+D2qnOMyBWCNtVZNYkKtbUal/t9IA2/E47PYo2ejnNORAO/6pvrQrm2
	 hBaqUoAF8eWXo1RLJlqR+j+0zxHJZjvqvPXZfwpZbgZBm8ORr64D2FVp9zrv8sIB9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=S3gXzT7n;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DFC606A31A;
	Fri, 30 Oct 2026 04:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18DFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=S3gXzT7n
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0049020B7166;
	Thu, 29 Oct 2026 21:00:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0049020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793332835;
	bh=ZymhCZv4QhfyzB3ebHwIZug3V/c78mQ4jnj3xtengqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3gXzT7ngOUpeWZ+y63S1dUQvRyR16J3LxH6MTy95tnmo8SQKb3ehM2z9bU5cZxXA
	 0slBa0D3pONNwxsFuxTqCq7rKts4woRooKbcFoeUy1wLIpZasZIj3G9GI2vIZlZAYY
	 b/gkDO3Vd+g1uGujfjVirzeUXQLZl+13tL0UYtKI=
Message-ID: <474b50db-438e-4ab5-8e8e-cf4dd713885a@linux.microsoft.com>
Date: Fri, 30 Oct 2026 09:30:46 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Account for lazy mm_cpumask maintenance
To: Michael Kelley <mhklinux@outlook.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261029064234.362385-1-namjain@linux.microsoft.com>
 <MN2PR02MB686397041FA339BEC423FBB3D46D2@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB686397041FA339BEC423FBB3D46D2@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/2026 8:09 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, October 28, 2026 11:43 PM
>>
>> CPUs no longer running an mm may remain in mm_cpumask(). Hyper-V treats
>> these CPUs as flush targets and bypasses the native callbacks that trim
>> the mask. A single-threaded process can therefore keep issuing
>> all-processor flushes after visiting all CPUs and returning to one CPU.
>>
>> Share the native target predicate and filter the mask before building
>> either hypercall format or selecting HV_FLUSH_ALL_PROCESSORS. Preserve
>> lazy-TLB exclusion and unfiltered page-table-freeing flushes, and use
>> native callbacks for periodic trimming and ASID transitions.
>>
>> When no remote targets remain, request immediate trimming through native
>> callbacks so stale memberships do not unnecessarily prevent later
>> invalidations from using the local fast path. Leave lazy CPU-mask
>> maintenance during context switches unchanged.
>>
>> Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> 
> I've read the commit message but haven't yet delved into the code for
> this patch. But the commit message feels like it is missing some context,
> particularly with the "Fixes:" tag.
> 
> I recall the last significant change to hyperv_flush_tlb_multi(), which takes
> CPUs in lazy tlb mode into account, and thereby avoids unnecessary flushing
> (commit 493cc07385cf, made in March 2023). It was a case where the
> native x86 flush code had gotten smarter, and the Hyper-V PV flush
> functions had not been updated to be smarter in the same way. Against
> that context, what is the situation here? Commit 209954cbc7d0 came a
> year and a half later in November 2024. Did it make things worse for the
> Hyper-V PV flush functions, and hence is deemed to have "broken"
> them? Or is it another native flush improvement that the Hyper-V PV
> flush functions just don't take advantage of?
> 
> I'm also curious how the issue was noticed. Was there a real-world
> performance problem, or is it a case of looking at the code and
> noticing a native improvement that hadn't been applied to the
> Hyper-V PV flush functions? The scenario of a single-threaded process
> visiting all CPUs and then returning to one CPU seems contrived,
> particularly as CPU counts get large. It may illustrate the improvement
> that is possible, but to me seems unlikely to be how the problem was
> originally noticed.
> 
> I intended to review the code carefully, but the additional context
> would be helpful in doing that review.
> 
> Michael
> 

Thanks Michael for looking into this.

We first observed a performance regression between Linux 6.8 and 7.0
on Azure MI300X VMs running SuperBench's eight-GPU PyTorch LSTM training
benchmark, using distributed data parallelism in FP32 and FP16.
Recreating DataLoader workers each epoch triggered long host-to-GPU
copy stalls and timeouts. We bisected the regression to commit being
fixed and then developed the reduced reproducer to isolate the excessive
Hyper-V TLB flushes. The CPU-visiting test came out of that
investigation, it was not how the problem was originally noticed.

209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily") changed where
stale mm_cpumask entries are removed. Previously, switching a CPU from
mm A to mm B cleared its bit in A's mask. After that change, the bit is
left set for removal by the native TLB flush callback when it finds a
different mm loaded.

The Hyper-V hypercall path bypasses that callback, so historical
memberships can persist. The lazy-TLB check from 493cc07385cf does not
cover this case: a CPU actively running B can have is_lazy == false
while still appearing in A's mask. Hyper-V then unnecessarily targets
it when flushing A. If the historical memberships cover all present
CPUs, the all-processors shortcut is selected before the per-CPU
lazy-TLB checks.

So the later change did make the Hyper-V path worse for affected
workloads, rather than merely adding a native optimization that
Hyper-V could also benefit from. That is the reason for the Fixes tag.
This is a performance regression, not a stale-translation correctness
failure.

The reporter has also tested the patch on a 96-vCPU MI300X VM. The
unpatched SuperBench workload hit the 600-second timeout; two patched
runs completed in 424 and 436 seconds, with all eight ranks validated.
The kernel configurations matched apart from kernel identity, and
the GPU driver source and executable text were unchanged.

For the reduced reproducer, the 96-CPU-history case dropped from
109.196 us per iteration to 1.594 and 1.616 us in the two patched runs,
about a 98.5% reduction. Each iteration contains two mprotect() calls
and a write, these are not individual hypercall timings.

The patch preserves your lazy-TLB exclusion and lazy CPU-mask
maintenance during context switches. It filters the targets before
selecting the hypercall format or the all-processors shortcut, and
uses native callbacks for mask trimming.

I restricted the commit msg to the mentioned 32 vCPU VM because that was
the one I got my hands on. I'll try to update the commit message or the
comments to explain the real workload, bisection, and distinction
between lazy TLB mode and lazy CPU-mask maintenance. But I'll wait for
any review comments to address them together.

Thanks,
Naman

>> ---
>> On a 32-vCPU Hyper-V guest, after a single-threaded process visited all
>> CPUs and returned to one CPU, the reproducer's median time per iteration
>> (two mprotect() calls and a write) dropped from 17.235 us to 1.622 us,
>> a 90.6% reduction. This could be more on higher vCPU VMs.
>>
<snip>

