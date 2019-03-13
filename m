Return-Path: <SRS0=yslr=RQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AECC10F03
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD532171F
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 14:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCMOXK (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:23:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMOXK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Mar 2019 10:23:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1so2214774wrs.8
        for <linux-hyperv@vger.kernel.org>; Wed, 13 Mar 2019 07:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JhxrnjEHkuyKpKcbEYaXIjWSELRlFJwUywf4gz8eEUk=;
        b=laI81cXu1lU5rJsT73DI3YVRSqTRknd/bc0NfAaGuro5wlkfaVDDgMWAPTXMv6IO92
         oOpPHqGz8Lcsu4WcmFNukQg6NCG4qD9bFOn1TGPpLXO4Z3REcODUgQs3HUhLg/yHGGVS
         MENu53/J2WYlCoW45dgALSjdOkxOJ6DZK7YvG27CAVj9xrceFBX4ibQL4N3U7+woIk2t
         Mkfw61OhCJtvSeIX7mYzkw78psSxGKhMQ8XLfvQwIFTzxeD54ucO/ABlMiV5SSZv4PuI
         8F+KTPigX58vUYY8hd55o0ACEx9uhkbZfMjWavNpkzYxCsAVlvGR4+qFXk3J5BtKHFo1
         fVqA==
X-Gm-Message-State: APjAAAWW/hIvy3GUNw9BTb3sA2rTHzplah00Ftv+qLwkXUpPXODtbQCc
        ffAPv2ZgA1AUeJGKJG8i/3C8WA==
X-Google-Smtp-Source: APXvYqwTXsmRHHxQw6VZ5anozxEeTAS9ZmnJC+VyIV7EQSB8zaO7m2tpDoeY/K1T8e/s77uvTf3Rvg==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr1672580wrn.275.1552486987828;
        Wed, 13 Mar 2019 07:23:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g2sm9185637wrh.7.2019.03.13.07.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:23:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "catalin.marinas\@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "will.deacon\@arm.com" <will.deacon@arm.com>,
        "marc.zyngier\@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "apw\@canonical.com" <apw@canonical.com>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: Move Hyper-V clockevents code to new clocksource driver
In-Reply-To: <DM5PR2101MB091897108980449F12FDDB3DD74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com> <1552426813-9568-2-git-send-email-mikelley@microsoft.com> <874l87tbz2.fsf@vitty.brq.redhat.com> <DM5PR2101MB091897108980449F12FDDB3DD74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Date:   Wed, 13 Mar 2019 15:23:05 +0100
Message-ID: <87pnqusvjq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, March 13, 2019 1:28 AM
>> 
>> > Clockevents code for Hyper-V synthetic timers is currently mixed
>> > in with other Hyper-V code. Move the code to a Hyper-V specific
>> > driver in the "clocksource" directory. Update the VMbus driver
>> > to call initialization and cleanup routines since the Hyper-V
>> > synthetic timers are not independently enumerated in ACPI.
>> >
>> 
>> I like the idea! Would it also make sense to consider moving Hyper-V
>> clocksource from arch/x86/hyperv/hv_init.c? The thing is that we use it
>> from arch-independent code (e.g. seee 'hyperv_cs' usage in
>> drivers/hv/hv_util.c).
>
> That's what the second patch in the series does. :-)  But let me
> know if there's something you think I've missed.
>

Oh, sorry, it's just me - your subject lines messed with my brain :-) I
like your idea even more then!

>> 
>> Nitpicking:
>> 
>> This has nothing to do with your patch but we have a mix of 'stimer',
>> 'timer', 'syntimer' names when we refer to Hyper-V Synthetic timers, it
>> may make sense to try to converge on something (stimer would probably be
>> my personal preference but I don't really care as long as we use the
>> same abbreviation). Examples:
>> 
>> hv_init_timer_config(...)
>> HV_MSR_SYNTIMER_AVAILABLE
>> HYPERV_STIMER0_VECTOR
>> hv_syntimer_init(...)
>> ...
>
> Yes, you are right about the mish-mash of names.  I also like converging
> on "stimer".  I'll certainly change things like hv_syntimer_init() to
> hv_stimer_init() as part of the patch and avoid making the problem
> worse.
>
> What about the name of the new .c and .h files?  They include code
> both the stimer-based clockevents, as well as the Hyper-V
> reference time source based clocksource.  Stay with "syntimer" or
> shorten to "stimer", even though the code is slightly broader than
> just the stimers?  (which highlights the generic Linux naming issue that
> "clocksource drivers" include code for both clockevents and
> clocksources)

"hyperv_timers.*" maybe? (those who read TLFS may get confused because
'Synthetic timers' doesn't refer to clocksources - just to clockevents).

>
>> 
>> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> > index be6e0fb..a887955 100644
>> > --- a/drivers/clocksource/Makefile
>> > +++ b/drivers/clocksource/Makefile
>> > @@ -83,3 +83,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>> >  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>> >  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>> >  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>> > +obj-$(CONFIG_HYPERV)			+= hyperv_syntimer.o
>> 
>> (just a couple of spare thoughs)
>> 
>> CONFIG_HYPERV can also be a module, are we OK with that? (we'll have to
>> support module loading/unloading then and honestly I see no reason for
>> that. I would prefer everything but VMBus devices to be in
>> kernel.) If we don't want it to be a module we can create a hidden
>> CONFIG_HYPERV_STIMER or something like that - just like we already do
>> for CONFIG_HYPERV_TSCPAGE.
>> 
>> There is, however, one additional dependency here: when running in
>> non-direct mode, Hyper-V clockevent devices require functional Hyper-V
>> messaging - which currently lives in VMBus code so that may explain why
>> you may want to keep stimer code in the same entity. Or, alternatively,
>> we can move Hyper-V messaging out of VMBus code (is it actually
>> architecture-agnostic?)
>> 
>
> I thought about introducing CONFIG_HYPERV_STIMER, but in my
> judgment it was just unnecessary complexity.  The Hyper-V clocksource
> driver can't exist independent of Hyper-V, and vice versa.  When both the
> clocksource and clockevents code is considered, the VMbus driver and
> Hyper-V initialization code has to call directly into the driver since the
> Hyper-V synthetic timers and reference time counter aren't independently
> enumerated.  Even if we could get the Hyper-V messaging out of VMbus
> code, we would still need the clocksource initialization call directly from
> hyperv_init(), which is not in a module (see the 2nd patch of the series).
>

Right, so hv_init_clocksource() cannot live in hv_vmbus module and we
need to somehow prevent hyperv_syntimer.o from going in there. And

+obj-$(CONFIG_HYPERV)                      += hyperv_syntimer.o

will do exactly the opposite - put it in hv_vmbus module. Or am I
missing something? (I haven't tried to build your code yet, sorry).

> Michael

-- 
Vitaly
