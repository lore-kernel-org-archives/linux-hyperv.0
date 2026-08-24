Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C8415F22;
	Mon, 24 Aug 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582120; cv=none; b=fUFAlgFMrlzHE94QmRBvHD5lkXP45/nnCPGM7XkMdsXdziiUsokPZDMViK8ts3z3Ac7jTSDTLQtGef5Z7hhp9e1pzsMk/70TrmB9Sdx2uGm82BtHp36WXM2Y+OWUSVb1wIXBJU6fmbpBCKisPkscFh8z90BW1R6rc/JnEu/IfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582120; c=relaxed/simple;
	bh=nfxh2QWzuWyBss/SDO71Jk3h9bBLLRSI8axqOGV4kEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7lVqDcWUmLcOWiiDYG345X94iRo3GmetGyBvkSskNjuCgps7V8v2awAKDpC+JuOkXwoB+prevTi1ByHeAH/EyHko/sHRoo6fHW6DJPNhwsY4BfrqzLx/+wJj1CbFHVqIT06BfKqJkJ8K4UHSHUi1Q6HTTJRHhLeJqFRLp5rwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S+XwT2W4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S+XwT2W4"
Received: from [192.168.1.70] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89C6020B7166;
	Mon, 24 Aug 2026 07:34:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89C6020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787582086;
	bh=G1yfKEQYJ91raM7xvnrS0fm+sxBB0bf8Opq4uDl5HbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S+XwT2W4U+OiuoApYOyGGm0AeJvYwSGGWyT6/ixshYMOGVyeMV6IxwDATqJUWvK28
	 gtPfDOFEwnMPlFz7uZ8vPKzzIjcxvO7sVMTRzroMtOkylr8ucEezoxZALhaMsHjq7P
	 eT641UBHxjVfm6/dFDf6RcrfNARfrlrcwknHVIUc=
Message-ID: <dd490d32-50c2-4c7f-8736-f556826b6a2d@linux.microsoft.com>
Date: Mon, 24 Aug 2026 20:05:10 +0530
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
 <SN6PR02MB415723B4BC62C164551B90CDD4A12@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415723B4BC62C164551B90CDD4A12@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/23/2026 9:17 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 9, 2026 11:22 PM
>>
>> group_cpus_evenly() computes how a device's queue interrupts are spread
>> across CPUs. It backs managed-interrupt affinity (kernel/irq/affinity.c)
>> and block-multiqueue mappings (block/blk-mq-cpumap.c), and is invoked
>> independently by every device that uses them - NVMe, NICs, storage HBAs,
>> and virtio devices. Its output is deterministic, i.e. for a given
>> topology, two similar devices produce an identical group-to-CPU mapping.
>>
>> When ngroups < ncpus, some groups end up with only a single CPU. An
>> interrupt whose mask has one CPU can only run there, making that CPU a
>> "hot" handler. Because the mapping is deterministic, identical devices
>> compute the same layout and stack all their single-CPU IRQs onto the
>> very same CPUs, leaving the rest of the system idle.
>>
>> This is easy to hit in practice. On an Azure L96as_v4 VM (96 vCPUs, 2
>> NUMA nodes of 48 CPUs, 6 NVMe disks with 62 I/O queues each),
>> group_cpus_evenly() splits each disk's 62 queues into 31 per node over
>> 48 CPUs. 48 does not divide evenly by 31:
>>
>>      per NUMA node: 48 CPUs / 31 queues
>>        17 groups get 2 CPUs   (cover 34 CPUs)
>>        14 groups get 1 CPU    (cover 14 CPUs)  <- single-CPU "hot" queues
>>
>> That is 14 hot queues per node, 28 per disk. All 6 disks land them on
>> the same 28 CPUs, so 168 hot interrupts pile onto 28 of 96 CPUs while
>> two-thirds of the system handles none:
>>
>>      Before (per-CPU, disks whose IRQs it services):
>>        CPU  0: 3 disks    ...   CPU 34: 6 disks (all six)
>>        CPU  1: 3 disks    ...   CPU 47: 6 disks (all six)
>>      Summary: 28 CPUs (34-47, 82-95) served all 6 disks and the other 68
>>      served only 3. Those 28 CPUs cap throughput and inflate tail
>>      latency while most of the system is idle.
>>
>> Fix this by introducing a per-caller rotation via a static atomic
>> counter (group_spread_cnt). Each call to group_cpus_evenly() takes a
>> unique spread_offset, applied to the two decisions that were previously
>> deterministic:
>>
>> 1) Cluster-level rotation in __try_group_cluster_cpus(): after
>>     alloc_groups_to_nodes() distributes groups proportionally across
>>     clusters, integer rounding leaves some clusters with one extra
>>     group. The extras are redistributed starting from a rotated
>>     position, with a stride of ncluster/total_extra to minimize overlap
>>     between consecutive callers. A multi-pass fallback ensures all
>>     extras are placed even when some clusters are at capacity.
>>
>> 2) Intra-cluster rotation in assign_cpus_to_groups(): the sequential
>>     extra assignment is replaced with a modular expression,
>>       (v + spread_offset) % nv->ngroups < extra_grps
>>     rotating which groups within a cluster receive the extra CPU.
>>
> 
> I've finally been able to review this. It took me a while to get up
> to speed on the overall approach of the existing code, and then your
> changes. I'm sure there are subtleties that I don't yet grok, so my
> comments might be off base.
>

