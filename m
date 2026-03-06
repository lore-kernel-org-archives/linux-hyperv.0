Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A649460;
	Fri,  6 Mar 2026 03:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767187; cv=none; b=Y7R+dpJGPmQo9Egx//6zNBCruYJ088gqYNXezJq3n5ZCODYhfcVKMlCwRPPQ+llmdPqXh3jig0sVz4NcedgZcXs+PKSs5wcQFFlu33vHIb1cLgan82m9rP6r7h0Y7jWeoHJwhUYTwvxJfSuWhWhO8bAvxAmMi++anxT2U/Li0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767187; c=relaxed/simple;
	bh=Bx0W36ktvluwD4hJ4k80u9Ws750UqYdcD1VVwsfb0lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+8NdXxCCvXWCDcWg4H9vbE4rO5f7F1PdwtXIFp+TgJoQw2Ou0L6gYA2iEASlpkyXukKQcNgy9XmVbrSUMrmdEcP1PbSsjnFosKgS/5s029IV0XEcTBBF2cwp33FKb25kALoBO3otcQIwVvVXjiu0SBCVG4WhV81ItNwqzPOOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GoSCq/Oe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GoSCq/Oe"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B32E220B6F02;
	Thu,  5 Mar 2026 19:19:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B32E220B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772767186;
	bh=YG93NeZZTIuTQL8Vy/lFQqiisacASeCZX4Rrguc71GA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GoSCq/OepG966qGXlxwoExish36NSkH70292JBLw+3owWJuGBzBA2nZCGoWwvsP6M
	 Z0Es5OlwKLWFDn6q/wQPXFTHC6bpqJvDlRUQiUDhjzm8y7Sws3z1pRM8/JtSdKIMcf
	 GLJsEOQgQrqIiRm7xvPcgdtIgLLZqEopTfDtnM+Y=
Message-ID: <cd9e9108-87af-e7a8-1dd4-baee8a3f2083@linux.microsoft.com>
Date: Thu, 5 Mar 2026 19:19:45 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/4] mshv: Support larger memory deposits
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258381446.229866.108795434668770412.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177258381446.229866.108795434668770412.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 16:23, Stanislav Kinsburskii wrote:
> Convert hv_call_deposit_pages() into a wrapper supporting arbitrary number
> of pages, and use it in the memory deposit code paths.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/hv_proc.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 5f4fd9c3231c..0f84a70def30 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -16,7 +16,7 @@
>   #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>   
>   /* Deposits exact number of pages. Must be called with interrupts enabled.  */
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +static int __hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   {
>   	struct page **pages, *page;
>   	int *counts;
> @@ -108,6 +108,54 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   	kfree(counts);
>   	return ret;
>   }
> +
> +/**
> + * hv_call_deposit_pages - Deposit memory pages to a partition
> + * @node        : NUMA node from which to allocate pages
> + * @partition_id: Target partition ID to deposit pages to
> + * @num_pages   : Number of pages to deposit
> + *
> + * Deposits memory pages to the specified partition. The deposit is
> + * performed in chunks of HV_DEPOSIT_MAX pages to handle large requests
> + * efficiently.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +{
> +	u32 done;
> +	int ret = 0;
> +
> +	/*
> +	 * Do a double deposit for L1VH. This reserves enough memory for
> +	 * Hypervisor Hot Restart (HHR).
> +	 *
> +	 * During HHR, every data structure must be recreated in the new
> +	 * ("proto") hypervisor. Memory is required by the proto hypervisor
> +	 * to do this work.
> +	 *
> +	 * For regular L1 partitions, more memory can be requested from the
> +	 * root during HHR by sending an asynchronous message. But this is
> +	 * not supported for L1VHs. A guest must not be allowed to block
> +	 * HHR by refusing to deposit more memory.
> +	 *
> +	 * So for L1VH a deposit is always required for both current needs
> +	 * and future HHR work.
> +	 */
> +	if (hv_l1vh_partition())
> +		num_pages *= 2;

I'm not sure if it is a good idea to just do this unconditionally for
all cases of l1vh. I'd like to experiment to see if this is actually
truy for all the passthru and interrupt related hypercalls that fail
with insuff memory.

> +
> +	for (done = 0; done < num_pages; done += HV_DEPOSIT_MAX) {
> +		u32 to_deposit = min(num_pages - done, HV_DEPOSIT_MAX);
> +
> +		ret = __hv_call_deposit_pages(node, partition_id,
> +					      to_deposit);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
>   EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>   
>   int hv_deposit_memory_node(int node, u64 partition_id,
> 
> 

