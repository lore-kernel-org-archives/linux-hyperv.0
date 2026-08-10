Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A53090D4;
	Mon, 10 Aug 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388621; cv=none; b=qF6fAO/p2IGUCJgtGyo8IM5eeTGxLj3WnVnR3lUGZw0MbSVtzTfaMiVsTk/zJdy2SAKyj84I1CUcTBqAjmDUEcnSA3bMgM16BixgjF7JYamIVIZPq4PR8+VcE7NUxZooIHULP1HXhb5/F+Isthcw1AZgM1XIa93LuhGwbAhgJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388621; c=relaxed/simple;
	bh=q2bcCIZ4dgolsRUYzeovrjzX9by+oJ6PTP3P1RDDybg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF8vl4yT9k/F3pxZUCn2PjLGxEBJb+3TmQcP2JZ/cboC2D6ue4pdQGL93eDHyETfM/yxOtQICYT3qOG6iEwLZHvLr8Lt4HtsdYJv6rgjLY5d9FuUnc7fs5XsBMhx/V4G3d/E5YGwSjGB7V4iw8oLW+LLDNBWh+bYgTrJvRpUClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h3aiYQYs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h3aiYQYs"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2959620B7167;
	Mon, 10 Aug 2026 12:03:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2959620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786388590;
	bh=P8nZDm19O79jea9Uz1kCkeTF8j1nb+vQ/x4vewJHtuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h3aiYQYst4ljZCTGWjoENBb1weWkY8gf/YtspTfwIJUSxxnzL5gFxOLwrDUVrazaY
	 C86Wheht04il3x+bPhnVB02weo89rwijhpeSdJs2jT6MJFa4OdAsV/c5Ep10s62K63
	 f2TSBFRRm46t30zf4EbhroBWCP8eGd/pZYOuwiUE=
Message-ID: <74f2ef45-9fc5-2df2-832d-dbbf5f30885f@linux.microsoft.com>
Date: Mon, 10 Aug 2026 12:03:32 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/hyperv: reserve more vectors
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: "mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20260730005020.2181875-1-wei.liu@kernel.org>
 <SN6PR02MB41579785497E4D4FC62A95E0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41579785497E4D4FC62A95E0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 08:35, Michael Kelley wrote:
> From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Wednesday, July 29, 2026 5:50 PM
>>
>> Microsoft Hypervisor delivers three vectors to the NT HAL running in the
>> root partition and refuses to map a device interrupt to any of them when
>> interrupt remapping is not available in the system. As of writing, the
> 
> s/of writing/of this writing/
> 
>> nested MSHV setup has no interrupt remapping capability.
>>
>> The three vectors are:
>>
>>    HAL_NT_APC_VECTOR		0x1F
>>    HAL_NT_DPC_VECTOR		0x2F
>>    HAL_NT_CLOCK_IPI_VECTOR	0xD2
>>
>> 0x1F is below FIRST_EXTERNAL_VECTOR so the vector allocator never hands
>> it out, but 0x2F and 0xD2 are both inside the allocatable range and are
>> handed out once enough vectors are in use. Mapping such an interrupt
>> then fails with HV_STATUS_INVALID_PARAMETER, and the interrupt is never
>> delivered.
>>
>> Reserve all three next to the hypervisor debug vectors that are already
>> kept out of the allocator's hands.
>>
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> ---
>>   arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 185d4f677ec0..229c7377a980 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -502,17 +502,32 @@ static void hv_reserve_irq_vectors(void)
>>   	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
>>   	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
>>
>> +	/*
>> +	 * The hypervisor delivers these three to the NT HAL and refuses to
>> +	 * map a device interrupt to any of them.
>> +	 *
>> +	 * The hypervisor will provide a hint in the future when these
>> +	 * vectors become available to use.
>> +	 */
>> +	#define HAL_NT_APC_VECTOR		0x1F
>> +	#define HAL_NT_DPC_VECTOR		0x2F
>> +	#define HAL_NT_CLOCK_IPI_VECTOR		0xD2
>> +
>>   	if (cpu_feature_enabled(X86_FEATURE_FRED))
>>   		return;
>>
>>   	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
>>   	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
>> -	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
>> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors) ||
>> +	    test_and_set_bit(HAL_NT_APC_VECTOR, system_vectors) ||
>> +	    test_and_set_bit(HAL_NT_DPC_VECTOR, system_vectors) ||
>> +	    test_and_set_bit(HAL_NT_CLOCK_IPI_VECTOR, system_vectors))
> 
> Calling test_and_set_bit() explicitly for each of the 6 vectors seems right
> on the border of where it would be better to declare a static array with
> the vectors and loop through the array. The loop could also populate the
> string to be output in the pr_info() statement below. But leaving it explicit
> as you have done is probably simpler unless the vector list grows again.

Simpler and better imo, but moreover, we want to discourage the
list enlarging, if anything, i hope going forward we can shrink it
back to absolutely minimum.

Thanks,
-Mukesh


> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
>>   		BUG();
>>
>> -	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x\n",
>> +	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
>>   		HYPERV_DBG_ASSERT_VECTOR, HYPERV_DBG_SERVICE_VECTOR,
>> -		HYPERV_DBG_FASTFAIL_VECTOR);
>> +		HYPERV_DBG_FASTFAIL_VECTOR, HAL_NT_APC_VECTOR,
>> +		HAL_NT_DPC_VECTOR, HAL_NT_CLOCK_IPI_VECTOR);
>>   }
>>
>>   static void __init ms_hyperv_init_platform(void)
>> --
>> 2.53.0
>>
> 

