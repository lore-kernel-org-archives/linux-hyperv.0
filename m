Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A5342146;
	Tue,  4 Aug 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883742; cv=none; b=enrRmgwIUOtevwFRRZ2VmKWicLQqt3dWca4MH1frR/C+KbN6UqHNUrDiA0uw2v/43H3dW0IdOgco3Mlj4lXOUF1CXEwrRoTEb0ttQpGL/XyZm8VlTMoFM88o4phNuBmXRHGt8jRxFMsXjgQjYCrlpeOsteEmi8WAynHslM49yJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883742; c=relaxed/simple;
	bh=KbBZxaBW+47Y/6cgoL5Runxd/IUBQHh8OWONDcVsMfU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dIofzFWsgGUmSbgUJtc08eTQj1JNsD3fQ1GFC4b5aPXvkY3qb9q5DJu2ZFfvtqAscyHm/DB20N3xUacJ1B1Q6U5uTURRPq35wBRc3MGjcAWeYKh58Y6l8YSzslDBDspeTCC9Poi43rwGXBfP+bPgdHwst6NLxlKJXJKpH0mcu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ideQ0II7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ideQ0II7"
Received: from [192.168.201.246] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id BAA9E20B7169;
	Tue,  4 Aug 2026 15:48:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAA9E20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785883720;
	bh=9fLLkiExEJxRw61XVMMco/fL0Zg+AagTClQ+0TappJc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ideQ0II7hdxoyj0oamnkF5hsJrcRHlOgMyPErQKaGsFReHgcdXabaPHBy8A0Z//KV
	 Ifl6nJaLLKuBqDFTPp6qtczfUccfuGHXeWH6FuBGTF0wm7MDlb9Ig+V2vwdh1D/GL5
	 Hm6ABWGUq3eDxmBkg8/zxbamPTi8bPghmriqxtys=
Message-ID: <afa0863f-92da-4f9e-81c6-f1676ea76870@linux.microsoft.com>
Date: Tue, 4 Aug 2026 15:48:52 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for
 non-nested root partition
To: Michael Kelley <mhklinux@outlook.com>
References: <20260804190517.101981-1-mhklinux@outlook.com>
 <ea0d31c0-5559-462c-b6d3-1ed6c01a9074@linux.microsoft.com>
 <SN6PR02MB415758E1637A763B06911B8AD4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ce1a513c-2eb6-449d-bfff-ce7a581d14f2@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <ce1a513c-2eb6-449d-bfff-ce7a581d14f2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/2026 15:47, Easwar Hariharan wrote:
> On 8/4/2026 15:17, Michael Kelley wrote:
>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Tuesday, August 4, 2026 12:40 PM
>>>
>>> On 8/4/2026 12:05, Michael Kelley wrote:
>>>> The VMBus module should not be loaded when Linux is running directly
>>>> in the root partition and root is not nested in another VM. Current
>>>> code checks this condition and skips VMBus module initialization, which
>>>> works. But it returns 0 as the result, so Linux thinks the module has
>>>> successfully loaded. Later, if the module were to be unloaded, the
>>>> VMBus module unload code tries to clean up things that were never
>>>> initialized, resulting in memory faults and a panic.
>>>>
>>>> Fix this by having VMBus module initialization return -ENODEV for this
>>>> case. The module is then not loaded, and the unload path can never run.
>>>>
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Closes: https://lore.kernel.org/linux-
>>> hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
>>>> Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
>>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>>> ---
>>>>  drivers/hv/vmbus_drv.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>>> index e19ec73b0187..849d7e1a7320 100644
>>>> --- a/drivers/hv/vmbus_drv.c
>>>> +++ b/drivers/hv/vmbus_drv.c
>>>> @@ -2976,7 +2976,7 @@ static int __init hv_acpi_init(void)
>>>>  		return -ENODEV;
>>>>
>>>>  	if (hv_root_partition() && !hv_nested)
>>>> -		return 0;
>>>> +		return -ENODEV;
>>>>
>>>>  	/*
>>>>  	 * Get ACPI resources first.
>>>
>>> This seems straightforward:
>>
>> Alas, it's not so straightforward, as Sashiko pointed out.  I knew that
>> the mshv module has a dependency on the vmbus module, but had
>> forgotten. There's a reason for the dependency as described in the
>> commit message for 840b740a35bf.
>>
>> There's another easy way to fix the VMBus module unload problem.
>> I'll send a v2. :-)
>>
>> Michael
>>
> I may be missing something, but mshv_root is used in 3 cases:
> 
> 1) Baremetal root partition, which requires no VMBus
> 
> 2) L1VH aka Direct Virtualization, which is conditioned on hv_l1vh_partition(), which is not the check here in the vmbus driver
> 
> 3) For the OpenHCL paravisor, where I honestly don't know what the dependency chain looks like, but based on a quick glance
> at https://github.com/microsoft/OHCL-Linux-Kernel/ and a cursory grep, doesn't seem to rely on hv_root_partition() but does rely
> on VMbus.
> 
> I feel like Sashiko's review falls into item 1, but then again, there may just be a mismatch
> between reality and my mental model, or my mental model may becorrect, but the code doesn't match it.
> 
> Thanks,
> Easwar (he/him)


Well, number 4 is as a parent on a nested hypervisor, but !hv_nested takes care of that.

- Easwar
