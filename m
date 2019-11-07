Return-Path: <SRS0=tGuR=Y7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994EC5DF61
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Nov 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E682178F
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Nov 2019 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573117842;
	bh=yenYJT5xWwnA7zEx1Ag7YzfGX1pWIW4nsVZ5Wm/3S28=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=O7s/zXk8/GLZM6NFF9/1rIHfRk0cJp9w5IfC0j6Cq0b5074fWyr7yEFJvA+c8Q4H3
	 ppyDRHHQ/EIs275xrdkEOfirEDXFcTjUKP2/Mvd3NiYe1zsNfhoUDsICy4Mu2WSs5W
	 p5ZXnOYP6Zj/iEk7OCVycEqTCbFviXvC/UlTiDs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbfKGJKl (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:10:41 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37968 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733142AbfKGJKl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 04:10:41 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iSdoJ-0002WC-Ai; Thu, 07 Nov 2019 10:10:35 +0100
To:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v5 2/8] arm64: hyperv: Add hypercall and register access  functions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Nov 2019 10:19:56 +0109
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
In-Reply-To: <DM5PR21MB013730D09CB8BA7658DE57F7D7790@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1570129355-16005-1-git-send-email-mikelley@microsoft.com>
 <1570129355-16005-3-git-send-email-mikelley@microsoft.com>
 <8cdc86e5bcf861c74069e0d349910c94@www.loen.fr>
 <DM5PR21MB013730D09CB8BA7658DE57F7D7790@DM5PR21MB0137.namprd21.prod.outlook.com>
Message-ID: <c8403255bf874856c10f07189e27080a@www.loen.fr>
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

On 2019-11-06 19:08, Michael Kelley wrote:
> From: Marc Zyngier <maz@kernel.org>  Sent: Wednesday, November 6,
> 2019 2:20 AM
>>
>> On 2019-10-03 20:12, Michael Kelley wrote:
>> > Add ARM64-specific code to make Hyper-V hypercalls and to
>> > access virtual processor synthetic registers via hypercalls.
>> > Hypercalls use a Hyper-V specific calling sequence with a non-zero
>> > immediate value per Section 2.9 of the SMC Calling Convention
>> > spec.
>>
>> I find this "following the spec by actively sidestepping it" counter
>> productive. You (or rather the Hyper-V people) are reinventing the
>> wheel (of the slightly square variety) instead of using the standard
>> that the whole of the ARM ecosystem seems happy to take advantage
>> of.
>>
>> I wonder what is the rational for this. If something doesn't quite
>> work for Hyper-V, I think we'd all like to know.
>>
>
> I'll go another round internally with the Hyper-V people on this
> topic and impress upon them the desire of the Linux community to
> have Hyper-V adopt the true spirit of the spec.  But I know they are
> fairly set in their approach at this point, regardless of the 
> technical
> merits or lack thereof.  Hyper-V is shipping and in use as a 
> commercial
> product on ARM64 hardware, which makes it harder to change.  I
> hope we can find a way to avoid a complete impasse ....

Hyper-V shipping with their own calling convention is fine by me. Linux
having to implement multiple calling conventions because the Hyper-V
folks refuse (for undisclosed reason) to adopt the standard isn't fine 
at
all.

HV can perfectly retain its interface for Windows or other things, but
please *at least* implement the standard interface on which all 
existing
operating systems rely.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
