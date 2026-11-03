Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695385;
	b=paTS3MiUcSKbMQvbnxyQT8hQIdOBnwBZLO6YumnUf4xLI2OSgkwsbl6fvD/eaQ6XrCRb
	 TRcWLOeJ7Yz3M4ezuJnyPxwEoOJI1GJ4MFC6RErW2XdVKY9s7NVHymAJEoAIRtrij3uad
	 vcWhl2Y8DVFtyVmlBOVa5KvSZsICNuzQALJw17I5ifd7foeTi7Fn/uyOwQvVN/aNhEPmA
	 hiA1ZoBCep+LBWXHyUIXBdAf56fkCLkF2+sTbO1xAaoygf1UPKc9u15jC86uNCAi8V8IF
	 3IgAOxdLDBidsM253ohqrQM7KJroCR7OACTsl361qnMjIo9hitAweEFXinElCDJ3hRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695385;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=R3G95yWaf+sWcTEm63d9FXQfK/5a79F3ruZBzma63A8=;
	b=yEfq3wLnrsFPcsstQdLGCvWfu7+0eqpQFx4iQn0NRmRjn1Wd3/jJHYfZjlFQY0gOo633
	 eob1HNRtMr2kpOoun7S8henqq5B7QTa4XvM0nV4mPEo7kFLqOcC6lnHOJP5nwviDsnAx4
	 mJ6F9Q80K9I3ZigBs5VmNQv85bgdpeXgaGBF+eHVX9Y+Ur+OPl0y6+yit77M25FNSKOvE
	 H9YvEhFVaqHPmIwIMKq3moV7sMPSZePzkskfQyGBFYQ9YyZA22ACOIVaZ+zUKMvxbK9Zj
	 UzljZ2F7ve6RIVRzylLz2/WmPWXoxTz+uPijPcxObwIuo5EVg5V9dCpew1vgt4+m6Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DXJPWLzn;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5D606A95E;
	Tue,  3 Nov 2026 08:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF5D606A95E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DXJPWLzn
Received: from [10.95.64.190] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87A4A20B7166;
	Tue,  3 Nov 2026 00:42:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87A4A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793695370;
	bh=R3G95yWaf+sWcTEm63d9FXQfK/5a79F3ruZBzma63A8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DXJPWLznZPYVXr3OmPYzZcQG1HlwtFfSG+/+kJHkWVF9KBIh8nLsRrdttdQlAdfcM
	 YrcqZmod/F1py7b2yxaEtICrqh3jba6UjP71iSIv/9FQqSK+oTSNUQxFDEQ9t6OZYs
	 G7sLeIYyi2a4f6h1I1R58pUHBgc2+6FMl+Ko4pxk=
Message-ID: <e7eacfc8-7bf1-4dde-b62a-607a490fdd06@linux.microsoft.com>
Date: Tue, 3 Nov 2026 14:12:59 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru
 device support
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261101022257.52819-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261101022257.52819-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/1/2026 7:52 AM, Michael Kelley wrote:
> Add a section to the documentation describing the IRQ domain and IRQ chip
> hierarchy that is created for virtual PCI devices, including the
> differences on x86 and arm64, and the reasons for those differences.
> 
> In the context of the IRQ domain and chip hierarchies, describe how the
> CPU selected for effective affinity is spread across CPUs in the affinity
> masks. Again, account for the differences in x86 and arm64.
> 
> Finally, rework existing text on how MSI messages are composed. Provide
> an expanded section on the overall approach that Hyper-V takes to MSI
> messages. The section provides more context on the handling of MSI messages
> in the Hyper-V vPCI driver, and why it is structured the way it is.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---

<snip>

> +MSI Messages
> +------------
> +In a typical guest on KVM, the VMM traps guest writes to a vPCI
> +device's MSI/MSI-X registers/tables. The guest writes a virutal
> +message (with a guest APIC address and a guest vector), and VMM
> +emulation translates the message to program the physical device and
> +physical device interrupt remapping (IR) tables on the guest's
> +behalf. The guest never sees or handles the host-level MSI message.
> +
> +Hyper-V takes a different approach in which MSI/MSI-X register or
> +table writes are not trapped. The guest writes the device's MSI/MSI-X
> +registers/tables directly with a host-valid MSI message. The physical
> +IOMMU and its remapping table are still owned by the host, so the
> +guest must ask the host for the proper message.
> +

Could we distinguish MSI-X table writes from MSI configuration-space
writes here?

pci_write_msg_msi() programs the MSI address/data through
pci_write_config_*(), which goes through the Hyper-V config-space
access mechanism. As described in the existing "PCI Device Setup"
and "PCI config space access in a CoCo VM" sections, those accesses
trap to Hyper-V in normal VMs, or use explicit hypercalls in CoCo VMs.

The distinction seems to be that Hyper-V requires the guest to obtain
a host-valid MSI message explicitly over VMBus, rather than relying
on interception of guest MSI programming to establish the interrupt
mapping. That is separate from whether the programming accesses
themselves are trapped. We should probably make that distinction instead
of saying that both MSI and MSI-X writes are untrapped?

> +The "asking" is done by the .irq_compose_msi_msg function for the
> +"Hyper-V PCIe MSI" chip, which is hv_compose_msi_msg(). The
> +implementation requires sending a VMBus message to the Hyper-V host
> +and awaiting an interrupt indicating receipt of a reply message.
> +Since .irq_compose_msi_msg can be called with IRQ spin locks held, it
> +doesn't work to do the normal sleep until awakened by the interrupt.
> +Instead hv_compose_msi_msg() must send the VMBus message, and
> +poll for the completion message. As further complexity, the vPCI
> +device could be ejected/rescinded while the polling is in progress,
> +so this scenario must be detected as well. See comments in the code
> +regarding this very tricky area. A synchronous hypercall to get the
> +MSI message would be a much nicer interface, but the code makes do
> +with what's available.
> +
> +Once the host-valid MSI message is obtained, the guest must treat it
> +as a black-box that the guest does not interpret or modify. The only
> +valid guest action is to write it to the MSI/MSI-X registers/tables
> +using the .irq_chip_write_msi_msg function on the HV-PCI-MSIX-<PCIaddr>
> +chip. That function is pci_msi_domain_write_msg(), which calls
> +__pci_write_msi_msg().
> +
> +If the affinity of an IRQ changes, the steps must be
> +repeated. A new host-valid MSI message is requested via the
> +.irq_compose_msi_msg function and that message is written
> +to the MSI/MSI-X registers using the .irq_chip_write_msi_msg
> +function.

I don't think ordinary affinity changes require a new MSI message,
including with the companion arm64 spreading patch applied.

hv_pcie_init_dev_msi_info() installs irq_chip_set_affinity_parent
instead of the generic compose-and-write affinity handler.

On arm64, the new hv_pci_arm64_set_affinity() selects a CPU and passes
a single-CPU mask to the parent. gic_set_affinity() then updates the
SPI's GICD_IROUTER and effective affinity, without recomposing or
rewriting the device's MSI message.

Similarly, on x86, the new CPU/vector is communicated through the
Hyper-V unmask/retarget path using the existing MSI descriptor.

Could this paragraph describe updating the routing of the existing
message, rather than obtaining and programming a new one?

Regards,
Naman

> +
>   DMA
>   ---
>   By default, Hyper-V pins all guest VM memory in the host

