Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39F28505E;
	Thu, 23 Apr 2026 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965587; cv=none; b=fqq1SLxXQNLRiNH/c9SeqfgPFFU3DCg0mqyPhyI1gaOhP/2IuDkqsgK7X4Pnc6dVQz9ldr7qJ7i7Tj9rMg8Zc8otDwntjNuRrJZcy3EVdQnuEDSo1+yqJCuwRPwbWldRv2mv0HsMZ/3fY8N4Mmi0K6Kyf4PSGKOSu1EBAwSR16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965587; c=relaxed/simple;
	bh=Do6nW/cLDQ8Ss+hloPK/QrL79z093YRBVQm+zfbmLrE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rG0CX0VIHPGdBwIBrVBTkYHznT6CFLdh4TbtqRS57wXMDiXgpOI5WJmwbGbrP7ykuRLnKOKtnbjmeQKOJ6c5fDhd+CMto1oURejH6PgzNBLBpxFhZfLATAHa8QIDVYnpj4nBfncrB9DAucQeePlFDAOL52qsUiuDEjvq5CALzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SFfO2Bbi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SFfO2Bbi"
Received: from [192.168.201.246] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F13D20B7165;
	Thu, 23 Apr 2026 10:33:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F13D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776965586;
	bh=PbMzWxSX0Ma10lH/h8g26Hx+/xAp3e1JW3fIWsSIWCs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SFfO2BbiRj95UDm9vxVcn0zRd398qvcpq/Bhyq5UMsCSV2FoB387QY3v/6whpnWYT
	 QrJI6u5N51rf1jNQ2/1QUjgSsit00WDOOVKYG06GNGOqktRd5GVQR5ivlYUHYIJdHB
	 m8PlHzYKYMUlyxgIJ//PTXnbd5jxyQKY+HwHluT8=
Message-ID: <19a904f4-e26f-4951-85ac-aae537da89cb@linux.microsoft.com>
Date: Thu, 23 Apr 2026 10:32:58 -0700
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
To: wei.liu@kernel.org
References: <20260423172625.1189669-2-wei.liu@kernel.org>
 <614f1e17-2dba-4529-b067-e1434b74cad8@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <614f1e17-2dba-4529-b067-e1434b74cad8@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/23/2026 10:29 AM, Easwar Hariharan wrote:
> On 4/23/2026 10:26 AM, wei.liu@kernel.org wrote:
>> From: Wei Liu <wei.liu@kernel.org>
>>
>> That was missed when importing the header.
>>
>> Reported-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
>> Reported-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> Fixes: e68bda71a2384 ("hyperv: Add new Hyper-V headers in include/hyperv")
>> Cc: stable@kernel.org
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> ---
>>  include/hyperv/hvhdk.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>> index 5e83d3714966..ff7ca9ee1bd4 100644
>> --- a/include/hyperv/hvhdk.h
>> +++ b/include/hyperv/hvhdk.h
>> @@ -79,6 +79,7 @@ struct hv_vp_register_page {
>>  
>>  		u64 registers[18];
>>  	};
>> +	__u8 reserved[8];
>>  	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
>>  	union {
>>  		struct {
> 
> 
> This is not a uapi, so why not just use u8 instead of __u8?
> Or since it's 8 u8s, a u64?
> 
> Thanks,
> Easwar (he/him)

Hm, occurs to me that this would be used by VMMs, but then the registers
field just above used a u64 instead of a __u64....


