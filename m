Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583181;
	b=BKuEszjojIQntGIeB8ec8uE+BWg+9PDE5+Cv+RpNE3Xp2HUxsg3oPTIFiNOA9H3mDkyU
	 BxaSzAB1eglK1zTagt6lYMtu7o38PiFETQgmZdlIqrJ9lPrd3GLoPIVsa5rUVTjtVEj83
	 /YgZ8znuIIFbNgnHnLQ8DAgNkALL41z9WxUdMARcyGrvEdFJfdePDeqxt7XTuDe9E5zF2
	 h41dmAVTMRlfaQJS2FkvcmI8nl6YtER0JTcb09PgUKr4+MjcGsUTLklYR1dzfWn7zcxmw
	 I98FnUB+T9wEfgFL/gMpBY2JCXoAfEBy6SZwqdOi7pSe3jI4H4MDCV+mIlnscG+DyRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583181;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=BgJ+h302Lr/tVC00fFZLAtt1DYKzMCFkSzn+eo2AnrE=;
	b=NeDaS7y56cuCQ6/AqN6d70i3lxTfvL5WYHWl19bnbeuB8CGYERxyRwGeMVWrGDrltOzk
	 VsJ5j+kADoFkSUYP+6RLhkoi52G7twuLMSfY4vHBGKZeAER8r4FyjIqqQy08I2Ra9FgQN
	 rjQfnIfNyXCbiXamH96kRlRNvQ3QTqAxWg1snLhCE3Of8RkGT/QwToJ854KrBONmTHikz
	 jHl0Ms0oWFQQhhDRIMMyoNMrZsPrDhvo5vskfGdUf5q+nXYkmlkukQZDmbMeAqvXvuyUn
	 3fa638IQJICLgQkZRzQI3s8+O5SN4t47gmiDqp4MRk2aZ/xngIQVPFmc1sDzOfReV/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YCcEPLKl;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3A606A321;
	Wed, 25 Nov 2026 05:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YCcEPLKl
Received: from [192.168.1.70] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2B07220B716E;
	Tue, 24 Nov 2026 21:06:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B07220B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795583176;
	bh=BgJ+h302Lr/tVC00fFZLAtt1DYKzMCFkSzn+eo2AnrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCcEPLKlTQxQHDthhfnAh78gvcKFpe1S9kIpLmmI93MO0U9Tz/fAVsKtunzvpFKml
	 Bl3KoQDNObSDx1I+nKV+8SoJhnB00gE7j7Nb/vwSmYjVDhxshtdY/DjLJdekBWYJ8u
	 zE1IaHVpPkjU2ROE0AvB24C5wn6qT6q23zeeB5o4=
Message-ID: <13d84ea8-2c72-48a3-9acb-e11e947d4672@linux.microsoft.com>
Date: Wed, 25 Nov 2026 10:36:11 +0530
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
Subject: Re: [PATCH v2 3/5] x86/hyperv: Use native callbacks for trimming and
 ASID transitions
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
 <20261117091507.2088642-4-namjain@linux.microsoft.com>
 <MN2PR02MB6863881EE9A8C2A04604652DD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
 <6ac7bb4f-7a80-41a2-b1ed-0235d35aebdc@linux.microsoft.com>
 <DM6PR02MB6860396375E1FD95F183F073D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <DM6PR02MB6860396375E1FD95F183F073D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/2026 1:42 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, November 23, 2026 10:45 PM
>>
>> On 11/24/2026 5:46 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>>>>
>>>> Successful Hyper-V flush hypercalls do not run the guest callbacks that
>>>
>>> How should I interpret the "Successful" qualifier on this statement? It seems
>>> a bit spurious since unsuccessful flush hypercalls don't run the callbacks
>>> either. But maybe there's something I'm not understanding ....
>>>
>>> Michael
>>>
>>
>> I meant that a failed hypercall leads to native fallback, which can run
>> the callbacks, whereas a successful call returns without
>> doing so. But the hypercall itself never runs those callbacks.
>>
>> I can use this commit msg the next time.
>>
>>
>> x86/hyperv: Use native flushes for mask trimming and ASID transitions
>>
>> When trimming mm_cpumask(), Linux needs to run flush_tlb_func() on
>> remote CPUs so they can clear their stale bits. A Hyper-V TLB flush
>> hypercall invalidates translations but does not run this function.
>>
>> The same applies during a global ASID transition. CPUs still using
>> local ASIDs need to run flush_tlb_func() to switch to the global ASID.
>>
>> Call native_flush_tlb_multi() in both cases so the required work runs
>> on the target CPUs.
>>
> 
> Yes, this text looks good to me.
> 
> A comment unrelated to the commit text: mm_in_asid_transition()
> is always false unless the INVLPGB instruction is present, which is only
> on AMD processors. Furthermore, when I last checked about a year
> ago, Hyper-V does not make INVLPGB available in guest VMs, except
> for SEV-SNP guests. So if you want to test the local ASID to global
> ASID path, it must be on an SEV-SNP VM.
> 
> Michael
> 
> 

Thanks. Let me check if I can get hands on this setup.

Regards,
Naman
