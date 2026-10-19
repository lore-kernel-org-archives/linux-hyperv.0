Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FA466AE1;
	Mon, 19 Oct 2026 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386130; cv=none; b=CRB4voK11ynerQIENe+m4v/K6HxNTigJxTYxQml5VMZT5ljjCkF1cKbAVbn+L/tb29WL3ga5iTemAxRPmUPgn8jNk+PqlOb2hnp+x27MAZ0yyshx9IOQbFkET9dp892VQo8Za+HvKh/3LW5xLEVs5DGi+uik8w4BysdzhLqPTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386130; c=relaxed/simple;
	bh=N1VzElti/CRCZRJYBLV1ksRYvHO8FeD1zy1hb2rRzAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V/q2zDb/RwH3agrd4D8O0p+HWVo9ALhEipYFa4MvIH/LkjR51JlLrkKmKAXy+nhvF8RfDJDr/4ov1YAbYxX8K9iiMHp6Zwl2hS0M10+kiSuVJ/Wo2iOHU93nCKOCXl9tiM9qBmo7tUAfYd7m2grk3gRsu2Nd80+K08StYe7FlAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e48BnFDO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e48BnFDO"
Received: from [10.95.64.89] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E9C220B7168;
	Sun, 18 Oct 2026 22:01:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E9C220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792386117;
	bh=YJcjyOk1+QqolzuhxWeZuoupRLUPtFnlqT1FVyfOllc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=e48BnFDO0qDkM/QFQmuoMkJdN8vlCw5rgPZZPodgSGGlB3fzN0o9LGT7+SAxSb/qf
	 ELQ2zgXs54SuewWzYFnHELVBVCC1BIHs5SsBbR4Im7wedy/sHDUgkJLyaj2AR0aXUm
	 UMUbD51DDD5u+TLnezk1I216vKxkcgQYA4+awj+0=
Message-ID: <778a2d3c-19bd-43ec-bc72-26fc02bfea47@linux.microsoft.com>
Date: Mon, 19 Oct 2026 10:31:59 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_vtl: initialize poll file mutex before device
 registration
To: Jiale Yao <yaojiale02@163.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261018034616.508850-1-yaojiale02@163.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261018034616.508850-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2026 9:16 AM, Jiale Yao wrote:
> mshv_vtl_init() registers /dev/mshv before initializing the poll file
> mutex. A concurrent MSHV_SET_POLL_FILE ioctl can therefore attempt to lock
> an uninitialized mutex while module initialization is still in progress.
> 
> Initialize the file-scope mutex statically so it is ready before the misc
> device becomes visible.
> 
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>   drivers/hv/mshv_vtl_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index d8225242c73f..2b40c9e3bf88 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -95,7 +95,7 @@ union hv_synic_overlay_page_msr {
>   	} __packed;
>   };
>   
> -static struct mutex mshv_vtl_poll_file_lock;
> +static DEFINE_MUTEX(mshv_vtl_poll_file_lock);
>   static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>   static union hv_register_vsm_capabilities mshv_vsm_capabilities;
>   
> @@ -1370,8 +1370,6 @@ static int __init mshv_vtl_init(void)
>   		goto free_low;
>   	}
>   
> -	mutex_init(&mshv_vtl_poll_file_lock);
> -
>   	device_initialize(mem_dev);
>   	dev_set_name(mem_dev, "mshv vtl mem dev");
>   	ret = device_add(mem_dev);

While this issue may not happen in practice, as OpenVMM userspace runs 
much later than these init function invocations, but it is good to have 
the potential race condition fixed.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman


