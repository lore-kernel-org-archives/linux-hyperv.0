Return-Path: <SRS0=abFz=EE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4281DC2D0A3
	for <linux-hyperv@archiver.kernel.org>; Thu, 29 Oct 2020 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7F121534
	for <linux-hyperv@archiver.kernel.org>; Thu, 29 Oct 2020 16:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FkT5gzj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PgpLqCB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgJ2Qxm (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:53:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJ2QwZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Oct 2020 12:52:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603990343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=BwThNbQsIy31JmqgarQ4wUhEb+UzdV725F922IlA/F4=;
        b=2FkT5gzjoyr+ccyJHCtb4QbofbUucrdb26XfUpdE+rdknukTxAg72GjxOZ5n41jAnKkYB/
        nOpJkfACWzeDMF9Gf28Vi+9nUZMt6JCdJF214EEVoZ1yZcMxqCTQCc46rL/vBXNOjbaYLf
        f+eXkQpHbUsq3GQII9gW2a6gC/yzaVGRhIDCe7QC8qE2NXhN+gqydOhJhoyJkPdfEZ6A3H
        521AeFSdgq1ad66a8zBLLVOR40MhLsMZO/mD5DBZk0Zoq9X1/sGoa8LUpdsu3PsEqtSaUm
        fd5d4g1zK5WhugYvwd0KaIDhMulezjPfh4Q5hU2OhBCUeaAlgqLTDOppSiEmsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603990343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=BwThNbQsIy31JmqgarQ4wUhEb+UzdV725F922IlA/F4=;
        b=PgpLqCB/8RWNfhP0PSdbieEqqU4kgNwBJgx4lowNSAaj/HnR/wMahgJJLuQXXytVePuRe9
        Nfyl8b5dIoAH1xCQ==
To:     Arnd Bergmann <arnd@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-hyperv@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list\:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
In-Reply-To: <CAK8P3a0e0YAkh_9S1ZG5FW3QozZnp1CwXUfWx9VHWkY=h+FVxw@mail.gmail.com>
Date:   Thu, 29 Oct 2020 17:52:22 +0100
Message-ID: <871rhhotyx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Arnd,

On Thu, Oct 29 2020 at 10:51, Arnd Bergmann wrote:
> On Thu, Oct 29, 2020 at 8:04 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 28/10/20 22:20, Arnd Bergmann wrote:
>> > Avoid this by renaming the global 'apic' variable to the more descriptive
>> > 'x86_system_apic'. It was originally called 'genapic', but both that
>> > and the current 'apic' seem to be a little overly generic for a global
>> > variable.
>>
>> The 'apic' affects only the current CPU, so one of 'x86_local_apic',
>> 'x86_lapic' or 'x86_apic' is probably preferrable.
>
> Ok, I'll change it to x86_local_apic then, unless someone else has
> a preference between them.

x86_local_apic is fine with me.

> I think ideally there would be no global variable, withall accesses
> encapsulated in function calls, possibly using static_call() optimizations
> if any of them are performance critical.

There are a bunch, yes.

> It doesn't seem hard to do, but I'd rather leave that change to
> an x86 person ;-)

It's not hard, but I'm not really sure whether it buys much.

Can you please redo that against tip x86/apic. Much of what you are
touching got a major overhaul.

Thanks,

        tglx
