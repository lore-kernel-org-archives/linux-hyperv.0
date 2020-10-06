Return-Path: <SRS0=rgq9=DN=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9E6C4363D
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75D220897
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Oct 2020 21:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CEmAhOFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N04vQuma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgJFVBV (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 6 Oct 2020 17:01:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgJFVBU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Oct 2020 17:01:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602018079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMHwtHkLw4HDoWmj5/QQIiyML9PtpWcAcXgOvT1HlN0=;
        b=CEmAhOFFqnUC32Z5WehKP0GW4jN+RtJUMYTyVfIqtEI2/sHAehg7OwomgSlyRdxR/pexp/
        zwOXgOLtNxzRHInyP81D6ht8z7ODAZQpJPKqkuyD8S+/mUeflkBEzGkncj3Sj6ErfW9aAD
        KTP+/V3+9A8R7bq7H/4zWpk0E1fOwGeuM6wCxP9OhNvRKVlfkQf9+K4H4+nXRulpwKBQX8
        1Gzj53dEq+e9HS1sxsbUuAYgxNNodmmTZAEdvLVMX72+BMzHYsFif3DN2BAmPZ8E1FDfLn
        IKY92Qz2a0zovWcxC9AYAQCzjB5T+8uSDYhqDIdSsxvY9WR/t54F2E4KN6uwYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602018079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMHwtHkLw4HDoWmj5/QQIiyML9PtpWcAcXgOvT1HlN0=;
        b=N04vQumazGWWXo/ctuk1rRy6XCnawiqTBr4RAbWVsrEjOSp6dE6ewjP71Wdl+DjiDKjmA6
        YXD1v1lHU+LlO2BA==
To:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/13] genirq: Prepare for default affinity to be passed to __irq_alloc_descs()
In-Reply-To: <20201005152856.974112-5-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org> <20201005152856.974112-1-dwmw2@infradead.org> <20201005152856.974112-5-dwmw2@infradead.org>
Date:   Tue, 06 Oct 2020 23:01:18 +0200
Message-ID: <87r1qb5ash.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
>  
>  #else /* CONFIG_SMP */
>  
> +#define irq_default_affinity (NULL)

...

>  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
>  		       const struct irq_affinity_desc *affinity,
> +		       const struct cpumask *default_affinity,
>  		       struct module *owner)
>  {
>  	struct irq_desc *desc;
>  	int i;
>  
>  	/* Validate affinity mask(s) */
> +	if (!default_affinity || cpumask_empty(default_affinity))
> +		return -EINVAL;

How is that supposed to work on UP?

Aside of that I really hate to have yet another argument just
because.

Thanks,

        tglx
