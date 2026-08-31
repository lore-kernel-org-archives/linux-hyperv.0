Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B132AD16;
	Mon, 31 Aug 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154278; cv=none; b=lJ+rEbVEHq/WaMy4bwdiHBYccOoJz2pkmm5BIHa2RBlKzGk45sgGW9DB93o6iXx1eOMUDgG2i2V9v33ntiSKXnBfYtpWr7ci5It5hkLGuSA+2GM7IygaHsC7ZKPazCEI03aurj77jjyznMjQ8oRUvyWu5KC7uJcnhUJzQg3imo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154278; c=relaxed/simple;
	bh=LCsSCuuOPY1pn3BqTdBch58ysMowYY/iG3gsfJSXPkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7j48y5dBTBAl2RHoli8sGEFZPx7qpJLYhXuT0tBeSFxIg7KCAPpFcOOMyujqBo8CYjV9CrHxFbPEq4MGNayB2X1vLROioXKLpcZ2Vz0dSgLbKjqrcU6pevTzT3NEWhVtxyZaUbfKD55htwUGwccc+bQUH561pk/uNQMyPeu5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qjqZ77Ix; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qjqZ77Ix"
Received: from [10.95.65.30] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id B271220B7168;
	Sun, 30 Aug 2026 22:30:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B271220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788154234;
	bh=rfO41nkJiRiqETYIHaR71M3ZSyMwQzOASX5L1tk/MB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qjqZ77IxPum1qzTgmXyYgJH1GlzaTbqty2npwQDHwPNe1dzfSulxF4xskZU5Mr/0R
	 qKa4UE9mafvgW2gJ5kBj0rq5ouxwS8V+SfECBG3ztny3dLkicz76Ner2PVdmJYXt74
	 tX25KYWAbhmrdE6E2fT7RNsv2vM+WjNzmitLWezQ=
Message-ID: <fa1b65fb-3f77-4089-8928-e4b8c656759f@linux.microsoft.com>
Date: Mon, 31 Aug 2026 11:01:03 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
To: Michael Kelley <mhklinux@outlook.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Wangyang Guo <wangyang.guo@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Long Li <longli@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
 <SN6PR02MB415735EB56D0EBEAC606282DD4AE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ffd568dc-8292-43c4-b425-a68047a40c8e@linux.microsoft.com>
 <SN6PR02MB4157F84374BFA68158E0D85AD4AA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F84374BFA68158E0D85AD4AA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 5:27 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, August 27, 2026 2:11 AM
>>
>> On 8/26/2026 7:31 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 9, 2026 11:22 PM
>>>
>>> [snip]
>>>
>>>> @@ -510,6 +633,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
>>>>    	if (!masks)
>>>>    		goto fail_node_to_cpumask;
>>>>
>>>> +	spread_offset = (unsigned int)atomic_fetch_inc(&group_spread_cnt);
>>>> +
>>>>    	build_node_to_cpumask(node_to_cpumask);
>>>>
>>>
>>> One additional observation:  In my testing, group_cpus_evenly() is
>>> often called with numgrps set to 1. This happens in the block "loop"
>>> devices (drivers/block/loop.c) and for the NVMe admin queue. In
>>> these cases, the spread_offset is never used, but group_spread_cnt
>>> gets incremented anyway. Incrementing for NVMe admin queues
>>> tends to dirty the spreading for multiple NVMe devices with the
>>> same configuration because it is usually interleaved with the
>>> spreading of the main NVMe I/O queues.
>>>
>>> To improve this, I changed the above code to this:
>>>
>>> +       if (numgrps == 1)
>>> +               spread_offset = 0;
>>> +       else
>>> +               spread_offset = (unsigned int)atomic_fetch_inc(&group_spread_cnt);
>>>
>>> With this change, my configuration #1 (Azure L48s v2 VM) is noticeably
>>> better.  All CPUs in NUMA node 1 have either 3 or 4 IRQs assigned. NUMA
>>> node 0 ranges from 3 to 5 IRQs, but that's partly because the NUMA
>>> nodes themselves aren't balanced, as previously discussed. With your
>>> change to apply group_spread_cnt to the NUMA nodes, and my change
>>> above, my config #1 is likely to work out very near optimal. Of course,
>>> there's no guarantee that some other device won't increment
>>> group_spread_cnt and dirty things, but for the typical case it probably
>>> works very well.
>>>
>>
>> Thanks for the suggestion, I tried this and it works fine.
>>
>>> This change to skip incrementing group_spread_cnt when numgrps == 1
>>> doesn't help my arm64 configs. I'm still thinking about ways to do better
>>> when there aren't any clusters. I have an idea that I'm experimenting
>>> with, but it may be a few more days before I reach any conclusions.
>>>
> 
> I finally figured out why arm64 is different from x86. By adding a
> kernel boot line parameter for controlling the number of NVMe queues
> per controller (for experimentation only), I could construct identical
> configs on x86 and arm64.  And even though the clustering is
> different, group_cpus_evenly() returns exactly the same set of
> cpumasks on the two architectures. So the clustering difference
> isn't the reason for the poor spreading on arm64.
> 
> My experiments have been mostly cases where the number of NVMe
> queues is small compared with the number of CPUs -- e.g., 6 NVMe
> queues on each controller in a VM with 96 CPUs. In this example,
> there are 16 CPUs in the cpumask for each queue. That set of 16
> CPUs is the smp_affinity for the IRQ and is the same for both
> architectures. But determining the single CPU that is the
> effective_affinity is different. The x86 APIC vector code must load
> balance assignments across CPUs because each x86 CPU has a
> limited number of vectors available. At a result, x86 spreads out
> which CPU in the set of 16 becomes the effective_affinity. But arm64
> does not. The GICv3 function gic_set_affinity() always picks the
> 1st CPU in the set of 16 CPUs. So the NVMe IRQs get stacked on
> the same 6 CPUs and the other 90 CPUs get none.
> 
> If the number of queues doesn't evenly divide into the number of
> CPUs, then your patch provides a modest amount of spreading in
> how the cpumasks are constructed, and the interrupt load gets
> slightly more spread on the arm64 CPUs, but not nearly as well
> as on x86.
> 
> I was previously aware of the vector load balancing done by
> x86, but had never compared with what arm64 does. I had
> to run a few experiments to have the light bulb come on in my
> head. :-)  But I learned something so it was time well spent.
> 
> In any case, improving the spreading in such configurations
> on arm64 probably isn't the job of group_cpus_evenly(). The
> arm64 GIC code would need to do some spreading when
> picking the effective_affinity from the CPUs in the affinity mask.
> 
> Michael

Thank you for looking into this and sharing this valuable information 
Michael, it means a lot.

So for now, we have two enhancements - NUMA node level balancing and 
additional (numgrps == 1) check.

I'll make these changes, evaluate them and send them in next version.

Regards,
Naman
