Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EB04BE45C
	for <linux-hyperv@vger.kernel.org>; Fri, 11 Sep 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150758; cv=none; b=GIuGsmXKIy3nNHC8PD9JLWcyQyGQqyvuPAyLW8JzfHDyWBNzW2E2y21vAO3rHMHWKIlGKRf//rU4TVlL/MhrgvqvDj2AkUqRD6GEZGfqjCzTxlb7SInUoXTqwu7ecOJUH4xS9cvXhy8iidK8OvXktiPCNkrTTXprKVSoxgazvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150758; c=relaxed/simple;
	bh=qwTfp3jd7ytFD9SocdNVwN01warOuILP9XtdpPcabtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvG81YFEW8dH9EbEv4wZl7Tuug3v8DCpixdFmegL9PYpYOPibxwxabQDo9B6sqKNLJV+PJLzUuCutflaDCjjfb+XQ+XwyZLvOq7GMsFY2hYas5dFJFdSj7xJ+1/XvkysVDvWnw8LNwqZD89JBVeoUU7/HF7M7vRs19baCBeViiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MpZ8855u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MpZ8855u"
Received: from [100.64.96.235] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B6B620B716A;
	Fri, 11 Sep 2026 11:18:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B6B620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789150709;
	bh=x7zl/xb3yO3wlHvQRT0aPOPUd0h/k8si8L1O/hsq2OI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MpZ8855usAsTi2EFU38AiQWDzq/egocVt3rnnlgIj5CKrAk0b41xQYjaSNzjyKIje
	 QEdMpEg7xmebIx0dS4W/tf52Jp9zrksrj+bezw6fRww7inaoiE2caMX3SGngBBzkpg
	 QOBzzAwe9tSVe6Q+cAEX3/y6KWr0pgY+yyA9IEtk=
Message-ID: <598411fa-364c-49d1-aa67-cdfe5ce8c775@linux.microsoft.com>
Date: Fri, 11 Sep 2026 11:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_vtl: Check per-CPU register page before mmap
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
 <20260911180509.8A5981F000FF@smtp.kernel.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20260911180509.8A5981F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/11/2026 11:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Returning VM_FAULT_NOPAGE for invalid memory offsets without installing a PTE causes an unkillable infinite page fault loop.
> - [High] Per-CPU memory allocated for `run` and `reg_page` is leaked on driver module unload and upon CPU hotplug setup failures.
> - [High] Premature character device registration allows userspace to trigger page faults and ioctls before per-CPU data is initialized, bypassing the newly added `if (!page)` check and causing kernel panics or UAF.
> --

All the reported issues are pre-existing and not related to this patch.
I will review the issues and fix them in a separate patch.

> commit 33a60782bd60657bd70b537be47acdb4ffe78f38
> Author: Hardik Garg <hargar@linux.microsoft.com>
>
> mshv_vtl: Check per-CPU register page before mmap
>
> Register-page setup is optional for each CPU. If allocation or
> registration fails, mshv_vtl_configure_reg_page() warns and leaves that
> CPU's reg_page NULL, but initial context setup continues successfully.
> Meanwhile, successful setup on another CPU sets the global
> mshv_has_reg_page flag.
>
> mshv_vtl_fault() checks this global flag before selecting the requested
> CPU's register page. With mixed setup results across online CPUs, the
> check passes even for a CPU with no register page, reaching
> get_page(NULL) when userspace faults in that mapping.
>
> Check the selected per-CPU register page before taking its reference and
> return VM_FAULT_SIGBUS if it is absent.
>
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index 6e3c11c681717..d8225242c73f8 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -819,6 +819,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>>  		return VM_FAULT_NOPAGE;
>>  	}
> [Severity: High]
> This isn't a bug introduced by this patch, but returning VM_FAULT_NOPAGE
> for an invalid memory offset without installing a PTE causes an unkillable
> infinite page fault loop.
>
> If a userspace process maps the /dev/mshv device and accesses an invalid page
> offset (neither MSHV_RUN_PAGE_OFFSET nor MSHV_REG_PAGE_OFFSET), this else
> branch is taken. Returning VM_FAULT_NOPAGE signals to the core MM subsystem
> that the fault handler successfully installed the page table entry, so the
> kernel returns to userspace without doing anything. Since no PTE was actually
> installed, the CPU will immediately re-fault on the same instruction, creating
> a 100% CPU hung task.
>
> Could we return VM_FAULT_SIGBUS here instead?
>
>>  
>> +	if (!page)
>> +		return VM_FAULT_SIGBUS;
> [Severity: High]
> This is a pre-existing issue, but premature character device registration
> allows userspace to bypass this newly added check.
>
> In mshv_vtl_init(), the character device is exposed to userspace early:
>
> mshv_vtl_init() {
>     ...
>     ret = misc_register(&mshv_dev);
>     ...
> }
>
> If a userspace process races the module initialization by opening /dev/mshv
> and mapping it before hv_vtl_setup_synic() allocates the per-CPU run page,
> mshv_vtl_cpu_run(cpu) will return NULL.
>
> When this happens, virt_to_page(NULL) is called:
>
> mshv_vtl_fault() {
>     ...
>     if (real_off == MSHV_RUN_PAGE_OFFSET) {
>         page = virt_to_page(mshv_vtl_cpu_run(cpu));
>     ...
> }
>
> This produces a garbage non-NULL pointer, causing the new if (!page) check
> to pass, and the subsequent get_page() will dereference the garbage pointer
> and panic.
>
> If initialization subsequently fails, the module load aborts and .text is
> freed while the racing userspace process retains an open file descriptor,
> leading to a use-after-free.
>
> Could the device registration be deferred until after the per-CPU data is
> initialized?
>
>> +
>>  	get_page(page);
>>  	vmf->page = page;
>>  
> [Severity: High]
> This is a pre-existing issue, but does this code leak the per-CPU pages
> allocated for run and reg_page on driver module unload and upon CPU hotplug
> setup failures?
>
> When setting up the hotplug state, the teardown callback is set to NULL:
>
> hv_vtl_setup_synic() {
>     ...
>     ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
>                             mshv_vtl_alloc_context, NULL);
>     ...
> }
>
> When the module unloads, cpuhp_remove_state() is called, but without a
> teardown callback, the memory permanently allocated via __get_free_page()
> in mshv_vtl_alloc_context() is leaked:
>
> mshv_vtl_alloc_context() {
>     ...
>     per_cpu->run = (struct mshv_vtl_run *)
>         __get_free_page(GFP_KERNEL | __GFP_ZERO);
>     ...
> }
>
> Additionally, if the hotplug state setup fails midway, the successfully
> processed CPUs will not be cleaned up.
>
> Could a teardown callback be provided to free these pages?
>
