Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295A38399C;
	Tue,  4 Aug 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872762; cv=none; b=kIKYnZUcsG1yVKCCMfkp6vDyR321UxCy5y6iRYi+mf0vGqQD8hbt77AmJgZRbGVW6YtNn04/6YUlucFlbDaE0gZRqM7cQxB/7ZlGNV/fXodkht4ILM16Y0X7uacuO1j5pfB/P+bUHigwMm+HmSA3x1kuPv7VVuFPkw6v6vrb3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872762; c=relaxed/simple;
	bh=1V8gouu3kMMUDN4lM+ccq6wspVoJ3edHPbLouduNNnM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fW8MHmnznE2KNdSuzS9e4OU3EPsrYBMbg5cJfmjTKIfQZKw5pRlKwaLIcyJ4011emSQuynW8r8uqbd3TvibykNsthrDeBFS1q5eu/XbD81x4ooBeFuAt+ZGkIA4jbXx065edKj5GN6VcAZCsONo1wvy3waynMAm2WsTZfI5QIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MqJBON4a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MqJBON4a"
Received: from [100.64.160.72] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5FB9420B7169;
	Tue,  4 Aug 2026 12:39:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FB9420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785872369;
	bh=AfmE6ydRnH/9XGZDFiN6AXwfJD/eQ2/hMzPtRMmhSss=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MqJBON4aaP0EUm1+w+WrV8giQoy3CTZhCP4hLVOWqmejnrY9ALMIwuWD0uxHo3xfx
	 QO4r+Izn1TWNIVImaV7QEvqv1ovSaFdCXDQVT5AzRPc3/CNNpZnuZq6CrCBJf+xEPl
	 ov3YB/UoTeUA2G7RksHMziIVAOn4mVSwX1hphfCk=
Message-ID: <ea0d31c0-5559-462c-b6d3-1ed6c01a9074@linux.microsoft.com>
Date: Tue, 4 Aug 2026 12:39:48 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for
 non-nested root partition
To: mhklinux@outlook.com
References: <20260804190517.101981-1-mhklinux@outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260804190517.101981-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/2026 12:05, Michael Kelley wrote:
> The VMBus module should not be loaded when Linux is running directly
> in the root partition and root is not nested in another VM. Current
> code checks this condition and skips VMBus module initialization, which
> works. But it returns 0 as the result, so Linux thinks the module has
> successfully loaded. Later, if the module were to be unloaded, the
> VMBus module unload code tries to clean up things that were never
> initialized, resulting in memory faults and a panic.
> 
> Fix this by having VMBus module initialization return -ENODEV for this
> case. The module is then not loaded, and the unload path can never run.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
> Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e19ec73b0187..849d7e1a7320 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2976,7 +2976,7 @@ static int __init hv_acpi_init(void)
>  		return -ENODEV;
>  
>  	if (hv_root_partition() && !hv_nested)
> -		return 0;
> +		return -ENODEV;
>  
>  	/*
>  	 * Get ACPI resources first.

This seems straightforward:


Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
