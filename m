Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF9243387;
	Tue, 22 Sep 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068142; cv=none; b=tXvfKSdIL7/PqPl87b4Ttmqggiwsz8fkzFCoLuTQUgKAsdILeelAIIGTV+M41xIBH/tvp2Bq1I/3Cs6i4CLlvMueZaSKbTEgXkXK/jBg4qPThIF9mSh1pp5HYAR1Kq2mJ7TGl306c515LM+DkQtlbsoDktldKMD6uwUzUPxUHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068142; c=relaxed/simple;
	bh=i8FGK72GQr9CSnr5prIRCcvnaw4o75COTdHdszIvstg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgupYiREZoaZvozykUhaZM8rBjKQMon2KKPc/3QovWY4RI1d+rP2/wLEZcjBDPGKfPJHD1KUKJJiNegAYgiTcVPCO2PAWgpEqHeDakkZjZcg82puKMgbX3dPrGCcAOFbCz4ZvchcMqk+KlTiBJan+Emh1GaZVtfgOrMAnq5meEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Mnv1fmj/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Mnv1fmj/"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 77AD520B7167;
	Tue, 22 Sep 2026 02:08:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77AD520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790068087;
	bh=rYpc4zPy6gvjTMKP6zLT8ArGLoC2PBhl6R7WqRuj41Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mnv1fmj/EkmzTtlrhGMBD4vcIRwT5SjJLfuFY2NTeErkYsQn/IoxtQmmhd/bE9Q92
	 XbJGS7EEfZHYjkUW+rrDpyj5V+3q+SJfe7jocitBN3deO98Lvh8TSuNTSSqjKnvYoK
	 cujDbTvbcj9JCEQxPc1NVGLGjn8CFXGgaI4Nkbf8=
Message-ID: <c3345afb-7491-42c9-9e9c-609860aea515@linux.microsoft.com>
Date: Tue, 22 Sep 2026 14:38:47 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157AB3B9404AF9CC43BF11FD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2026 2:39 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2026 10:48 PM
>>
>> On Hyper-V guests each virtual PCI bus is enumerated by its own
>> hv_pci_probe() call. The probe performs several synchronous host
>> request/response exchanges while negotiating the protocol, querying bus
>> relations, entering D0, and reporting allocated resources. These waits
>> are latency-bound rather than CPU-bound.
>>
>> hv_pci registers as an ordinary VMBus driver, so driver_register() walks
>> matching vPCI buses and probes them sequentially while the driver's
>> initcall runs. On guests that expose several devices, each through its
>> own vPCI bus, this serialization adds the host round-trip latencies to
>> device initialization.
>>
>> Each bus is described by its own struct hv_pcibus_device, so
>> independent buses can be probed concurrently. Request asynchronous
>> probing via PROBE_PREFER_ASYNCHRONOUS, causing the driver core to
>> schedule matching buses for asynchronous probe work.
>>
>> On an Azure Standard_L32s_v3 guest with five vPCI targets (four NVMe
>> controllers and one Mellanox VF), Linux 7.2.3 was tested with one warm-up
>> and three measured boots per variant. The median interval from the first
>> hv_pci_probe() entry to the last return decreased from 2847.968 ms to
>> 2786.709 ms, a 61.259 ms (2.15%) improvement.
> 
> The elapsed time improvement is rather disappointing given the
> complexity of the probing sequence and the number of interactions
> with the Hyper-V host. Do you have any insight into why there isn't a
> larger reduction? Is something mostly serializing the work even though
> PROBE_PREFER_ASYNCHRONOUS is specified?
> 
> Michael
> 

I can see these reasons for not seeing great improvements:
1. Timing of device offers from the host is beyond the control of guest 
and the Hyper-V host may also be serializing the requests from the host.
2. Shared locks that needs to be handled separately:
    * hyperv_mmio_lock during VMBus MMIO allocation.
    * pci_rescan_remove_lock during PCI resource assignment and device 
addition.


I digged more into it, and it is indeed because of late offers from 
Hyper-V. I was considering the start of first probe to the last return, 
for time calculations.

For the 4 PCI devices on my setup whose offers were delivered together, 
the performance improvement was about 24%. However with the last offer 
coming late for MLX PCI device, overall improvement in time was lesser 
in terms of percentage.

Dexuan had removed pci_rescan_remove_lock in his previous upstream 
attempt, but I ommitted it intentionally this time because from AI 
review, I saw a potential race condition that we would introduce if we 
remove it. Secondly, I did not observe any benefits of removing this 
lock. But I am going to revisit it again.

Regards,
Naman

>>
>> Co-developed-by: Dexuan Cui <decui@microsoft.com>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>
>> Previous discussion around this change:
>> https://lore.kernel.org/all/20230420024037.5921-7-decui@microsoft.com/
>>
>> Skipping removal of pci_rescan_remove_lock, due to possible
>> synchronization problems associated with this lock removal. Also, with
>> my current setup, I was not able to see much improvements with this
>> change, so keeping it for later. Asynchronous probing change is not
>> dependent on this.
>>
>> ---
>>   drivers/pci/controller/pci-hyperv.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 89816a2bd7cd3..056d379b3cee4 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -4155,6 +4155,9 @@ static struct hv_driver hv_pci_drv = {
>>   	.remove		= hv_pci_remove,
>>   	.suspend	= hv_pci_suspend,
>>   	.resume		= hv_pci_resume,
>> +	.driver = {
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>>   };
>>
>>   static void __exit exit_hv_pci_drv(void)
>> --
>> 2.43.0
>>
> 