Hi Michael,
Thank you so much for reviewing the code and testing those scenarios.


> My first question is about the placement of your (1) change above.
> It comes after alloc_groups_to_nodes() is called by
> alloc_cluster_groups(), and it modifies what alloc_groups_to_nodes()
> set up. I had expected that your (1) change would be included in
> alloc_groups_to_nodes() so that it would also be applied at the
> NUMA node level. There are cases where the NUMA node count
> might be relatively large, but the cluster count is 0 or 1. In that
> case, your (1) change is never invoked. Maybe there's a reason
> for not applying your updates at the NUMA node level, but that
> reason isn't evident to me.
> 

No, there was no reason to leave it. I coded it, and it is working in my 
initial attempt. I'll see if there are any surprises in AI review. Your 
configuration 1 would be covered with that.

>> Nothing else about the layout changes - same queue count, same NUMA
>> weighting, same full CPU coverage and locality. Each caller simply
>> starts its mapping from a different point, and each individual call
>> still produces a valid, fair distribution. Across callers, different
>> CPUs absorb the single-CPU group IRQ load:
>>
>>      After (same setup, with the rotation):
>>        CPU  0: 4 disks    CPU  2: 4 disks    CPU 47: 4 disks
>>        CPU  1: 4 disks    CPU  3: 4 disks    ...
>>      Summary: no CPU serves more than 4 disks, and all 96 CPUs are used.
>>
>> The total interrupt work is unchanged - every CPU still handles one
>> queue per disk; only the placement of the single-CPU hot queues moves.
>> This benefits every managed-IRQ, blk-mq, and virtio-vdpa / virtio-fs
>> device with no driver changes.
>>
>> Because the offset comes from a global counter advanced once per call,
>> the mapping now depends on call (device probe) order. A given device's
>> exact layout can differ from one boot to the next, and a later recompute
>> (e.g. a blk-mq remap) may pick a different layout. Every such layout is
>> still valid, fair, and proportional - only the choice among equally good
>> mappings varies.
>>
>> On a 96-vCPU Hyper-V VM running 4K random-read fio across 6 NVMe disks,
>> worst-disk degradation versus average dropped from 11% to 5%, and the
>> previously penalized disks gained 12% IOPS at 10% lower latency.
> 
> My second question is about the range of NUMA and cluster
> configurations to which you expect your changes to be applicable. You've
> cited an example above where the changes are very effective. But I
> did some experiments on other configurations, and found them to be
> less effective than I had expected. Maybe my expectations are wrong,
> or the changes have a bug or incompleteness. In at least one case,
> algorithm change (1) not being applied at the NUMA node level may
> be the cause of reduced effectiveness, though I didn't fully investigate
> the details.
> 

The idea at this moment was to cover the worst case scenarios and make 
them less bad. If you see the performance difference, its not going to 
be much, comparing to the complexity we would need to introduce in these 
functions logic.

Second design challenge here is that these APIs get called once per 
device, and one call does not know about the number of queues and number 
of devices that are going to come later.

I could make case 2 and 3 a little better, but could not immediately 
find a way to make it the best version of configuration that could be 
there. But I will think more about it, if that is possible.

Thanks for sharing your thoughts, these are good scenarios to think 
about while solving this problem.

Regards
Naman

> Here are the three configuration I tried:
> 
> 1)  Azure L48s v2 VM. This VM has 6 NUMA nodes, each with 8
> vCPUs. It has 24 clusters, each with two vCPUs that are a hyper-
> threaded pair. It has 6 NVMe controllers, each with 32 queues, so
> there are 192 IRQs to be assigned. With existing code, all 48 vCPUs
> are assigned IRQs:  32 vCPUs get 3 IRQs and 16 vCPUs get 6 IRQs,
> which is somewhat unbalanced but not terrible. With your patch,
> all vCPUs get between 3 and 5 IRQs, which is an improvement, but
> not as good as the theoretical best of 4 IRQs/vCPU. In both cases,
> the NUMA nodes are slightly unbalanced -- 2 NUMA nodes
> get 36 IRQs each, and 4 NUMA nodes get 30 IRQs each.
> 
> 2) Azure D16plds v6 VM. This is an arm64 VM with a single
> NUMA node. It has 1 cluster with all 16 vCPUs because arm64
> uses CONFIG_GENERIC_ARCH_TOPOLOGY, which makes
> clusters degenerate. It has 2 NVMe controllers, each with 6 queues.
> As expected, existing code assigns 2 IRQs each to 6 vCPUs.
> With your patch, 4 vCPUs still have 2 IRQs, while 4 vCPUs have
> 1 IRQ. I had expected that 12 vCPUs would each be assigned
> 1 IRQ, but didn't investigate why that didn't happen.
> 
> 3) Azure D96plds v6 VM. Also an arm64 VM, but with 2 NUMA
> nodes. Again, it has 1 cluster with all 96 vCPUs. It has 6 NVMe
> controllers, each with 14 queues. As expected, existing code
> assigns 6 IRQs to each of 14 vCPUs. With your patch, the IRQs
> are spread across 26 vCPUs (13 in each NUMA node) with
> counts ranging from 1 to 6. I can't discern a pattern in the
> IRQ counts, except that the pattern for each NUMA node
> is the same.
> 
> At this point, I'm just calling out my top-level observations.
> I may look more closely at the details of "why" some of
> these cases don't get much improvement.
> 
> Michael
> 
