Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438558;
	b=ciSKHxj4OpzRBr+6QNxjkYcKZs9tvHg5KPZOy94gr2LKJxall6W54lUCHx2OaNXCctr6
	 3/ct7SILThxyR1/ZrX9I+JlX2zQKTfdOH609CjqTPNE8/oQGlQt3Drboa/yczMM5HUqpS
	 uWSCvPaCNmQKcDpuBygJ23LoJCnclOa5ZzZLRriw9MmNGvWyr6s8qomQayj9tQAAS7wPY
	 Z8kr8X2wOcr4pgUNHIXYLbu14nDrLMbn2i+13EuhNO1tcUi+7mU7gUzLqrz83rPrmq9E/
	 rl6A9HYtt5YKbSMgFg1ntrSlMqu15bRfyUfD5o7bc61kqKhGrbYoTh+dxiVESlimOYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438558;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=vZZFw2Ags+4t3vPs7KDSZfrmQf6/AGi96Xfe0bS6fp4=;
	b=VslGNeS6Re8J6WePs/Fk1XtcZ3mOBAf9RfrDDqNSWZxM1pynlFfeC7jVCit4ufugw3Mt
	 M22ImT7Wn7vrD0m+uNGPTUx/y/yFEXKeomECq9X+XDR9bUWYwrhOMaYtxAeeJiBsw/pwi
	 tjvEhEiPgBzWRVaZOTZXKW5YJjC1FmJSalSnPrUOLmyeYvl9RmZvBdB24ORClV0ag5AC6
	 /j0v/662C97NC0S5XjTPlkWJN+9Qqu33P1+dnvF7wXspf2Y2NGjfdvFq9fcc6/GlwC5Z8
	 8RYxqAaYANDEAVsyriqCzqM6VYdaxQzpo6JWtckFRj8W8srL+3VQ2+/ihHYMsb4ZHzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RBFuGBtc;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DE606A324;
	Wed, 11 Nov 2026 23:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 643DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RBFuGBtc
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D1A720B7166;
	Wed, 11 Nov 2026 15:09:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D1A720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794438554;
	bh=vZZFw2Ags+4t3vPs7KDSZfrmQf6/AGi96Xfe0bS6fp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RBFuGBtcsb19NOcWncTWCNuz/bCEbDa7HyhaWyJRgMDTWQ4AiwQ2pCFEy+kQE9oeA
	 E/tS0SqjnbhwrClB4GCR2j8R4R6BFNiw9tCIkGCskkixgczoCsPdt6uug4JKZK0Xji
	 bK2rKE9Z0DFH5IeVJ2xQMMiPSBYIaTBGguADcHrs=
Message-ID: <488ac669-eeb6-4873-217d-da111d58eb09@linux.microsoft.com>
Date: Wed, 11 Nov 2026 15:09:16 -0800
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
Subject: Re: [PATCH V0 1/2] Drivers: hv: Add new function
 hv_isolation_hw_cvm()
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "mhkelley58@gmail.com" <mhkelley58@gmail.com>
References: <20261111022036.351231-1-mrathor@linux.microsoft.com>
 <20261111022036.351231-2-mrathor@linux.microsoft.com>
 <MN2PR02MB68638A29ED39B5D77EF34616D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <MN2PR02MB68638A29ED39B5D77EF34616D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 10:09, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, November 10, 2026 6:21 PM
>>
>> Add a new function hv_isolation_hw_cvm() for convenient check
>> if a VM is running in HW confidential mode, ie, TDX or SNP.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/ivm.c          | 5 +++++
>>   drivers/hv/hv_common.c         | 9 +++++++--
>>   include/asm-generic/mshyperv.h | 7 +++++++
>>   3 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 2ce4dfe53472..b3340be0c43a 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -944,3 +944,8 @@ bool hv_isolation_type_tdx(void)
>>   {
>>   	return static_branch_unlikely(&isolation_type_tdx);
>>   }
>> +
>> +bool hv_isolation_hw_cvm(void)
>> +{
>> +	return hv_isolation_type_snp() || hv_isolation_type_tdx();
>> +}
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 27b9b79d4f4c..62b52855ae69 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -528,8 +528,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>   			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>   		}
>>
>> -		if (!ms_hyperv.paravisor_present &&
>> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>> +		if (!ms_hyperv.paravisor_present && hv_isolation_hw_cvm()) {
> 
> Any reason not to use hv_is_isolation_supported()? Your
> new function seems conceptually equivalent, though at a
> detailed level it handles VBS isolation differently from
> hv_is_isolation_supported(). But I don't think including
> VBS isolation here is a problem since set_memory_decrypted()
> is a no-op with VBS isolation.
> 
> Also, Kameron Carr has a patch set in flight that collides
> on exactly this code.  See [1] for the patch and my comments.
> 
> Michael

Hi Michael,

The issues my patch addresses only apply to hardware isolations, like
TDX and SNP, hence I called the function: hv_isolation_hw_cvm()

IOW, hv_is_isolation_supported() cannot be used in my case.

If there is conflict, I guess, one of us will have to rebase depending
on who merges first.

Thanks,
-Mukesh


> [1] https://lore.kernel.org/linux-hyperv/MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com/
> 
> 
>>   			ret = set_memory_decrypted((unsigned long)mem, pgcount);
>>   			if (ret) {
>>   				/* It may be unsafe to free 'mem' */
>> @@ -696,6 +695,12 @@ bool __weak hv_isolation_type_tdx(void)
>>   }
>>   EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>>
>> +bool __weak hv_isolation_hw_cvm(void)
>> +{
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_isolation_hw_cvm);
>> +
>>   void __weak hv_setup_vmbus_handler(void (*handler)(void))
>>   {
>>   }
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index a3d497d99b0b..440c599784eb 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -87,6 +87,13 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64
>> input2);
>>   bool hv_isolation_type_snp(void);
>>   bool hv_isolation_type_tdx(void);
>>
>> +/* This needs to be before hv_do_rep_hypercall() below */
>> +#if IS_ENABLED(CONFIG_HYPERV)
>> +bool hv_isolation_hw_cvm(void);
>> +#else
>> +static inline bool hv_isolation_hw_cvm(void) { return false; }
>> +#endif
>> +
>>   /*
>>    * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
>>    * it doesn't provide a recommendation flag and AEOI must be disabled.
>> --
>> 2.51.2.vfs.0.1
>>

