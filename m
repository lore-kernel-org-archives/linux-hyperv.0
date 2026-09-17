Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AE30216D;
	Thu, 17 Sep 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789623070; cv=none; b=pQfITuilME2P9w/epDqxIQG8wX9miLXqumwa+SmbL/fW1jVQvYMmZr2+aoDQjp9efUVg0CsvAI9aZ2sz46PH6AnHP6bS0B1by5yV9mJ5roZUTaw7xevEPp4vEvftwLGOwYgc6m3fQPT8GLGmAkqJBN58IQ4uut26LcSZrA7DG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789623070; c=relaxed/simple;
	bh=33pHxhqcKOACoiDbk8F25AIt1rOFzy0h0XB5mJ7Slew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtNGP8zQujwTmFNhkd+tlOQrc1UzLb8pH21E9iII2pVjsMNc0fUV9vY8tYEQLOYRi9QtF6CZhLJgaOwV295eEREk1JPmTpk+U/tsPjGDKvPL6d4+QDg6eq5tXClhL/C61Aonwmnw11XWahCrpuNIEbuWiXmWGDeF7iWtKmYVF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nODgqGEV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nODgqGEV"
Received: from [10.26.7.43] (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id B6D7A20B7169;
	Wed, 16 Sep 2026 22:30:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6D7A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789623023;
	bh=L1pN5bVd9usMHlHHI6Pzx9hyCre9b6mdSIltt5Mq1Eo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nODgqGEVBO2Xo1Jk6m0Eopf6OvUMppRSgUHv89lQYFLzYWp3sC6JBwa1HsHkxm3qi
	 eHXm2Tey7eS63QOF46hN5SRZof5Yd14FjOBK4QZUx/H1Qp9Rvfz0GbJQZYkx4TR203
	 L7uQR09mJ9LC31UVy0Nvzka0677iUqNpuPgOYQ1M=
Message-ID: <011f1fa5-89c5-4bc5-8b2e-c5f415a57559@linux.microsoft.com>
Date: Thu, 17 Sep 2026 11:01:03 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: hv: Probe vPCI buses asynchronously
To: Naman Jain <namjain@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <20260907054742.235389-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07-09-2026 11:17, Naman Jain wrote:
> On Hyper-V guests each virtual PCI bus is enumerated by its own
> hv_pci_probe() call. The probe performs several synchronous host
> request/response exchanges while negotiating the protocol, querying bus
> relations, entering D0, and reporting allocated resources. These waits
> are latency-bound rather than CPU-bound.
> 
> hv_pci registers as an ordinary VMBus driver, so driver_register() walks
> matching vPCI buses and probes them sequentially while the driver's
> initcall runs. On guests that expose several devices, each through its
> own vPCI bus, this serialization adds the host round-trip latencies to
> device initialization.
> 
> Each bus is described by its own struct hv_pcibus_device, so
> independent buses can be probed concurrently. Request asynchronous
> probing via PROBE_PREFER_ASYNCHRONOUS, causing the driver core to
> schedule matching buses for asynchronous probe work.
> 
> On an Azure Standard_L32s_v3 guest with five vPCI targets (four NVMe
> controllers and one Mellanox VF), Linux 7.2.3 was tested with one warm-up
> and three measured boots per variant. The median interval from the first
> hv_pci_probe() entry to the last return decreased from 2847.968 ms to
> 2786.709 ms, a 61.259 ms (2.15%) improvement.
> 
> Co-developed-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> 
> Previous discussion around this change:
> https://lore.kernel.org/all/20230420024037.5921-7-decui@microsoft.com/
> 
> Skipping removal of pci_rescan_remove_lock, due to possible
> synchronization problems associated with this lock removal. Also, with
> my current setup, I was not able to see much improvements with this
> change, so keeping it for later. Asynchronous probing change is not
> dependent on this.
> 
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 89816a2bd7cd3..056d379b3cee4 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -4155,6 +4155,9 @@ static struct hv_driver hv_pci_drv = {
>  	.remove		= hv_pci_remove,
>  	.suspend	= hv_pci_suspend,
>  	.resume		= hv_pci_resume,
> +	.driver = {
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
>  };
>  
>  static void __exit exit_hv_pci_drv(void)
LGTM.
Reviewed-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Regards,
Sahil
