Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963939A060;
	Mon, 10 Aug 2026 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351632; cv=none; b=SwdIGLLouwAJRRGz4QCPbXARvGYFgSnkvmW+FOGukISAwPvlLG2jy+opVsg6ix/n70vdy7OaS4hCJRHSTO9kUsLzmsBWF9a+LdSZNypYscL9QTDt2mmnRfO51r4Mkuhapi/ZOZlnLMlSlooOOeVkeFAV77wJyDALQNYS08QsGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351632; c=relaxed/simple;
	bh=HUTfnTXnEQIt4LfxR74Y0DC3dl2fiMrJd1c6JPp96dE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JWdnamRrQX2Akp2hWF6DF0FR/oMJ0BqSBw+q/n0makhmUlXoU5ekFl+JMN5mKDwFDutfr0WVC39xMQybjemUVWUQYsbC7Fye2pvPHgDOJDYvuKsDjDEG8+wpArA/Iq7hEIn2w9Qwkf4sAw8kFaEt4FKAHrvnfA3HSRqTdz8tKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N2ajSEza; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N2ajSEza"
Received: from [10.7.58.6] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1AF7C20B7166;
	Mon, 10 Aug 2026 01:46:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1AF7C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786351604;
	bh=pqoczrzoKBE5UEH/72QJFq494rVfCWgfuUuZjpkn8Io=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=N2ajSEzaj30rlJbB5+g7Vt4abrSus07RVzWAFtTM493j0uC1A3H54TE1LRuCSCNIV
	 GYw5zhOqtmJ1JHjz42EJUeDCyQZPGi7WuLHsbSOVEuH3KD3IIACzQJxaZA9ci20ZKo
	 46QIX0b1pWVhXZrV/umzECp4qpnPuKlUteimewwo=
Message-ID: <6bb5bdd9-dbfb-4ac1-8f4a-c21fdadceec0@linux.microsoft.com>
Date: Mon, 10 Aug 2026 14:17:08 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
From: Naman Jain <namjain@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Wangyang Guo <wangyang.guo@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Long Li <longli@microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260810062144.2108758-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/2026 11:51 AM, Naman Jain wrote:
> group_cpus_evenly() computes how a device's queue interrupts are spread
> across CPUs. It backs managed-interrupt affinity (kernel/irq/affinity.c)
> and block-multiqueue mappings (block/blk-mq-cpumap.c), and is invoked
> independently by every device that uses them - NVMe, NICs, storage HBAs,
> and virtio devices. Its output is deterministic, i.e. for a given
> topology, two similar devices produce an identical group-to-CPU mapping.
> 
> When ngroups < ncpus, some groups end up with only a single CPU. An
> interrupt whose mask has one CPU can only run there, making that CPU a
> "hot" handler. Because the mapping is deterministic, identical devices
> compute the same layout and stack all their single-CPU IRQs onto the
> very same CPUs, leaving the rest of the system idle.
> 
> This is easy to hit in practice. On an Azure L96as_v4 VM (96 vCPUs, 2
> NUMA nodes of 48 CPUs, 6 NVMe disks with 62 I/O queues each),
> group_cpus_evenly() splits each disk's 62 queues into 31 per node over
> 48 CPUs. 48 does not divide evenly by 31:
> 
>      per NUMA node: 48 CPUs / 31 queues
>        17 groups get 2 CPUs   (cover 34 CPUs)
>        14 groups get 1 CPU    (cover 14 CPUs)  <- single-CPU "hot" queues
> 
> That is 14 hot queues per node, 28 per disk. All 6 disks land them on
> the same 28 CPUs, so 168 hot interrupts pile onto 28 of 96 CPUs while
> two-thirds of the system handles none:
> 
>      Before (per-CPU, disks whose IRQs it services):
>        CPU  0: 3 disks    ...   CPU 34: 6 disks (all six)
>        CPU  1: 3 disks    ...   CPU 47: 6 disks (all six)
>      Summary: 28 CPUs (34-47, 82-95) served all 6 disks and the other 68
>      served only 3. Those 28 CPUs cap throughput and inflate tail
>      latency while most of the system is idle.
> 
> Fix this by introducing a per-caller rotation via a static atomic
> counter (group_spread_cnt). Each call to group_cpus_evenly() takes a
> unique spread_offset, applied to the two decisions that were previously
> deterministic:
> 
> 1) Cluster-level rotation in __try_group_cluster_cpus(): after
>     alloc_groups_to_nodes() distributes groups proportionally across
>     clusters, integer rounding leaves some clusters with one extra
>     group. The extras are redistributed starting from a rotated
>     position, with a stride of ncluster/total_extra to minimize overlap
>     between consecutive callers. A multi-pass fallback ensures all
>     extras are placed even when some clusters are at capacity.
> 
> 2) Intra-cluster rotation in assign_cpus_to_groups(): the sequential
>     extra assignment is replaced with a modular expression,
>       (v + spread_offset) % nv->ngroups < extra_grps
>     rotating which groups within a cluster receive the extra CPU.
> 
> Nothing else about the layout changes - same queue count, same NUMA
> weighting, same full CPU coverage and locality. Each caller simply
> starts its mapping from a different point, and each individual call
> still produces a valid, fair distribution. Across callers, different
> CPUs absorb the single-CPU group IRQ load:
> 
>      After (same setup, with the rotation):
>        CPU  0: 4 disks    CPU  2: 4 disks    CPU 47: 4 disks
>        CPU  1: 4 disks    CPU  3: 4 disks    ...
>      Summary: no CPU serves more than 4 disks, and all 96 CPUs are used.
> 
> The total interrupt work is unchanged - every CPU still handles one
> queue per disk; only the placement of the single-CPU hot queues moves.
> This benefits every managed-IRQ, blk-mq, and virtio-vdpa / virtio-fs
> device with no driver changes.
> 
> Because the offset comes from a global counter advanced once per call,
> the mapping now depends on call (device probe) order. A given device's
> exact layout can differ from one boot to the next, and a later recompute
> (e.g. a blk-mq remap) may pick a different layout. Every such layout is
> still valid, fair, and proportional - only the choice among equally good
> mappings varies.
> 
> On a 96-vCPU Hyper-V VM running 4K random-read fio across 6 NVMe disks,
> worst-disk degradation versus average dropped from 11% to 5%, and the
> previously penalized disks gained 12% IOPS at 10% lower latency.
> 
> Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
> Co-developed-by: Long Li <longli@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko pointed to a minor issue in this patch, which can be addressed 
in the next version. It was not seen when I ran Sashiko locally.
I would also want to add CC: stable tag and stable list in the next version.

But I will wait for any reviews on this patch before sending the next 
version.

Regards,
Naman

Link: 
https://sashiko.dev/#/patchset/20260810062144.2108758-1-namjain%40linux.microsoft.com


