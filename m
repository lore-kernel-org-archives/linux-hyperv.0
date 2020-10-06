Return-Path: <SRS0=rgq9=DN=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3479FC4363D
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D1B208B6
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPhWVA2K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IqDnbIx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgJFVm2 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 6 Oct 2020 17:42:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFVm2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Oct 2020 17:42:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602020546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgwoBb+lMGeaN4dDMd5GpX1k8Re+bWv1lEsLT0KLZAc=;
        b=hPhWVA2KVPIs9qDac9R5H4bbdRmwKGUdGzRraTnqzLrJT8MbsdOVjVSpONVw6Fn/LmmNQ8
        TUNY/MeF3zyGRIkYroto5fyqDCae0+zaV1czvzOfOqk0Aof9y66pWQ8l7owwfCl2WweH5w
        X89GJ94rcCo5+dgcyjYhmXDWjl4Lh2aDb6tIQLMKuY8XSaxYlgI974yrz+AMApJg3smkkm
        y6KhEZvsU1yYbxeBs5Jlx18TmvHuT0qjniIe0m9bNO6tFxj6bDhrNpADK6j5Y0sCcQ/42V
        LCu7oec5y/zwAyxh+JvVir3yZNh38tVCLi8enrqfRjwIgYkPq8cccq5SQ0VKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602020546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgwoBb+lMGeaN4dDMd5GpX1k8Re+bWv1lEsLT0KLZAc=;
        b=IqDnbIx3Xxv/d+jdD48Dhpe7Gre9PdfZJ1v46I0jDRxCHZ9PfR4IfuHw1mGi9yHBO5GB60
        Nx5+QyZZa24/HzCQ==
To:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/13] x86/irq: Add x86_non_ir_cpumask
In-Reply-To: <20201005152856.974112-9-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org> <20201005152856.974112-1-dwmw2@infradead.org> <20201005152856.974112-9-dwmw2@infradead.org>
Date:   Tue, 06 Oct 2020 23:42:25 +0200
Message-ID: <87ft6r58vy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> This is the mask of CPUs to which IRQs can be delivered without interrupt
> remapping.
>  
> +/* Mask of CPUs which can be targeted by non-remapped interrupts. */
> +cpumask_t x86_non_ir_cpumask = { CPU_BITS_ALL };

What?

>  #ifdef CONFIG_X86_32
>  
>  /*
> @@ -1838,6 +1841,7 @@ static __init void x2apic_enable(void)
>  static __init void try_to_enable_x2apic(int remap_mode)
>  {
>  	u32 apic_limit = 0;
> +	int i;
>  
>  	if (x2apic_state == X2APIC_DISABLED)
>  		return;
> @@ -1880,6 +1884,14 @@ static __init void try_to_enable_x2apic(int remap_mode)
>  	if (apic_limit)
>  		x2apic_set_max_apicid(apic_limit);
>  
> +	/* Build the affinity mask for interrupts that can't be remapped. */
> +	cpumask_clear(&x86_non_ir_cpumask);
> +	i = min_t(unsigned int, num_possible_cpus() - 1, apic_limit);
> +	for ( ; i >= 0; i--) {
> +		if (cpu_physical_id(i) <= apic_limit)
> +			cpumask_set_cpu(i, &x86_non_ir_cpumask);
> +	}

Blink. If the APIC id is not linear with the cpu numbers then this
results in a reduced addressable set of CPUs. WHY?

> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index aa9a3b54a96c..4d0ef46fedb9 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2098,6 +2098,8 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
>  		struct irq_alloc_info info;
>  
>  		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
> +		if (domain->parent == x86_vector_domain)
> +			info.mask = &x86_non_ir_cpumask;

We are not going to sprinkle such domain checks all over the
place. Again, the mask is a property of the interrupt domain.

Thanks,

        tglx
