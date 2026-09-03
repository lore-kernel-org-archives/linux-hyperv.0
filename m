Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96558381C4;
	Thu,  3 Sep 2026 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407377; cv=none; b=JaygkfAXoMNiV+sOHpLezFRmqXQbOo+l87Q2cgo8a35zLBQswvYinIBjljUy47VzRTPX+w301GJQi3p6ecLuBvWRlr3scw3xGdAcddxtPhwKwoEtPfBk9BumF0b2RavYGsQzKa/qiew8P1zyaJffGIAeASYeSR8JAIU7TZaXq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407377; c=relaxed/simple;
	bh=z5CvLUuofvAe8GI8gKmPn4EW0bh2oqppoVI5P02+Z88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvQZw+3tyoDuGawNoRbgnmUk/+iT2kyxOX/Gjtn7aV9AUBijqIlFV7Sa4e4El5vvzo3/5uq5c+kOjvsaU//hrigSPCudtkVOLQVcZ6CCh0uoE3m4Dtdg4eSgHLqy2YW1QUViDzMNuyh4wP8BztlGvrYPeK2nTz8BeyjSPMX7/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nDkLncuS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nDkLncuS"
Received: from [10.95.64.226] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D28D20B712B;
	Wed,  2 Sep 2026 20:48:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D28D20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788407338;
	bh=Wo3Ed13yCp/5LcEXhS+O9pJVsrv0TOYJuNHXP79BYn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nDkLncuSCOpScfnfJTIAQi0tlzDn60GxjE1amvn1E4YWJ0byUmmaL0DPFXJns529R
	 0gF7WJgBtWkberN5qRC3CBA3+vl1Kv0/dDW6IP+1OyqCkI8CA9f4/G6cQvcjKkWf85
	 ptTZ6l2sRBWqvamG8vwPgMYX94HQuHjfbi87anuI=
Message-ID: <b48d7847-b8d0-4499-9462-e67ff5eb696c@linux.microsoft.com>
Date: Thu, 3 Sep 2026 09:19:30 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ
 stacking
To: Michael Kelley <mhklinux@outlook.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Wangyang Guo <wangyang.guo@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Long Li <longli@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20260810062144.2108758-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157B73B333F08702875110ED4A82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <19005077-4dde-4193-aafa-5b248a2131a6@linux.microsoft.com>
 <SN6PR02MB4157F6AD93437B057878E048D4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F6AD93437B057878E048D4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/2026 10:27 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, September 1, 2026 10:03 PM
>>
>> On 9/1/2026 5:32 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 9, 2026 11:22 PM
> 
> [snip]
> 
>>>> @@ -270,11 +279,15 @@ static void assign_cpus_to_groups(unsigned int ncpus,
>>>>    	for (v = 0; v < nv->ngroups; v++, *curgrp += 1) {
>>>>    		cpus_per_grp = ncpus / nv->ngroups;
>>>>
>>>> -		/* Account for extra groups to compensate rounding errors */
>>>> -		if (extra_grps) {
>>>> +		/*
>>>> +		 * Rotate which groups get the extra CPU so that
>>>> +		 * successive callers produce different mappings,
>>>> +		 * avoiding IRQ stacking when multiple devices
>>>> +		 * share the same CPU topology.
>>>> +		 */
>>>> +		if (extra_grps &&
>>>
>>> Explicitly testing extra_grps for zero isn't necessary. If it is
>>> zero, the "less than" test below will always be false anyway.
>>>
>>
>> That is true, but the intention was to improve readability of this
>> block. Unless you really feel that this should be removed, I would
>> prefer to retain this.
>>
> 
> Fair enough. It's your call unless Thomas Gleixner as the maintainer
> says otherwise. I flag these cases because I spend time looking for
> some subtle reason why the test is actually needed. For example,
> if the left side of the "less than" test below has side-effects, then
> checking extra_gaps for zero prevents the side-effects from occurring.
> To me the redundant test introduces ambiguity -- is there a reason
> it is needed, or is it superfluous?
> 

In my head, I was reading it like this: If there are extra groups and 
these groups satisfy this condition, do this. Other than that, it did 
not add any value.

I should remove it.

> Interestingly, I had an identical conversation in another patch
> review [1] three days ago.
>

:) Sorry for the trouble and thank you again for reviewing the patch.

Regards,
Naman

