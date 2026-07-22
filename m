Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6234E766;
	Wed, 22 Jul 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712547; cv=none; b=KG6OPSCb7l2MMUsdgERh0zqjhYn4/DGNyXwW+ZMBZu/VG12Xlq794W8/1qHXwpQID2mf6mox9RlR4NiHCPqHvEf+oGIDqoTrbYHDNkxRzy4J79Ds17nxfvZf3PwPJHZwJ/K5vzYPHqRlIcXnnDD4j/cD+nTXmLcuzmweZE4fgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712547; c=relaxed/simple;
	bh=cIfdE/AIMmsnUsEN8YUDk7AFJS8rIzLtpcUPT137xdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6QjaQY4mbiEu7huVd3RNdqsNcVsivjRqqz0rBT0n7NK8LVn/fpAAwKSvuuZeQLw3GQMAuAkxN1+IQfHMyZ6RRDEiGdD/Gwdfx4z2m72PCSyp8UCkBSNL3fU4nFlxK+Wa9bSRfAMM5MUqigtqu2Hbwngw5H9XBitPL2izlS+Vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=scH0UDg9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="scH0UDg9"
Received: from [10.7.58.6] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id CABD420B7167;
	Wed, 22 Jul 2026 02:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CABD420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784712532;
	bh=iqAPRhcc1h5MShLEAXRNpHsK0JmIybRW26xH8S34QTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=scH0UDg9JoMA+bK71N2e/DCQG4afBAx5dCr831VeJslldFRZMghfjnwi7PxZVLY0g
	 Xh+Qxilb0cvZeQZr+5MrjcY/1CpVCrqMIi/8NL/Uw6Yte+JKlYztvUbZwUawBDYQfB
	 sb+iYOw0IMdJfiond660K7kNVSKA9I617Zk6kOPE=
Message-ID: <12557e3a-5feb-4601-ad53-cf4846052edd@linux.microsoft.com>
Date: Wed, 22 Jul 2026 14:59:02 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/apic: Fix lost IRQ during forced vector migration
 on Hyper-V
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
References: <20260710054007.288807-1-namjain@linux.microsoft.com>
 <874ihskq1h.ffs@fw13>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <874ihskq1h.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/2026 2:40 AM, Thomas Gleixner wrote:
