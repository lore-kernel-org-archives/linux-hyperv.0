Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5ABC433F5
	for <linux-hyperv@archiver.kernel.org>; Thu, 24 Mar 2022 12:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349972AbiCXMZN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbiCXMZM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 08:25:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F6B46C1EB;
        Thu, 24 Mar 2022 05:23:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE5311FB;
        Thu, 24 Mar 2022 05:23:40 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C053F73D;
        Thu, 24 Mar 2022 05:23:37 -0700 (PDT)
Message-ID: <e6d9af22-df69-bf6a-7877-b916918d0682@arm.com>
Date:   Thu, 24 Mar 2022 12:23:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] PCI: hv: Propagate coherence from VMbus device to
 PCI device
Content-Language: en-GB
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-03-23 20:31, Michael Kelley wrote:
> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
> device and as a PCI device.  The coherence of the VMbus device is
> set based on the VMbus node in ACPI, but the PCI device has no
> ACPI node and defaults to not hardware coherent.  This results
> in extra software coherence management overhead on ARM64 when
> devices are hardware coherent.
> 
> Fix this by setting up the PCI host bus so that normal
> PCI mechanisms will propagate the coherence of the VMbus
> device to the PCI device. There's no effect on x86/x64 where
> devices are always hardware coherent.

Honestly, I don't hate this :)

It seems conceptually accurate, as far as I understand, and in 
functional terms I'm starting to think it might even be the most correct 
approach anyway. In the physical world we might be surprised to find the 
PCI side of a host bridge behind anything other than some platform/ACPI 
device representing the other side of a physical host bridge or root 
complex, but who's to say that a paravirtual world can't present a more 
abstract topology? Either way, a one-line way of tying in to the 
standard flow is hard to turn down.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   drivers/pci/controller/pci-hyperv.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ae0bc2f..88b3b56 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3404,6 +3404,15 @@ static int hv_pci_probe(struct hv_device *hdev,
>   	hbus->bridge->domain_nr = dom;
>   #ifdef CONFIG_X86
>   	hbus->sysdata.domain = dom;
> +#elif defined(CONFIG_ARM64)
> +	/*
> +	 * Set the PCI bus parent to be the corresponding VMbus
> +	 * device. Then the VMbus device will be assigned as the
> +	 * ACPI companion in pcibios_root_bridge_prepare() and
> +	 * pci_dma_configure() will propagate device coherence
> +	 * information to devices created on the bus.
> +	 */
> +	hbus->sysdata.parent = hdev->device.parent;
>   #endif
>   
>   	hbus->hdev = hdev;
