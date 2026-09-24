Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1F46D2B9;
	Thu, 24 Sep 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267428; cv=none; b=XmvnXfuqwYaqz/6AhHvi2o5+XxGnl2Nj8wBHMVb6fCxc4egZ6Zb0c/wnJjlP1+XGNAaf8JoRKPn4NT+5TQeZGzgvRoNhdFW6IIKdaIQzQwcQbZdbBrrLSPa7gqpknvo/Vlf/jgmqWSjqMS20NedatY4PjjlAuM9voDx5L7TPVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267428; c=relaxed/simple;
	bh=EFKLPxpD51REhXuM89skqdof7tnyOIh62qPAGdowEO0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CMlPR3ci4dkDfsemCqfFBQFQCBsmxMQUlVJT/E2RQpZTPPUvlm3GXt2Oq6+rx5bjManOpiNieKSINsB+BTSyk8rnE03xx/FJvFpbYM1x5Zntu8phke7cIJuwmQXrukKeIkrMO+SeCbXfBleaV2vE/ieoogVLgFpbFsS3NocKHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jlksxfma; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jlksxfma"
Received: from [10.20.15.95] (unknown [131.107.147.223])
	by linux.microsoft.com (Postfix) with ESMTPSA id F0DCB20B7167;
	Thu, 24 Sep 2026 09:29:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0DCB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790267372;
	bh=JhcaBYYEuGfLjImrY8WW5mtbj+RiNCHHNq56dHK1JZg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jlksxfmabBlOA3OftkrPoGLR8MgLPhRy3ctctCesvA9v7jzkpMcENrpVCQeISJ35I
	 ep0tT9xK8zX4SnZT2zvTDqj3AZ2S6N/apNv2Uq1ibD6WJsNaBvy9cQwL+ZzxcPPgnZ
	 EkF9qcWNV268TNi28pJ3Lwh6y5eq+buKp75gr0rc=
Message-ID: <dca62265-c75a-4ea9-9540-7a9da833b83e@linux.microsoft.com>
Date: Thu, 24 Sep 2026 09:30:20 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, jgg@nvidia.com, jacob.pan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V0 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-4-mrathor@linux.microsoft.com>
 <4f7cadc5-817c-4163-bac8-1c02a7c6a862@linux.microsoft.com>
 <21f8bbbc-0298-2e31-c165-0db660ae5208@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <21f8bbbc-0298-2e31-c165-0db660ae5208@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/2026 14:42, Mukesh R wrote:
> On 9/22/26 10:49, Easwar Hariharan wrote:
>> On 9/21/2026 15:50, Mukesh R wrote:
>>> Add a new file to implement a kernel only virtual IOMMU that works
>>> with Microsoft Hyper-V hypervisor on privileged VMs aka root VMs. The
>>> hypervisor claims the IOMMU upon boot, and this driver communicates with
>>> it for creating and deleting paging domains, attaching of devices, mapping
>>> and unmapping of pages, etc. During boot, hypervisor automatically creates
>>> identity and blocked domains, so there is no need to do hypercalls to
>>> create them.  This is a kernel only driver and only supported on baremetal
>>> root (and not L1VH root) without any guest passthru support. Support
>>> for guest device passthru will be added incrementally.
>>>
>>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>>> ---
>>>   arch/x86/kernel/pci-dma.c            |   2 +
>>>   drivers/iommu/Kconfig                |   1 +
>>>   drivers/iommu/hyperv/Kconfig         |  15 +
>>>   drivers/iommu/hyperv/Makefile        |   1 +
>>>   drivers/iommu/hyperv/hv-iommu-root.c | 645 +++++++++++++++++++++++++++
>>>   include/asm-generic/mshyperv.h       |   3 +
>>>   include/linux/hyperv.h               |   6 +
>>>   7 files changed, 673 insertions(+)
>>>   create mode 100644 drivers/iommu/hyperv/Kconfig
>>>   create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
>>>

<snip>

>>> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
>>> new file mode 100644
>>> index 000000000000..a5268e0e52cc
>>> --- /dev/null
>>> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
>>> @@ -0,0 +1,645 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Hyper-V root vIOMMU driver.
>>> + * Copyright (C) 2026, Microsoft, Inc.
>>> + */

<snip>

>>> +
>>> +/*
>>> + * Currently, hypervisor does not provide list of devices it is using
>>> + * dynamically. So use this to allow users to manually specify devices that
>>> + * should be skipped. (eg. hypervisor debugger using some network device).
>>> + */
>>
>> Maybe a flag, say OwnedByHyp = 1 returned for the root equivalent of the guest driver's
>> GetLogicalDeviceProperty hypercall can solve this.
> 
> "hypervisor does not provide list of devices it is using dynamically"

Sorry, can you be more verbose? When I read this response yesterday, I thought by dynamically, you
meant at runtime, but on thinking this through, the current scheme doesn't help with that either.
You have to pass the kernel command-line parameter at boot because the IOMMU driver is built-in, and
so if a debugger is attached to the hypervisor "at runtime", your current scheme, just like my suggestion
for a flag returned by GetPhysicalDeviceProperty above, requires a reboot of the root partition.

> 

<snip>

>>>   #endif /* _HYPERV_H */
> 

