Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583188;
	b=ot4kURWROHxELWN037YSXIcN//gA6QcDvpF8bI1AukLf/T7ZclwpoJcHIIHcji8mht4+
	 oZRyjE7CYT48yIUahzJGI0a541uKM8T1DNWUGKMtCvaSLpilvbvksLXf5IixHCmZy1NkA
	 7pyKrVcZuoNCVkngTQFbfqdpdlil/f1EPi5SQ9NiGeTe5YyB9BnMIMGlFRWdBfP3hxKvw
	 A8UtGMjaaGxEi8tVfoUtG35D+KphpBrX/C02md2SSKOigAiEcUz1tg2+8vKs9qAgJCvxE
	 oDRoPA28F73bVNa4Mgo7PPguR9rr9mswGdfiHLUa17wKz8GkjijBT28MvLRtytfdPtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583188;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=Nmo4dsf9NWbBgg65NchXnZ4iW2xW3rLRdAHljU/x5tY=;
	b=H3shM55/2unYUV3qtcH5Iez1BeZGGzbklrGMnXrszvBPqeb8FNScPJb0ikWKB3Da/RuX
	 GjYwXKYLtKsqM6r22wjJphyOuv9cZokcVpkctWEjuleYAMee6PWDQIZKqpGdU57TUjLzw
	 6ZTZInjCpzQfGcl8agel2g9qDjExWzPSrj+BlKGs5WvcirgHZB4KQDib26L1hbsc1xjMo
	 j0I+VonS3F8miyBkTxNR8QCVcOzNDmH5eK1y6OO+72XUhkGekMab0WvdEIkfRnZxJ966u
	 z0Ehaz3EOLuZww6xF6MHC6DOn7IhtsI1Eo/qzA7vWvWweczA9XImhEcsiniNX2XBgHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="gnoKs/4Y";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB94606A330;
	Wed, 25 Nov 2026 05:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB94606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gnoKs/4Y
Received: from [192.168.1.70] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5644520B716F;
	Tue, 24 Nov 2026 21:06:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5644520B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795583183;
	bh=Nmo4dsf9NWbBgg65NchXnZ4iW2xW3rLRdAHljU/x5tY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gnoKs/4YJ9448QpEibRsQ/bZRql58aSGa1JbsZLv0QmA0qx7PB7iBAW+7G7uUXtqW
	 9lrcXw9fk/mC5kFkRPr9OiY1fKwl1I3N6TdnMpge8kVMHzvKD4x46RYx4OU9gR8wPC
	 vdXj/+yabHtxbcU/t2oOPvXQSo1h2ASXoqDZ+BNQ=
Message-ID: <20501417-94ae-4846-a616-69ecd0989f73@linux.microsoft.com>
Date: Wed, 25 Nov 2026 10:36:19 +0530
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
Subject: Re: [PATCH v2 4/5] x86/hyperv: Filter TLB targets before building
 hypercalls
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
 <20261117091507.2088642-5-namjain@linux.microsoft.com>
 <MN2PR02MB6863EA8EE36408EA031F1CEDD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
 <d7c486ff-dbd6-4ec0-ad3e-673976b811e6@linux.microsoft.com>
 <DM6PR02MB686096C4BD67938C356B7EE6D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <DM6PR02MB686096C4BD67938C356B7EE6D4442@DM6PR02MB6860.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/2026 1:50 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, November 23, 2026 10:45 PM
>>
>> On 11/24/2026 5:46 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17,
>> 2026 1:15 AM
>>>>
>>>> SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs regressed
>>>> between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch caused
>>>> host-to-GPU copy stalls and timeouts. The reported bisection identified
>>>> commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").
>>>>
>>>> That change leaves a CPU's bit set after it switches to another mm.
>>>
>>> To be more explicit,
>>>
>>> "... leaves a CPU's bit set in the mm_cpumask even after the CPU switches
>>> to another mm".
>>>
>>
>> Acked.
>>
>>>> Native flush callbacks remove these stale bits, but successful Hyper-V
>>>
>>> Again, I'm wondering about the "successful" qualifier.
>>>
>>
>> Discussed in patch 3 comments. Please let me know if I can retain this.
> 
> I know I'm being a bit pedantic, but perhaps this text:
> 
> ... but successfully taking the Hyper-V hypercall path does not run those
> callbacks.
> 

This LGTM. Thanks.

Regard,
Naman

<snip>
