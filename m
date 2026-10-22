Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651259;
	b=T8STbFL2nS9sNKM88ucSsEKlPALxkdSCN4Tbo8n3sEclulBvmDbXf8iur61hytIaBeFr
	 re24Xzp6+5j/rq3iX8X345hdwppjSzdmJvz/LRCWfgyxcHkYxSPVyFwd1qDbGVKzDDB7+
	 rhw8ct53Gnj4aRMV4LKAXD3uyVlHpBj8Me+mvhYAJbHn7v/84ajX7cCabG+tspb4PAFDA
	 6xyOjfMYcZq81tMPtq27l52wHisthhELop9ZVu4yh0DWMqFRwIJNO9d8fMksfQE8JVKVD
	 P9WAx2yxVAFcpeXnjpuicuCLc4PXwTUkl0klo55Kaq2wHqAQ1HSliBuwzMUYqxJrE7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651259;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=Ak39HYGsVbjQ81liEI2M4HumUVWbf64V9toCPOlMMmU=;
	b=zWUJ+YgYQpQJKkHCduf/CJDX5QkRj3X8R5v0OZTedmcS2JULTnIx/0LpoAD7LeeGlDhN
	 5+ZhNFdKLx4meBas08xKHSYjMvOkVYhgpwRPJCGJpwaImqgHYlvYaJQMRLp713popjhcX
	 r74mdwk61Bkr2BRHwk+kPtLuREQ0Lq70/O5PCkLhjZbmRtkQmEcxVuXWGRg0EGyQFD4O9
	 ce1kqXCY+8OyC1PkUAxbvZkmLpfK1dww2pnJvAUfmg4R3dQ+9Y4X8MJuDe6eQouM3EAGY
	 eUKfI63jiWyXXQtGrmYrBWI0OlUbDhHSS1P+m3+MIkzovWDpIhxY3ikhOQcxxkNs/Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=aOqxDhdQ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B46606A31A;
	Thu, 22 Oct 2026 06:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B46606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=aOqxDhdQ
Received: from [10.95.64.178] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D5A920B7166;
	Wed, 21 Oct 2026 23:40:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D5A920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792651249;
	bh=Ak39HYGsVbjQ81liEI2M4HumUVWbf64V9toCPOlMMmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aOqxDhdQcgsNSOufTKSffimOkjuZFAgoNtYb79wHFSwD2JIib5/Z+6FS2gBpTKK7w
	 o/FXWlQlWw3VoX9z8pXILgRSd6vCD04gt2LboSV66Y9JOFdY87eSVtqSlxBJORQmk7
	 XX+gdIU5LGvpprc1qxCa7Oi9Z5nL8VfnY1SpUkZk=
Message-ID: <7da0011b-b51e-4181-961e-fb6b177b7691@linux.microsoft.com>
Date: Thu, 22 Oct 2026 12:10:52 +0530
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
Subject: Re: [PATCH 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20261020182433.336637-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261020182433.336637-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/2026 11:54 PM, Michael Kelley wrote:
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

The overall changes are well explained and LGTM. I saw your comment 
about Sashiko review, so that is covered.
Mentioning some minor nits and review comments inline.

You may also want to look at some of the checkpatch "strict" warnings 
with these changes. Since you sent it from a different email id than 
what is signed-off by, you may not have seen that mismatch warning in 
local run.

> ---
> As an alternative, this spreading functionality could be implemented
> for SPIs directly in the GICv3 IRQ chip, similar to what the ITS IRQ
> chip already has for LPIs. While Hyper-V's scheme of using SPIs for
> vPCI interrupts is allowed by the arm64 architecture, it's atypical.
> So the original decision was for the Hyper-V vPCI driver to handle
> the allocation and management of SPIs for this purpose rather than do
> it in generic GIC code. That led of the introduction of the "MSI" IRQ
> chip in the Hyper-V vPCI driver. This implementation of the spreading
> functionality follows that original decision by extending the "MSI"
> IRQ chip. If reviewers have reasons to prefer enhancing the GICv3 IRQ
> chip driver instead, I'm open to doing that.
> 
> I have not added any documentation to Documentation/virt/hyperv/vpci.rst.
> That documentation needs an entirely new section on the IRQ domains
> and chips, and their hierarchy differences on x86 and arm64. I'm
> working on a separate patch to add that documentation. But I don't
> want to hold up this improvement for that larger documentation task.
> 
>   drivers/pci/controller/pci-hyperv.c | 144 +++++++++++++++++++++++++++-
>   1 file changed, 142 insertions(+), 2 deletions(-)
> 

IRQ-affinity comparison with and without your changes:

System:
   Azure Standard_D64plds_v6
   64 ARM Neoverse-N2 vCPUs, no SMT, one NUMA node.
   Four independent Microsoft NVMe Direct Disk v2 controllers,
   approximately 945 GB each, with 14 I/O queues/controller.
   Hyper-V GICv3 SPI routing; no ITS/LPIs.

Both kernels use next-20261021.

                              Vanilla       With patch
   Data IRQ vectors              56              56
   Effective target CPUs         14              56
   Maximum data IRQs/CPU         4               1

The requested affinity masks remain unchanged. Entries below are
measured effective target CPUs. Columns identify the four controllers
by stable serial suffix, not their boot-dependent nvmeX names.

              Vanilla                    With patch
Queue   0001 0002 0003 0004        0001 0002 0003 0004
q1         0    0    0    0           4    2    1    3
q2         5    5    5    5           8    7    5    6
q3        10   10   10   10          13   10   12   11
q4        15   15   15   15          18   15   17   16
q5        20   20   20   20          23   20   22   21
q6        25   25   25   25          28   25   27   26
q7        30   30   30   30          33   30   31   32
q8        35   35   35   35          38   35   36   37
q9        40   40   40   40          43   41   42   40
q10       44   44   44   44          47   45   44   46
q11       48   48   48   48          51   48   49   50
q12       52   52   52   52          55   52   53   54
q13       56   56   56   56          59   58   56   57
q14       60   60   60   60          63   62   61   60

This distribution could effectively prevent soft lockups from happening 
on this ARM VM when sufficiently high FIO workload was run, focussed on 
4 CPU group (cpu 5-9 for example). I verified this by testing on the 
same VM as mentioned above.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 85d826f8f68d..1706090cebeb 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c

<snip>

> +
> +static unsigned int hv_pci_arm64_get_min_load(struct irq_data *d,
> +				       const struct cpumask *cpu_mask)
> +{
> +	return hv_pci_arm64_get_min_load_and(d, cpu_mask, cpu_possible_mask);
> +}
> +
> +static int hv_pci_arm64_select_cpu(struct irq_data *d,
> +			  const struct cpumask *aff_mask)
> +{
> +	int cpu;
> +
> +	if (irqd_affinity_is_managed(d))
> +		cpu = hv_pci_arm64_get_min_load(d, aff_mask);
> +

You can remove the empty lines here, if these are not intentional.

> +	else if (cpumask_intersects(aff_mask, cpu_online_mask))
> +		/* Try the intersection of the affinity and online masks */
> +		cpu = hv_pci_arm64_get_min_load_and(d, aff_mask, cpu_online_mask);
> +

Ditto

> +	else
> +		/* If that doesn't fly, the online mask is the last resort */
> +		cpu = hv_pci_arm64_get_min_load(d, cpu_online_mask);
> +
> +	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);

Add an empty line here instead.

> +	return cpu;
> +}
> +
> +/*
> + * Track the count of SPIs assigned to each CPU. Pick a single CPU from the
> + * affinity mask based on the SPI loading data, and have the parent IRQ
> + * chip (should be "GICv3") set the effective affinity to that single CPU.
> + */

