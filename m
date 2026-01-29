Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE62BB13;
	Thu, 29 Jan 2026 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680091; cv=none; b=TOR4fS785mKqolvPI/DZrdcnsDAKs+yJ9Z5YM8YFLNCPf68711+TYBwCIWcV/YTgwaIUbVZ1Ct1DttjWSYxZTVcil1FRyPryQJVZiZ5LxzI6C5sPX+Q6qUMqs4bIGAu1Yb0S11EjZktlFO8tibNHxb0LkXUOfAfHDKht9DyQYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680091; c=relaxed/simple;
	bh=BvhwViOtSzPVMfX2ixCUvGSB2MCwtQoHgJFynCZR6ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsJ/RidkNpVNgaj3nT9fXL0+uluw93tdrcRC6GRA/jT0zh8+P60VtUvPAf8fjtUOCvp9LzkyWA+29x3v1jXYs7GWCM6nWhwDPu9jGRmFqbqaPfQVRdEZROpeEXsYg8wNL15KeaM3MPqYUTcdGlsc8WxWln8638VV+8r9tezCIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fT/uIGNR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fT/uIGNR"
Received: from [192.168.0.105] (unknown [49.204.149.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAD6220B7167;
	Thu, 29 Jan 2026 01:48:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAD6220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769680090;
	bh=tKkMV9qLAx7sEqRVUdQib74BAJIgs0tAKzwW5+IISeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fT/uIGNRe6rQ6fHWUUZn2o/YBEXtUpwI9PO21xAq6lPyjOkekETxk/+aaHF5SaTTw
	 E0sOUofRMa53DJQ4ebN3uA1nYV72ciY/6DeX0I8cP42RyRrYKthnnme8dfwLE1OPlj
	 U3+VbCkj478bt4FMrfvwbP64G5NXZzPLqTmIjhfo=
Message-ID: <604190fa-c760-4cac-ac38-437178615597@linux.microsoft.com>
Date: Thu, 29 Jan 2026 15:18:04 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20260111170034.67558-1-mhklinux@outlook.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20260111170034.67558-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11-01-2026 22:30, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Field pci_bus in struct hv_pcibus_device is unused since
> commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   drivers/pci/controller/pci-hyperv.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 1e237d3538f9..7fcba05cec30 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -501,7 +501,6 @@ struct hv_pcibus_device {
>   	struct resource *low_mmio_res;
>   	struct resource *high_mmio_res;
>   	struct completion *survey_event;
> -	struct pci_bus *pci_bus;
>   	spinlock_t config_lock;	/* Avoid two threads writing index page */
>   	spinlock_t device_list_lock;	/* Protect lists below */
>   	void __iomem *cfg_addr;

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Regards,
Prasanna Kumar
