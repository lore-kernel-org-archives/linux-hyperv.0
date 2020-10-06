Return-Path: <SRS0=rgq9=DN=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC1FC4363D
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C7E208B8
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQTOLm0L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVX4OPAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgJFVya (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 6 Oct 2020 17:54:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFVya (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Oct 2020 17:54:30 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602021268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSV1PANxT6SrZlsLhulgWDYB2UZuXJN9hmUsQEh/jgs=;
        b=UQTOLm0LdgcJlPz5Yzogz4fAopCcBsc7DkCa7/Jli0I32RaoPhX6OdTyO6AUDxwUDbpJXm
        ToeIwnaB/hlU3SuusiQEKujeKm81OVk0vp7o6iw5W6lzYGZsjv0zJFngqSa1w4BJ2DFB32
        9twqKj+bA6Hyx2+bF3V6jqPY6S4MqqS2+SNOyPS3BHPWT8C82Rujr25+4qhSKPKvaqyXsO
        Y0JCRJErsQHBYdOc6fxUO7IiLTDr4B3Te/TJ+6imvMKDZFKeY7v0WelJvZg3T71IZYhFVv
        awwC9oM3CaOCnFmFdsDY9cOKPuXGRYzRTz0ZUZI3Ck0MhSbOEYDmExdSlALB/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602021268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSV1PANxT6SrZlsLhulgWDYB2UZuXJN9hmUsQEh/jgs=;
        b=NVX4OPALrRRIxfxSJrlfPj8FJqm0A1+Ls915mDPtnJu7rah0BhfqTAausT0TyQ4qculSHV
        hV/8c76CZGch6CDQ==
To:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity without IR
In-Reply-To: <20201005152856.974112-10-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org> <20201005152856.974112-1-dwmw2@infradead.org> <20201005152856.974112-10-dwmw2@infradead.org>
Date:   Tue, 06 Oct 2020 23:54:27 +0200
Message-ID: <87d01v58bw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
>
> When interrupt remapping isn't enabled, only the first 255 CPUs can

No, only CPUs with an APICid < 255 ....

> receive external interrupts. Set the appropriate max affinity for
> the IOAPIC and MSI IRQ domains accordingly.
>
> This also fixes the case where interrupt remapping is enabled but some
> devices are not within the scope of any active IOMMU.

What? If this fixes an pre-existing problem then

      1) Explain the problem proper
      2) Have a patch at the beginning of the series which fixes it
         independently of this pile

If it's fixing a problem in your pile, then you got the ordering wrong.

You didn't start kernel programming as of yesterday, so you really know
how that works.

>  	ip->irqdomain->parent = parent;
> +	if (parent == x86_vector_domain)
> +		irq_domain_set_affinity(ip->irqdomain, &x86_non_ir_cpumask);

OMG

>  	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
>  	    cfg->type == IOAPIC_DOMAIN_STRICT)
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 4d891967bea4..af5ce5c4da02 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -259,6 +259,7 @@ struct irq_domain * __init native_create_pci_msi_domain(void)
>  		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
>  	} else {
>  		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
> +		irq_domain_set_affinity(d, &x86_non_ir_cpumask);

So here it's unconditional

>  	}
>  	return d;
>  }
> @@ -479,6 +480,8 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
>  		irq_domain_free_fwnode(fn);
>  		kfree(domain_info);
>  	}
> +	if (parent == x86_vector_domain)
> +		irq_domain_set_affinity(d, &x86_non_ir_cpumask);

And here we need a condition again. Completely obvious and reviewable - NOT.

Thanks,

        tglx
