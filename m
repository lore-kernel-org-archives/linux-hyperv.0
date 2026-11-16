Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858805;
	b=Zp+WToN2T3Cfk6z6uDfdXWLmNDvs5gazMXNkJXChTGZfSW/MXg3UJxRhd9iESTzY05rW
	 RtXSyR+ZMHJR5T6ivJHvtT7tLjeF61U+4X5jnA8FN4H49Ex2jdUf2KyJd+fd9+FU0vTUF
	 mL4NVS7/HdiJkK648yWnBmAOPR4Qzn1du8zeBL4Yomevlt2CkygTbzED0Of8b27pzKw8E
	 GV0hDs0z6l+pb+vxa3gY9iT4/OawcUbBs9xORfRQek7BCo4Z3f5l3QyITin4C5KywFAZ6
	 uisGV0GJmE+VJparNqT0qZ4tXofxtnFTG283az5esqsf/9xgqTeIUA2rR6GEQjhHMlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858805;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=0W0YD2zGg/Ir8R1RY7KNc850yXIwuHO/SFxtm7fh/Lg=;
	b=WgzmvX9EO9VLi7vmfZFjqkHzLOGSnF+k3bFLpmNDrKf+6Xh1uqamiWZ0vxSdie+6AMYS
	 ZLe28OuRyn8W0My7qTMc1vmkuxJ3/iO5NHKw8CTQYJbJ+6X0vugNlX82Nl4lvcILC7fml
	 erVdAD9vh+4BkrEOzXn+RiDZkylWgjJ6ha+J02rpQkY6PzwRMLuFuy7kfHeBVPEfUMcz1
	 /yQA2bWcJ8cog2RU9S3mPcAZN7luJhrYYhDYeWqpDdUlwe4p04YdFeGUYOH0Wic/Uaeza
	 p2+6nWZt4bTHz0iIWuLsLUFn3R2ZdcJW6Req4Hyegl18W0KuBbi0rK0qYLZVDQFN68g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=F3foXHRS;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85E606A322;
	Mon, 16 Nov 2026 19:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D85E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=F3foXHRS
Received: from [10.4.158.9] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id C262320B7168;
	Mon, 16 Nov 2026 11:53:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C262320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794858798;
	bh=0W0YD2zGg/Ir8R1RY7KNc850yXIwuHO/SFxtm7fh/Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F3foXHRSxF5RNkQ01Sjp4sDx88NP636u+exqnQWyx0deiwJr7eKILGLpYi6AQEdDP
	 0PN5yj35zupNu981dy5mblCBWCSFBpPmPxMgXPnjIadfqSJcPkp9KhuBJyXp2/3pqS
	 2i+uUGkyMkmBAmenMLPx18lg7lSZyufy1vcUoc3w=
Message-ID: <5fddb57c-8805-4fbd-9e27-1c8654f29436@linux.microsoft.com>
Date: Mon, 16 Nov 2026 11:53:15 -0800
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
Subject: Re: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
To: Mukesh R <mrathor@linux.microsoft.com>
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
 <f74db23c-ee1d-e0b1-c463-55dad00f9c61@linux.microsoft.com>
 <7ebf7187-bf42-fc11-e89b-b1aba96539d2@linux.microsoft.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <7ebf7187-bf42-fc11-e89b-b1aba96539d2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/13/2026 6:59 PM, Mukesh R wrote:
