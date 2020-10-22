Return-Path: <SRS0=ONDh=D5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991C3C388F9
	for <linux-hyperv@archiver.kernel.org>; Thu, 22 Oct 2020 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2768E24641
	for <linux-hyperv@archiver.kernel.org>; Thu, 22 Oct 2020 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KdmmgfEM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3e4TbHeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372731AbgJVWKi (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 22 Oct 2020 18:10:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49994 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370028AbgJVWKh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Oct 2020 18:10:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603404635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MvN0PZcC1LUdr+xhWQX/PywlAVCnw/qFd8HerpuaJjU=;
        b=KdmmgfEMYQPX3gnHsmGI0RFxcGG45vVDNq6dm1XXwwyYp05viid6K68JmwV3LO7dzeFezv
        ZWyF7Ge+U9J+rK4GEcd0tFwYleqEJhBzfzC74riy16r0Bu3gZj0bYf2n5E1YjrFFb873r6
        GnrVJ2KkD5QXzZ6X/G8bs9q0Nz1vE7imO/Ss09B8fdwL1UXCqu/T7sSCezoiCi4lUtM8d5
        K0XHP2fXnFrV0Pmhoa1oS4GglSzbqPCk2Hao2nI539QPDnTN9wO+iYxmxXFXLKdIGJcQ7Y
        +5UG0gBvoydbyiERX9Sh0DoQDJvZ2fPC4FScIjAU+fD7BA2I17SJ636bUTDeqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603404635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MvN0PZcC1LUdr+xhWQX/PywlAVCnw/qFd8HerpuaJjU=;
        b=3e4TbHegA5nWCISA9Baz7hJnQ+ZqGUL6K/dux7vuU/UBKa2eizznt8BtrgtCGwcHneSjMA
        PRF6BfgQjtaihxDQ==
To:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Cc:     kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 8/8] x86/ioapic: Generate RTE directly from parent irqchip's MSI message
In-Reply-To: <87y2jy542v.fsf@nanos.tec.linutronix.de>
References: <87y2jy542v.fsf@nanos.tec.linutronix.de>
Date:   Fri, 23 Oct 2020 00:10:35 +0200
Message-ID: <87sga56hes.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 22 2020 at 23:43, Thomas Gleixner wrote:
> On Fri, Oct 09 2020 at 11:46, David Woodhouse wrote:
> Aside of that it works magically because polarity,trigger and mask bit
> have been set up before. But of course a comment about this is
> completely overrated.

Also this part:

> -static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
> -			   struct IO_APIC_route_entry *entry)
> +static void mp_setup_entry(struct irq_data *irq_data, struct mp_chip_data *data)
>  {
> +	struct IO_APIC_route_entry *entry = &data->entry;
> +
>  	memset(entry, 0, sizeof(*entry));
> -	entry->delivery_mode = apic->irq_delivery_mode;
> -	entry->dest_mode     = apic->irq_dest_mode;
> -	entry->dest	     = cfg->dest_apicid & 0xff;
> -	entry->virt_ext_dest = cfg->dest_apicid >> 8;
> -	entry->vector	     = cfg->vector;
> +
> +	mp_swizzle_msi_dest_bits(irq_data, entry);
> +
>  	entry->trigger	     = data->trigger;
>  	entry->polarity	     = data->polarity;
>  	/*

does not make sense. It did not make sense before either, but now it
does even make less sense.

During allocation this only needs to setup the I/O-APIC specific bits
(trigger, polarity, mask). The rest is filled in when the actual
activation happens. Nothing writes that entry _before_ activation.

/me goes to mop up more

