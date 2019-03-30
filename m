Return-Path: <SRS0=nmsr=SB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA13C43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 05:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6F1218A3
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 05:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QiXYKcsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfC3FHD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:07:03 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:18616 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfC3FHD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 Mar 2019 01:07:03 -0400
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2019 01:07:01 EDT
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x2U56dQM012142;
        Sat, 30 Mar 2019 14:06:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x2U56dQM012142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553922399;
        bh=+AqLJsKJFUr5Npn79zEVONZIZ0IJw3jjXebMGdV3k3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QiXYKcsAHU0TeoIRWJwVxC6wDoQoH5sy2xQlEhK0eSUE89MJur4RIczn98IZ+oxu5
         i6C7NXTfN/IF5B6FzzYqanDMKsjZTt79sF92zHOK8AmmbVqM1GcioSUZIG2l+5awdF
         /4Iqb1FnYGfiVQnzdHk7xeI+TsA6a7hwaM5XsAY3MjXSG39t6C19h27SL03ksJMGTn
         tN8qoqEQVduXrkARPIYg8iH13BwYcR6lkKqiyeAyJ3qNODtWH+8YxHVkF0loUJFROM
         elvS8R+NekckhkBxG4sanbDpgD0wTBf4Kq5ch2GDy7Z8APrYzobNexwRLO4F04bsYo
         Bv16uwUDS63qQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id d8so1522133vsp.2;
        Fri, 29 Mar 2019 22:06:39 -0700 (PDT)
X-Gm-Message-State: APjAAAV9cz1HpynQZbM2qsQCvoYC06FN6JZ0atF2xkLwlzAWwnLCAuGi
        1tL4D/Ug4lW/EoC9reXbAIoZfY3zYX9fM54Opp0=
X-Google-Smtp-Source: APXvYqwTrhGF5jqtrR86x6CELAu4w44AWkAFFn4d5wu7N1SG3KHrXM+xZpbBHMIFFBtEiwt2Sr50iBUYnjOtH1muGcY=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr32260408vsc.54.1553922398554;
 Fri, 29 Mar 2019 22:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <1553921453-23777-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553921453-23777-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Mar 2019 14:06:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmXqLyJ_gvNo_Yh3eivCbzE4n6fE0PYPaXmDnCJksJgw@mail.gmail.com>
Message-ID: <CAK7LNARmXqLyJ_gvNo_Yh3eivCbzE4n6fE0PYPaXmDnCJksJgw@mail.gmail.com>
Subject: Re: [PATCH] Remove SPDX "WITH Linux-syscall-note" from kernel-space headers
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 30, 2019 at 1:54 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The "WITH Linux-syscall-note" should be added to headers exported to
> the user-space.
>
> Some kernel-space headers have "WITH Linux-syscall-note", which seems
> a mistake.
>
> [1] arch/x86/include/asm/hyperv-tlfs.h
>
> 5a4858032217 ("x86/hyper-v: move hyperv.h out of uapi") moved this file
> out of uapi, but missed to update the SPDX License tag.
>
> [2] include/asm-generic/shmparam.h
>
> 76ce2a80a28e ("Rename include/{uapi => }/asm-generic/shmparam.h really")
> moved this file out of uapi, but missed to update the SPDX License tag.
>
> [3] include/linux/qcom-geni-se.h
>
> eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver") added this
> file, but I do now see a good reason why its license tag must include


This is a fatal typo, which makes the meaning opposite.

"I do now see ..." -> "I do not see ..."





> "WITH Linux-syscall-note".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/x86/include/asm/hyperv-tlfs.h | 2 +-
>  include/asm-generic/shmparam.h     | 2 +-
>  include/linux/qcom-geni-se.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 2bdbbbc..cdf44aa 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 */
>
>  /*
>   * This file contains definitions from Hyper-V Hypervisor Top-Level Functional
> diff --git a/include/asm-generic/shmparam.h b/include/asm-generic/shmparam.h
> index 8b78c0b..b8f9035 100644
> --- a/include/asm-generic/shmparam.h
> +++ b/include/asm-generic/shmparam.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __ASM_GENERIC_SHMPARAM_H
>  #define __ASM_GENERIC_SHMPARAM_H
>
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index 3bcd67f..dd46494 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>   */
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
