Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC724BBF4;
	Thu, 23 Apr 2026 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968199; cv=none; b=My/9TvY/3FJC2ojRoAq690GEIeYSigqtaGMQ3DFc2RbIzGRAdz66tGjEi4IJf/r/nkXO+dhthbL2U/QQjhsLKuo6ABQD7w64EeKdEXk96ZgTEjm9HbfhvymnBiSH92ZqiA/ksSqUPt0Npmwldfvk5KzE8f/nizYqrJfLw38L1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968199; c=relaxed/simple;
	bh=ReWg/Q2+C4dPCqYieRDECynDoW7jFpKT6bV2EWofO1U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4EUU+H8YC1tmVx2Z8nczxCAhOG6toK9cCD6AjyLRUWPnTXLSIE215JZCJSsqpVe56Vy8qP/pLYwvgTMvkm1dW6eVa7Lr15gQsiq/kZbaHy9aeBZEgItSrvvO94jETTq3Ap+u183Kz7lGSVSUbdOoYI9detbsl68jSgP388Z4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bhj4dKPH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bhj4dKPH"
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0C52120B7165;
	Thu, 23 Apr 2026 11:16:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C52120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776968198;
	bh=e3CUKzqbG2zw4unebTfRIFQxFIPbMXWdeLVnGvqEyZU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bhj4dKPHmxBoZ+cqi7OMaL33S9erulJwG9VTPV0THMv3SeMHJDOYyumpmfJLgAbGF
	 7mxiAmMrIR41AxaUIdVFaZcuLGdtIDTGeeZrzDTAcAcIK07/x9w+MsBKzu168PjQnW
	 rwDTW3GG8G4GmlO4ylV5VOzvcRERsDjLpIE/aFYM=
Message-ID: <eda39cba-ac5f-4beb-8630-d8bb8d124d73@linux.microsoft.com>
Date: Thu, 23 Apr 2026 11:16:30 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, stable@kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: add a missing padding field
To: Wei Liu <wei.liu@kernel.org>
References: <20260423172625.1189669-2-wei.liu@kernel.org>
 <614f1e17-2dba-4529-b067-e1434b74cad8@linux.microsoft.com>
 <19a904f4-e26f-4951-85ac-aae537da89cb@linux.microsoft.com>
 <20260423181440.GA1196957@liuwe-devbox-debian-v2.local>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260423181440.GA1196957@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/23/2026 11:14 AM, Wei Liu wrote:
> On Thu, Apr 23, 2026 at 10:32:58AM -0700, Easwar Hariharan wrote:
>> On 4/23/2026 10:29 AM, Easwar Hariharan wrote:
>>> On 4/23/2026 10:26 AM, wei.liu@kernel.org wrote:
>>>> From: Wei Liu <wei.liu@kernel.org>
>>>>
>>>> That was missed when importing the header.
>>>>
>>>> Reported-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
>>>> Reported-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>>>> Fixes: e68bda71a2384 ("hyperv: Add new Hyper-V headers in include/hyperv")
>>>> Cc: stable@kernel.org
>>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>>>> ---
>>>>  include/hyperv/hvhdk.h | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>>>> index 5e83d3714966..ff7ca9ee1bd4 100644
>>>> --- a/include/hyperv/hvhdk.h
>>>> +++ b/include/hyperv/hvhdk.h
>>>> @@ -79,6 +79,7 @@ struct hv_vp_register_page {
>>>>  
>>>>  		u64 registers[18];
>>>>  	};
>>>> +	__u8 reserved[8];
>>>>  	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
>>>>  	union {
>>>>  		struct {
>>>
>>>
>>> This is not a uapi, so why not just use u8 instead of __u8?
>>> Or since it's 8 u8s, a u64?
>>>
>>> Thanks,
>>> Easwar (he/him)
>>
>> Hm, occurs to me that this would be used by VMMs, but then the registers
>> field just above used a u64 instead of a __u64....
> 
> I fat-fingered u8 to __u8.  User space code has scripts to massage the
> types as needed.
> 
> To remain consistent with the existing code, it should be u8.
> 
> I can change the type when I commit this.
> 
> Wei
Thanks, with that fixed:

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
