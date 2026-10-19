Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9234ABBA9;
	Mon, 19 Oct 2026 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401861; cv=none; b=Oxq959QrNCxeXgE7CuEMTniK3TVZe44aXEZBULsejyE23igcJVij9LVdSGzBV6bQnfqX3FmhzeblAtMFGs0Vfigljtuq6AgVxHP0Js+hu+PFqKCOYKh4X65m6iS00CJJ/LNqRLQoHfRnhJxOiVO25wlO4wK9k0RbBumiQPSY/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401861; c=relaxed/simple;
	bh=zuxTAK6KYrdRdHEVJDHRu5Jqv/nDM1EsaUddarXo/J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vC/OmaDM9bRu0RvzXyTEDWatLIpI6PNIipTt9Sm+WPlkJAqpT9GeJzlkclgrDHpfAYNPD+Oqf5dB9d7Pebv5dDeGbttUR1gCDqg1kSNeCpTs85HP9bVQTxGpgUvpET5FzJb4ybG8Tyu6xtsJFkP0fnVLdPX0Y7TTTWXNqfLWjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jZ6BfK+V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jZ6BfK+V"
Received: from [10.95.64.89] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7657820B7168;
	Mon, 19 Oct 2026 02:24:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7657820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792401852;
	bh=gPrmHuhoX8V91KtuoqSxyz/GmQaJJNckFAKFVgbE3kI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jZ6BfK+VHrgnw+3mxVojoaeU0fNkGlCWCiFGDylNIbE5ijdkPaeVwq8/fZ71mDFoM
	 1O9wmXgHVHK3ducLcSeydLNwYoqx+rLnkZT1W9bKDyAaY2Z9JiIDjPXH6zWDccqg3Y
	 Z9kMDnnzP7PrevkFPXEuOT+E9TxSxt7Sjn7plPFs=
Message-ID: <65524c06-55e1-4340-b7a7-b038d20e6b74@linux.microsoft.com>
Date: Mon, 19 Oct 2026 14:54:13 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: Check ACPI companion before use
To: Jiale Yao <yaojiale02@163.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261017064313.3816553-1-yaojiale02@163.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261017064313.3816553-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/2026 12:13 PM, Jiale Yao wrote:
> Platform drivers can be forced to bind to devices outside their match
> tables through driver_override. vmbus_acpi_add() assumes that every bound
> device has an ACPI companion and dereferences it without checking.
> 
> Return -ENODEV when the companion is absent to avoid a NULL pointer
> dereference.
> 
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>   drivers/hv/vmbus_drv.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4692687cdbf3..28f459679406 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2571,10 +2571,14 @@ EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>   #ifdef CONFIG_ACPI
>   static int vmbus_acpi_add(struct platform_device *pdev)
>   {
> +	struct acpi_device *ancestor;
> +	struct acpi_device *device;
>   	acpi_status result;
>   	int ret_val = -ENODEV;
> -	struct acpi_device *ancestor;
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
>   
>   	vmbus_root_device = &device->dev;
>   

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
