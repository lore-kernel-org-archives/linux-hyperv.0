Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E5353A7A;
	Thu, 23 Jul 2026 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797678; cv=none; b=uaBTK8jKH4yg5zi17Ig4hJQsUo9GsY+WdSX/fIP+Te5Z6RFEAG2/2hmo25OqfzVWhz9xIx0SoCUItOqJ56gDyNgrEhjq1aFTfMWfhgCpVyF3e9Ie7AyNW7UZhMl2uc96dOGBU5ia1q45MPd5yhvy9JqfcAJm7kZVE/WWQMdZzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797678; c=relaxed/simple;
	bh=vEUGtbZ+up8SZL5Bx7NXQHiNt+tPI+HsPM0cNheUXIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kG+7u4uB1WZReDPNMVvISiSpH6IIT1B1PS9qtM+ZblMM5Gv1tX4b0eC96hZLBxPv6RcMgFMaQ3aX37NGZpm6cfPuo9EN2uwGl3Ri69K5hxm/u+26mvLPF+rx+SVezDTMEeZ3U0vaLTTbhEupuT5l6Ud258PSA2b2zKX7QqUTM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LGJ9NYZq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LGJ9NYZq"
Received: from [10.7.58.6] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6495A20B7167;
	Thu, 23 Jul 2026 02:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6495A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784797663;
	bh=sPFinmVR/A+ZeU4t6Ey93Fz10iwEfV8ZV3Y0Jwimarw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LGJ9NYZqHP/6Fh/TMIWDlcEhmrG08g2p6PhlPuI8WNWhntUC2vH+DkyyqW6WFipWo
	 4xu0Cv4GQwQ2223uRHNZkhPpEF9cCHS38L+KE3+AkQ9iMk66cNF2EI4Loz6jAxH4Qb
	 zbWOPONr7XHylbdJU7glJAFBaim8DMp/v3HY16fA=
Message-ID: <eb6113fc-4fc8-4f28-8dfc-121cf6de5abd@linux.microsoft.com>
Date: Thu, 23 Jul 2026 14:37:51 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: bounds-check cpu index in vtl mmap fault handler
To: Yi Xie <xieyi@kylinos.cn>, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709021947.49436-1-xieyi@kylinos.cn>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260709021947.49436-1-xieyi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/2026 7:49 AM, Yi Xie wrote:
> cpu is taken from pgoff & 0xffff.  cpu_online() does not reject cpu >=
> nr_cpu_ids, and per_cpu_ptr() can then walk off __per_cpu_offset.
> 
> Signed-off-by: Yi Xie <xieyi@kylinos.cn>
> ---
>   drivers/hv/mshv_vtl_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f..fc50c44ac1bd 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -801,7 +801,7 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>   	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
>   	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
>   
> -	if (!cpu_online(cpu))
> +	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
>   		return VM_FAULT_SIGBUS;
>   	/*
>   	 * CPU Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.

The problem fixed by this patch generally does not happen in practice as 
the user space is trusted user space (OpenVMM). Nevertheless, it's good 
to have this check.

Nit: subject - s/"mshv:"/"mshv_vtl:"
as this was the agreed upon prefix for changes to mshv_vtl_main driver.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
