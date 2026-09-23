Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E238F25C;
	Wed, 23 Sep 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137211; cv=none; b=GpnvasOthjLLUs0uplyDI7Fimhg8yIdtRooCZAEQpI3qUb1+5lsjLIgPY/I9DHh60NUxgzHFC+iDLb68qoaVB7gB2POlpdXVvcjCMv9MNhme0h0f/pvYV2tjkatZebbi8v9b1H3KmlU4HauDPFpX7b8tUiYZVj8s16u3Z7oeCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137211; c=relaxed/simple;
	bh=5gZoE00uG48SxAB6q1up1WLM+4HS0b+PT7joXzrK5BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJXQvC251dBAO3AImDGinb5X19gzMLb/v5xn2Mw6kSSsEyUALQRO/xEZ7Aps+pBifWCfjycvI6x/x6oTdEUGWu21HfMUONJM7tDc2uTIjTSiv9HlvVEAzf70nePFBXixddeToqyOKRGk+aWKDc06JaF+dK0riJ9w6cYjP+V0/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gWIcXOjO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gWIcXOjO"
Received: from [100.67.200.185] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AEC520B7167;
	Tue, 22 Sep 2026 21:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AEC520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790137161;
	bh=Af0CwPE6fgHbBmxoY/Eezao4/Sn7v0Sx3xmR0fEB1MY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gWIcXOjOzKZOHawitrLxQfyDot6TBwxCdxfgggbS6qDjz7JO5fVBbUqWuly5mAUPr
	 8fvlTvdFYKf/UG4rMNQ5bAg4NJJnyD9cUSRumM6pM0Y8Tka+VvcoB8zXkr4kjWA3FH
	 5Ac+aGfoGQ95OVaMSTpOc6XggLNLwLLGoovCIOk0=
Message-ID: <fabfdde6-9b9a-4879-9de0-c6ff18045e02@linux.microsoft.com>
Date: Wed, 23 Sep 2026 09:50:03 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: hv: Probe vPCI buses asynchronously
To: Michael Kelley <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157AB3B9404AF9CC43BF11FD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c3345afb-7491-42c9-9e9c-609860aea515@linux.microsoft.com>
 <SN6PR02MB41574C84E56157D1FC2E4F86D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574C84E56157D1FC2E4F86D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/2026 8:12 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, September 22, 2026 2:09 AM
>>
>> On 9/22/2026 2:39 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2026 10:48 PM
>>>>
>>>> On Hyper-V guests each virtual PCI bus is enumerated by its own
>>>> hv_pci_probe() call. The probe performs several synchronous host
>>>> request/response exchanges while negotiating the protocol, querying bus
>>>> relations, entering D0, and reporting allocated resources. These waits
>>>> are latency-bound rather than CPU-bound.
>>>>
>>>> hv_pci registers as an ordinary VMBus driver, so driver_register() walks
>>>> matching vPCI buses and probes them sequentially while the driver's
>>>> initcall runs. On guests that expose several devices, each through its
>>>> own vPCI bus, this serialization adds the host round-trip latencies to
>>>> device initialization.
>>>>
>>>> Each bus is described by its own struct hv_pcibus_device, so
>>>> independent buses can be probed concurrently. Request asynchronous
>>>> probing via PROBE_PREFER_ASYNCHRONOUS, causing the driver core to
>>>> schedule matching buses for asynchronous probe work.
>>>>
>>>> On an Azure Standard_L32s_v3 guest with five vPCI targets (four NVMe
>>>> controllers and one Mellanox VF), Linux 7.2.3 was tested with one warm-up
>>>> and three measured boots per variant. The median interval from the first
>>>> hv_pci_probe() entry to the last return decreased from 2847.968 ms to
>>>> 2786.709 ms, a 61.259 ms (2.15%) improvement.
>>>
>>> The elapsed time improvement is rather disappointing given the
>>> complexity of the probing sequence and the number of interactions
>>> with the Hyper-V host. Do you have any insight into why there isn't a
>>> larger reduction? Is something mostly serializing the work even though
>>> PROBE_PREFER_ASYNCHRONOUS is specified?
>>>
>>> Michael
>>>
>>
>> I can see these reasons for not seeing great improvements:
>> 1. Timing of device offers from the host is beyond the control of guest
>> and the Hyper-V host may also be serializing the requests from the host.
> 
> Ah, right. This is probably the key factor.
> 
>> 2. Shared locks that needs to be handled separately:
>>      * hyperv_mmio_lock during VMBus MMIO allocation.
> 
> This probably has minimal impact. While there's a decent amount
> of code protected by the lock, I don't think there's any interaction
> with the host (even via traps), so it should run quickly.
> 
>>      * pci_rescan_remove_lock during PCI resource assignment and device
>> addition.
> 
> OK. I don’t know about this one.
> 
>>
>>
>> I digged more into it, and it is indeed because of late offers from
>> Hyper-V. I was considering the start of first probe to the last return,
>> for time calculations.
>>
>> For the 4 PCI devices on my setup whose offers were delivered together,
>> the performance improvement was about 24%. However with the last offer
>> coming late for MLX PCI device, overall improvement in time was lesser
>> in terms of percentage.
> 
> For traditional configs where the VF NIC is paired with a netvsc
> instance, the host doesn't offer the VF NIC to the guest until the
> corresponding netvsc instance has been probed and the netvsc
> driver has told the host it will accept a VF NIC. In these cases, the
> Mellanox or MANA VF NIC device is always "late" and probably
> shouldn't be included when determining the speed-up of doing
> hv_pci probing asynchronously.
> 
>>
>> Dexuan had removed pci_rescan_remove_lock in his previous upstream
>> attempt, but I ommitted it intentionally this time because from AI
>> review, I saw a potential race condition that we would introduce if we
>> remove it. Secondly, I did not observe any benefits of removing this
>> lock. But I am going to revisit it again.
> 
> Thanks for the discussion. Using PROBE_PREFER_ASYNCHRONOUS
> is still a good thing to use, but the benefit will accrue the most when
> there are a significant number of NVMe devices and when Hyper-V
> is quick about offering them. As I described above, it will be harder
> to get parallelism with the VF NIC.
> 
> Michael

Thanks Michael, this makes sense now. I'm glad that you asked.

Regards,
Naman
