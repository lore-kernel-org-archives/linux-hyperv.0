Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835047884F
	for <linux-hyperv@vger.kernel.org>; Fri, 25 Sep 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372000; cv=none; b=W/KiBOrTbm3Y5aeFkycLNFcROnvO1s7ybk4AS16e9Tx60sPz7+j5OYHuc6NK7j13zshIKItSKnYAjDcWEWb0Bk7ZBz0e287UYljHExj5iHoxIiiZsfwVQ+99RYE7lgU/gEjfDpbeQUV6mJ8NVKOVp8VETr9qW4+IHKP0U4QAsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372000; c=relaxed/simple;
	bh=fdYTU5U5yPhXQuFyexoLor1rQLck6e9sGLmm960hzA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEL/B9213+P70NipSuDJhXf9PH8yGm/8LxydZbppoc5zfzNcIbnM0YPSSLESvoK5SUuqtNWVWxw66+YcGLA4CBo4bSuGUqXNCzNabG8KOJAiesmM75SOH+f99rgpm9mviAcASpgrEgGiT4wu42bkualZ2PVTqx5PjXdytPvmtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XL40tDeU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XL40tDeU"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2AE2B20B7169;
	Fri, 25 Sep 2026 14:32:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2AE2B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790371949;
	bh=TRnGNk2C3pGkf1OWgvn5WxWb3mQ1EV+W88G8M579pHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XL40tDeUa5VP2TXhXbvOTl66CYxfzmaPao2PLYMJfKbSctGeK5c+9tMWY8H7XG13T
	 syScJ2xM88QTECHDr2GsrMAanWxYJyalfIWOOAUAvnMx/j6roCyN6MtyU6GZtoxLh6
	 NRlAQQtUvIN0jLCZT2n76WzwduAuUJUTqV1X/vBU=
Message-ID: <44536e5f-efcd-c9d4-7619-d2343c7b7f9f@linux.microsoft.com>
Date: Fri, 25 Sep 2026 14:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] mshv: Redesign hypervisor memory deposit logic
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
References: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
 <20260912000318.2959621-3-mrathor@linux.microsoft.com>
 <20260912001508.0C31C1F000FF@smtp.kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260912001508.0C31C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 17:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Memory leak of all un-deposited pages when `hv_do_rep_hypercall` returns `U64_MAX`.
> --
> 
> commit 68b286f4de61fdc1a888242cfc4b1a1ea3d187dc
> Author: Mukesh R <mrathor@linux.microsoft.com>
> 
> mshv: Redesign hypervisor memory deposit logic
> 
> This commit redesigns the hypervisor memory deposit logic to optimize
> performance and address preexisting issues. It defaults to allocating and
> depositing 2M chunks when possible to reduce overhead and avoids unnecessary
> interrupt disabling during the process.
> 
>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>> index 57864bb5bcd8c..df39a5c587ca2 100644
>> --- a/drivers/hv/hv_proc.c
>> +++ b/drivers/hv/hv_proc.c
> [ ... ]
>> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
>> +{
> [ ... ]
>> +	/* Not using hyperv_pcpu_input_arg, so no need to disable interrupts */
>> +
>> +	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages, 0,
>> +				     hc_input, NULL);
>> +	if (!hv_result_success(status))
>> +		goto err_free_dep_pages;
>> +
>> +	if (lastpfn) {
>> +		hc_input->gpa_page_list[0] = lastpfn;
>> +		status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
>> +					     hc_input, NULL);
>> +
>> +		if (!hv_result_success(status) && hv_repcomp(status) == 0)
> 
> [Severity: Medium]
> Will this leak the page pointed to by lastpfn if hv_do_rep_hypercall() returns
> U64_MAX?
> 
> If the hypervisor is unavailable or hypercalls are unsupported,
> hv_do_rep_hypercall() can return the sentinel value U64_MAX, which is explicitly
> handled by hv_result_to_errno() elsewhere.
> 
> When status is U64_MAX, the hv_repcomp(status) macro extracts bits 43:32, which
> results in 4095 instead of 0.
> 
> Does this cause the condition to evaluate to false and skip freeing the page?

This hypercall will not return U64_MAX.


>> +			/* We deposited lot earlier, so give it a go */
>> +			__free_page(pfn_to_page(lastpfn));
>> +	}
>> +
>> +	free_page((unsigned long)hc_input);
>> +	return 0;
>> +
>> +err_free_dep_pages:
>> +	hv_status_err(status, "\n");
>> +	rc = hv_result_to_errno(status);
>> +
>> +	for (i = hv_repcomp(status); i < num_pages; i++)
> 
> [Severity: Medium]
> Will this loop fail to free any pages in the pfna[] array when status is
> U64_MAX?
> 
> Similar to the check above, if status is U64_MAX, hv_repcomp(status) evaluates
> to 4095.
> 
> Since num_pages is bounded to a maximum of 511 (HV_DEPOSIT_INP_MAX) in this
> path, the loop initialization sets i = 4095, making the condition i < num_pages
> immediately false.
> 
> Does this cause the loop to terminate without executing, silently leaking up to
> 511 allocated pages per failed deposit attempt?


status cannot be U64_MAX for this hypercall.


>> +		__free_page(pfn_to_page(pfna[i]));
>> +	if (lastpfn)
>> +		__free_page(pfn_to_page(lastpfn));
>> +
>> +out_free:
>> +	free_page((unsigned long)hc_input);
>> +	return rc;
>> +}
> 

