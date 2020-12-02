Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325FAC71155
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Dec 2020 09:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D892C2222A
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Dec 2020 09:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbgLBJ5G (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 2 Dec 2020 04:57:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388462AbgLBJ5G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:57:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606902984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ITThREJyYKgdVDP8BrxeZZquiJpUQMhRfu4ZTflB4TU=;
        b=X3QAAs3ckISUUWG4JJlFph2NnRIwNeaLE3wK3ajpyTpKBnjYav53rMdiurQ4jGCRO/ygKG
        6jWHI2XX4+cQh/csusD6wphm4zlZXxFsgI8aGpjw/0KVbgWRxwkVBFMfNzZB3Du79Hhefk
        2xns0YmYm0KsJkHpJZDjYU4tPACPgBry7LF143jLh3WI6EjUcHRHXorOR6pLHPuE/TYWYQ
        OV8mh49Qw1BydybEM8hH/8Zd60WQVPnleuUX4LUVjq2jwGKQlPH+mTe3u7bo4YaZGVvWoP
        tWO1NQSdvtEl4b+wGxxJzc7oMfQSuhvy4hHxWC54vr8ISzzicscbvbnoYupQVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606902984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ITThREJyYKgdVDP8BrxeZZquiJpUQMhRfu4ZTflB4TU=;
        b=b9neEEERJjd556NoK2GzpE5+E8u4vImeIIA5ZyL6Bc2eNU2YeQvdgCzUZa2tWdMJsRKvgt
        3EJixrTbLSI2NJCg==
To:     Dexuan Cui <decui@microsoft.com>, dwmw@amazon.co.uk,
        x86@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] iommu/hyper-v: Fix panic on a host without the 15-bit APIC ID support
In-Reply-To: <20201202004510.1818-1-decui@microsoft.com>
References: <20201202004510.1818-1-decui@microsoft.com>
Date:   Wed, 02 Dec 2020 10:56:23 +0100
Message-ID: <87wny0edko.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 01 2020 at 16:45, Dexuan Cui wrote:
> The commit f36a74b9345a itself is good, but it causes a panic in a
> Linux VM that runs on a Hyper-V host that doesn't have the 15-bit
> Extended APIC ID support:
>     kernel BUG at arch/x86/kernel/apic/io_apic.c:2408!

This has nothing to do with the 15bit APIC ID support, really.

The point is that the select() function only matches when I/O APIC ID is
0, which is not guaranteed. That's independent of the 15bit extended
APIC ID feature. But the I/O-APIC ID is irrelevant on hyperv because
there is only one.

> This happens because the Hyper-V ioapic_ir_domain (which is defined in
> drivers/iommu/hyperv-iommu.c) can not be found. Fix the panic by
> properly claiming the only I/O APIC emulated by Hyper-V.

We don't fix a panic. We fix a bug in the code :)

I'll amend the changelog.

Thanks,

        tglx
