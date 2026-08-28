Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE53BBFAD;
	Fri, 28 Aug 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895632; cv=none; b=iuZ84yBf32n4X8Qv52GRwqtOGv4l4fP1z0IeC8ojngIYaF7fkxfMZt2QkMCz+N/m8GYslcou/wnZ7ME1fBTbEo857HJ/rgsOMv11tfXSI/YJfzR3g4qiQYA/6coSQ4WPbh5KajIaKCe7HdCzv/TJDnRQpLsY5XGYz0IVIoNpBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895632; c=relaxed/simple;
	bh=eUbFwp2PG0fl1ojsL6Secy1mOkbeNfISfk/aamS/g+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhicXV5Cxtqvbh97yFmMohxwhXSd8jGmvtR09oN4FH/THsgTvBKWhDiOjba92dbQ2m+xbnj0crr7W354jVZcLXoirtJ43/f3XkzX8Ya2ATcWtlfdhw6fXPNh/Bge8WHoHRKTvnIBGEj5CwSrAAL0BfLj1tqg0EH8dxX3g7agJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mPBz4YEI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mPBz4YEI"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2103520B710C;
	Thu, 27 Aug 2026 22:39:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2103520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787895596;
	bh=CTrVeM9o/7ylhxd1mu/YGbNHLW47aNI/iqZ1r6HJ+As=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mPBz4YEIU1NvxDCbxYc6+yJqx+5R9337ulR0/0Ic4+/cD+QNF9Ttwq+SzSjnGI5Q9
	 3S5+I/GDX/OHcFoAcXmbI22F2mZ2SsFb+Hkh2momrYxCnGyPUjiIxO6vOesQVWJ7jX
	 iWSVGT9HFVPfWmJvnsRni71TQJ6WcDLCvwwvGZTM=
Message-ID: <27277d1e-fd41-4dc9-aea2-eae3773ba322@linux.microsoft.com>
Date: Fri, 28 Aug 2026 11:10:22 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: Long Li <longli@microsoft.com>,
 Sahil Chandna <sahilchandna@linux.microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
 <SA1PR21MB66836C32FD0FABD94B45D7F6CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SN6PR02MB41578D73327A61FD3D7412C2D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <apB1HytkO5xu7jP6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <apB1HytkO5xu7jP6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/2026 11:04 PM, Saurabh Singh Sengar wrote:
> On Thu, Aug 27, 2026 at 04:07:06PM +0000, Michael Kelley wrote:
>> From: Long Li <longli@microsoft.com> Sent: Tuesday, August 25, 2026 10:01 AM
>>
>> [snip]
>>
>>>>
>>>> Basically something like this:
>>>>
>>>> #define PCI_RESPONSE_WARN_TIMEOUT_SEC 300
>>>>
>>>> static int wait_for_response(struct hv_device *hdev,
>>>>                    struct completion *comp) {
>>>>       unsigned long warn_at =
>>>>           jiffies + secs_to_jiffies(PCI_RESPONSE_WARN_TIMEOUT_SEC);
>>>>       bool warned = false;
>>>>
>>>>       while (true) {
>>>>           if (hdev->channel->rescind) {
>>>>               dev_warn_once(&hdev->device, "The device is gone.\n");
>>>>               return -ENODEV;
>>>>           }
>>>>
>>>>           if (wait_for_completion_timeout(comp, HZ / 10)) {
>>>>               if (warned || time_after_eq(jiffies, warn_at))
>>>>                   dev_warn(&hdev->device,
>>>>                        "PCI response received after prolonged wait.\n");
>>>>               return 0;
>>>>           }
>>>>
>>>>           if (!warned && time_after_eq(jiffies, warn_at)) {
>>>>               dev_warn(&hdev->device,
>>>>                    "PCI still waiting for response.\n");
>>>>               warned = true;
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> Regards,
>>>> Naman
>>>
>>> This looks better.
>>>
>>
>> I like getting the "response received" message if the response
>> eventually does come in. It's a judgment call, but I would be OK
>> with outputting the "still waiting" message after each wait interval
>> rather than doing it only once. And I would make the interval smaller
>> than 300 seconds. Five minutes is a long time to wait and wonder
>> what's going on when things are hung. 60 or 120 seconds would
>> be OK -- a line in dmesg every 1 or 2 minutes doesn't seem like
>> spamming to me when something is fundamentally broken.
>> And probably don't expect a VM in this broken state to keep running
>> for hours -- the sysadmin or automatic monitoring software will
>> reboot it to get it working again.

I think this is a main point of this discussion. FWIK, this is not 
automatically recovered as of now, ever. With these changes, we could 
get dmesg logs completely filled with this same log, which does not add 
any value. On the other hand, I was suggesting Sahil if this problem is 
not recoverable by Azure fabric layer or other monitoring services, and 
is extremely rare and the VM is unusable, perhaps we should consider 
adding a bug/timeout in this path instead of just logging about it.

Regards,
Naman

> 
> I will also vote for repeated message as long as interval between two
> messages is greater than 60 seconds.
> 
> - Saurabh
> 
>>
>> Just my $.02. Outputting the "still waiting" message only once is
>> also OK. Your call.
>>
>> Michael


