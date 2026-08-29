Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CE357D13
	for <linux-hyperv@vger.kernel.org>; Sat, 29 Aug 2026 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966518; cv=none; b=Tpdpr1oPjv4uawct0hfTuZIFs2AHJK/AXk5UMEgwePxLO4ytKO3fNN5IRXhYdCRdtqoWvtLiK/DtduuhV5upYp0/vyh4MFsvX4GwB9GAoEbmIi9eoDipa1RWOQaMpAYE58P9zrvacD9MCpnhI9iXrcFZ7e1O4v4e3a/WF0gWw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966518; c=relaxed/simple;
	bh=+zQrU98vhTYj/KR3MpHbgaH2hixkvilwrL0lL0io7Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0MUQd/9tETW66gY3g2yAg5uXjN2wPdsT9EdXuYPQba1jHyAQXK6EkW0P7CZi7DZSx7utaZkUJT/ppBVrn7cCuQy5xl9bM2y4FG9ZSrGS5gf6NPR9+65lX8PY4kXy/to+W46mL5J3uqxspAucvcCCcP4yo70HSdTucyOXvAppro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgnD2S0Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgnD2S0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787966505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4eQd8x6rtle8vK9ePOub4Q1UY0x0tjfeHS1+YJ6Wi4=;
	b=WgnD2S0YwpKWKjvqtgmbSCoMos8xG8KU+fhKvwQmXbuXuMN/A0OBuLdYULcDo5peepTHj6
	+AFui0RU/CYlvz0wgNgWj0hdUkj8u+UB8HptqVten3yQXnjqRvHaOGykSEgoY10UQCmokU
	qxPsa6aactaXWkoTjUxrK4J+++1c7Kk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-tHB4TbucMj2tv-8hS-231g-1; Fri,
 28 Aug 2026 21:21:39 -0400
X-MC-Unique: tHB4TbucMj2tv-8hS-231g-1
X-Mimecast-MFC-AGG-ID: tHB4TbucMj2tv-8hS-231g_1787966497
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B90921835AD5;
	Sat, 29 Aug 2026 01:21:37 +0000 (UTC)
Received: from [100.91.18.181] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 388221955D8D;
	Sat, 29 Aug 2026 01:21:36 +0000 (UTC)
Message-ID: <aaf4826e-6b25-45ff-8aec-8cfeae3b4fd5@redhat.com>
Date: Fri, 28 Aug 2026 21:21:35 -0400
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
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260827193750.662623-1-longman@redhat.com>
 <SN6PR02MB415755118796082D643126ACD4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <SN6PR02MB415755118796082D643126ACD4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8/27/26 5:10 PM, Michael Kelley wrote:
> From: Waiman Long <longman@redhat.com> Sent: Thursday, August 27, 2026 12:38 PM
>> There is a retry loop in init_vp_index() where the CPUs from a certain
>> node are stripped out if they have already been in the allocated cpumask
>> or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
>> CPU left, the allocated cpumask is ignored and the process is retried
>> again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
>> out not to contain any CPU in that particular node, that will become an
>> infinite retry loop.  This particular problem was reported by sashiko
>> [1]. This should rarely happen, but we still need to guard against this.
>>
>> Fix this infinite loop problem by also skipping NUMA node that has no
>> housekeeping CPU in the inner while loop of init_vp_index(). As the outer
>> for loop will only be reached if the housekeeping cpumask isn't empty,
>> a NUMA node with housekeeping CPUs will eventually be found.
>>
>> Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kernel.org [1]
>> Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/hv/channel_mgmt.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> index 89d214dda360..ed121d74d73f 100644
>> --- a/drivers/hv/channel_mgmt.c
>> +++ b/drivers/hv/channel_mgmt.c
>> @@ -752,6 +752,7 @@ static void init_vp_index(struct vmbus_channel *channel)
>>   	u32 i, ncpu = num_online_cpus();
>>   	cpumask_var_t available_mask;
>>   	struct cpumask *allocated_mask;
>> +	const struct cpumask *node_mask;
>>   	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>>   	u32 target_cpu;
>>   	int numa_node;
>> @@ -780,14 +781,16 @@ static void init_vp_index(struct vmbus_channel *channel)
>>   				next_numa_node_id = 0;
>>   				continue;
>>   			}
>> -			if (cpumask_empty(cpumask_of_node(numa_node)))
>> +			node_mask = cpumask_of_node(numa_node);
>> +			if (cpumask_empty(node_mask) ||
>> +			    !cpumask_intersects(node_mask, hk_mask))
> The cpumask_empty() test looks to be redundant. The
> cpumask_intersects() test will catch the case where
> node_mask is empty.
>
> Otherwise, I think this looks good as a solution to the core
> problem.
>
> Michael

Yes, I am aware that cpumask_empty() test is redundant and can be 
skipped. I keep it just to make it easier to read. I can certainly drop 
the cpumask_empty() statement.

Cheers,
Longman

>
>>   				continue;
>>   			break;
>>   		}
>>   		allocated_mask = &hv_context.hv_numa_map[numa_node];
>>
>>   retry:
>> -		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
>> +		cpumask_xor(available_mask, allocated_mask, node_mask);
>>   		cpumask_and(available_mask, available_mask, hk_mask);
>>
>>   		if (cpumask_empty(available_mask)) {
>> --
>> 2.55.0
>>

