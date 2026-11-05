Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875215;
	b=SPMehFzmxRWtiejV7Z0dgE+YVq2h0g3AbepDAbv5wzA7TLgfRCjP4Wmrw3YzNiZnGpAa
	 lQnBg1prFDeAdD+7W+CPUhM2IU7vHG1tjw7txjGx1n+mWR8sFShcMrju7ZthOT5OxE5aL
	 U3k9hODFAdYvzCdjUS4XSbYMgRCJzbXaGMKw2ZKCrc0B4qodC/nJrGduxzBBsKIImFOqA
	 qpZWsNGC3iF5XLXVPm6cAf4PDqP12bQlov34il3apTsLmFQA7P7Gma1owKiWeAubnZOEn
	 Ti0nujzH+TTAbeRDNHzYZ7ivrNQF2REaUjJpq7mUeaWDetJhzaKOqKGTSPBb8cG4t9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875215;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=Vc0UcibIUsQO1V+EAprSp8/th7aJCVVxiNeqHJlPYWg=;
	b=q7HxmHsdqB2rlRnfZytpzHvaVUq2Ot+u4vjOTdNeF+WeCmiwyeDMPbn9dvC7RzkWYk0l
	 waGNHmXjuJfbgY4UHN2DjeBBmpXUPVqG1ZvrgZ3VPEWhpQdR6kzkNH3vt1doZ5L362Yhx
	 ZhlbKdLWScCC6qCNoYE6tdziKrxBBQAS1vakO7tIOqvzLt6Qv5wa7QX2jtADv2P1CBty+
	 M5UTpNlufRvCcQgrwZ1BxpUScbN8UCuQhCa3uzm3C7GjpFM7AVCL/i7TqYt5nRCSVlugW
	 VCSh8Lpu+EuVqqLkRx8I1ny2U8NUQdnhyOX7JCChQ6brdjz0FccaE3fhlytxKL7LuJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=q6ZUXX6N;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D191606A335;
	Thu,  5 Nov 2026 10:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D191606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=q6ZUXX6N
Received: from [192.168.1.14] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0536C20B7166;
	Thu,  5 Nov 2026 02:39:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0536C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793875198;
	bh=Vc0UcibIUsQO1V+EAprSp8/th7aJCVVxiNeqHJlPYWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q6ZUXX6NJiKddYYkOjy1xWv04f7z8awMY+Ma1d/A1x6kplUSv4qsuF5H6NsXpSOEm
	 aq7mq0IVrz8OPsENzIY4CthsCiJGiUe96sAQXWh3JviH0pyFTJqAAd243Y9pUvPnfc
	 FaMoIpZ8n6Fm9iRLRAbmdQ+uiPKfHlU7XTi6AGhs=
Message-ID: <c1e732c1-fcc6-4437-8891-dbea5e59ed27@linux.microsoft.com>
Date: Thu, 5 Nov 2026 16:10:08 +0530
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
Subject: Re: [PATCH] tools: hv: Zero unused bytes in KVP pool records
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Shradha Gupta <shradhagupta@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Carpenter <error27@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261102102953.432924-1-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261102102953.432924-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/2/2026 3:59 PM, Shradha Gupta wrote:
> From: Shradha Gupta <shradhagupta@microsoft.com>
> 
> KVP pool files store fixed-size key and value arrays. New records copy only
> the supplied key and value lengths into uninitialized storage, but the
> daemon writes each record in full. This can persist uninitialized heap
> bytes in the unused array tails. Shorter value replacements and
> string-based deletion compaction can also leave stale data in those tails.
> 
> Zero new records before populating them, clear values before replacement,
> and copy complete records when compacting a pool after deletion.
> 
> Also clear unused tails when loading existing records so GET and
> enumeration do not return legacy residual bytes. These sanitized records
> reach disk on the next successful update to that pool; loading alone does
> not rewrite the file.
> 
> The record layout and logical key/value strings are unchanged.
> 
> Fixes: db425334e5bb ("Tools: hv: Fully support the new KVP verbs in the user level daemon")
> Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
> ---
>   tools/hv/hv_kvp_daemon.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 1f64c680b..d57729f60 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -203,6 +203,7 @@ static void kvp_update_mem_state(int pool)
>   {
>   	FILE *filep;
>   	size_t records_read = 0;
> +	size_t i, len;
>   	struct kvp_record *record = kvp_file_info[pool].records;
>   	struct kvp_record *readp;
>   	int num_blocks = kvp_file_info[pool].num_blocks;
> @@ -248,6 +249,15 @@ static void kvp_update_mem_state(int pool)
>   		break;
>   	}
>   
> +	/* Discard stale bytes after strings in existing pool records. */
> +	for (i = 0; i < records_read; i++) {
> +		len = strnlen(record[i].key, sizeof(record[i].key));
> +		memset(record[i].key + len, 0, sizeof(record[i].key) - len);
> +		len = strnlen(record[i].value, sizeof(record[i].value));
> +		memset(record[i].value + len, 0,
> +		       sizeof(record[i].value) - len);
> +	}
> +
>   	kvp_file_info[pool].num_blocks = num_blocks;
>   	kvp_file_info[pool].records = record;
>   	kvp_file_info[pool].num_records = records_read;
> @@ -327,8 +337,7 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
>   		j = i;
>   		k = j + 1;
>   		for (; k < num_records; k++) {
> -			strcpy(record[j].key, record[k].key);
> -			strcpy(record[j].value, record[k].value);
> +			memcpy(&record[j], &record[k], sizeof(record[j]));
>   			j++;
>   		}
>   
> @@ -383,6 +392,7 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>   		 * Found a match; just update the value -
>   		 * this is the modify case.
>   		 */
> +		memset(record[i].value, 0, sizeof(record[i].value));
>   		memcpy(record[i].value, value, value_size);
>   		kvp_update_file(pool);
>   		if (debug)
> @@ -406,6 +416,7 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>   		kvp_file_info[pool].num_blocks++;
>   
>   	}
> +	memset(&record[i], 0, sizeof(record[i]));
>   	memcpy(record[i].value, value, value_size);
>   	memcpy(record[i].key, key, key_size);
>   	kvp_file_info[pool].records = record;
> 
> base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
