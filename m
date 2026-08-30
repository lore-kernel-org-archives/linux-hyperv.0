Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C473311C36
	for <linux-hyperv@vger.kernel.org>; Sun, 30 Aug 2026 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133157; cv=none; b=h7FI9x6/VGwXGiNt+dxOEoL+qkyih1TCZtZt+dUFSiz2CZdO9qtrU8aljKHCFBrsMOZ9WMGT4+zL9TF54YHF/hVfwMoctihrxkd5PVIRRKcNXmjh+qvZlkghh2YNdVRhQt4NuFOYwkRP3QJzcMKmCdqIEycod2RRzBK1RS3i3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133157; c=relaxed/simple;
	bh=Usx5lwl5n9XpT/PcyVdJkAARY+S5BiVlfV/s1vU7KQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFsGc8Yv8t1QrBzf+Zf5j+HXshMAvLOLmZMLYGBwR1pcrcjhemd2r10Tm2vv2y8nnrOEVcj+Nd+LhIboYm79A5EAA+qm2UI7FY9hilc00YsZ2U9Ny1yY7Lwq4nrMCxfmlf2c77lhVBBy7PJoJ6ugDXxddtO1n3uFTOmKDLP1wB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTmzI+kW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTmzI+kW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788133154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ol6gNgrKiwoeuBxPS4BqyR4X8WD4H1/GCsMThRbHN8=;
	b=NTmzI+kWkqZnngo5Ps5kHkt11YcvOa35ovGfogYjMss1leHgEERsmWYH4DBtvOOXzKC13z
	WqpJTZl+WKZr4qc88fdn3L1Z9xZHrwZSnM8OdZZV7Sir3ynaRiY0+6axTyaW5rCPoN7loj
	mcUBV38m1Ptr0C/xOvHj2MvyfciCAQE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-aGhgeMCQNV21asgzB1t0IA-1; Sun,
 30 Aug 2026 19:39:11 -0400
X-MC-Unique: aGhgeMCQNV21asgzB1t0IA-1
X-Mimecast-MFC-AGG-ID: aGhgeMCQNV21asgzB1t0IA_1788133149
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B415219541A8;
	Sun, 30 Aug 2026 23:39:09 +0000 (UTC)
Received: from [100.91.18.181] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 512F2195608A;
	Sun, 30 Aug 2026 23:39:08 +0000 (UTC)
Message-ID: <8d38f7c0-f15d-4568-bc2f-559179ccb45c@redhat.com>
Date: Sun, 30 Aug 2026 19:39:07 -0400
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
To: Michael Kelley <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260827193750.662623-1-longman@redhat.com>
 <SN6PR02MB415755118796082D643126ACD4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aaf4826e-6b25-45ff-8aec-8cfeae3b4fd5@redhat.com>
 <SN6PR02MB4157019C1A3D1233CAFAC2D0D4AA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <SN6PR02MB4157019C1A3D1233CAFAC2D0D4AA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8/30/26 7:17 PM, Michael Kelley wrote:
> From: Waiman Long <longman@redhat.com> Sent: Friday, August 28, 2026 6:22 PM
>> On 8/27/26 5:10 PM, Michael Kelley wrote:
>>> From: Waiman Long <longman@redhat.com> Sent: Thursday, August 27, 2026 12:38 PM
>>>> There is a retry loop in init_vp_index() where the CPUs from a certain
>>>> node are stripped out if they have already been in the allocated cpumask
>>>> or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
>>>> CPU left, the allocated cpumask is ignored and the process is retried
>>>> again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
>>>> out not to contain any CPU in that particular node, that will become an
>>>> infinite retry loop.  This particular problem was reported by sashiko
>>>> [1]. This should rarely happen, but we still need to guard against this.
>>>>
>>>> Fix this infinite loop problem by also skipping NUMA node that has no
>>>> housekeeping CPU in the inner while loop of init_vp_index(). As the outer
>>>> for loop will only be reached if the housekeeping cpumask isn't empty,
>>>> a NUMA node with housekeeping CPUs will eventually be found.
>>>>
>>>> Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kernel.org [1]
>>>> Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs")
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    drivers/hv/channel_mgmt.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>>>> index 89d214dda360..ed121d74d73f 100644
>>>> --- a/drivers/hv/channel_mgmt.c
>>>> +++ b/drivers/hv/channel_mgmt.c
>>>> @@ -752,6 +752,7 @@ static void init_vp_index(struct vmbus_channel *channel)
>>>>    	u32 i, ncpu = num_online_cpus();
>>>>    	cpumask_var_t available_mask;
>>>>    	struct cpumask *allocated_mask;
>>>> +	const struct cpumask *node_mask;
>>>>    	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>>>>    	u32 target_cpu;
>>>>    	int numa_node;
>>>> @@ -780,14 +781,16 @@ static void init_vp_index(struct vmbus_channel *channel)
>>>>    				next_numa_node_id = 0;
>>>>    				continue;
>>>>    			}
>>>> -			if (cpumask_empty(cpumask_of_node(numa_node)))
>>>> +			node_mask = cpumask_of_node(numa_node);
>>>> +			if (cpumask_empty(node_mask) ||
>>>> +			    !cpumask_intersects(node_mask, hk_mask))
>>> The cpumask_empty() test looks to be redundant. The
>>> cpumask_intersects() test will catch the case where
>>> node_mask is empty.
>>>
>>> Otherwise, I think this looks good as a solution to the core
>>> problem.
>>>
>>> Michael
>> Yes, I am aware that cpumask_empty() test is redundant and can be
>> skipped. I keep it just to make it easier to read. I can certainly drop
>> the cpumask_empty() statement.
>>
> The flip side is people like me try to figure out "why is this
> here?", thinking there must be a reason. :-)  I'd say drop the
> code and add a comment like "Also catches an empty node_mask".

Fair, will do that.

Thanks,
Longman

> Michael

