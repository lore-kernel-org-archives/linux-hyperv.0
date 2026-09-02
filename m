Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B231E824;
	Wed,  2 Sep 2026 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325376; cv=none; b=PkESLmQyLmkZEiuIP/p1V0frqMRV9dg/MR4RgkGlYv7K66Ecem+dEbQixwtYS3ERZWdOzhhu4Zya/A+Otc302DIQES2+jqQptpL+15eAcDScq23ejfgadxdY757Lw27fJxV2zHc4mhruIgJIaQs5nB5Uc4XykY+eIhAsVPbX0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325376; c=relaxed/simple;
	bh=ZnwLyVk6Q7tVd0Acc2yLxF+iGTo+Lx7EJKXUsMixozo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO57dOnFzS3YbG50X1v0+9QniUuad0cWBDb5qlIs6O9SRZfgEMoH1gX0Rw07YqtiEYUODqZqlO541vIdVI8TrhutwQWFFkgjgVL61uxW3sxqSiyiLqmvLV84IjAZULCQoVoyCyoghu6BFwNAAtJL5PKJCG7hTjbwX7I+E6X86a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P/M3qmAJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P/M3qmAJ"
Received: from [192.168.1.70] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCEA520B7129;
	Tue,  1 Sep 2026 22:02:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCEA520B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788325337;
	bh=ENp71upqIOZykYWR/vy+lgBkrXVjharHWw75NHimAk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/M3qmAJ9nG2XdKKAD3+MUkmhjpAiy/wJbHsiMg8agH81rAHkhfV+Zs8/FLvWrZ2d
	 wLF6vn7Ge2yx7/jVufgt7k8xbAwl9lgPT9dkOLEiwVV4giftoEkfov5g7ygzSJe2zI
	 zRb5QOwoOZ33Vx1DSrBgqbk8bdbdVccOerDpxQD0=
Message-ID: <19005077-4dde-4193-aafa-5b248a2131a6@linux.microsoft.com>
Date: Wed, 2 Sep 2026 10:32:52 +0530
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
 <SN6PR02MB4157B73B333F08702875110ED4A82@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157B73B333F08702875110ED4A82@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/1/2026 5:32 AM, Michael Kelley wrote:
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
> 
> This is not quite accurate. The condition is ncpus/2 < ngroups < ncpus.
> If ngroups is <= ncpus/2, then all groups have at least 2 CPUs. If ngroups
> is <= ncpus/3, then all groups have at least 3 CPUs, and so on. Rotating which
> groups get the "extra" CPUs can be somewhat helpful even when all groups
> have at least 2 CPUs. But as the minimum number of CPUs per group
> increases, avoiding excessive stacking depends on how well the irqchip driver
> does spreading when picking the effective affinity CPU from the multiple CPUs
> assigned to the group (per our discussion elsewhere in this thread).
> 

You're right. I should simplify this to something like this “When the 
allocation leaves some groups with only a single CPU, those IRQs are 
forced onto the same CPUs and are stacked up.”

>> interrupt whose mask has one CPU can only run there, making that CPU a
>> "hot" handler. Because the mapping is deterministic, identical devices
>> compute the same layout and stack all their single-CPU IRQs onto the
>> very same CPUs, leaving the rest of the system idle.
>>
>> This is easy to hit in practice. On an Azure L96as_v4 VM (96 vCPUs, 2
>> NUMA nodes of 48 CPUs, 6 NVMe disks with 62 I/O queues each),
>> group_cpus_evenly() splits each disk's 62 queues into 31 per node over
>> 48 CPUs. 48 does not divide evenly by 31:
> 
> And FWIW, this example meets the stricter condition that I describe above ....

True.