Could concurrent affinity updates for different IRQs select the same 
stale minimum here?

Each update holds only its own IRQ descriptor lock, so two callbacks can 
both decrement their old counts, observe the same CPU as least loaded, 
program both SPIs to it, and only then increment its count. Could the 
selection and count reservation be serialized across these IRQs, or 
could the selected CPU be reserved atomically before programming the parent?

> +static int hv_pci_arm64_set_affinity(struct irq_data *d,
> +				     const struct cpumask *mask_val,
> +				     bool force)
> +{
> +	unsigned int cpu, prev_cpu;
> +	int ret;
> +
> +	prev_cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
> +	if (prev_cpu < nr_cpu_ids)
> +		hv_pci_dec_spi_count(d, prev_cpu);
> +
> +	if (force)
> +		cpu = hv_pci_arm64_get_min_load(d, mask_val);
> +	else
> +		cpu = hv_pci_arm64_select_cpu(d, mask_val);
> +
> +	if (cpu >= nr_cpu_ids)
> +		goto err;
> +
> +	ret = irq_chip_set_affinity_parent(d, cpumask_of(cpu), force);
> +	if (ret < 0)
> +		goto err;
> +
> +	hv_pci_inc_spi_count(d, cpu);
> +	return ret;
> +
> +err:
> +	if (prev_cpu < nr_cpu_ids)
> +		hv_pci_inc_spi_count(d, prev_cpu);
> +	return -EINVAL;
> +}
> +
>   /* Hyper-V PCI MSI IRQ chip */
>   static struct irq_chip hv_arm64_msi_irq_chip = {
>   	.name = "MSI",
> -	.irq_set_affinity = irq_chip_set_affinity_parent,
> +	.irq_set_affinity = hv_pci_arm64_set_affinity,
>   	.irq_eoi = irq_chip_eoi_parent,
>   	.irq_mask = irq_chip_mask_parent,
>   	.irq_unmask = irq_chip_unmask_parent
> @@ -888,21 +1010,39 @@ static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
>    * composing MSI from the hypervisor. GIC will eventually set the right
>    * affinity for the irq and the 'unmask' will retarget the interrupt to that
>    * cpu.
> + *
> + * The first cpu is always used for initial activation because spreading the
> + * initial CPU would have to be done without information about affinity groups
> + * that may exist. The resulting assignments would pollute the "least loaded"
> + * data for making the final assignments. Everything would still work, but
> + * the spreading would be less even than it could be.
>    */
>   static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
>   					  struct irq_data *irqd, bool reserve)
>   {
> -	int cpu = cpumask_first(cpu_present_mask);
> +	int cpu = cpumask_first(cpu_online_mask);

This should be harmless, but I am wondering if this is actually required 
for your changes or this is a separate independent change, addressing 
some other issue.

>   
> +	hv_pci_inc_spi_count(irqd, cpu);
>   	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
>   
>   	return 0;
>   }
>   
> +static void hv_pci_vec_irq_domain_deactivate(struct irq_domain *domain,
> +					     struct irq_data *irqd)
> +{
> +	int cpu;
> +
> +	cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
> +	if (cpu < nr_cpu_ids)
> +		hv_pci_dec_spi_count(irqd, cpu);
> +}
> +
>   static const struct irq_domain_ops hv_pci_domain_ops = {
>   	.alloc	= hv_pci_vec_irq_domain_alloc,
>   	.free	= hv_pci_vec_irq_domain_free,
>   	.activate = hv_pci_vec_irq_domain_activate,
> +	.deactivate = hv_pci_vec_irq_domain_deactivate,
>   };
>   
>   #ifdef CONFIG_OF

Regards,
Naman

