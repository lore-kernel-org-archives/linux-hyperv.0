Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451409;
	b=PtXlLiySDl6977BxXQ7oNFdUH+VHdl+Xb+o1ZUU+lBIoL+GTFJx5z65KR908xH6ZIZa8
	 njTjGO3o9hJtjnTWMqpZjBYr8IeAn7momKwMw/TgdT0kWUFxKB5lq5erlzUsVYtfEboDf
	 5inRHSgGufhjg1O4yrYtblcgHUq6eXybTxtO3lF1XnUZs+LJKA6ex3rquTaYMfKDsk78V
	 yuaBiWcxVWdUd2LFmvtL2Z3P2kVI/ct34p+Ko5iYyNJpc0b3UFcUfLXxhIg5/ghBQ8n1U
	 rGHiq8dslDgVpvCoHKt/OrlGHqqno0GHx6IDuzSMjuAARn8QlRB8mIWU/gP0E1O0neQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451409;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=XdkaBsBaFVJPPurgDNIn6T1G0WeNJH9pMqVBcKCihf8=;
	b=uIHVi3eo9C2jqwntVBQoC6iKBP6XyzYGcPdA4KL+IAyL5q48/X3aeOxszSzJpklH9IbP
	 VT4iUAWc2rYIR2jr68fkbqFvk4uNXZ1FfWW8p6IE3uBd+sRD/QtXpXnYztW1m9qJeaNU8
	 JQ5vU6GVzGgmCCBEFIhTSNwA+S4loODAC5njsYui8nWghqLQdJEb3PAlw1ymerZrhKgF8
	 Phq2Q6TPhhFos3gQZqbcUK4GBuVk8LGsNdp9ybO1lGM5bB6hkE9WlMXyEpqgoNObbEBw5
	 JmzcQG4rvwubs02E1S79TPCcRSgdPbJKRJCs1ioKCliX2tFHY/nRVhJFS7do1IonBjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SlzSn2Z+;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00345606A326;
	Thu, 12 Nov 2026 02:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00345606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SlzSn2Z+
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0ACFE20B7166;
	Wed, 11 Nov 2026 18:43:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0ACFE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794451404;
	bh=XdkaBsBaFVJPPurgDNIn6T1G0WeNJH9pMqVBcKCihf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SlzSn2Z+Gl7kJcsX9wJLqJ90/vk2fEkxrE+wu5+JYE1DqzF0i4hmLIYUxC2bTTM9u
	 E6Gmvo27MKj5KArH76fYvRbG97Iw6gByVN8EqGGz3Rs1ThL8ZwqSC8n8NxB+TXjeGw
	 K3q9NMitLOhAYSiq1vFLg45YHdeyROGC134yrgQk=
Message-ID: <c6b7f583-878d-1f1e-60cc-e602e277d075@linux.microsoft.com>
Date: Wed, 11 Nov 2026 18:43:26 -0800
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
To: Michael Kelley <mhklinux@outlook.com>,
 Kameron Carr <kameroncarr@linux.microsoft.com>,
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
 <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
 <MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 10:01, Michael Kelley wrote:
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
>>   arch/arm64/hyperv/mshyperv.c   |  5 +++++
>>   drivers/hv/hv_common.c         | 17 +++++++++++++----
>>   include/asm-generic/mshyperv.h |  1 +
>>   3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 46ab2da..da6c3aa0 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -182,3 +182,8 @@ bool hv_is_hyperv_initialized(void)
>>   	return hyperv_initialized;
>>   }
>>   EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
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
>>   	u64 msr_vp_index;
>>   	gfp_t flags;
>>   	const int pgcount = hv_output_page_exists() ? 2 : 1;
>> +	const size_t alloc_size = ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, PAGE_SIZE);
>>   	void *mem;
>>   	int ret = 0;
>>
>> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>   	 * online and then taken offline
>>   	 */
>>   	if (!*inputarg) {
>> -		mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
>> +		mem = kmalloc(alloc_size, flags);
>>   		if (!mem)
>>   			return -ENOMEM;
>>
>> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>>   		}
>>
>>   		if (!ms_hyperv.paravisor_present &&
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

>> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
>> +		     hv_isolation_type_cca())) {

With my change, this will become:

         (hv_isolation_hw_cvm() || hv_isolation_type_cca())) {


Thanks,
-Mukesh


> You don't provide the non-stub hv_is_isolation_supported() until
> Patch 6 of this series, but the weak stub should allow everything to
> build if a bisection splits this patch series.
> 
> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/20261111022036.351231-2-mrathor@linux.microsoft.com/
> 
>> +			ret = set_memory_decrypted((unsigned long)mem,
>> +						   alloc_size >> PAGE_SHIFT);
>>   			if (ret) {
>>   				/* It may be unsafe to free 'mem' */
>>   				return ret;
>>   			}
>>
>> -			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
>> +			memset(mem, 0x00, alloc_size);
>>   		}
>>
>>   		/*
>> @@ -666,6 +669,12 @@ bool __weak hv_isolation_type_tdx(void)
>>   }
>>   EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>>
>> +bool __weak hv_isolation_type_cca(void)
>> +{
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_isolation_type_cca);
>> +
>>   void __weak hv_setup_vmbus_handler(void (*handler)(void))
>>   {
>>   }
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index bf601d6..1fa79ab 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -79,6 +79,7 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64
>> input2);
>>
>>   bool hv_isolation_type_snp(void);
>>   bool hv_isolation_type_tdx(void);
>> +bool hv_isolation_type_cca(void);
>>
>>   /*
>>    * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
>> --
>> 2.45.4
>>

