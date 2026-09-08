Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC14B4861;
	Tue,  8 Sep 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900207; cv=none; b=F24NHT8mz7ikKyfh62YUiJZ1O1i4R6lZ1nXymsU0hLE/o7/Z3lv6CcQNGS3vguIjMeCNRUt/yyWubU/Yby46A+yBArjVBhuCCEK0SKZVgm1APtn6yWqMSNXPs7mqgm6YEdTCq0OYMoGOqSYA4T3pbvegAhKqVBvdhVqRwIVG69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900207; c=relaxed/simple;
	bh=x3ltNi+mlg5xXpPiwLIvNwb8NCf0VtPbDGUCOtrtxl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvFaecDYo+xE7b/wTkL2dvGccbWLH8WdJ77I/oBhj9/JLBCcKsmD9lGXvqk6Hmy+DGPgnaGE7aPbnHYbl+8m3BI7XeRlHHdKrsmraNTPA7ZsPe6zKbeg9EVvAOZFVMhbzkrnKqZXYx2QP/hqeIxfGsl/W7VgaUMhENnXTLQ8OZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WGD9Rz0V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WGD9Rz0V"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F93820B7128;
	Tue,  8 Sep 2026 13:42:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F93820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788900165;
	bh=7Bk5RJUn+3ekyT3G6f+NHqnbS0cO26QgcVZCitW6VQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WGD9Rz0VdNewyBAzLYwFEWs6M3yxs6BZsUkkK3dX2NLP9Foyr8gs/gk/gKzjpqytt
	 hMkjrvsMbKJHi7jw7Z3NZ7y9wHvzCkHbTOLfnccUZHr8DVs5swgSFG4uS92uF+Jebz
	 i3DCYMsBOEGDdishYBgLyVfihaWw8WAdq/8aUDUU=
Message-ID: <921a1646-4257-c627-1019-8ac41ea89ed4@linux.microsoft.com>
Date: Tue, 8 Sep 2026 13:43:24 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 1/3] mshv: Rename memory deposit memory functions to
 _old
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-2-mrathor@linux.microsoft.com>
 <SN6PR02MB4157D9294688C8E5F21BDD19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D9294688C8E5F21BDD19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 11:01, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 7, 2026 7:14 PM
>>
>> Rename hv_call_deposit_pages() and hv_deposit_memory_node() to _old
>> to make reviewing the new functions much easier.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/hv_proc.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>> index 57b2c64197cb..57864bb5bcd8 100644
>> --- a/drivers/hv/hv_proc.c
>> +++ b/drivers/hv/hv_proc.c
>> @@ -13,10 +13,10 @@
>>    * See struct hv_deposit_memory. The first u64 is partition ID, the rest
>>    * are GPAs.
>>    */
>> -#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>> +#define HV_DEPOSIT_MAX_OLD (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>>
>>   /* Deposits exact number of pages. Must be called with interrupts enabled.  */
>> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>> +static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num_pages)
>>   {
>>   	struct page **pages, *page;
>>   	int *counts;
>> @@ -29,7 +29,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>   	struct hv_deposit_memory *input_page;
>>   	unsigned long flags;
>>
>> -	if (num_pages > HV_DEPOSIT_MAX)
>> +	if (num_pages > HV_DEPOSIT_MAX_OLD)
>>   		return -E2BIG;
>>   	if (!num_pages)
>>   		return 0;
>> @@ -40,7 +40,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>   		return -ENOMEM;
>>   	pages = page_address(page);
>>
>> -	counts = kzalloc_objs(int, HV_DEPOSIT_MAX);
>> +	counts = kzalloc_objs(int, HV_DEPOSIT_MAX_OLD);
>>   	if (!counts) {
>>   		free_page((unsigned long)pages);
>>   		return -ENOMEM;
>> @@ -108,10 +108,14 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>   	kfree(counts);
>>   	return ret;
>>   }
>> +
>> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>> +{
>> +	return hv_call_deposit_pages_old(node, partition_id, num_pages);
>> +}
>>   EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>>
>> -int hv_deposit_memory_node(int node, u64 partition_id,
>> -			   u64 hv_status)
>> +static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id, u64 hv_status)
> 
> I'm not clear on why there is "__maybe_unused" here. If CONFIG_MSHV_ROOT
> isn't defined, this whole file isn't built.

The main 2nd patch adds newer version of the function, so  this _old is
not called anymore, and will generate compiler warning.

Thanks,
-Mukesh


> But it doesn't really matter since Patch 3 of the series deletes the code anyway.
> 
>>   {
>>   	u32 num_pages = 1;
>>
>> @@ -137,7 +141,12 @@ int hv_deposit_memory_node(int node, u64 partition_id,
>>   		hv_status_err(hv_status, "Unexpected!\n");
>>   		return -ENOMEM;
>>   	}
>> -	return hv_call_deposit_pages(node, partition_id, num_pages);
>> +	return hv_call_deposit_pages_old(node, partition_id, num_pages);
>> +}
>> +
>> +int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
>> +{
>> +	return hv_deposit_memory_node_old(node, partition_id, hv_status);
>>   }
>>   EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>>
>> --
>> 2.51.2.vfs.0.1
>>
> 
> The "__maybe_unused" notwithstanding,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