> On Fri, Jul 10 2026 at 05:40, Naman Jain wrote:
>>
>> Fixes: e84cf6aa501c5 ("x86/apic/vector: Handle vector release on CPU unplug correctly")
> 
> Errm. This does not fix anything in the common code. It fixes a hyperv
> PCI/MSI problem.
> >>   	} else {
>> +		/*
>> +		 * The outgoing CPU cannot use the deferred cleanup-vector
>> +		 * mechanism, so its vector is freed inline below. On Hyper-V the
>> +		 * MSI retarget hypercall is asynchronous, so an interrupt raised
>> +		 * inside the stop_machine window can be posted to the outgoing
>> +		 * CPU's old vIRR after the free. Two complementary steps handle
>> +		 * that (see also the retrigger at the end of the function):
>> +		 *
>> +		 *  - Retrigger on the new target so a raced completion is drained
>> +		 *    there rather than lost. The retarget is asynchronous, so the
>> +		 *    outgoing IRR is not authoritative and the IPI is issued
>> +		 *    unconditionally; a spurious ISR is harmless to
>> +		 *    completion-draining handlers (they find an empty queue).
>> +		 *  - Mark the freed slot VECTOR_RETRIGGERED so a late stray is
>> +		 *    absorbed by reevaluate_vector() instead of logging "No irq
>> +		 *    handler" while the CPU still takes interrupts during
>> +		 *    teardown; __setup_vector_irq() resets it on re-online.
>> +		 *
>> +		 * This mirrors msi_set_affinity()'s protection, which the Hyper-V
>> +		 * MSI chip bypasses via IRQCHIP_MOVE_DEFERRED.
> 
> What has msi_set_affinity() and IRQCHIP_MOVE_DEFERRED to do with this?
> 
>    - msi_set_affinity() solves a completely different problem. It handles
>      the case when the PCI/MSI device does not provide masking of the MSI
>      interrupt across the message change.
> 
>      Q: What exactly is mirrored here?
>      A: Nothing
> 
>    - In the context of CPU hot-unplug IRQCHIP_MOVE_DEFERRED is not
>      deferring anything simply because there is no way to do the deferred
>      (in interrupt context) move on the original target CPU.
> 
>      fixup_irqs()
>         irq_migrate_all_off_this_cpu()
>            migrate_one_irq()
>              irq_do_set_affinity()
> 
>      The only check there which is related to IRQCHIP_MOVE_DEFERRED is
>      the masking decision in migrate_one_irq(), but that has nothing to
>      do with the semantics of IRQCHIP_MOVE_DEFERRED.
> 
>      That flag tells the interrupt core that regular affinity changes
>      have to be delayed into the context of the next device interrupt,
>      which is obviously not possible for interrupt startup and forced
>      migration on CPU hot-unplug, which both ignore that restriction. The
>      only effect in CPU hot-unplug migrations is that the interrupt is
>      masked at the outermost domain level across the affinity change
>      operation because that's an requirement for msi_set_affinity() and
>      similar workarounds (loongarch) to avoid the multi vector dance.
> 
>      The fact that hyper-V invokes the retarget hypercall in context of
>      the unmask() callback has nothing to with that flag and due to the
>      lack of explanation why the flag is needed in the first place.
> 
> I'm all for commenting complex issues, but comments have to be
> technically correct, which excludes both LLM and human hallucinations.
> The same applies to the change log which carries the same fairy tale.
> 
> Aside of that, doing the re-targeting in the unmask() callback
> unconditionally is pointless overhead. Why?
> 
>      disable_irq($IRQ);             // Sets the disabled flag, but does not mask
> 
>      --> $IRQ is raised
>      handle_edge_irq($IRQ)
>      if (disabled($IRQ))
>        mask_irq($IRQ);              // Masks at the PCI/MSI level
> 
>      enable_irq($IRQ)
>      if (masked($IRQ))
>        unmask_irq($IRQ)
>          issue_hypercall(RETARGET)  // Pointless exercise when affinity
>                                     // has not changed
>          unmask_pci_msi();          // Unmasks at the PCI/MSI level
> 
> Not that I care at all, but I have no idea why pci-hyperv has to do the
> affinity change in the unmask() callback and why it needs to take the
> overhead which comes with the deferred affinity changes in general.
> 
>> +		 * restricted to edge MSI vectors on Hyper-V (msi_desc present):
>> +		 * only the MSI retarget hypercall is asynchronous, so edge IOAPIC
>> +		 * lines (retargeted synchronously via the RTE) and level-triggered
>> +		 * lines never see this race and must not be force-injected.
>> +		 */
>> +		if (hypervisor_is_type(X86_HYPER_MS_HYPERV) &&
>> +		    apicd->vector >= FIRST_EXTERNAL_VECTOR &&
>> +		    !irqd_is_level_type(irqd) && irq_data_get_msi_desc(irqd))
> 
> TBH. This is a tasteless layering violation. We are not cluttering
> common code with hypervisor specific MSI workarounds. The non-remapped
> MSI workaround is not implemented here either.
> 
>> +			hv_retrigger = true;
>>   		apic_free_vector(apicd->cpu, apicd->vector, managed);
>> +		/*
>> +		 * apic_free_vector() releases the matrix bit but leaves the
>> +		 * outgoing CPU's vector_irq[] slot pointing at the stale desc, so
>> +		 * the marker is written unconditionally here.
> 
> What's exactly unconditional about
> 
>         if (cond)
>            write()
> 
> ?
> 
>> +              						(Unlike
>> +		 * msi_set_affinity(), which marks a genuinely unused slot and
>> +		 * therefore guards with IS_ERR_OR_NULL, the slot here still holds
>> +		 * this irq's old desc.)
> 
> What has msi_set_affinity() to do with this? It sets RETRIGGER for a
> very different reason. These references are confusing at best. Simply
> explain WHY you need to do this and explain it correctly.
> 
>> +		 */
>> +		if (hv_retrigger)
>> +			per_cpu(vector_irq, apicd->cpu)[apicd->vector] = VECTOR_RETRIGGERED;
>>   	}
>>   
>>   setnew:
>> @@ -190,6 +231,13 @@ static void chip_data_update(struct irq_data *irqd, unsigned int newvec, unsigne
>>   	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
>>   	per_cpu(vector_irq, newcpu)[newvec] = desc;
>>   	apic_update_irq_cfg(irqd, newvec, newcpu);
>> +	/*
>> +	 * Drain any completion that raced onto the freed vIRR by retriggering
> 
> What's a freed vIRR and which completion? This code deals with vector
> management and not with hyperV MSI implementation specific completions
> and it does not care whether it operates on a physical or a virtual
> APIC.
> 
>> +	 * on the new target (see the else-branch above). Issued after the new
> 
> 'See the else-branch above' is as useful as 'See some random explanation
> elsewhere'. It's obvious where to look for that information as the
> hv_retrigger condition must be set by something to make the condition true.
> 
>> +	 * mapping is installed so the handler is present when it is serviced.
>> +	 */
>> +	if (hv_retrigger)
>> +		__apic_send_IPI(newcpu, newvec);
> 
> You are claiming above that the MSI retarget hypercall is asynchronous,
> but you fail to specify in which way.
> 
>    - If you refer to the retarget invocation in the unmask() callback,
>      then that happens still before the new target can handle it.
> 
>    - If it is truly asynchronous, i.e. the hypervisor handles it at some
>      arbitrary point in time, then the retriggered vector on the new
>      target CPU can be handled _before_ the retarget is in effect. In
>      that case a subsequent interrupt might still end up on the dead CPU,
>      no?
> 
> IOW, your or your LLM's elaborate comment is useless word salad as it
> does not explain the problem in a coherent and comprehensible way. Quite
> to the contrary it is more confusing than helpful.
> 
> But as I told you already, this is not a problem of incoherent comments,
> this is simply the wrong place to address that.
> 
> Looking at the pci-hyperv implementation made me immediately notice a
> bug, which exists since the driver was merged:
> 
>    The driver does not set the irq_retrigger() callback for the
>    interrupt chip.
> 
> That means that fixup_irqs() can't do anything even when it observes the
> IRR bit set. And that matches the incoherent problem description as far
> as I can tell from trying to oracle something out of the word salad.
> 
> Great that your AI ass-istant did not figure that out and you blindly
> trusted the nonsense it hallucinated.
> 
> The uncompiled and therefore untested below should exactly do what you
> want to achieve without having hyperV specific hackery in the common
> code.
> 
> If it does not, then you need to provide a coherent technical
> explanation why it is not sufficient.
> 
> Thanks,
> 
>          tglx
> 
> ---


Thanks a lot for reviewing the code. I was actually debugging hangs and 
timeouts when we test stress-FIO with hotplug. Occasionally I saw "No 
irq handler" logs in those hangs, and started debugging in that 
direction. I had tried adding the hyper-V irq_retrigger() callback, but 
the hang still reproduced. This kept me under the impression that this 
change did not fix the issue and led me to over-engineer this fix in the 
wrong place. Recently, I was able to root cause the hang to some other 
reason (using different NVME scheduler).

I completely agree with your comments, and now that I know how to fix 
this, do you suggest me to -

1. add irq_retrigger callback in pci-hyperv.c
or
2. go with your fixup-irq() change to no longer need drivers to add the 
above? And then see what all stale irq_retrigger inits can be removed

Going with 1) would be easier for me to fix this bug, and back port it 
to older kernels, with proper Fixes tag (pointing to some pci-hyperv.c 
change).
Then later, we can go with 2) separately as a general enhancement (not a 
Fix).

