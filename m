Return-Path: <SRS0=4qqU=ZM=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D3C432C0
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Nov 2019 09:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1991921D7A
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Nov 2019 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKTJuD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:50:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfKTJuD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 04:50:03 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXMcS-0004FR-UU; Wed, 20 Nov 2019 10:49:53 +0100
Date:   Wed, 20 Nov 2019 10:49:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dexuan Cui <decui@microsoft.com>
cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        david@redhat.com, arnd@arndb.de, bp@alien8.de,
        daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com,
        x86@kernel.org, Alexander.Levin@microsoft.com, vkuznets@redhat.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/hyperv: Implement
 hv_is_hibernation_supported()
In-Reply-To: <1574234165-49066-2-git-send-email-decui@microsoft.com>
Message-ID: <alpine.DEB.2.21.1911201049030.6731@nanos.tec.linutronix.de>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com> <1574234165-49066-2-git-send-email-decui@microsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 19 Nov 2019, Dexuan Cui wrote:
> Once all the vmbus and VSC patches for the hibernation feature are
> accepted, an extra patch will be submitted to forbid hibernation if the
> virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
> false.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> v2 is actually the same as v1. This is just a resend.
> 
> I suggest this patch should go through the Hyper-V tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> because it's needed by
> [PATCH v2 2/2] hv_balloon: Add the support of hibernation
> and some upcoming patches.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
