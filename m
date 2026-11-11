Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436653;
	b=VPWekMVhcLPtIYB9cuYBC0WYxiKKJiTfzaf4eNxxWIUBZrtR9njCVNZS6Imhmb+ln0Zb
	 UV2go754jU3dHvHJ7Vb7AFI4olE7qRZR918GU6uNfuT5BkrEpZ6Cr1zebJI+WH8d958Cb
	 o2XMKlcQsx825TPBWM1iUGm/Z7sxJKj9ZTs42lHwE+zRcV9zRso693yXX47YP6Lqq2ztQ
	 qNslgOK2fUCAUFhF4JQ/kcPtj0ehHuD5u15bvLDeIbKolSl+fMMM3IO+HhKickkP5docZ
	 i+RSmv//6sszwcgA7C59OJHtrwUt+t/5ia6yok/9zm66xMQhKrRO5BKiABN4fv7ODgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436653;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=iJrORkTKZetlPYnGNZA/pkmKUZubavEmrWi57SbUmv4=;
	b=CIKfTR/4+ZxsucHp6et7ZqU/1EV4jX0uXfSPIGdBXAmc2sDV/lTf1h6K8LQZdS+UJJwV
	 F2vP1xl6kcbJdK7sZCTR7MpRLk3ON+NgS/lRAeXCxjwCzlgxOpa6r+mBi/6ibQ/nCymKy
	 KGMpuCp6VY961fqZaBzyihgUXASrTbmUMGzxOqo/9z3F1hAtMcy7vITNtBPHrlEEriDQH
	 V6EZQ+KxBP+TaJfouu9xNI1AJQjGPnyVfwdQKZpU/E9hBTYXDArq/7JgeOHxBkldeXYoB
	 aDnJAAH7NnDyzmvB0orrzuwehzKuRn1PBIYDZuv0gjB+85sYCb6aqzx24ajNaLF6V2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=dPZKH9zM;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2A606A324;
	Wed, 11 Nov 2026 22:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C2A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=dPZKH9zM
Received: from [10.4.158.9] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 53D8220B7166;
	Wed, 11 Nov 2026 14:37:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53D8220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794436648;
	bh=iJrORkTKZetlPYnGNZA/pkmKUZubavEmrWi57SbUmv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dPZKH9zMDVcGATZlXDqvy/tVc2lf0uR4VyrTZtKpNH5QXkZiZQLnP/VcBimx5FE3T
	 uImY8EV0e5m9I7fZIdCYLSIXQM4O815KVDGahs5UYll1dCfNWKY1zQIbJjL/uWjHQl
	 mGkTB7JbsR3zeb+Wah0rI/ZBmKHIEKUd84s8Hqpg=
Message-ID: <5d9dccba-61b0-4fac-8dc2-f09ce630157e@linux.microsoft.com>
Date: Wed, 11 Nov 2026 14:36:57 -0800
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
To: Michael Kelley <mhklinux@outlook.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Mukesh R <mrathor@linux.microsoft.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
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
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2026 10:01 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, October 30, 2026 5:14 PM
>>
>> In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
>> to be marked as decrypted (shared) for confidential VM isolation types.
>> This is already done for SNP and TDX isolation; extend the same handling
>> to Arm CCA Realm guests so that the host hypervisor can access the
>> shared hypercall buffers.
>>
>> is_realm_world() is declared in include/linux/arm-rsi-cmds.h which only
>> builds on arm64 (it includes <asm/memory.h>), so using it directly in
>> the arch-neutral drivers/hv/hv_common.c would break the x86 build.
>> Introduce a Hyper-V-specific helper following the established
>> hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.
>>
>> On architectures other than arm64 the weak default keeps the existing
>> behaviour.
>>
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
>> ---
>>  arch/arm64/hyperv/mshyperv.c   |  5 +++++
>>  drivers/hv/hv_common.c         | 17 +++++++++++++----
>>  include/asm-generic/mshyperv.h |  1 +
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 46ab2da..da6c3aa0 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -182,3 +182,8 @@ bool hv_is_hyperv_initialized(void)
>>  	return hyperv_initialized;
>>  }
>>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>> +
>> +bool hv_isolation_type_cca(void)
>> +{
>> +	return is_realm_world();
>> +}
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 31256cb..a60c92c 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>  	u64 msr_vp_index;
>>  	gfp_t flags;
>>  	const int pgcount = hv_output_page_exists() ? 2 : 1;
>> +	const size_t alloc_size = ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, PAGE_SIZE);
>>  	void *mem;
>>  	int ret = 0;
>>
>> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>  	 * online and then taken offline
>>  	 */
>>  	if (!*inputarg) {
>> -		mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
>> +		mem = kmalloc(alloc_size, flags);
>>  		if (!mem)
>>  			return -ENOMEM;
>>
>> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>>  		}
>>
>>  		if (!ms_hyperv.paravisor_present &&
>> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>> -			ret = set_memory_decrypted((unsigned long)mem, pgcount);
>> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>> +		     hv_isolation_type_cca())) {
> 
> Could this big "if" statement use "hv_is_isolation_supported()" instead
> of explicitly testing for each CoCo VM type? I ask partly because
> Mukesh Rathor has just submitted a patch [1] that introduces a new
> function that does something almost exactly the same as
> hv_is_isolation_supported() and uses it here.
> 
> You don't provide the non-stub hv_is_isolation_supported() until
> Patch 6 of this series, but the weak stub should allow everything to
> build if a bisection splits this patch series.

Including your response to Mukesh for context:
> Any reason not to use hv_is_isolation_supported()? Your
> new function seems conceptually equivalent, though at a
> detailed level it handles VBS isolation differently from
> hv_is_isolation_supported(). But I don't think including
> VBS isolation here is a problem since set_memory_decrypted()
> is a no-op with VBS isolation.

I'm not fully convinced that calling set_memory_decrypted() is always a
no-op for VBS.

I see that on VBS VMs, ms_hyperv_init_platform() calls hv_vtom_init().
If set_memory_decrypted() calls hv_mark_gpa_visibility(), you will try
to use the inputarg before it has been initialized.

Please let me know if my understanding is incorrect.

-- 
Regards,
Kameron

> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/20261111022036.351231-2-mrathor@linux.microsoft.com/
> 
>> +			ret = set_memory_decrypted((unsigned long)mem,
>> +						   alloc_size >> PAGE_SHIFT);
>>  			if (ret) {
>>  				/* It may be unsafe to free 'mem' */
>>  				return ret;
>>  			}
>>
>> -			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
>> +			memset(mem, 0x00, alloc_size);
>>  		}
>>
>>  		/*
>> @@ -666,6 +669,12 @@ bool __weak hv_isolation_type_tdx(void)
>>  }
>>  EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>>
>> +bool __weak hv_isolation_type_cca(void)
>> +{
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_isolation_type_cca);
>> +
>>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>>  {
>>  }
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index bf601d6..1fa79ab 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -79,6 +79,7 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64
>> input2);
>>
>>  bool hv_isolation_type_snp(void);
>>  bool hv_isolation_type_tdx(void);
>> +bool hv_isolation_type_cca(void);
>>
>>  /*
>>   * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
>> --
>> 2.45.4
>>

