Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E33C8717;
	Wed,  5 Aug 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950652; cv=none; b=ksoODg1j7nt2OJgw7jXEpAgZHqKKHLAemJ8Bev5JXOmPk7cPETstFUPmS+ujlYn8iK80qcNP7KI/Wkv8G1LfRKeauRZwQXyJOEWKdHFaNr3R61s//Rr25Bmj+ppPt9HK+E5eRZZJJYzKLHkOB8A/L4yae+Q5VJTCmDITol5+V3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950652; c=relaxed/simple;
	bh=7Hra8MiiFA1bpttIEjZrJR+4edB5KH25Bj97EZLmDjo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bpbMPgmfnVYYHO4Di+GGvNkVcoKD5iZjEn3sSjMzXo7rSxPw4u9H3fhVKKf4VS4nWlOPvQEkVUdp6G6GDOw0S8BhSUidV+9RqdmFDkKCWIZsKplJ1ySxrTR9pn2tBMmxJT+jIjevFgtkmVdxCrVZHWRPO+teqrDQ45aZl6IbH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dap7uAwL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dap7uAwL"
Received: from [10.21.58.224] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06A4320B7169;
	Wed,  5 Aug 2026 10:23:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06A4320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785950630;
	bh=XPvRWFUhHMnNObZ6Hnjr7BBy003ESek6ZolrR6Wr9ek=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Dap7uAwLIkg5aq1LJM38ldefrZkiYD9vaeCQHVIZh/yrU3ridtabIoDU3wSDGE+is
	 8mEGSgXsEqlf1P6Zo32jG5T3rrJ0Xfi3w4J34uWOKFRJ6be7ML+WjUQ0g1/XGY4z2s
	 a5OKmV6MSnG8VTcs7RnhkD01wE0dmfGrJM1WijEs=
Message-ID: <cd0437fc-4cf9-44d4-a212-6672dff64533@linux.microsoft.com>
Date: Wed, 5 Aug 2026 10:24:03 -0700
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
 <afa0863f-92da-4f9e-81c6-f1676ea76870@linux.microsoft.com>
 <SN6PR02MB4157566CE78CCD02C925E3CDD4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB4157566CE78CCD02C925E3CDD4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/2026 21:13, Michael Kelley wrote:
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Tuesday, August 4, 2026 3:49 PM
>>
>> On 8/4/2026 15:47, Easwar Hariharan wrote:
>>> On 8/4/2026 15:17, Michael Kelley wrote:
>>>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Tuesday, August 4, 2026 12:40 PM
>>>>>
>>>>> On 8/4/2026 12:05, Michael Kelley wrote:
>>>>>> The VMBus module should not be loaded when Linux is running directly
>>>>>> in the root partition and root is not nested in another VM. Current
>>>>>> code checks this condition and skips VMBus module initialization, which
>>>>>> works. But it returns 0 as the result, so Linux thinks the module has
>>>>>> successfully loaded. Later, if the module were to be unloaded, the
>>>>>> VMBus module unload code tries to clean up things that were never
>>>>>> initialized, resulting in memory faults and a panic.
>>>>>>
>>>>>> Fix this by having VMBus module initialization return -ENODEV for this
>>>>>> case. The module is then not loaded, and the unload path can never run.
>>>>>>
>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>> Closes: https://lore.kernel.org/linux-
>>>>> hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
>>>>>> Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
>>>>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>>>>> ---
>>>>>>  drivers/hv/vmbus_drv.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>>>>> index e19ec73b0187..849d7e1a7320 100644
>>>>>> --- a/drivers/hv/vmbus_drv.c
>>>>>> +++ b/drivers/hv/vmbus_drv.c
>>>>>> @@ -2976,7 +2976,7 @@ static int __init hv_acpi_init(void)
>>>>>>  		return -ENODEV;
>>>>>>
>>>>>>  	if (hv_root_partition() && !hv_nested)
>>>>>> -		return 0;
>>>>>> +		return -ENODEV;
>>>>>>
>>>>>>  	/*
>>>>>>  	 * Get ACPI resources first.
>>>>>
>>>>> This seems straightforward:
>>>>
>>>> Alas, it's not so straightforward, as Sashiko pointed out.  I knew that
>>>> the mshv module has a dependency on the vmbus module, but had
>>>> forgotten. There's a reason for the dependency as described in the
>>>> commit message for 840b740a35bf.
>>>>
>>>> There's another easy way to fix the VMBus module unload problem.
>>>> I'll send a v2. :-)
>>>>
>>>> Michael
>>>>
>>> I may be missing something, but mshv_root is used in 3 cases:
>>>
>>> 1) Baremetal root partition, which requires no VMBus
>>>
>>> 2) L1VH aka Direct Virtualization, which is conditioned on hv_l1vh_partition(), which is
>> not the check here in the vmbus driver
>>>
>>> 3) For the OpenHCL paravisor, where I honestly don't know what the dependency
>> chain looks like, but based on a quick glance
>>> at https://github.com/microsoft/OHCL-Linux-Kernel/ and a cursory grep, doesn't
>> seem to rely on hv_root_partition() but does rely
>>> on VMbus.
>>>
>>> I feel like Sashiko's review falls into item 1, but then again, there may just be a
>> mismatch
>>> between reality and my mental model, or my mental model may becorrect, but the
>> code doesn't match it.
>>>
>>> Thanks,
>>> Easwar (he/him)
>>
>>
>> Well, number 4 is as a parent on a nested hypervisor, but !hv_nested takes care of that.
>>
> 
> For your #1, indeed the root partition does not require actual VMBus
> functionality. But it *does* require that the VMBus module be loaded
> if CONFIG_HYPERV_VMBUS=y. In that case, the only function the root
> requires for #1 is the function hv_vmbus_exists(), and it requires that
> to distinguish between your #1 and your #4 when it sets up the SynIC.
> 
> If you want to build an image that only works for #1, then build with
> CONFIG_HYPERV_VMBUS=n and there's no issue. But if you want an
> image that works for #1 or #4, build with CONFIG_HYPERV_VMBUS=y
> or =m, and the VMBus module must loaded so that hv_vmbus_exists()
> gives the right answer (false for #1, true for #4). Furthermore, the
> mshv_root dependency on the VMBus module ensures that the
> VMBus module is always loaded before the mshv_root module so
> that hv_vmbus_exists() will give an up-to-date answer when
> mshv_root asks.
> 
> The way the SynIC is managed should be refactored to better
> handle #4, as Jork Loeser has proposed. Hopefully such a refactoring
> would make the mshv_root->vmbus dependency go away. But until
> such a refactoring is done, the dependency is what we have.
> 
> I agree that your #2 and #3 are not relevant here.
> 
> Michael

Makes sense, I did not think of the distro user that'd probably like 1 image that serves all use
cases. I'll look at your v2.

Thanks,
Easwar (he/him)



