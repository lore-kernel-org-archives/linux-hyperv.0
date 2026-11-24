Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502623;
	b=zmjv1Mc2W9fCrCVNyII3p8WR9BxpmDDlT6Pa+/CguwZBkN5+dsprY0bpeRhqkKFUXinY
	 YdkJqXS80egeNcop16gTNrmduDNcEPu3OHAhD1+y79qj8iVmKKvJLlo9AMvU03QMb1OhU
	 3snzn7aRpxlBOPts0H70sL8Iif2at87wZy5oAPBltbkmZetyQjpdQ2wb8IdPuyZl/1jEg
	 LhWxlo1DJJJrIUB9PJGfQjZAP26Gxo4Xv8pcEvcSxHekweZaTeYq6M0D8b+/MrZQXlGHM
	 ATTxG7/l4Z9Jdu/8zd8UVSwPd5hKSODqJGlCHfhForGBl01z02myjX0GXv9RXkhb/zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502623;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=A50t8edxVMGyCwRue/V4sIhEioPlpqXcf0ne27dJBKs=;
	b=30lGr6MD6Wvxoaxl5e8Qxo3Ahu7vkYCqtKdsM2Pz7S1bLYnkzCCL56S8EnzZH3EAMWZJ
	 l81UwDyhFlAu1de6pUH/FYTyhbXgGTbJv6Zu2UDekGT69WvA07echyKd63jZpoG626T0r
	 kRhh2/RoinNyGXLU16KwEg3txA+qPZjv86KQZgwh+zZi3Zg1OE03t3PMsaVVjs0cHPfeP
	 lSYWAL4ZGOPApII/lQ2CNrVFRK4krf+6S/zFVd52Lw6R5ZAyM2lxuPto5BwYGLTVodE8N
	 9bmgSYeLroUxm6wNnNYp1sQmG6y02Gpsvn4yFMj2i5THb6OrDNFIT3tJp2rcZJiEMlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YlR7zOL8;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6DD606A31E;
	Tue, 24 Nov 2026 06:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F6DD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YlR7zOL8
Received: from [10.95.64.197] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8BD4120B7168;
	Mon, 23 Nov 2026 22:43:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BD4120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502618;
	bh=A50t8edxVMGyCwRue/V4sIhEioPlpqXcf0ne27dJBKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YlR7zOL8aQQKjum357R0mGrnSBv6t/HM0UzzJlJQvt7a8FI3PsOdkXfLJh6xRXpKT
	 xFDvHq/UXq4NRdmVQk+uTIZWRdKYZanyePl4bEX6rJPlDFp3KVpJw2bPq3CFpIXTLZ
	 TWLO4P1bjvnAYpW57fpsYeQTBBg1L1u/OURbxPfc=
Message-ID: <2ddd53be-646f-4fe8-b91b-ceddb347a79f@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:13:35 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] x86/hyperv: Reject unrepresentable TLB flush VP
 sets
To: Michael Kelley <mhklinux@outlook.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "zhouchuyi@bytedance.com" <zhouchuyi@bytedance.com>,
 "houwenlong.hwl@antgroup.com" <houwenlong.hwl@antgroup.com>,
 "qq570070308@gmail.com" <qq570070308@gmail.com>,
 "bastien.curutchet@bootlin.com" <bastien.curutchet@bootlin.com>,
 "dianders@chromium.org" <dianders@chromium.org>,
 "jgross@suse.com" <jgross@suse.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-2-namjain@linux.microsoft.com>
 <MN2PR02MB6863BDBAFE5B4235BF4AEFABD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863BDBAFE5B4235BF4AEFABD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 5:44 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>> The VP-set conversion helper returns zero when it cannot represent the
>> maximum VP index. Treat zero as an error, just like negative results,
>> rather than issuing an extended flush with an empty target set.
> 
> This is more a theoretical issue than a real issue, right?  The max VP
> index would need to be >= 4096 for this error to occur, and to my
> knowledge the max vCPU count in a Hyper-V VM is something smaller
> than 4096.
> 

Right, this is more of a defensive solution. I can remove this if at
all, you feel this is not required at the moment. Or else, I can make
it clear in the commit message.

>>
>> This lets the caller fall back to native flushing, as the extended IPI
>> path already does. Filtering a mask that initially includes all present
>> CPUs can make it use this conversion instead of the all-processors
>> shortcut.
> 
> I don't understand the last sentence. Is it a leftover or a bad copy/paste?
> 
> Michael

I meant that removing stale CPUs from an all-present mask can make the
flush use an explicit VP set instead of HV_FLUSH_ALL_PROCESSORS. The
control flow would then reach this condition more often after these
changes. But that doesn't establish that the conversion limit can
actually be reached. The sentence adds confusion, so I'll remove it.

Regards,
Naman

> 
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/mmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index cfcb60468b01c..1ea57d642faa4 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -199,7 +199,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask
>> *cpus,
>>   	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>>   	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
>>   			info->freed_tables ? NULL : cpu_is_lazy);
>> -	if (nr_bank < 0)
>> +	if (nr_bank <= 0)
>>   		return HV_STATUS_INVALID_PARAMETER;
>>
>>   	/*
>> --
>> 2.43.0
>>

