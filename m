Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426057;
	b=DO3JhH9Vixx8HMd67MqAE/3jykh9axaBgSSEBbTOu0zolg/eXBLS7afI8URCHgre+r+d
	 Y1ZDagX9+huBGU3oUw0EYMV1ThnDQ11obiCyZHQqKbCMPEje6Fc38Fqd7QGGGk+C5UMdZ
	 qAKj1XdRFFdLlgbq87ngm63EKCW3uEMt3uE0oQv3p3fSTEkdA9R+gWxo3t/mN7tJCWpb1
	 8jcvRwhahGmgISglo0zfhtMazYMSWDwN8CozWLENRUL2QXFgjUyBqP4S+DJzYFdftyC8X
	 nB5t8VQrS6Oq5Y8ATQmGghJO3hgGkjruwSvwSOmFwhImFwk7wzFHqLbkiZigCki7ttw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426057;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=0yA9h3rkrGWUwNZM2GbnX6IgS2NUA31EDSsvcPpVQ64=;
	b=N31REdtGVD7Bo2T/bIszyuZAdUyM1g6BuXJnFTFnQaTBAMNxUiVjvO4F6x8LLXbAss+/
	 3OTQd1j3yRBSTYL5Bnn9Vq1r1nJtlJT8H7lXW51EJqJRz+zNDkiiGFrr3MuAooHmH74NU
	 qmM/atJCVZgfYhCmC23ZqOaD0ygBH6JHxmTHHct4E8E0Er1QalgmLH9XTikPOyCYBF91F
	 W59WinEXs748jdjjgkl+rEXQFWQwHpVNo3VRPNJBRAH6wVhs7qyRfpIVFnp9BS7pK7GUr
	 99THkpORyBXjoaUwpStLDhyXGb79VxFDU2bgLdd2BssqQrRCcOiVfy62k3TaToIw5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="G+/va11U";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F8606A327;
	Wed, 11 Nov 2026 19:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93F8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=G+/va11U
Received: from [10.4.158.9] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54CAD20B7166;
	Wed, 11 Nov 2026 11:40:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54CAD20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794426052;
	bh=0yA9h3rkrGWUwNZM2GbnX6IgS2NUA31EDSsvcPpVQ64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G+/va11Uca+TJlQut2gfWo97vYuAIr4he/rj5Ckgh4c6vYKyd1cQMXUDy1zs31kaC
	 VZJ8MwQwAd9070qO/iFTXd8Qg1jWxu5gz6WoO1/0+6RzAENz1AI7crUTS2hKzewFwT
	 C2xvP4kfRLjDFNZuoUPWXciq0bs3mDglDDWDiesU=
Message-ID: <fe67b6bd-c2e9-47f7-8a11-f99c010dc479@linux.microsoft.com>
Date: Wed, 11 Nov 2026 11:40:47 -0800
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
Subject: Re: [PATCH v6 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
To: Michael Kelley <mhklinux@outlook.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>
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
 <20261031001412.4150488-4-kameroncarr@linux.microsoft.com>
 <MN2PR02MB686375CB482F6EEA9D00F806D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <MN2PR02MB686375CB482F6EEA9D00F806D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2026 10:00 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, October 30, 2026 5:14 PM
>>
>> Arm CCA Realms cannot issue Hyper-V hypercalls via HVC; the guest must
>> route them through the RSI_HOST_CALL interface, which takes the IPA of a
>> per-CPU rsi_host_call structure as its argument.
>>
>> Add hv_hostcall_array as a per-CPU struct array and allocate it during
>> hyperv_init().
> 
> A quibble: This statement is a bit misleading. I think you mean it is a
> global array with an entry for each CPU.  The term "per-CPU" typically
> means something allocated out of the per-CPU area.

I agree. Earlier versions of the patch did use a per-CPU struct but it
was changed to a global array because the structure was small enough.

This series has already been applied to hyperv-next, but I can reach out
to Wei about editing the commit messages.

-- 
Regards,
Kameron

> Michael
>  
>> The allocation is gated on is_realm_world() so non-Realm
>> arm64 Hyper-V guests pay no memory cost.
>>
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
>> ---
>>  arch/arm64/hyperv/mshyperv.c      | 27 +++++++++++++++++++++++++--
>>  arch/arm64/include/asm/mshyperv.h |  4 ++++
>>  2 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 82572c5..46ab2da 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -14,12 +14,16 @@
>>  #include <linux/arm-rsi-cmds.h>
>>  #include <linux/export.h>
>>  #include <linux/errno.h>
>> +#include <linux/slab.h>
>>  #include <linux/version.h>
>>  #include <linux/cpuhotplug.h>
>>  #include <asm/mshyperv.h>
>>
>>  static bool hyperv_initialized;
>>
>> +struct rsi_host_call *hv_hostcall_array;
>> +EXPORT_SYMBOL_GPL(hv_hostcall_array);
>> +
>>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>  {
>>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
>> @@ -110,6 +114,20 @@ static int __init hyperv_init(void)
>>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>>  		return 0;
>>
>> +	/*
>> +	 * The RSI host-call buffers are only ever used when
>> +	 * is_realm_world() is true. Skip the allocation on non-Realm
>> +	 * guests. A single contiguous array of nr_cpu_ids entries is
>> +	 * allocated; each CPU indexes into it by its processor ID.
>> +	 */
>> +	if (is_realm_world()) {
>> +		hv_hostcall_array = kcalloc(nr_cpu_ids,
>> +					    sizeof(struct rsi_host_call),
>> +					    GFP_KERNEL);
>> +		if (!hv_hostcall_array)
>> +			return -ENOMEM;
>> +	}
>> +
>>  	/* Setup the guest ID */
>>  	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
>>  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
>> @@ -131,13 +149,13 @@ static int __init hyperv_init(void)
>>
>>  	ret = hv_common_init();
>>  	if (ret)
>> -		return ret;
>> +		goto free_hostcall_mem;
>>
>>  	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE,
>> "arm64/hyperv_init:online",
>>  				hv_common_cpu_init, hv_common_cpu_die);
>>  	if (ret < 0) {
>>  		hv_common_free();
>> -		return ret;
>> +		goto free_hostcall_mem;
>>  	}
>>
>>  	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>> @@ -150,6 +168,11 @@ static int __init hyperv_init(void)
>>
>>  	hyperv_initialized = true;
>>  	return 0;
>> +
>> +free_hostcall_mem:
>> +	kfree(hv_hostcall_array);
>> +	hv_hostcall_array = NULL;
>> +	return ret;
>>  }
>>
>>  early_initcall(hyperv_init);
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index b721d31..aed0aa5 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -61,6 +61,10 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>>  				HV_SMCCC_FUNC_NUMBER)
>>
>> +/* Per-CPU-indexed RSI host call structures for CCA Realms */
>> +struct rsi_host_call;
>> +extern struct rsi_host_call *hv_hostcall_array;
>> +
>>  #include <asm-generic/mshyperv.h>
>>
>>  #endif
>> --
>> 2.45.4
>>
