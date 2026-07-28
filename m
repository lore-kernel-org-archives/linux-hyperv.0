Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6510F0;
	Tue, 28 Jul 2026 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197288; cv=none; b=sQ2kksxX21mT0Q7/NZSU2K1tuPoIJRmIxC91GAqnxS/DgiPWOIR1JtzLMpnI39KWnhWyTbyW+lguGUDQ8+fHxcVZxLd53mvrVMaoD3BaVWrmeGbl2IkKBT2SqKPDORnUboHGop0O7A91VLM3a5YNnjZKJCpPbAIj433h8RwNmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197288; c=relaxed/simple;
	bh=nDDyFVMwgmSswFEWYhHOA4bnKI5cR1vOFgKBgpucE08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlBqUDqZLUwiRZ+oKsDhVtiOmZ5ckgaRcaJJyGK6IYfOxb7IqyuikV+51E7eGsO0r9jGuTKBBZY/ixEwe9UrUik7AEjfnx35QRM7XJ8u+3UujkQi5mr3AEL1WZHYuOvrWJNCvzJL+HcXWpWQTHQtpXLwWplHhg0NX1+9Iqb60C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dg61kxOK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dg61kxOK"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id C78A520B7166;
	Mon, 27 Jul 2026 17:07:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C78A520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785197270;
	bh=vzvfcpVxDsuVawwit4pR/t2LHBXcGZwsJw8S4ksNCBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dg61kxOKdsAHTBmUVS3VuUpz/c+oMZgDos0sQdoOVeyv5pn0Ft6/0iSzes9cCm3zN
	 GuHbgFF3icfQd/b1Hv2BZO76EXZIkHNvx6v+Fz+YlHYuG78WdkoJAs62qxLKZKh8RF
	 3lLqKnBCXPbY540SvbEyQeqxFhjV1UU6LM8TTQEU=
Message-ID: <7dc1af73-f1e4-9bb9-2a2e-57cc3945dfe1@linux.microsoft.com>
Date: Mon, 27 Jul 2026 17:08:05 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V4 5/9] mshv: Import data structs around device passthru
 from hyperv headers
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-6-mrathor@linux.microsoft.com>
 <20260718023047.E8EC51F000E9@smtp.kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260718023047.E8EC51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 19:30, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The memory layout of `union hv_device_domain_id` is inverted compared to the expected Hyper-V ABI, resulting in corrupted device domain IDs being passed to the hypervisor.
> --
> 
> --- Patch [5]: [PATCH V4 5/9] mshv: Import data structs around device passthru from hyperv headers ---
> commit 02ed2cd292e85f0b6e754b6a29df473f95394315
> Author: Mukesh R <mrathor@linux.microsoft.com>
> 
> mshv: Import data structs around device passthru from hyperv headers
> 
> This commit copies and imports definitions and declarations from Hyper-V
> public headers. These additions are related to creating domains in the
> hypervisor and attaching devices to them.
> 
>> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
>> index b4cb2fa26e9bc..90497635c3cbd 100644
>> --- a/include/hyperv/hvhdk_mini.h
>> +++ b/include/hyperv/hvhdk_mini.h
> 
> [ ... ]
> 
>> +/* 3 domain types: stage 1, stage 2, and SOC */
>> +#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
>> +#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
>> +#define HV_DEVICE_DOMAIN_TYPE_SOC 2 /* HV_DEVICE_DOMAIN_ID_TYPE_SOC */
>> +
>> +/* ID for stage 2 default domain and NULL domain */
>> +#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
>> +#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
>> +
>> +union hv_device_domain_id {
>> +	u64 as_uint64;
>> +	struct {
>> +		u32 type : 4;
>> +		u32 reserved : 28;
>> +		u32 id;
>> +	};
>> +} __packed;
> 
> [Severity: High]
> Is the memory layout of union hv_device_domain_id inverted compared to the
> expected Hyper-V ABI?

No.

> The macro HV_DEVICE_DOMAIN_ID_S2_NULL is defined as 0xFFFFFFFFULL, which
> places 0xFFFFFFFF in the lower 32 bits and 0 in the upper 32 bits. Given
> that Stage 2 (S2) domains have a type of 0, this macro implies that the id
> should be in the lower 32 bits and the type should be in the upper 32 bits.

HV_DEVICE_DOMAIN_ID_S2_NULL is never assigned to any data struct of
type "union hv_device_domain_id".


> However, union hv_device_domain_id defines type as the first bitfield
> (occupying the lower 32 bits) and id as the second (occupying the upper 32
> bits).
> 
> Under this layout, casting 0xFFFFFFFFULL evaluates to type = 15 and id = 0,
> instead of the expected type = 0 and id = 0xFFFFFFFF. Could this cause
> malformed domain IDs to be sent to the hypervisor?
> 

