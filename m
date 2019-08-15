Return-Path: <SRS0=rveM=WL=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF2DC3A59B
	for <linux-hyperv@archiver.kernel.org>; Thu, 15 Aug 2019 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233D62083B
	for <linux-hyperv@archiver.kernel.org>; Thu, 15 Aug 2019 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12jafkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfHOMYY (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:24:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41739 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOMYY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Aug 2019 08:24:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so1259202pfz.8;
        Thu, 15 Aug 2019 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkLCqEaTsCEsmy9YXO9VB9gRG815ysfSK6aR/96UBWI=;
        b=X12jafkxUf3oUMSLLeTSUyAgcMeSLWAcr6AghhrF+MMPPQcFZEO/qciPdtJb84K0k/
         9fAkwyzGxaMc5DudLdhfoM41+YoCxYLXKojk/I3jmXtg+PZbEqGcsdAwYLbHYL8siuk+
         HqsQ3QfI6iV1MYF4lH0EdDe3R3dcuNpI9+hv7VP3DeejIctXRVbC4MR1d7Rz7chfeSAp
         2rvb9wzlmJygiY2hzHPyGbyqsrP9kjWH3SLA6T/3QakdZuyaeVX+NI2GlFmuxjcdaha6
         qMdSGo7DXomUcOpfleayw+qROiHK4nyUKfM+JiDSASkDQyG1y+tFuIfLqVgO5Aczd86a
         FNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkLCqEaTsCEsmy9YXO9VB9gRG815ysfSK6aR/96UBWI=;
        b=RoUyZxGr2f/SM5TdbwaQIUbO9fkmuq6xM/w46Ux95vZlVhCemEKdqimDrFuYaGetMU
         L7eiYnUOMGdE776pbxiZkdPaY5jkvvlCPKEZF55yekS54LYNfn2FQUv0602GWn4gQ4KY
         CC7O4UfT40K/BdAlrYJ6aqmeULzNnrAtX7iikpMBO3/XF7dOytyfP10V/gsjNtc7/5to
         C6MS0T6YhGFEugtl/5t+dYxNzvzBLJOEVsHaWixglxsatS4EWrb6PpIZ0xd6etKaaJoi
         yUVcR/3yThCbhF1dRNmOiP6wG9adapdskZbCYvcPvmtIPMaVqIPLHFzA9RxPZoUu5TXp
         mJQA==
X-Gm-Message-State: APjAAAUffaX6tS0ACa+uQwZuUkVpmTo6ewoGJ0CC+bh8z/9rnbC+TT3C
        xrY0ER2vUALCj6hEpSWG319YbPUusaOZnO5IWZc=
X-Google-Smtp-Source: APXvYqw7Vskl27n+kw4aFIclMqNvSOuuA6ATYEI3pXYymtYk9YM8rU6NPsdyB98X6QsowSAEODkRIYHMbFK3AtzXd1E=
X-Received: by 2002:a65:5043:: with SMTP id k3mr3409939pgo.406.1565871863801;
 Thu, 15 Aug 2019 05:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190814073447.96141-1-Tianyu.Lan@microsoft.com>
 <20190814073447.96141-4-Tianyu.Lan@microsoft.com> <1a1410a7-e2dc-904e-a271-3e2017d42bae@redhat.com>
In-Reply-To: <1a1410a7-e2dc-904e-a271-3e2017d42bae@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 15 Aug 2019 20:24:14 +0800
Message-ID: <CAOLK0pxX=fY=1Kux5_K-qZBU3CNoL1dmnghtL-_Yrh0UgAbbQA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] KVM/Hyper-V/VMX: Add direct tlb flush support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        michael.h.kelley@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Paolo:
          Thanks for your review.

On Wed, Aug 14, 2019 at 9:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/08/19 09:34, lantianyu1986@gmail.com wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index c5da875f19e3..479ad76661e6 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -500,6 +500,7 @@ struct kvm {
> >       struct srcu_struct srcu;
> >       struct srcu_struct irq_srcu;
> >       pid_t userspace_pid;
> > +     struct hv_partition_assist_pg *hv_pa_pg;
> >  };
> >
> >  #define kvm_err(fmt, ...) \
>
> This does not exist on non-x86 architectures.  Please move it to struct
> kvm_arch.
>
Nice catch. Will update in the next version. Thanks.
-- 
Best regards
Tianyu Lan
