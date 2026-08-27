Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA573FD12A;
	Thu, 27 Aug 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821888; cv=none; b=li1aimdqA9BPh42B0Cw6sRu6QZQZnxtuVPfjZUnBId+iN2Wl9ghZc11u3wXOQjtd612aaW4jjctmwiNfh1QuZ/VAqB6YabNmUyQJ1lDvfLTwKpc4+kBDIe/n1rGJaPQfXkTZ4WRTP7iv6rcSB6Rc8awcKy6LpgFhFWBuX4av5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821888; c=relaxed/simple;
	bh=rqn5qgF0ey7m+CUiH7k4tp5mvuDf4KdzxBl57y0xAiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZTHehopcKm07iywora1Xg+9KMVRZQgH/BBX/Cxv5J37hpI+N0B+tfhaLOAiXJRnhXhBIoDeBBjxg8S/zvcjwy5lhAirIHASvx2s/cPF80kKUDH2IRz7UrcnyaUe+2SLUgak3F3fsa1LpagFd5YUm/PiSjqWWz7wpI/tGZ/NY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eirjbYFv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eirjbYFv"
Received: from [10.95.65.43] (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54DF620B7167;
	Thu, 27 Aug 2026 02:10:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54DF620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787821852;
	bh=Hm2hfLqIvPKYexzQZBKUPaVmWCI7ULZvISViEVv0iVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eirjbYFv1kwyLaDCsuBnLhfr4Fo/2Sq9pdMPLpqbaXThZfu+DBj3FxQTkSBrq38f6
	 UqJ48VrWXAHO1gcvwhwE/zguzpn6dSdSWMPeX/e9nWJjIiFsJQuCL87XmFFh20Jj6N
	 xKmeqnnpJMlWS4odRvvyg6KtHNboGM9yFdE5FnV0=
Message-ID: <ffd568dc-8292-43c4-b425-a68047a40c8e@linux.microsoft.com>
Date: Thu, 27 Aug 2026 14:41:19 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415735EB56D0EBEAC606282DD4AE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/26/2026 7:31 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 9, 2026 11:22 PM
> 
> [snip]
> 
>> @@ -510,6 +633,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
>>   	if (!masks)
>>   		goto fail_node_to_cpumask;
>>
>> +	spread_offset = (unsigned int)atomic_fetch_inc(&group_spread_cnt);
>> +
>>   	build_node_to_cpumask(node_to_cpumask);
>>
> 
> One additional observation:  In my testing, group_cpus_evenly() is
> often called with numgrps set to 1. This happens in the block "loop"
> devices (drivers/block/loop.c) and for the NVMe admin queue. In
> these cases, the spread_offset is never used, but group_spread_cnt
> gets incremented anyway. Incrementing for NVMe admin queues
> tends to dirty the spreading for multiple NVMe devices with the
> same configuration because it is usually interleaved with the
> spreading of the main NVMe I/O queues.
> 
> To improve this, I changed the above code to this:
> 
> +       if (numgrps == 1)
> +               spread_offset = 0;
> +       else
> +               spread_offset = (unsigned int)atomic_fetch_inc(&group_spread_cnt);
> 
> With this change, my configuration #1 (Azure L48s v2 VM) is noticeably
> better.  All CPUs in NUMA node 1 have either 3 or 4 IRQs assigned. NUMA
> node 0 ranges from 3 to 5 IRQs, but that's partly because the NUMA
> nodes themselves aren't balanced, as previously discussed. With your
> change to apply group_spread_cnt to the NUMA nodes, and my change
> above, my config #1 is likely to work out very near optimal. Of course,
> there's no guarantee that some other device won't increment
> group_spread_cnt and dirty things, but for the typical case it probably
> works very well.
> 

Thanks for the suggestion, I tried this and it works fine.

> This change to skip incrementing group_spread_cnt when numgrps == 1
> doesn't help my arm64 configs. I'm still thinking about ways to do better
> when there aren't any clusters. I have an idea that I'm experimenting
> with, but it may be a few more days before I reach any conclusions.
> 
> Michael

Acked.

Regards,
Naman
