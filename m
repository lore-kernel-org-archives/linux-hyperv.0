Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130330;
	b=4p6gVLJGWoZo4QUh/DV6w1K3VgYm01C+g7mVIAH3tx0eCsWmBmoeLozNz0NWVO1zNeeT
	 NqMWl3b7jkkccovaRCaRvdU5yM5X2uacXXA2GdLT6lHkpn2EOg+LSVX34tRUzGQayP/ND
	 l1C4RjYUems0bfXTDmjAltOSrxn0w7mbHSg3uVQpfYB+XSPItC7xoJXFDT1mtBbEasmuh
	 m1SN0UpFACgKTHJ8IixLmY6fZGFr/6zT9M52NzCVeitFiyl2uH68/pZtdwYyzSXDL1YCm
	 npmd2uO6EfztugQEeM45ZdL3ex8DpsJ0EdePDEIWIkZy3JDDz46R9G9dBVAs8k6U23A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130330;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=IoabV2VxoUyRhnu9jmXaZBldz5Wr97ijw+Y3IW83qfM=;
	b=tyjkg7gJFRmmZIeaU3EsQzHVHdp0Wo5xsCJ5LRcpjmpeBm6HIgpNJV8MD/1x0GBA1pCN
	 8N+3gQHY+ATSUpxOlgN1mq/xQ4Ycsg86Q2GAPp/Vj1tlD7Z2CHItHOLXZ1L3GKUKdNrrx
	 91njTFdvsvIZv6SQ4bhM2ma8yi2WfIJvY2bQAOkqLYaHttjrIaQX0uccC97nMcLMqIFGf
	 30lmyKW3s7Z+QjzYNqa94lsfDnUt9RwuiJZhNFyvUuNqm7zPZbSypvCBWmpP8/I0Z8dR4
	 FfejPIbZ2oQCELrkCA+cirUsmisEWRzlhJCxIFEhNnTK6wbSGiUjbaPt7a1hgAaMyRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=H1OAbmxz;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60240606A32C;
	Thu, 19 Nov 2026 23:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60240606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=H1OAbmxz
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93B9C20B7166;
	Thu, 19 Nov 2026 15:18:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93B9C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795130328;
	bh=IoabV2VxoUyRhnu9jmXaZBldz5Wr97ijw+Y3IW83qfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H1OAbmxzqQXd4m5xgxOYa9Lc8M4W0KGHhMF8BGhB6RMSjzC1SQd7TCafdyccGls2F
	 6nwT+n+OjtkIDNHAGdKZKiA1iMkEezYzO9szzMcmIPVVkNqpX/jSvjXlQwnDc/GHk9
	 fZ7/mXHELX4rc9KBcGZiniFbpcRP+suqjqL+Tm6A=
Message-ID: <1f486680-f2b2-5967-2cf6-bfbf5fe1fc5f@linux.microsoft.com>
Date: Thu, 19 Nov 2026 15:18:48 -0800
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

Hey Kameron,

Since this function is added to check cca and is being used now, there
are places that still use is_realm_world() in arch/arm64/hyperv/mshyperv.c
that I think should switch over to hv_isolation_type_cca(). Should be
quick patch.

Thanks,
-Mukesh

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

