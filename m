Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004948;
	b=v/46hix1Iv2AQIIQf6I61Cg0sTI7hZtuTAE499dw0q+HJXgOH+YpdjmeM8Y/pgkRAZfO
	 /Q0xIOkzUzrncp19s9Eh8Pp+04ggWBetOrbpcoANh9aAzwf19mixr/3kkhPwn8DhbuO+r
	 LXq9uZUUstolx7g4UK1H5EQAv/B2fBDxskKEzp1Ms9wenEtmbBocRlVevsIBnoQbvunYs
	 3UwSw7VZNZUimwUevM3M5tuaWKC1AQ/iG8DtxIoJMmyQ5fGQgFv4vtzA88bPDplOXn70L
	 HKh9Hq8oNIyml1KIgwiIDt1W8YMPrlurBl+WeM1xCO9RZjVQGgZvec2eX0y1KzbhNlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004948;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=eMaUrds+x9DLxiS8cPn4zLFLc/nlUkgskqEyT+lNW8Q=;
	b=mtiWLAh8kEBB8yRtJuLYOWEH04/psgZC1OKZOAcBXT7TrE6TWQLEoYKC8G3bpidcLnzW
	 Kv5gj+5qBxQ2yKnrczJo/lfalqQKb/A1OeBoSh26LTrqi4Gl8ylo5W5PkeN8tYmaUKP4z
	 rI/tKSfgLim+pcL/Mj988I7KWUd/t0aDuVzvhQdpFEkBaODQoyr2DNHJ0kNu161xfL5zt
	 oWmKliZulHfm2r0vfFHtx6AFpnLQLB4LK9iIjYMwsUe49NCXApk/iOS/9mdvWBqGVhUOf
	 IQR4cY68pFTaiNIgmCGFADIlbX4GpElLPcY5qX10UhJMt4RhmqFOeYdG8U+BZUWOlOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IVwYsHYN;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89706606A31B;
	Mon, 26 Oct 2026 08:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89706606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IVwYsHYN
Received: from [10.95.64.230] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32B8C20B7166;
	Mon, 26 Oct 2026 01:55:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32B8C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793004931;
	bh=eMaUrds+x9DLxiS8cPn4zLFLc/nlUkgskqEyT+lNW8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IVwYsHYNTO2McQS4l7TasR8d9aFlwkFmbISbn1/KcS/tQptbkBU93Ol58ROQTk8qE
	 G/vk+hZSR26vlli3Lt+u8KAQ9kyuvnDfZk1LRF+YIKFkFOqnK/nXmjmSGauJMe+IDW
	 +imkngZAt/hE5YBtbMIc3058kd86B8Mi1p6FIyUY=
Message-ID: <53f73450-7eaa-4f0c-90be-ffcfe1116e73@linux.microsoft.com>
Date: Mon, 26 Oct 2026 14:25:35 +0530
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
Subject: Re: [PATCH v2 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20261026045930.129874-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261026045930.129874-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/2026 10:29 AM, Michael Kelley wrote:
> In a system with multiple devices with the same configuration (such as
> NVMe controllers), the affinity masks are the same for all such devices.
> Linux typicaly must select a single CPU from each mask to be the effective
> affinity. If a fixed algorithm is used, such as picking the first CPU
> in the mask, interrupts from multiple devices are assigned to the same
> CPUs, while other CPUs are not assigned any interrupts, producing an
> interrupt load imbalance.
> 
> On x86, the "APIC" IRQ chip avoids this problem by spreading the
> interrupts across the CPUs in an affinity mask. It tracks the number
> of IRQs assigned to each CPU, and chooses the CPU in the mask that
> has the fewest assignments. Because Hyper-V vPCI device IRQs eventually
> parent to APIC, the spreading done by APIC accrues to Hyper-V vPCI
> devices, so all is good in x86 systems.
> 
> On arm64, the "ITS" IRQ chip for the GICv3+ITS does the same kind of
> spreading for LPI interrupts. But Hyper-V provides guest VMs only with
> a virtual GICv3, not including an ITS or LPI support. IRQs for vPCI
> devices on arm64 are mapped to SPIs and parented to the "GICv3" IRQ
> chip. The GICv3 IRQ chip always chooses the first CPU in the affinity
> mask as the effective affinity, producing an interrupt load imbalance
> for Hyper-V vPCI devices in arm64 systems.
> 
> The Hyper-V vPCI driver already has an arm64-specific IRQ chip to
> allocate and managed SPIs for use by vPCI devices. Solve the imbalance
> problem by extending this IRQ chip to implement a "set affinity"
> function that tracks SPIs assigned to each CPU, and chooses the
> least-loaded CPU as the effective affinity. Then invoke the parent
> IRQ chip (GICv3) to actually set that single CPU as the effective
> affinity in the virtual GICv3 hardware. As a result, IRQs are spread
> across CPUs like on x86 and interrupt load imbalances are avoided.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

<snip>

> +/*
> + * Track the count of SPIs assigned to each CPU. Pick a single CPU from the
> + * affinity mask based on the SPI loading data, and have the parent IRQ
> + * chip (should be "GICv3") set the effective affinity to that single CPU.
> + */
> +static int hv_pci_arm64_set_affinity(struct irq_data *d,
> +				     const struct cpumask *mask_val,
> +				     bool force)
> +{
> +	unsigned int cpu, prev_cpu;
> +	int ret;
> +
> +	prev_cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
> +
> +	scoped_guard(raw_spinlock_irqsave, &cpu_spi_count_lock) {
> +		if (prev_cpu < nr_cpu_ids)
> +			hv_pci_dec_spi_count(d, prev_cpu);

Nit: Would it be better to add this nr_cpu_ids check in 
hv_pci_dec_spi_count()/hv_pci_inc_spi_count() instead? I don't have a 
strong opinion on it.

> +
> +		if (force)
> +			cpu = hv_pci_arm64_get_min_load(d, mask_val);
> +		else
> +			cpu = hv_pci_arm64_select_cpu(d, mask_val);
> +
> +		if (cpu >= nr_cpu_ids) {

At some places like this, you may still need to retain it.

> +			if (prev_cpu < nr_cpu_ids)
> +				hv_pci_inc_spi_count(d, prev_cpu);
> +			return -EINVAL;
> +		}
> +
> +		hv_pci_inc_spi_count(d, cpu);
> +	}
> +
> +	ret = irq_chip_set_affinity_parent(d, cpumask_of(cpu), force);
> +	if (ret < 0) {
> +		guard(raw_spinlock_irqsave)(&cpu_spi_count_lock);
> +
> +		if (prev_cpu < nr_cpu_ids)
> +			hv_pci_inc_spi_count(d, prev_cpu);
> +		if (cpu < nr_cpu_ids)
> +			hv_pci_dec_spi_count(d, cpu);
> +	}
> +
> +	return ret;

<snip>

With or without above nit changes, for the patch -

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
Tested-by: Naman Jain <namjain@linux.microsoft.com>

Tested the patch on Azure ARM64 VM and verified the interrupt 
distribution and also saw soft lockups disappearing after optimal 
distribution of NVME - PCI interrupts produced by this patch.
Not repeating here, observations are similar to what I mentioned in the 
review of v1.

Regards,
Naman
