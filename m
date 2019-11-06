Return-Path: <SRS0=k8xt=Y6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36708C5DF62
	for <linux-hyperv@archiver.kernel.org>; Wed,  6 Nov 2019 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEC720869
	for <linux-hyperv@archiver.kernel.org>; Wed,  6 Nov 2019 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573035557;
	bh=TbCi1v0EBWWikEEGm5oxQHJ2Q6Bv5jfqqcOcNkFUMDk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=hSscfNWisRPAlMTYqsLlxHrKzAONH++hsqOwhVCXjSsCHqmt8X9iOWtG4FJJ23mDF
	 yO1SkHz8NKQHCSen67DVctePjMdmJsPY4lkjhULOxVX+zyXrJFu3SpE5qD0TXbg4AG
	 a0ONp8bkfN/SxQvM/zzrI2VlWuSDJwpR9B9kREIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKFKTQ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:19:16 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:51332 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbfKFKTQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Nov 2019 05:19:16 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iSIP7-0007q5-Ff; Wed, 06 Nov 2019 11:19:09 +0100
To:     Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 2/8] arm64: hyperv: Add hypercall and register access  functions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Nov 2019 11:28:30 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, <devel@linuxdriverproject.org>,
        <olaf@aepfle.de>, <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, <jasowang@redhat.com>,
        <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng" <boqun.feng@gmail.com>
In-Reply-To: <1570129355-16005-3-git-send-email-mikelley@microsoft.com>
References: <1570129355-16005-1-git-send-email-mikelley@microsoft.com>
 <1570129355-16005-3-git-send-email-mikelley@microsoft.com>
Message-ID: <8cdc86e5bcf861c74069e0d349910c94@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: mikelley@microsoft.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com, sunilmut@microsoft.com, boqun.feng@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2019-10-03 20:12, Michael Kelley wrote:
> Add ARM64-specific code to make Hyper-V hypercalls and to
> access virtual processor synthetic registers via hypercalls.
> Hypercalls use a Hyper-V specific calling sequence with a non-zero
> immediate value per Section 2.9 of the SMC Calling Convention
> spec.

I find this "following the spec by actively sidestepping it" counter
productive. You (or rather the Hyper-V people) are reinventing the
wheel (of the slightly square variety) instead of using the standard
that the whole of the ARM ecosystem seems happy to take advantage
of.

I wonder what is the rational for this. If something doesn't quite
work for Hyper-V, I think we'd all like to know.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
