Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF3C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007921916
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 14:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfCUOYt (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:24:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53068 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUOYt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Mar 2019 10:24:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so2966096wma.2
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2019 07:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zqicGzQ8Noe2OtXjVfYgwh5daH9XKHGdgFau1NNCQ/M=;
        b=Ffa28vhFl5+mT53vsJaiZNwoemuWRdNg6ZRBxgXNSDU+0yNRoeO1gGQghZYbPoQm+A
         E6OGtXFhsGgQOjY+UnE1/6Oiocsr3xZS6FZ7yMIo/LoxizkZg0Dn4NzjT2B4LbHuWBrj
         xsIzdGVdZMiOS0d9kn+hni7DL5iiymncnwWrFLBEiBLANKr1TzIfqzSDBxH4R3rPnOis
         /aEmzOZpxvk8WnL8RxE4/saZJ8vGpMmBNb4jEtHQ8P+xRNCG5W/TgcaMixT863/iyL1T
         RxTuwNh8rfGpX7MXlMfB8oJwwKEHjbBxJlKCwMxV9dCxsJI3Otwzk6RsPjyuF6nRET4q
         0pPw==
X-Gm-Message-State: APjAAAUkFdrh9VFYgK2EsuHNOR2Q1N3frXPsQrpYCwIc+jkQ6TGFnGIK
        86khx8Khbm3zT+GwXgOp6WRu0g==
X-Google-Smtp-Source: APXvYqySVbYjI37k3UG3Zacg7M7x1iZFDe9o/m+kEpFLE/XhcZPCvfX+gtds0Nyl+EvC1jUa5JtY2Q==
X-Received: by 2002:a7b:c016:: with SMTP id c22mr2693182wmb.55.1553178288105;
        Thu, 21 Mar 2019 07:24:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n189sm9916168wmb.28.2019.03.21.07.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 07:24:47 -0700 (PDT)
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
Subject: Re: [PATCH v2 0/2] Drivers: hv: Move Hyper-V clock/timer code to separate clocksource driver
In-Reply-To: <1552849512-10063-1-git-send-email-mikelley@microsoft.com>
References: <1552849512-10063-1-git-send-email-mikelley@microsoft.com>
Date:   Thu, 21 Mar 2019 15:24:46 +0100
Message-ID: <874l7we24x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> This patch series moves Hyper-V clock/timer code to a separate Hyper-V
> clocksource driver. Previously, Hyper-V clock/timer code and data
> structures were mixed in with other Hyper-V code in the ISA independent
> drivers/hv code as well as in arch dependent code. The new Hyper-V
> clocksource driver is ISA independent, with a just few dependencies on
> arch specific functions. The patch series does not change any behavior
> or functionality -- it only reorganizes the existing code and fixes up
> the linkages. A few places outside of Hyper-V code are fixed up to use
> the new #include file structure.
>
> This restructuring is in response to Marc Zyngier's review comments
> on supporting Hyper-V running on ARM64, and is a good idea in general.
> It increases the amount of code shared between the x86 and ARM64
> architectures, and reduces the size of the new code for supporting
> Hyper-V on ARM64. A new version of the Hyper-V on ARM64 patches will
> follow once this clocksource restructuring is accepted.
>
> The code is currently diff'ed against Linux 5.0.  I'll rebase
> to linux-next once 5.1-rc1 is available.
>
> Changes in v2:
> * Revised commit short descriptions so the distinction between
> the two patches is clearer [GregKH]
> * Renamed new clocksource driver files and functions to use
> existing "timer" and "stimer" names instead of introducing
> "syntimer". [Vitaly Kuznetsov]
> * Introduced CONFIG_HYPER_TIMER to fix build problem when
> CONFIG_HYPERV=m [Vitaly Kuznetsov]

Actually, it is "CONFIG_HYPERV_TIMER" but the typo appears only in this
blurb :-)

> * Added "Suggested-by: Marc Zyngier"
>
> Michael Kelley (2):
>   Drivers: hv: Create Hyper-V clocksource driver from existing
>     clockevents code
>   Drivers: hv: Move Hyper-V clocksource code to new clocksource driver

Thanks for fixing v1 issues!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>
>  MAINTAINERS                          |   2 +
>  arch/x86/entry/vdso/vclock_gettime.c |   1 +
>  arch/x86/entry/vdso/vma.c            |   2 +-
>  arch/x86/hyperv/hv_init.c            |  91 +---------
>  arch/x86/include/asm/hyperv-tlfs.h   |   6 +
>  arch/x86/include/asm/mshyperv.h      |  80 ++-------
>  arch/x86/kernel/cpu/mshyperv.c       |   2 +
>  arch/x86/kvm/x86.c                   |   1 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/hyperv_timer.c   | 328 +++++++++++++++++++++++++++++++++++
>  drivers/hv/Kconfig                   |   3 +
>  drivers/hv/hv.c                      | 154 ----------------
>  drivers/hv/hyperv_vmbus.h            |   3 -
>  drivers/hv/vmbus_drv.c               |  39 +++--
>  include/clocksource/hyperv_timer.h   | 104 +++++++++++
>  15 files changed, 485 insertions(+), 332 deletions(-)
>  create mode 100644 drivers/clocksource/hyperv_timer.c
>  create mode 100644 include/clocksource/hyperv_timer.h

-- 
Vitaly
