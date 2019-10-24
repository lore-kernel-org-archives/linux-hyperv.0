Return-Path: <SRS0=3Gw5=YR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBFCA9EAF
	for <linux-hyperv@archiver.kernel.org>; Thu, 24 Oct 2019 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C2321872
	for <linux-hyperv@archiver.kernel.org>; Thu, 24 Oct 2019 22:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfJXWiL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:38:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbfJXWiL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Oct 2019 18:38:11 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNlk6-0002Wn-Sd; Fri, 25 Oct 2019 00:38:07 +0200
Date:   Fri, 25 Oct 2019 00:38:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Roman Kagan <rkagan@virtuozzo.com>
cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <20191024163204.GA4673@rkaganb.sw.ru>
Message-ID: <alpine.DEB.2.21.1910250036090.1783@nanos.tec.linutronix.de>
References: <20191024152152.25577-1-vkuznets@redhat.com> <20191024163204.GA4673@rkaganb.sw.ru>
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

On Thu, 24 Oct 2019, Roman Kagan wrote:
> > +
> > +	if (cpu >= 64)
> > +		goto do_ex_hypercall;
> > +
> > +	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
> > +				     BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
> > +	return ((ret == 0) ? true : false);
> 
> D'oh.  Isn't "return ret == 0;" or just "return ret;" good enough?

   'return ret == 0' != 'return ret'

!ret perhaps :)

Thanks,

	tglx
