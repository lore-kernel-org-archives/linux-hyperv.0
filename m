Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502679;
	b=uVhjlZdw3+1N4P6VFCPX5h/24OAEuOzevEjcbnWz+m1d1mu7Q3BeXs/JLRLQon0J1P72
	 U2AiRh4dmZA9P095Mp6ro9NjapYkZJyDZa1I9Z+AxgALuw5ouKg6wf/tyebGiqR2Q6O5Y
	 ojMjNe/jZsStJ6kNQEEz2JN2YiCfRycjNujfwfvLnUlhXCRzsRRjhDW0aArXQ+/SziBI4
	 7R5mIGfuR0NuXvAGg6rD6wQ9e61PxTme2qcW1NsckFG6/+lZsAYr4X1v/ujEr/JBKSES1
	 c8k9sGFyqOW3520aLJSPPJkGrl9evgEUPJmFm+NpFMtp2CCX6w4xcm4/KjI1yLzDvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502679;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=2ivtXHycQObTf+KSb95k9xENEqkwy7oAGAUI2F+kaFw=;
	b=vOxakrDd8TWVNraX2+90d2CjFbXffnlHd73z692BvvtrBWVhlmc7W7F0cAO/sRMqlwXn
	 DiUlb+Pk6YO20ZEvrDEy2TKXIMi7pko0+ME8RgHO7wHZj/cSH0dxiyBRhOeu0fwdzaT9M
	 xEAyFi4+5EzEzuakaEfWgYpdXd/JYIa75hlwHQME5xghydfEhsaZ9q2YC+15UAxuLU0t2
	 Dcv2j3MmZOhXw5tITDAH9cm73NfkNvjE/ZdgyMfORhtyKpbMDVGgsrgaJIw2FHXtToWWL
	 WaJ3sUAXzDsEcCZn1GtNMBzk/OA5hHD1mUmJUKpZOFlY3+K7P6vgGaH4GGuHzN0p5Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=N+3qN5kR;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA0606A321;
	Tue, 24 Nov 2026 06:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEA0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=N+3qN5kR
Received: from [10.95.64.197] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D95A20B716B;
	Mon, 23 Nov 2026 22:44:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D95A20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502674;
	bh=2ivtXHycQObTf+KSb95k9xENEqkwy7oAGAUI2F+kaFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N+3qN5kRzzkXjdjbCXdjBzfir+RKjf2k3i1GECTOkm1Qa4pTRZ+m8Ru+GdcC/84DN
	 KqruVzCg4L77dGVZtdm4XCoOWO5puYHi088qQe6OKwXsCjDW0LwUpuKQMGJ2XkIIzD
	 fjDeUlWPA1aSZ/BzhJCbJSpcTeQ6vGBXw4cufBe4=
Message-ID: <6ac7bb4f-7a80-41a2-b1ed-0235d35aebdc@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:14:31 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863881EE9A8C2A04604652DD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 5:46 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>>
>> Successful Hyper-V flush hypercalls do not run the guest callbacks that
> 
> How should I interpret the "Successful" qualifier on this statement? It seems
> a bit spurious since unsuccessful flush hypercalls don't run the callbacks
> either. But maybe there's something I'm not understanding ....
> 
> Michael
> 

I meant that a failed hypercall leads to native fallback, which can run 
the callbacks, whereas a successful call returns without
doing so. But the hypercall itself never runs those callbacks.

I can use this commit msg the next time.


x86/hyperv: Use native flushes for mask trimming and ASID transitions

When trimming mm_cpumask(), Linux needs to run flush_tlb_func() on
remote CPUs so they can clear their stale bits. A Hyper-V TLB flush
hypercall invalidates translations but does not run this function.

The same applies during a global ASID transition. CPUs still using
local ASIDs need to run flush_tlb_func() to switch to the global ASID.

Call native_flush_tlb_multi() in both cases so the required work runs
on the target CPUs.


Regards,
Naman

