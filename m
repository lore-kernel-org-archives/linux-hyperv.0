Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040242C506;
	Mon,  3 Aug 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780371; cv=none; b=kKubrtnj8u+flhLfzsuKBbEXPE9vQX/8Q/pevxBCXgI1OEAiS3nkZ1V2CnPE37Uc5InZhEy1qOPNYitxFbyiWJnt6wK7EkMVCNjciTIFXEelizIMwmn8NJqIYztd9zZPWehDOlknC3OvyBGEsv8SWDk5foCtSWir7Y+ZmYk351Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780371; c=relaxed/simple;
	bh=c54gsormIwsur8nIUH7Sp2Sm/IFHjGgHIhB9EJH6QaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBEmsWdUCYV5vsqoNKWnzz/zTsW0MbaR5gmt+1nUtYByEgHgVhpYHHBQ8Ta9w7SRqt31kyeZfRb3mK36NUbWbIvLVl0d8v/gVuT1RpGvwmp8IpYI2/I756hEWSBA26ZD4OA9d8thjnlP3yvmmSEuMWKA4b5hII2CQAdugkh04HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q+QP8Cvz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q+QP8Cvz"
Received: from [192.168.1.71] (unknown [103.172.5.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D5CB20B7168;
	Mon,  3 Aug 2026 11:05:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D5CB20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785780350;
	bh=l75URa6NxkEZDaloy4fDYW6DlbosrDiag8Qm0LfpBwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+QP8CvzqSWkIrMXYUtxwlqU0y+lWoyrnzWdXWTcGTt+KB+DtNPgCYUrNFtGvzfcZ
	 XI0TCnNSIlpKgWj1MHF/AuH7Ga3fpThj6RGzkMKGyChpJRWMJYlw08jhTQ1g+kRL+W
	 4zYWMrbS/V1RMZR5ZBgfT979jIURyXDIYvCGQNrg=
Message-ID: <9b7dd08d-c007-47ed-9c75-ecfd735f26f8@linux.microsoft.com>
Date: Mon, 3 Aug 2026 23:35:57 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V
 PCI MSI irqchip
To: Naman Jain <namjain@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: x86@kernel.org, Jake Oshins <jakeo@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-2-namjain@linux.microsoft.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20260728135117.2888175-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28-07-2026 19:21, Naman Jain wrote:
> The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
> 
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> the outgoing CPU to a new target. If an interrupt still has its pending bit
> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
> new target through the irqchip's irq_retrigger() callback. As the Hyper-V
> PCI/MSI chip does not provide that callback, the pending interrupt is
> silently dropped, which can result in lost interrupts, stalls and "No irq
> handler for vector" messages during CPU hotplug.
> 
> Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
> the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent on its
> new target CPU via the parent x86 vector domain.
> 
> Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Cc: stable@vger.kernel.org
> Suggested-by: Long Li <longli@microsoft.com>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>   drivers/pci/controller/pci-hyperv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index cfc8fa403dad6..89816a2bd7cd3 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>   	info->ops->msi_prepare = hv_msi_prepare;
>   
>   	chip->irq_set_affinity = irq_chip_set_affinity_parent;
> +	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>   
>   	if (IS_ENABLED(CONFIG_X86))
>   		chip->flags |= IRQCHIP_MOVE_DEFERRED;

Reviewed-by: Aditya Garg <gargaditya@linux.microsoft.com>
