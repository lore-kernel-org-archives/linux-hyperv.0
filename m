Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F52BC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A6217F5
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 13:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9uERepV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfBZNYt (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:24:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36884 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNYs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 08:24:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so6259028pfh.4;
        Tue, 26 Feb 2019 05:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wsOqzk17/c7HujJ1r9qF6cPtSjMUoUBeFErS+XcOSU=;
        b=m9uERepVd5k6YSLSHFo48SCfiQf7E3e0wiym0oWHP5HhXwWkHXtWkdMWS7JNPpE+vq
         9zcl61raOz2r8tuR9zvyN4M5kc3H6fL+ib+2E9ke6hLibbU6cBYDSYb2927MMZlJx5uo
         pL4dagOHZJ17RF6TfaOmVUwulrFNg4lV5zieB1hUskanXPSiZhackibzwABRx1EkNVnP
         QZohP0R+BDGVA33BEaJAclR9ita1R60mcjZvUwC9izS52JiukliZ7LYd2BL/ugDnKDcH
         iVGIgWZcpMtMscpsqXfn3qEfP+wKtfYAK5arY+f2xMELKY5hfFS5eVgdFCVJ0OwEukoG
         SIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wsOqzk17/c7HujJ1r9qF6cPtSjMUoUBeFErS+XcOSU=;
        b=i6Ze+P3ljUIFHRdApHeTZrgKwnlbGWQqpRHZyYtQh0rDFKz2M3pYc8WdiqdyS20v1n
         V/orcDUnt30AFvfqysdHodNNkeRSm+UBdOBZ7gZ8P3ssVmU2CLceszGsbJYaLoCdw2Wb
         96UJJZqwr6pG9iBTDOCW0lWgzhAJLkzwlwv3InjAj39lb1wKudwi3jvstJzG1SF0QcAI
         lYtk9nec2h1ks6S6a+AX4gUejXpECsJ9VRrSQl409lwBRU7eMwbFEOH/jVhA4xJ+ZpLg
         VDG7P0CjtwUrpXIlzjMAU4GeTj0rUUiJfJICRWQUxoUXILjWKlHvWYhEQ34jh/yiAWT3
         9GHA==
X-Gm-Message-State: AHQUAuZ5RQKucaPxv7bSbIiQQ8tYTgbdox6bUfCAAx3Ct4K7tkqbW/9F
        nv7YccbFt+2twaE7rsg+oSsF2c6ARQq+/icczgA=
X-Google-Smtp-Source: AHgI3IZh/PxGw4qY5MXuDINjjH15KxTtZPGQypt0BpzPmbl62vLhkCoXHfVLE6JFM18gznjk6YHkgONEuaYN289D8sY=
X-Received: by 2002:a65:614f:: with SMTP id o15mr14941244pgv.383.1551187488065;
 Tue, 26 Feb 2019 05:24:48 -0800 (PST)
MIME-Version: 1.0
References: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com> <20190226130741.GD32526@8bytes.org>
In-Reply-To: <20190226130741.GD32526@8bytes.org>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 26 Feb 2019 21:24:37 +0800
Message-ID: <CAOLK0pzrnukw8jPpO_aFT6SeXDopK1KespFPogQKBf-kjs6N9A@mail.gmail.com>
Subject: Re: [Resend PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver
 to support x2apic mode
To:     Joerg Roedel <joro@8bytes.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        michael.h.kelley@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, iommu@lists.linux-foundation.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 26, 2019 at 9:07 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Feb 26, 2019 at 08:07:17PM +0800, lantianyu1986@gmail.com wrote:
> > Lan Tianyu (3):
> >   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is
> >      available
> >   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
> >   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
> >     scope
>
> Applied (patch 2 with slight subject changes
> 'HYPERV/IOMMU' -> 'iommu/hyper-v'), thanks.

Great. Thanks.

-- 
Best regards
Tianyu Lan
