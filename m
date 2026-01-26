Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596D271A71;
	Mon, 26 Jan 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458812; cv=none; b=QJKdqZx36gFL+LWm22tN5bPUkW553NG33xPBFgQoHfbEh7wxSE/TNe8CsLg/HDGYlQEw01UIDZZRHnLlBV5ugvPa6RYNq1gtQs/1oIeZaVp3SRU2UJCgkE5hBu3TM8q/Ci2ZGHsGgGlV3qJIuGejGB3NpaYvrLZGbA2fA+ZsMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458812; c=relaxed/simple;
	bh=Wy3ysnlPUFP4WvqUdLDTbQ20UnUffcxJu2ifThFWYsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYf/xDoLwwS2oHqEUQFFyl0Urhm1rbkAoX5BY4WQ5iHELfqjKopmKdGi0zn0vRvInbC5T0trFeF8ZJqZXlA04pYEIDNvJ83/22ZjX+mAMzs5a1qioKEN2GVUEjyUZDffUpLGPySaOCnwIvrjUp4qxzHAufQdm/6k0vAAZ5Ks0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JQAzb4Tu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JQAzb4Tu"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E07520B7165;
	Mon, 26 Jan 2026 12:20:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E07520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769458810;
	bh=WZ8SV2ROlQi1X4iKSvqcrIvxtSUnGqXRVv8kteXZpUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JQAzb4TuON6tstPMb+ZaaidZgzX2dYpPsrQnIqvpODD2jFWKTfGTNJWMOsKWHv3Es
	 aYTL19vAJTKCzXIy2v6xmzQNQO8vEh004qc4B9pWzVaogy6p9XC7YPcm7sAD84dVA0
	 n7FQH0zfe9ULTHlZJvpsafRQlBrvo1kOctygJvyM=
Message-ID: <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
Date: Mon, 26 Jan 2026 12:20:09 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
>> On 1/23/26 14:20, Stanislav Kinsburskii wrote:
>>> The MSHV driver deposits kernel-allocated pages to the hypervisor during
>>> runtime and never withdraws them. This creates a fundamental incompatibility
>>> with KEXEC, as these deposited pages remain unavailable to the new kernel
>>> loaded via KEXEC, leading to potential system crashes upon kernel accessing
>>> hypervisor deposited pages.
>>>
>>> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
>>> management is implemented.
>>>
>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>> ---
>>>    drivers/hv/Kconfig |    1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>> index 7937ac0cbd0f..cfd4501db0fa 100644
>>> --- a/drivers/hv/Kconfig
>>> +++ b/drivers/hv/Kconfig
>>> @@ -74,6 +74,7 @@ config MSHV_ROOT
>>>    	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>>>    	# no particular order, making it impossible to reassemble larger pages
>>>    	depends on PAGE_SIZE_4KB
>>> +	depends on !KEXEC
>>>    	select EVENTFD
>>>    	select VIRT_XFER_TO_GUEST_WORK
>>>    	select HMM_MIRROR
>>>
>>>
>>
>> Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
>> implying that crash dump might be involved. Or did you test kdump
>> and it was fine?
>>
> 
> Yes, it will. Crash kexec depends on normal kexec functionality, so it
> will be affected as well.

So not sure I understand the reason for this patch. We can just block
kexec if there are any VMs running, right? Doing this would mean any
further developement would be without a ver important and major feature,
right?

> Thanks,
> Stanislav
> 
>> Thanks,
>> -Mukesh