> 
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
>>
>> Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
>> Co-developed-by: Long Li <longli@microsoft.com>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>> Changes since v1
>> (https://lore.kernel.org/all/20260324075352.2326972-1-namjain@linux.microsoft.com/):
>> - Cluster base is now a per-cluster proportional floor
>>    (ngroups * cap / ncpus) instead of the global per-cluster minimum,
>>    so proportional weighting is preserved on asymmetric (e.g.
>>    big.LITTLE) cluster topologies. (Sashiko review)
>> - Document that the rotation offset is call/probe-order dependent: a
>>    device's exact layout may vary across boots and recomputes (each
>>    layout is still valid, fair, and proportional).
>> - Rewrite the commit message with a worked example and fio numbers.
>>
>>   lib/group_cpus.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 137 insertions(+), 12 deletions(-)
>>
>> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
>> index e6e18d7a49bba..8bed0f9d2110b 100644
>> --- a/lib/group_cpus.c
>> +++ b/lib/group_cpus.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/cpu.h>
>>   #include <linux/sort.h>
>> +#include <linux/atomic.h>
>>   #include <linux/group_cpus.h>
>>
>>   #ifdef CONFIG_SMP
>> @@ -255,12 +256,20 @@ static void alloc_nodes_groups(unsigned int numgrps,
>>   	alloc_groups_to_nodes(numgrps, numcpus, node_groups, nr_node_ids);
>>   }
>>
>> +/*
>> + * Per-caller rotation counter for group_cpus_evenly().
>> + * Wrapping is harmless: the offset is only used modulo small values
>> + * (ncluster or nv->ngroups), so any unsigned value works.
>> + */
>> +static atomic_t group_spread_cnt = ATOMIC_INIT(0);
>> +
>>   static void assign_cpus_to_groups(unsigned int ncpus,
>>   				  struct cpumask *nmsk,
>>   				  struct node_groups *nv,
>>   				  struct cpumask *masks,
>>   				  unsigned int *curgrp,
>> -				  unsigned int last_grp)
>> +				  unsigned int last_grp,
>> +				  unsigned int spread_offset)
>>   {
>>   	unsigned int v, cpus_per_grp, extra_grps;
>>   	/* Account for rounding errors */
>> @@ -270,11 +279,15 @@ static void assign_cpus_to_groups(unsigned int ncpus,
>>   	for (v = 0; v < nv->ngroups; v++, *curgrp += 1) {
>>   		cpus_per_grp = ncpus / nv->ngroups;
>>
>> -		/* Account for extra groups to compensate rounding errors */
>> -		if (extra_grps) {
>> +		/*
>> +		 * Rotate which groups get the extra CPU so that
>> +		 * successive callers produce different mappings,
>> +		 * avoiding IRQ stacking when multiple devices
>> +		 * share the same CPU topology.
>> +		 */
>> +		if (extra_grps &&
> 
> Explicitly testing extra_grps for zero isn't necessary. If it is
> zero, the "less than" test below will always be false anyway.
> 

That is true, but the intention was to improve readability of this 
block. Unless you really feel that this should be removed, I would 
prefer to retain this.


>> +		    (v + spread_offset) % nv->ngroups < extra_grps)
>>   			cpus_per_grp++;
>> -			--extra_grps;
>> -		}
>>
>>   		/*
>>   		 * wrapping has to be considered given 'startgrp'
>> @@ -361,7 +374,8 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
>>   				     struct cpumask *node_cpumask,
>>   				     struct cpumask *masks,
>>   				     unsigned int *curgrp,
>> -				     unsigned int last_grp)
>> +				     unsigned int last_grp,
>> +				     unsigned int spread_offset)
>>   {
>>   	struct node_groups *cluster_groups;
>>   	const struct cpumask **clusters;
>> @@ -379,6 +393,111 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
>>   	if (ncluster == 0)
>>   		goto fail_no_clusters;
>>
>> +	/*
>> +	 * Rotate which clusters receive extra groups so that different
>> +	 * callers of group_cpus_evenly() produce different group-to-CPU
>> +	 * mappings. Without this, all devices get identical affinity
>> +	 * masks, causing IRQ stacking on CPUs assigned single-CPU groups.
> 
> s/assigned/assigned to/
> 
>> +	 *
>> +	 * alloc_groups_to_nodes() distributes ngroups proportionally, but
>> +	 * integer rounding causes some clusters to get one more group
>> +	 * than others. The assignment is deterministic, so every device
>> +	 * gets the same mapping. Fix: compute a proportional floor for
>> +	 * each cluster (ngroups * cap / ncpus), collect only the
>> +	 * rounding-induced extras, then redistribute them starting from
>> +	 * a rotated position. This preserves the proportional weighting
>> +	 * across differently-sized clusters while rotating the rounding
>> +	 * extras, keeping the rotation effective on both symmetric and
>> +	 * asymmetric cluster topologies.
>> +	 *
>> +	 * Note: after alloc_groups_to_nodes(), cluster_groups[].ngroups
>> +	 * holds the group count (the union no longer holds per-cluster CPU
>> +	 * counts), so each cluster's CPU capacity (cap) is taken from its
> 
> Having to recompute "cap" three times in the code below is fairly clumsy.
> Is there any reason that cluster_groups[].ncpus and .ngroups need to be a
> union? If they were separate fields, then "cap" would be immediately
> available when you need it. I looked back through the commit history
> and LKML discussion for when the union was originally added, and I
> didn't find any explanation for why it is a union. A union saves a bit
> of memory, but the overall amount of memory here is small, so the
> implementation doesn't need to be particularly stingy.

I'll remove the union, and simplify this "cap" re-computation.

> 
>> +	 * mask. The ncpus divisor is the function parameter, which equals
>> +	 * the sum of the per-cluster caps.
>> +	 */
>> +	if (ncluster > 1) {
>> +		unsigned int total_extra = 0;
>> +		unsigned int start, stride;
>> +
>> +		/*
>> +		 * Compute a per-cluster proportional floor and collect
>> +		 * only the rounding-induced extras for redistribution.
>> +		 *
>> +		 * Each cluster's floor is ngroups * cap / ncpus, which
>> +		 * preserves its proportional share.  Only the rounding
>> +		 * remainders (typically one per cluster) are collected
>> +		 * for rotated redistribution, keeping the rotation
>> +		 * effective even on asymmetric topologies (e.g.
>> +		 * big.LITTLE) where differently-sized clusters would
>> +		 * otherwise absorb all extras deterministically.
>> +		 */
>> +		for (i = 0; i < ncluster; i++) {
>> +			unsigned int cap, prop_floor, base;
>> +
>> +			cap = cpumask_weight_and(clusters[cluster_groups[i].id],
>> +						 node_cpumask);
>> +			prop_floor = ngroups * cap / ncpus;
>> +
>> +			/*
>> +			 * Use proportional floor as base.  Ensure at
>> +			 * least 1 group per cluster, and never exceed
>> +			 * alloc_groups_to_nodes()'s original allocation
>> +			 * (which may be less than prop_floor when small
>> +			 * clusters consumed groups via max(1,...)).
>> +			 */
>> +			base = prop_floor > 0 ? prop_floor : 1;
>> +			if (base > cluster_groups[i].ngroups)
>> +				base = cluster_groups[i].ngroups;
>> +
>> +			total_extra += cluster_groups[i].ngroups - base;
>> +			cluster_groups[i].ngroups = base;
>> +		}
> 
> We had a separate discussion about how your new code here should
> go with alloc_groups_to_nodes() so that it is also applied at the NUMA
> node level. You said you had it working. Question: Did you combine the
> above "for" loop with the "for" loop in alloc_groups_to_nodes()? It
> seems unnecessarily complex to do group allocations, including extras,
> using the "for" loop in alloc_groups_to_nodes(), and then follow that
> with another "for" loop here to figure out which nodes got extras and
> strip them out. A single loop should be able to set all the nodes to
> their base value and count the extras.
> 

I just did a prototype and had not combined it yet. I'll try to combine 
them into a single function now.

>> +
>> +		/*
>> +		 * Redistribute rounding extras using a stride to scatter
>> +		 * them across clusters.  With stride = ncluster / extras,
>> +		 * consecutive callers' extra sets overlap minimally
>> +		 * (e.g. max 2 overlap for 6 callers with 24 clusters
>> +		 * and 7 extras, vs 6 overlap with stride 1).
>> +		 */
>> +		start = spread_offset % ncluster;
>> +		stride = (total_extra > 0 && total_extra < ncluster) ?
>> +			 ncluster / total_extra : 1;
>> +
>> +		for (i = 0; i < ncluster && total_extra > 0; i++) {
>> +			unsigned int idx =
>> +				(start + i * stride) % ncluster;
>> +			unsigned int cap;
>> +
>> +			cap = cpumask_weight_and(clusters[cluster_groups[idx].id],
>> +						 node_cpumask);
>> +			if (cluster_groups[idx].ngroups < cap) {
>> +				cluster_groups[idx].ngroups++;
>> +				total_extra--;
>> +			}
>> +		}
>> +
>> +		/* Fallback: place remaining extras wherever they fit */
> 
> Just so I'm clear, you could have "remaining extras" because a stride > 1
> in the previous loop could miss some clusters/nodes that have available
> space, depending on how the arithmetic works out. The code below
> does essentially the same thing, but with a stride of 1 so that every
> node is checked.  And you might have to make multiple passes in
> case some nodes have space for two or more extras. But you know
> there's enough space available somewhere.
> 
> Is my understanding correct?
> 

Yes, this is correct.

>> +		while (total_extra > 0) {
>> +			unsigned int placed = 0;
>> +
>> +			for (i = 0; i < ncluster && total_extra > 0; i++) {
>> +				unsigned int cap;
>> +
>> +				cap = cpumask_weight_and(clusters[cluster_groups[i].id],
>> +							 node_cpumask);
>> +				if (cluster_groups[i].ngroups < cap) {
>> +					cluster_groups[i].ngroups++;
>> +					total_extra--;
>> +					placed++;
>> +				}
>> +			}
>> +			if (!placed)
>> +				break;
> 
> Is the control variable "placed" necessary? If all the extra groups are
> guaranteed to fit somewhere, then total_extra should go to zero and
> the checks on total_extra > 0 will break out of the loops. Thinking about
> it from the other direction, if the "for" loop ever completed without
> incrementing "placed", wouldn't that mean total_extra is still
> non-zero, and you have an extra group that isn't assigned to a
> cluster/node?
> 
> Michael

It's not required. I should remove it.

Regards,
Naman
