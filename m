Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502712;
	b=l3+Ft1jiBDjCZKMm2GqWrGMF+HlfF3Q9TYCPjdyx6gc+MRMceAZzYFMTef1F8/8hqsli
	 IjWO4AZLk+2opQ+HAz/M0FucAYZJ9q4iPnD+pB7znndiiPnpO3q2/BnZByOE3oh28piQW
	 m0s/UcqJHmseaDjNlfYb8phABDZia//XG44XqhFP/zxU0Lq51PFO4uUlvLmQrZmBhJoqm
	 DAP4EaSl+FK2PMVw4jqGJHYUe+CvV4ZTmpzny5wCv0zrKyrHgc9Xdh/yftpY++oMUnETk
	 VqHA2X7u0YLg8BjHF5DY0NjkUkTT+h+tPAje0ygZDwbi7quqMfCPWjXwu0NmOZ6ROOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502712;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=mByiXuSIR3saYuaSuQdz+k+0udfliR+/jJtT3AIqz/M=;
	b=zux7Kdhu3+x8lvoSt8aVySXb20CEUrBHym06My/s4PGsd9nNTGln0RoCWSE7ktPaYdAR
	 jVTUUhRhp7QyZ9AnHfJLScP6+k+XNN+gKicZarbdM1Mc4LGNCMZRcvAUzKR+HEjmfFe3S
	 uAOib4sH8z0RMRavvaYa6Q5F9XnzJ4X2RfLH7FE1sxOAOEb9D6rqU8irNbwXtHp8hvMIR
	 P4Cu4QXhEs1Sew+IYnTscuX7HV142FO033u+uEoXl4mXwS/A3iLSWhfAS/VFaRttgM6IK
	 OQ32rhX8K+rYsm7JUS2a1c7dg75B0CUqjhxan4i8JxISQKbB/79DYbycPbcs0ueDdjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lrJCV9Pm;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A37606A31E;
	Tue, 24 Nov 2026 06:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A37606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lrJCV9Pm
Received: from [10.95.64.197] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86CD820B717A;
	Mon, 23 Nov 2026 22:45:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86CD820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502707;
	bh=mByiXuSIR3saYuaSuQdz+k+0udfliR+/jJtT3AIqz/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lrJCV9PmhBW+Lq5Uwss5C3gZFOQx1/MuFnJZztIbo/lRJYSOopcjycaZbk78rw28C
	 mYYZkqBm4VXRF9whLa178QgNdQyP+/Gu6VO4d4Zv+JcwghzbccwYM8vIPqVijh/saR
	 FM9efwIma6/JcferilFHPMtgcx3bYx/xWD1/rFz8=
Message-ID: <8a0b83c3-1358-41f3-926b-2a130b9dce7a@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:15:04 +0530
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
Subject: Re: [PATCH v2 5/5] x86/hyperv: Request mask cleanup when no remote
 target remains
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
 <20261117091507.2088642-6-namjain@linux.microsoft.com>
 <MN2PR02MB68634640FB1BAE74B2A5DBDFD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB68634640FB1BAE74B2A5DBDFD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 5:47 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>>
>> Filtering avoids unnecessary hypercalls but leaves historical CPU-mask
>> entries in place. These entries can keep later flushes on the multi-CPU
>> path even when only local work is needed.
> 
> This needs some rewording.  Something like:
> 
> Filtering avoids flushing on CPUs that don't need it, but the filtering
> doesn't remove any stale entries from the mm_cpumask. These stale
> entries can keep later flushes on the multi-CPU path even when only
> the local CPU needs to be flushed.
> 

Acked. Thanks.

>>
>> When no remote target remains after filtering, request native trimming
>> of the original candidate mask instead of waiting for the periodic trim.
> 
> And maybe substitute mm_cpumask instead of "original candidate mask"
> (if that's actually correct).
> 

Acked. Yes, that's correct.

>> Copy the const request so only this call requests cleanup.
>>
>> The native predicate still skips lazy CPUs, so cleanup may not leave a
> 
> Again, be explicit instead of "native predicate".
> 

Acked.

>> local-only mask. The new early return also makes the empty basic
>> processor-mask check unnecessary.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/mmu.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index 833eaea1d3fa8..545a25fcf6c34 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -102,6 +102,21 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>   		}
>>   	}
>>
>> +	/*
>> +	 * No remote target remains after filtering. Request native cleanup
>> +	 * of stale, non-lazy memberships so later flushes can take the local
>> +	 * fast path when possible. Lazy memberships may remain.
> 
> This comment reads like an assertion of the state of things at this point.
> But it's only true if the below "if" statement is true. Reword as "If no
> remote target remains after filtering, request native cleanup ..."

Acked. I will change it.

Regards,
Naman

> 
>> +	 */
>> +	if (cpumask_any_but(flush_cpus, smp_processor_id()) >= nr_cpu_ids) {
>> +		/* Keep the caller's const request unchanged. */
>> +		struct flush_tlb_info trim_info = *info;
>> +
>> +		trim_info.trim_cpumask = 1;
>> +		local_irq_restore(flags);
>> +		native_flush_tlb_multi(cpus, &trim_info);
>> +		return;
>> +	}
>> +
>>   	if (info->mm) {
>>   		/*
>>   		 * AddressSpace argument must match the CR3 with PCID bits
>> @@ -148,12 +163,6 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>   			__set_bit(vcpu, (unsigned long *)
>>   				  &flush->processor_mask);
>>   		}
>> -
>> -		/* nothing to flush if 'processor_mask' ends up being empty */
>> -		if (!flush->processor_mask) {
>> -			local_irq_restore(flags);
>> -			return;
>> -		}
>>   	}
>>
>>   	/*
>> --
>> 2.43.0
>>

