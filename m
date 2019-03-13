Return-Path: <SRS0=yslr=RQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C7CC43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 17:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F7921019
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 17:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfCMRRT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:17:19 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43215 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMRRT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Mar 2019 13:17:19 -0400
Received: by mail-wr1-f52.google.com with SMTP id d17so2858460wre.10
        for <linux-hyperv@vger.kernel.org>; Wed, 13 Mar 2019 10:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6sbUrWmoVzADBndVgqIFaX/kyLeylNsbfWUVFK0JOas=;
        b=Ahv3MgcFW6OC5iIjvz/aUXZkCsPAD3rVDp3m8bQP9Yt2CSze/Rmgc4mJrglTH90h60
         Ww2JJk7goNQU1sT4Rdarx60D6J0rOWZdfhvDthZ8VxRwHJqKj4AbpF1BG8q7gLBsf7TN
         TeOP+7yRgN8tgtYf6bvbENz6fCBFuwqe/133z9s/BvVJkWGfUttHO8WnN0cl8T1cg4P+
         bqZsGu+ffAyRDOPSrAVtExBIwJT0HdCr3YZfUr7Y0ItV8pmhoJL0p6kYvOde9J5uVUK6
         ZFqyUDC8qs5nfDEPpQiYihNHBF8+CnIKmsWmxrmkdFyjwbhqSO8K4v+O5mY4OLyWoRax
         yoDw==
X-Gm-Message-State: APjAAAUxqEJpDMDidtrqtWQprcz1AoOxp++kHYGf3YKLfyfdPJ7IfjhB
        4UCtxwpSCuJTtx2K6c5XtNJjHg==
X-Google-Smtp-Source: APXvYqzIWgqqr7I6BeG3SHBvFQCtTgEtoimYgAD4lYjkZn06Onr9bpAbHk2LdWUDLOnhMwZh7qhcyg==
X-Received: by 2002:adf:efca:: with SMTP id i10mr28441362wrp.265.1552497437313;
        Wed, 13 Mar 2019 10:17:17 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o18sm39996168wrg.40.2019.03.13.10.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 10:17:16 -0700 (PDT)
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
In-Reply-To: <DM5PR2101MB09180753D788F8587B19B993D74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com> <1552426813-9568-2-git-send-email-mikelley@microsoft.com> <874l87tbz2.fsf@vitty.brq.redhat.com> <DM5PR2101MB091897108980449F12FDDB3DD74A0@DM5PR2101MB0918.namprd21.prod.outlook.com> <87pnqusvjq.fsf@vitty.brq.redhat.com> <DM5PR2101MB09180753D788F8587B19B993D74A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Date:   Wed, 13 Mar 2019 18:17:15 +0100
Message-ID: <87mulysnhg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, March 13, 2019 7:23 AM
>
>> >> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> >> > index be6e0fb..a887955 100644
>> >> > --- a/drivers/clocksource/Makefile
>> >> > +++ b/drivers/clocksource/Makefile
>> >> > @@ -83,3 +83,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>> >> >  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>> >> >  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>> >> >  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>> >> > +obj-$(CONFIG_HYPERV)			+= hyperv_syntimer.o
>> >>
>> >> (just a couple of spare thoughs)
>> >>
>> >> CONFIG_HYPERV can also be a module, are we OK with that? (we'll have to
>> >> support module loading/unloading then and honestly I see no reason for
>> >> that. I would prefer everything but VMBus devices to be in
>> >> kernel.) If we don't want it to be a module we can create a hidden
>> >> CONFIG_HYPERV_STIMER or something like that - just like we already do
>> >> for CONFIG_HYPERV_TSCPAGE.
>> >>
>> >> There is, however, one additional dependency here: when running in
>> >> non-direct mode, Hyper-V clockevent devices require functional Hyper-V
>> >> messaging - which currently lives in VMBus code so that may explain why
>> >> you may want to keep stimer code in the same entity. Or, alternatively,
>> >> we can move Hyper-V messaging out of VMBus code (is it actually
>> >> architecture-agnostic?)
>> >>
>> >
>> > I thought about introducing CONFIG_HYPERV_STIMER, but in my
>> > judgment it was just unnecessary complexity.  The Hyper-V clocksource
>> > driver can't exist independent of Hyper-V, and vice versa.  When both the
>> > clocksource and clockevents code is considered, the VMbus driver and
>> > Hyper-V initialization code has to call directly into the driver since the
>> > Hyper-V synthetic timers and reference time counter aren't independently
>> > enumerated.  Even if we could get the Hyper-V messaging out of VMbus
>> > code, we would still need the clocksource initialization call directly from
>> > hyperv_init(), which is not in a module (see the 2nd patch of the series).
>> >
>> 
>> Right, so hv_init_clocksource() cannot live in hv_vmbus module and we
>> need to somehow prevent hyperv_syntimer.o from going in there. And
>> 
>> +obj-$(CONFIG_HYPERV)                      += hyperv_syntimer.o
>> 
>> will do exactly the opposite - put it in hv_vmbus module. Or am I
>> missing something? (I haven't tried to build your code yet, sorry).
>> 
>
> That line just controls whether hyperv_syntimer.o is built.  It doesn't put
> it in the hv_vmbus module.  All of the clocksource .o files that are built go
> into the kernel, not in a module.  But thinking about it more, the above works
> correctly when CONFIG_HYPERV=y, but not when CONFIG_HYPERV=m.

Yes, that's what I meant.

> I'll have to introduce CONFIG_HYPERV_TIMER after all.  Will fix this in v2.  Thanks
> for the discussion!

Thanks!

-- 
Vitaly
