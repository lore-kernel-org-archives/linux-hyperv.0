Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E931326F;
	Wed, 29 Jul 2026 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302343; cv=none; b=Qyz/YRi3F5QJu+bnha+FiEXWHEFR+0G1OMicK2VAd7B6O+RwX/IuoDN8zcgyaBzVG3inP/3Ca4k0v0yxnY5pkZkKTarEMW2q6tjhI/lVEZgtsUvYww+0IdZK81ptPBbmN91PrWZkRQpLFKEEEz4eBurwsXEmscJhc5H2oKBh+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302343; c=relaxed/simple;
	bh=6NgqUNDyY3gfEySJnc0bUGr1Y0dhIYdDenGxSEz5jeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REGUZuFJPNstDdfSdjK7ef7vfQ1gW8YfY9AdMj4qY3QfufSGMFtG9cJX9CYTJ2T36MNHM56Rh4uc3yN+2mamtJZf3qhV4/6ft82LfBLD9WPPXee/f81HlRkbgFrkG6P2w0e12IhKe6f33hJwj/NtCL8cANrRdWRHX+KiicypzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ir11ZTlu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ir11ZTlu"
Received: from [192.168.0.105] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2BCB320B7166;
	Tue, 28 Jul 2026 22:18:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BCB320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785302324;
	bh=Gx7S+xiggbvjnZUiqX+0qEuJb6B3YIvh3F6wPERICwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ir11ZTluafeXX5Yhh4TshZcSa9tYd24z5hFm2DxLjmn4fw5Vdk0OkJXOeV1uhS8Yk
	 eZ4izaeffxZTyNPfLbxIJqnzWsNpgMg/EwlcgtqmBoeOcMvedObl1ghjZL3IIosnqa
	 WRuGbGq6NVzOJogWVG5tohiQB8NybSt5RfCdEGSk=
Message-ID: <63882f44-4c22-43d1-a909-8586b2123afd@linux.microsoft.com>
Date: Wed, 29 Jul 2026 10:48:55 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Use meaningful errnos for hypercall status
 codes
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
 Hardik Garg <hargar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com
References: <20260727211101.2199630-1-hargar@linux.microsoft.com>
 <bc819b23-49c5-43d1-9a69-d34dba8f4762@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <bc819b23-49c5-43d1-9a69-d34dba8f4762@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/2026 2:53 AM, Easwar Hariharan wrote:
> Hi Hardik,
> 
> On 7/27/2026 14:11, Hardik Garg wrote:
>> Commit 3817854ba892 ("hyperv: Log hypercall status codes as strings")
>> converted hv_result_to_errno() from a switch to a table and added status
>> codes used for string logging. Statuses without an existing specific
>> mapping were assigned the generic -EIO fallback even when a more specific
>> errno was available.
>>
>> Map HV_STATUS_ACCESS_DENIED and HV_STATUS_OPERATION_DENIED to -EACCES,
>> HV_STATUS_UNKNOWN_PROPERTY and HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE to
>> -EINVAL, and HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED to -EOPNOTSUPP.
>> This lets callers distinguish permission, argument, and capability
>> failures from generic I/O errors.
>>
>> The table conversion also added duplicate HV_STATUS_INVALID_LP_INDEX and
>> HV_STATUS_INVALID_REGISTER_VALUE entries. Remove the later -EIO entries,
>> which are unreachable because find_hv_status_info() returns the first
>> match.
>>
>> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
>> ---
>>   drivers/hv/hv_common.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
> Glad to see that this was something that bothered you as well. If you like, you
> can pick up feedback from Nuno on my attempt to solve this [1] and do a de-facto v3.
> 
> [1] https://lore.kernel.org/all/479242d4-ae08-442c-b61b-c9408ba2e9b0@linux.microsoft.com/
> 
> Thanks,
> Easwar (he/him)

I see no harm but only benefits in returning meaningful error code 
corresponding to HV_STATUS_*, where we can, specially when such an error 
code exists. So I agree with the motivation of this exercise.

On this patch or a new v3 of previous patch, feel free to pick my review:

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
