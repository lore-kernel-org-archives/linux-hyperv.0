Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425596;
	b=BboVWl2rdl3jscMhoJQ/hfxGDtQCMzm8uZAYemZPSCXvVTqDs1qKmr0ns3kuI87AMMEa
	 +SF5qonoQyT0JZDuM6x/vpBTkFYf7SvEkbAC3lFozuGwA0+IZ1CfVZ83D1tM15hGE3smf
	 RGQyM4edzrZNUlTqlfYJUmYQOycmIMOX71LTTgeL5DdFp+fHQj/hz7yzDmb3ZoHRSK6nW
	 QtOl1rfPJpii1IwfOxJsf0xeiZygZ3kce8BTFkMySFnyOaIddf/dNm8INR90wO0/ak+PN
	 01wG8ioJoDISXeZwJZBY4IaZZBfSI6krRhQCTCLU4GWOUdJgZl1KEF1fHCIiWG+potQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425596;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=XkYzj1wDxfAIpCaHTXRvZeY0rPBL7U7tgJ6A5K+XKXc=;
	b=mHuvR5+uPsttkqJnwpV0grAiobF23AaEifYaMI0lq6Y/EBrnblEH5jpQbLiQHyhs0LhP
	 nxY2Ic/LXpm/5XEoIw3y+PsCUMrXrM6vmyCQA2I+a/3w/njp4GXxxOQ7baCs66hsn7zru
	 12F7E+Enm8i01sv9BrkOvqd0mqYo0bndwdM2kGnd5P10qu+JBImcJV+5NhRSf97dRhnxX
	 RFMjWuu859L8RjZR3B5pCMF7FMuPULeeVqzwFT6JgaunIjT78US2CtMm2bucqw0RtWB5N
	 kJaljFTLQGc/OY290QhDgS0npf19I02py92nUpfaDlGqE15LF8RtipYPYiuQk/Q5CbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=sdAuBVV1;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150B606A31C;
	Wed, 11 Nov 2026 19:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2150B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=sdAuBVV1
Received: from [10.4.158.9] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5AE6F20B7166;
	Wed, 11 Nov 2026 11:33:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AE6F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794425592;
	bh=XkYzj1wDxfAIpCaHTXRvZeY0rPBL7U7tgJ6A5K+XKXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sdAuBVV1iYh6ALVSvPbbuS3kbrw9KywjuIwbdoNJ4kCMluqCCr9IIpLf4ZHHsd+fk
	 RZva/j1N6fubwMR+Za3nW+nlFP8Q2wV28gYJu7ByeOqCWqU0vZlxG6Y3VEfv+yvEkQ
	 7xQ31zo5ASqixU32rt2PhC2x/T6EuAn9cAHue3bM=
Message-ID: <4d5ff278-bd47-4304-967c-92313dbd4fd7@linux.microsoft.com>
Date: Wed, 11 Nov 2026 11:33:07 -0800
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
Subject: Re: [PATCH v6 6/6] arm64: hyperv: Implement
 hv_is_isolation_supported() for CCA Realms
To: Michael Kelley <mhklinux@outlook.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
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
 "thuth@redhat.com" <thuth@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-7-kameroncarr@linux.microsoft.com>
 <MN2PR02MB6863D42CE499C3D423EDBC10D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863D42CE499C3D423EDBC10D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2026 10:01 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, October 30, 2026 5:14 PM
>>
>> Provide an arm64 implementation of hv_is_isolation_supported() that
>> overrides the __weak default in drivers/hv/hv_common.c.
>>
>> The implementation deliberately does not depend on
>> hv_is_hyperv_initialized() because hv_common_init() consults
>> hv_is_isolation_supported() before hyperv_initialized is set.
> 
> Quibble: What's the genesis of this statement about
> hv_is_hyperv_initialized()? On the x86 side, hv_is_isolation_supported()
> doesn't depend on hv_is_hyperv_initialized(), so I don't think you
> are making a distinction vs. what x86 does. The statement seems
> like it might be a leftover from an early version of this patch set.

From what I recall, I wrote this line after going down a long rabbit
hole attempting to have functional parity with x86
hv_is_isolation_supported(). I agree that is doesn't make sense without
context.

I couldn't find equivalent methods for checking if the Realm is running
on Hyper-V. I initially considered using hv_is_hyperv_initialized(), but
that ran into ordering issue described above. I eventually concluded
that just returning is_realm_world() is sufficient, since
hv_is_isolation_supported() is never used to determine whether the VM is
running on Hyper-V.

The comment would be more clear if it simply pointed out that
hv_is_isolation_supported() functionally differs on ARM64 vs. x86
because it does not check whether it is running on Hyper-V.

I believe Wei already applied this series to hyperv-next, but perhaps he
can remove this line from the commit message.

-- 
Regards,
Kameron

> Michael
> 
>>
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
>> ---
>>  arch/arm64/hyperv/mshyperv.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index da6c3aa0..8a2c446 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -187,3 +187,8 @@ bool hv_isolation_type_cca(void)
>>  {
>>  	return is_realm_world();
>>  }
>> +
>> +bool hv_is_isolation_supported(void)
>> +{
>> +	return is_realm_world();
>> +}
>> --
>> 2.45.4
>>
