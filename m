Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BDC433DB
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Jan 2021 16:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572472339E
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Jan 2021 16:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbhATQIk (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbhATQIQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 11:08:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B86C0613C1
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:07:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bx12so12383544edb.8
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odx+DIka95/c6zrkDR8kFE4sUKEXLWcK1XgsQ64ZqzY=;
        b=UMnPQ/JMGjxdP+z21Xc0rMdynZ2F0/J98NfDoBgwtmxhotW2QGV2jdCpP/jnDdF+a9
         t0TDXmlE+faEnS+090/bYRA/KjWHkaodSI/IplZnq1ZLL2b/SaMsRbTa4Cj8p/F4jSVi
         oOeR3NyDb3+wpTLdgaGPmdnNysc00uvxirVYEcFmZiWTNZUTv3NrY+AlNuvS+7Gjelg3
         W+a239Cc+KCibmr3e7lV7xnhShn1E6Qzyk78zvOEmmjdS7m1Z3wsXTckFVACoAM7rN+f
         UuAVI6hYX9K9sVw6pwc5Z7u01qATw6GAws+9iSSXFn81Cdu/CcyTQFibhnW4KDrxc4TG
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odx+DIka95/c6zrkDR8kFE4sUKEXLWcK1XgsQ64ZqzY=;
        b=sSVj4dZYazcMPj16SYAmL52ZBHQab1Fd8ccyNscXv4TtcJPPzmb/MlTCTWQcE5XBaS
         rlSai96Yu+XXp0r6s3wWS2YsCOUYTaiubp6wdvwt5ln9+Pmbo+/C6goL/bWFoOvdfw0g
         OHCzw0W1PVCFeB1O66GzvSLYPBry5KbDAcHsEF/ZRfbIiYMNLa4/F4K2tPDsJ3cyj6zJ
         UI7sHlxmvqyhWmYvinTLB65kOI6mwWYgUqKrl98ke8brhShwQXWsrZQjOhqOcthaj7kn
         bncHBK8mZOut0xBr7K2jW1mKpgjRU7yEH1mfS1rIk6r3O0FtVauaOIOG9SsXVlNKMPlQ
         7Byw==
X-Gm-Message-State: AOAM531mqS/rUZsR3j5u+eKDhfv1NAw4B2zI7V3HZuj9wPUCT12qwcZZ
        YU1XjtzXz/kVPY1ryYnlmE+aoUTPK7Zw7pEEv76qzA==
X-Google-Smtp-Source: ABdhPJw1NEcdnEbxX+CkQBkpBO6Vc2zgJb1eRfvm75+kgadtVnofZIhH+bMdVnrUYhwCtF+ahQ/2RUr6G06e0f8kpQ8=
X-Received: by 2002:a05:6402:304e:: with SMTP id bu14mr7526130edb.60.1611158854493;
 Wed, 20 Jan 2021 08:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-4-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-4-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 11:06:58 -0500
Message-ID: <CA+CK2bBUSN5N4XYepibbvakKFgkzEWwFN4DUMrufPtDrYBJvDQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization if
 Linux is root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: Return 0 instead of -ENODEV.
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd95f6d..ee27b3670a51 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2620,6 +2620,9 @@ static int __init hv_acpi_init(void)
>         if (!hv_is_hyperv_initialized())
>                 return -ENODEV;
>
> +       if (hv_root_partition)
> +               return 0;
> +

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