Regards,
Naman

> Subject: TBD
> 
>    Instead of adding the missing callback to the hyperv driver, which
>    would be the trivial "fix", it changes the x86 fixup_irqs()
>    implementation. Why?
> 
>    That makes the code more resilient and allows to remove quite a bit of
>    initializations of interrupt chips all over the place.
> 
> Not-Signed-off-yet-by: Thomas Gleixner <tglx@kernel.org>
> Assisted-by: Human Intelligence
> ---
>   arch/x86/kernel/irq.c |   23 +++++++----------------
>   1 file changed, 7 insertions(+), 16 deletions(-)
> 
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -466,11 +466,6 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi
>   /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
>   void fixup_irqs(void)
>   {
> -	unsigned int vector;
> -	struct irq_desc *desc;
> -	struct irq_data *data;
> -	struct irq_chip *chip;
> -
>   	irq_migrate_all_off_this_cpu();
>   
>   	/*
> @@ -489,22 +484,18 @@ void fixup_irqs(void)
>   	 * vector_lock because the cpu is already marked !online, so
>   	 * nothing else will touch it.
>   	 */
> -	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> -		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
> +	for (unsigned int vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> +		struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
> +
> +		if (IS_ERR_OR_NULL(desc))
>   			continue;
>   
>   		if (is_vector_pending(vector)) {
> -			desc = __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> -			data = irq_desc_get_irq_data(desc);
> -			chip = irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			guard(raw_spinlock)(&desc->lock);
> +			if (irq_chip_retrigger_hierarchy(&desc->irq_data))
>   				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>   		}
> +
>   		if (__this_cpu_read(vector_irq[vector]) != VECTOR_RETRIGGERED)
>   			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
>   	}

