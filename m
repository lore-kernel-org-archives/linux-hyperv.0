Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEF1C43381
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Jan 2021 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DA923444
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Jan 2021 20:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbhAGUWF (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGUWE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 15:22:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC3C0612F4;
        Thu,  7 Jan 2021 12:21:24 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e34002d59f6405ecee32d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3400:2d59:f640:5ece:e32d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C001D1EC0505;
        Thu,  7 Jan 2021 21:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610050882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+vZgyc0oWmeUQ6q4lERXNRsw6fNLD2Q20rQ6hQNStAI=;
        b=Vvgmfzql9ErCztm9wHqi9RKwSLUN1ra7fS7JMKQnaH3omNtS6NDuCvqd5nEkEjg8bWGhvl
        5+/eehITz/t+f1kMJLW1LrQLTi54zMuh6eAwlx7e4hJBnwTq4qW7Cu79uQRBQChoIav/y2
        grp3pxLvacQUPFaX6/bbz12gPSdfslk=
Date:   Thu, 7 Jan 2021 21:21:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi
 set-up and handling
Message-ID: <20210107202120.GJ14697@zn.tnic>
References: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20210107080317.GE14697@zn.tnic>
 <SN4PR2101MB088009D87B77E37943B2F007C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB088009D87B77E37943B2F007C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 07, 2021 at 08:16:28PM +0000, Sunil Muthuswamy wrote:
> > What is this SoB chain supposed to say?
> 
> Quoting from the link you shared:
> "The Signed-off-by: tag indicates that the signer was involved in the development of
> the patch, or that he/she was in the patch's delivery path."
> 
> My intent to include Boqun in the Signed-off by tag was to indicate that he was involved
> in the development of the patch here.

Do you see "Co-developed-by" in the title of that section? This is how
you express co-authorship.

As it is now:

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>

it says that you authored the patch and Boqun handled it further, i.e.,
he's in the patch's delivery path. But he isn't - you're sending it.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
