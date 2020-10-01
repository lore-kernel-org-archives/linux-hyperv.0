Return-Path: <SRS0=Dd0k=DI=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34444C4741F
	for <linux-hyperv@archiver.kernel.org>; Thu,  1 Oct 2020 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DF7207F7
	for <linux-hyperv@archiver.kernel.org>; Thu,  1 Oct 2020 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDpfVmta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUPBvkhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbgJANxJ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 1 Oct 2020 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANxJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 09:53:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE20FC0613D0;
        Thu,  1 Oct 2020 06:53:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601560387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QlmQU4U707WUFGOJ0XG+Q1YjhMDkPVgYfkVUA/WoFc=;
        b=jDpfVmtaeTkDdW/IvYOq5JTlvoEDvMPuXHKdBkqxDhj9NtP6sTCT7g/kMy5ECqhZUGy2+4
        ++hAJ4Lf+UXj9X848nWTQXsWOUQwa0nSp8X6CBBBUzXU5W59I9y+JhIX+EAI1RusI4giOx
        WoE//JGbOJ/9aovK5UwQd1DPj/14mcwlcfKH5BL9ZmpEPYc59kRKDsf6dp6TQ7Zewxpo4q
        yL8kwmNhWt7cTao5A/py29YkkltUhHrvrLanp3xl0L310qxEaveU9Sh4MqjbrIFJvjOInj
        eMAYvmm8xoIqfs4bQEuXBHHNbgDKRhrRhhHHt1xe5fMSTnynEXYGFUqVvcIPNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601560387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QlmQU4U707WUFGOJ0XG+Q1YjhMDkPVgYfkVUA/WoFc=;
        b=VUPBvkhvJ43I0rw6XwXLBzv6cBppoaj+or1uLt5D2g6BaWB0D6BqJUpq/u8iIurpo4fr5G
        aeKaeW8Pag4Xo9Bg==
To:     Zi Yan <ziy@nvidia.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: Boot crash due to "x86/msi: Consolidate MSI allocation"
In-Reply-To: <2F4EC354-C0BB-44BD-86A5-07F321590C31@nvidia.com>
References: <A838FF2B-11FC-42B9-87D7-A76CF46E0575@nvidia.com> <874knegxtg.fsf@nanos.tec.linutronix.de> <2F4EC354-C0BB-44BD-86A5-07F321590C31@nvidia.com>
Date:   Thu, 01 Oct 2020 15:53:07 +0200
Message-ID: <87h7ref3y4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Yan,

On Thu, Oct 01 2020 at 09:39, Zi Yan wrote:
> On 1 Oct 2020, at 4:22, Thomas Gleixner wrote:
>> Can you please test:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq
>>
>> which contains fixes and if it still crashes provide the dmesg of it.
>
> My system boots without any problem using this tree. Thanks.

linux-next of today contains these fixes, so that should work now as
well.

Thanks,

        tglx
