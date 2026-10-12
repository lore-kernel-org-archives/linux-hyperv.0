Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A7D331EBD;
	Mon, 12 Oct 2026 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795126; cv=none; b=f8SFKDrpBiSo/6RZbeEqBrkhnMrMh6dcLNi3updmbQI7ssulackr2jYYSMabDiR+p5G3txS+Aat300f3+pTt7Zpb57Jm4BOiLRri4TFTTZZO8z4RGctBHTkRiLrrtUeWKvZC2YeWic38rD7yPw8kwYzY0l3/r2wG1mqLUEt+l/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795126; c=relaxed/simple;
	bh=edYYOpX9LOnEBQqgC+NRIhWrVp3o96YMzcZ35Ddg1ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5HeaqZyyoHaEUERII0RqVG2ZW50IYLD9eoSMwmNyWYtqwixJj4+H56SRl1W/lUybSG2XO6t+3e52SAu6opNk4ZacielHU1OGx9SK5QSRM7IToWjYD8XV8GbtdTJldhb3MLStrhF/T1vnbL2Ha3EaH76s3rpvYWKUn25ezgc4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M/AWsMh6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M/AWsMh6"
Received: from [10.95.64.165] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19CF620B7166;
	Mon, 12 Oct 2026 01:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19CF620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791795122;
	bh=74qUF1YYhzBWD4lwZlU5CNljoJZQ7TIEvkuEJ9sAh6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M/AWsMh6fdsSlV0vIMS+lRrq3HNnP6HZlr2uYWO/S2FFy3/WkgMlcVHDBRsqf+fcm
	 Nwj6CmTyq8ZClM0sNItxosuQsMuu4ZMXkf0aVfzq29Deu40KId39Cprx0go1t10mJH
	 uM2lcaiZQO+awhkPPPJPZy2AjoaBfKn5UjnR3C9M=
Message-ID: <41d9bb59-7490-498c-8ec9-770e08b2ca38@linux.microsoft.com>
Date: Mon, 12 Oct 2026 14:21:59 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
To: Fengnan <changfengnan@bytedance.com>,
 Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Luigi Rizzo <lrizzo@google.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
 <1c7c7fd9-e2e6-41ac-ac97-9c4d71b1c2fc@bytedance.com>
 <8bff7953-a9df-4ede-b3de-a4df558946a9@linux.microsoft.com>
 <758e4c6b-1b1a-4191-baeb-3f9799783ee6@bytedance.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <758e4c6b-1b1a-4191-baeb-3f9799783ee6@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/12/2026 12:30 PM, Fengnan wrote:
> 在 2026/10/12 14:48, Naman Jain 写道:
>>
>>
>> On 10/9/2026 5:06 PM, Fengnan wrote:
>>> Hi Naman:
>>>
>>> This is an issue I hadn’t noticed before.
>>> I'll take a closer look at this issue later.
>>>
>>> Regarding testing, there are a few points to note:
>>> 1. My patch has been updated to V2, https://lore.kernel.org/linux-nvme/20260826061546.56006-1-changfengnan@bytedance.com/
>>> 2. In my experience, when do performance tests, it’s best to do precondition
>>> first and then execute an ABBA test; this ensures reliable results.
>>> 3. IIRC, disabling interrupts in the QEMU kernel does not actually disable hardware
>>> interrupts; QEMU still handles them, which has a significant impact on performance testing.
>>> Perhaps you could test this on a physical machine.
>>>
>>> Also, I’d like to ask: does this softlockup issue only occur on QEMU+ARM?
>>> or does it also occur on x86 physical machines?
>>> Have you tried enabling the “Posted Interrupt” feature in VM? Maybe this will solve
>>> this problem in VM.
>>>
>>> Thanks.
>>
>> Hi Fengnan,
>> Thanks for the suggestion.
>>
>> I was using QEMU just for sanity, all the test results are based on experiments in an Azure ARM64 Hyper-V VM. I could not create enough load on my local QEMU VM to cause a lockup, so I am relying only on the Azure VM I have. I would not rule out x86 for this issue, as we have seen spurious lockups in the fleet, which are more common on certain SKUs, but my current experiments are limited to arm64. The proposed solution should solve it for both.
> 
> I set up a test environment on my own this morning.
> Although I wasn't able to reproduce the soft lockup issue, I did observe
> I/O latency of several hundred milliseconds.

Acked.

> 
>>
>> The guest exposes a GICv3 CPU interface and Hyper-V vPCI maps the NVMe MSI-X vectors as guest GIC SPIs. I do not see an ITS, LPIs/vLPIs, GICv4 VPEs, or another direct virtual interrupt injection interface exposed to the guest. Also, posted/direct interrupts would reduce host-to-guest interrupt injection overhead, but the lockup here occurs after delivery, while nvme_irq() repeatedly drains completion queues in guest hardirq context. So I would not expect posted interrupts alone to provide the missing scheduling boundary.
> 
> I'm thinking that adding a scheduling check to my patch should also resolve
> this issue.
> That would be simpler and more acceptable, we can work together to refine it.
> 
> Thanks.
> 

Sure, happy to collaborate. Please include me in any new discussions you 
have in your patch. And let's hear what Christoph and other maintainers 
have to say, and then we can converge on that approach going forward.


Regards,
Naman
