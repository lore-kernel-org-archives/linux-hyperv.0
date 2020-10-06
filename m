Return-Path: <SRS0=rgq9=DN=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3ACC4363D
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0017208B6
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2+AYqpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZMJwnHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgJFVcH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 6 Oct 2020 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgJFVcH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Oct 2020 17:32:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE7C061755;
        Tue,  6 Oct 2020 14:32:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602019925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAllStXUlg+AiDlHucG15WJGldjEYpu7ef3AjJW7I7g=;
        b=P2+AYqpzchLK62fKUQ80gjgTsbtfUS4zuhN8OtrqKS5LsYSssUAEmPRzflu1xgrPE0dMdJ
        ZV/aISe4wuEFK1dQiRQEq7SFXLY6uiBTBV7y48PFmmIPclv/Y/wghICFjVAJ10uwyZHUWM
        HwYQkGvdQioNgj6GeOvK0zp2lqtL/e/cTxOqZZKCi94GRGwItmCcau6a4mmrLNBvgW2Sp9
        kN8mcDb7FUw/cHr0jswrovOlND7c2oyxePD6DklpaY43FYWTqbMl05tAs5+AtTcf+mTtGH
        lJSvJB4TP2xiIGL+U7pmP5Y+e6KxAAILWh/wZiHSm3vGZK42NJBfKtw2uk48HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602019925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAllStXUlg+AiDlHucG15WJGldjEYpu7ef3AjJW7I7g=;
        b=cZMJwnHd6tWgvwvZzxj4qBKC3MBLENnkZFUQuzgd9e7eFik0v56WN+Pdg8+u/ua4Q4EE2N
        Ewghf2L76ZjpveBQ==
To:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/13] genirq: Add irq_domain_set_affinity()
In-Reply-To: <20201005152856.974112-8-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org> <20201005152856.974112-1-dwmw2@infradead.org> <20201005152856.974112-8-dwmw2@infradead.org>
Date:   Tue, 06 Oct 2020 23:32:05 +0200
Message-ID: <87imbn59d6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
> +/**
> + * irq_domain_set_affinity - Set maximum CPU affinity for domain
> + * @parent:	Domain to set affinity for
> + * @affinity:	Pointer to cpumask, consumed by domain
> + *
> + * Sets the maximal set of CPUs to which interrupts in this domain may
> + * be delivered. Must only be called after creation, before any interrupts
> + * have been in the domain.
> + *
> + * This function retains a pointer to the cpumask which is passed in.
> + */
> +int irq_domain_set_affinity(struct irq_domain *domain,
> +			    const struct cpumask *affinity)
> +{
> +	if (cpumask_empty(affinity))
> +		return -EINVAL;
> +	domain->max_affinity = affinity;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_domain_set_affinity);

What the heck? Why does this need a setter function which is exported?
So that random driver writers can fiddle with it?

The affinity mask restriction of an irq domain is already known when the
domain is created.

Thanks,

        tglx
