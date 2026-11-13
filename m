Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530783;
	b=1zWF+LGGuviBR5LZKOcRmmUIh+L+mR5I4Bip2SYwHOOQh9aKYsAOGmXOe3hrvHMx7Tj6
	 YzywAnIeee0J7Sl2Fn1ReUWabcq66ZC5ZvajQOnUlCGn4nil7Wcu7yrCpMbtWBzyNnUv4
	 Ap0ju1z09BU9f5FwDsrWWxSmiGS4ack4wL8/wGe1UGpQ0xPCXS9CkDrw5Ic0RCnm7vrtV
	 VnqjnHStvSUmbtfmZC+wZ8BAu1PXy+RNUeulipn9uH4lcDWwQn4NCo2DTBOFejTOiXqjL
	 oM0vkfxeJSpYjlsJCf8V0OzwI+gFIuNmzBlkw3tA5GyYYXfXa+Q30mEG0H8Sny9C4tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530783;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=1vBgOZighXGOllRdyE42732n3hMUT8k/mfbvblMTQQA=;
	b=ca+FuSWGHEfFOEW1OT0M7fiMPEPOi5mkWJ9WCY/CXL/MVEKI8NH6i6sHnheDeYkCC9t7
	 p7vnqZ8tPHDtalhF4pvbFVu784gN8y/Ou5gMCOXdR0hkYAOOCDmRVb/qddJ8Z8K4EVqK6
	 cUYuihL5NzdDDY4HVE+UUInGBCx7oBCAdVFMszVPChxTJdha0nDiJ00e/3EGZHY9At/la
	 /io6V0cFijzMEDM5ZiHXzX/q8kp50PFwIrZ08t2RYv9f3p8B3PLnjLSL1mh2yAexye8NX
	 W3V6KTF5JokINB/VY5piuiGd3BWQqhfhmUD5+aT/Tp9jZZtllymu0jTkzzZEiAxdswA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="Dt/E76kI";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61E606A330;
	Fri, 13 Nov 2026 00:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F61E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Dt/E76kI
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 040C620B7166;
	Thu, 12 Nov 2026 16:46:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 040C620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794530778;
	bh=1vBgOZighXGOllRdyE42732n3hMUT8k/mfbvblMTQQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dt/E76kI/3MFpUYYHZOURgy6EkuaTi8S8z5ncW2I/9sTmvxARptIu+vmDL6Tjc4IN
	 5gSmEOJ0Q1EPS7g1x//7jcGiliU1FVjk8KiQarz3eBVAdpjIXlT/6b+rBBy3Gmi2m7
	 yhwafN52I0kemUkmW8gkwXEyUvkufDSSAKcNQa9U=
Message-ID: <f74db23c-ee1d-e0b1-c463-55dad00f9c61@linux.microsoft.com>
Date: Thu, 12 Nov 2026 16:46:21 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Content-Language: en-US
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "sudeep.holla@kernel.org" <sudeep.holla@kernel.org>,
 "thuth@redhat.com" <thuth@redhat.com>, "will@kernel.org" <will@kernel.org>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
 <MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com>
 <c6b7f583-878d-1f1e-60cc-e602e277d075@linux.microsoft.com>
 <af057438-a684-4840-815c-581b866678c1@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <af057438-a684-4840-815c-581b866678c1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 09:49, Kameron Carr wrote:
> On 11/11/2026 6:43 PM, Mukesh R wrote:
>> On 11/11/26 10:01, Michael Kelley wrote:
>>> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, October 30, 2026 5:14 PM
>>>>
>>>> In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
>>>> to be marked as decrypted (shared) for confidential VM isolation types.
>>>> This is already done for SNP and TDX isolation; extend the same handling
>>>> to Arm CCA Realm guests so that the host hypervisor can access the
>>>> shared hypercall buffers.
>>>>
>>>> is_realm_world() is declared in include/linux/arm-rsi-cmds.h which only
>>>> builds on arm64 (it includes <asm/memory.h>), so using it directly in
>>>> the arch-neutral drivers/hv/hv_common.c would break the x86 build.
>>>> Introduce a Hyper-V-specific helper following the established
>>>> hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.
>>>>
>>>> On architectures other than arm64 the weak default keeps the existing
>>>> behaviour.
>>>>
>>>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>>>> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
>>>> ---
>>>>    arch/arm64/hyperv/mshyperv.c   |  5 +++++
>>>>    drivers/hv/hv_common.c         | 17 +++++++++++++----
>>>>    include/asm-generic/mshyperv.h |  1 +
>>>>    3 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>>>> index 46ab2da..da6c3aa0 100644
>>>> --- a/arch/arm64/hyperv/mshyperv.c
>>>> +++ b/arch/arm64/hyperv/mshyperv.c
>>>> @@ -182,3 +182,8 @@ bool hv_is_hyperv_initialized(void)
>>>>        return hyperv_initialized;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>>>> +
>>>> +bool hv_isolation_type_cca(void)
>>>> +{
>>>> +    return is_realm_world();
>>>> +}
>>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>>> index 31256cb..a60c92c 100644
>>>> --- a/drivers/hv/hv_common.c
>>>> +++ b/drivers/hv/hv_common.c
>>>> @@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>        u64 msr_vp_index;
>>>>        gfp_t flags;
>>>>        const int pgcount = hv_output_page_exists() ? 2 : 1;
>>>> +    const size_t alloc_size = ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, PAGE_SIZE);
>>>>        void *mem;
>>>>        int ret = 0;
>>>>
>>>> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>         * online and then taken offline
>>>>         */
>>>>        if (!*inputarg) {
>>>> -        mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
>>>> +        mem = kmalloc(alloc_size, flags);
>>>>            if (!mem)
>>>>                return -ENOMEM;
>>>>
>>>> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>            }
>>>>
>>>>            if (!ms_hyperv.paravisor_present &&
>>>> -            (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>>>> -            ret = set_memory_decrypted((unsigned long)mem, pgcount);
>>>> +            (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>>>> +             hv_isolation_type_cca())) {
>>>
>>> Could this big "if" statement use "hv_is_isolation_supported()" instead
>>> of explicitly testing for each CoCo VM type? I ask partly because
>>> Mukesh Rathor has just submitted a patch [1] that introduces a new
>>> function that does something almost exactly the same as
>>> hv_is_isolation_supported() and uses it here.
>>
>>>> +            (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>>>> +             hv_isolation_type_cca())) {
>>
>> With my change, this will become:
>>
>>          (hv_isolation_hw_cvm() || hv_isolation_type_cca())) {
> 
> Any reason you wouldn't change hv_isolation_hw_cvm() to
> 
>    return hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>      hv_isolation_type_cca()
> 
> That would seem more logical to me.
> 

We could, I just don't know if on cca, the repeat hypercall has same
behavior. I was leaving that for the arm team. Anyways, I sent question
to the hyp team, if they say yes, i can update my patch to include that.

Thanks,
-Mukesh