> On 11/12/26 16:46, Mukesh R wrote:
>> On 11/12/26 09:49, Kameron Carr wrote:
>>> On 11/11/2026 6:43 PM, Mukesh R wrote:
>>>> On 11/11/26 10:01, Michael Kelley wrote:
>>>>> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, October 30, 2026 5:14 PM
>>>>>>
>>>>>> In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
>>>>>> to be marked as decrypted (shared) for confidential VM isolation types.
>>>>>> This is already done for SNP and TDX isolation; extend the same handling
>>>>>> to Arm CCA Realm guests so that the host hypervisor can access the
>>>>>> shared hypercall buffers.
>>>>>>
>>>>>> is_realm_world() is declared in include/linux/arm-rsi-cmds.h which only
>>>>>> builds on arm64 (it includes <asm/memory.h>), so using it directly in
>>>>>> the arch-neutral drivers/hv/hv_common.c would break the x86 build.
>>>>>> Introduce a Hyper-V-specific helper following the established
>>>>>> hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.
>>>>>>
>>>>>> On architectures other than arm64 the weak default keeps the existing
>>>>>> behaviour.
>>>>>>
>>>>>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>>>>>> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
>>>>>> ---
>>>>>>    arch/arm64/hyperv/mshyperv.c   |  5 +++++
>>>>>>    drivers/hv/hv_common.c         | 17 +++++++++++++----
>>>>>>    include/asm-generic/mshyperv.h |  1 +
>>>>>>    3 files changed, 19 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>>>>>> index 46ab2da..da6c3aa0 100644
>>>>>> --- a/arch/arm64/hyperv/mshyperv.c
>>>>>> +++ b/arch/arm64/hyperv/mshyperv.c
>>>>>> @@ -182,3 +182,8 @@ bool hv_is_hyperv_initialized(void)
>>>>>>        return hyperv_initialized;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>>>>>> +
>>>>>> +bool hv_isolation_type_cca(void)
>>>>>> +{
>>>>>> +    return is_realm_world();
>>>>>> +}
>>>>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>>>>> index 31256cb..a60c92c 100644
>>>>>> --- a/drivers/hv/hv_common.c
>>>>>> +++ b/drivers/hv/hv_common.c
>>>>>> @@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>>>        u64 msr_vp_index;
>>>>>>        gfp_t flags;
>>>>>>        const int pgcount = hv_output_page_exists() ? 2 : 1;
>>>>>> +    const size_t alloc_size = ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, PAGE_SIZE);
>>>>>>        void *mem;
>>>>>>        int ret = 0;
>>>>>>
>>>>>> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>>>         * online and then taken offline
>>>>>>         */
>>>>>>        if (!*inputarg) {
>>>>>> -        mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
>>>>>> +        mem = kmalloc(alloc_size, flags);
>>>>>>            if (!mem)
>>>>>>                return -ENOMEM;
>>>>>>
>>>>>> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>>>            }
>>>>>>
>>>>>>            if (!ms_hyperv.paravisor_present &&
>>>>>> -            (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>>>>>> -            ret = set_memory_decrypted((unsigned long)mem, pgcount);
>>>>>> +            (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>>>>>> +             hv_isolation_type_cca())) {
>>>>>
>>>>> Could this big "if" statement use "hv_is_isolation_supported()" instead
>>>>> of explicitly testing for each CoCo VM type? I ask partly because
>>>>> Mukesh Rathor has just submitted a patch [1] that introduces a new
>>>>> function that does something almost exactly the same as
>>>>> hv_is_isolation_supported() and uses it here.
>>>>
>>>>>> +            (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>>>>>> +             hv_isolation_type_cca())) {
>>>>
>>>> With my change, this will become:
>>>>
>>>>          (hv_isolation_hw_cvm() || hv_isolation_type_cca())) {
>>>
>>> Any reason you wouldn't change hv_isolation_hw_cvm() to
>>>
>>>    return hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>>>      hv_isolation_type_cca()
>>>
>>> That would seem more logical to me.
>>>
>>
>> We could, I just don't know if on cca, the repeat hypercall has same
>> behavior. I was leaving that for the arm team. Anyways, I sent question
>> to the hyp team, if they say yes, i can update my patch to include that.
>>
>> Thanks,
>> -Mukesh
> 
> 
> Confirming, arm has same behavior and needs the fix also. So, we can def
> expand the check to include _cca.
> 
> I just sent V1, renaming hv_isolation_hw_cvm() to hv_isolation_type_hw().
> If your patch goes after mine, you just need to add to your 0004*:
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d7..67a16b4d2235 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -134,3 +134,8 @@ bool hv_is_hyperv_initialized(void)
>         return hyperv_initialized;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +bool hv_isolation_type_hw(void)
> +{
> +       return is_realm_world();
> +}
> 
> 
> OR, you could pick mine 0001-* and make it part of your series, and I
> can drop it from mine and make it dependent on yours. But mine is small
> enough that it has higher chances of going in first.....
> 

This patch set has already been applied to hyperv-next, so maybe you can
rebase off that.

-- 
Regards,
Kameron
