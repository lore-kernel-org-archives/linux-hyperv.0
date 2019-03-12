Return-Path: <SRS0=mRNI=RP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92549C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CD2173C
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552428064;
	bh=mzqJdzs7aPWWo7/bSoKNz+UZfdtrDaPFc2zFxpmIM/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qtuluEbCJBkH6V6axAqU+dxh+XVW+LO5M+0M6kJ1PuIUgiXEmY76NqdzPU6KRheSY
	 mewHPCfkIygF5sVCUTyCGlr8f9IFhXklxVwkEb10x33u0ZJBni+e4fESty32KDJpJe
	 hkgrKK1O7Uxg2S+saTxPbMTRlG4hf2mO1/Go55/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCLWBE (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfCLWBD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Mar 2019 18:01:03 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D467214AE;
        Tue, 12 Mar 2019 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552428063;
        bh=mzqJdzs7aPWWo7/bSoKNz+UZfdtrDaPFc2zFxpmIM/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=10rpadjO3U0nScJfo0dNHMO9HkWU7vE3gZCEfTH441/Wmw5Xtx8we55x7VQGsmwL1
         Yvc2fjLxm601bQIStMJZARvkspVjZqpqX1QpYyUpCnaEDe7G42Eb/5n2IK6fw+UIDc
         pDHGzTWpCoXbJhVj0CNuqzPqfyS4lIXeA0QzrNJQ=
Date:   Tue, 12 Mar 2019 15:01:02 -0700
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Message-ID: <20190312220102.GA17164@kroah.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
 <20190312214652.GA15914@kroah.com>
 <DM5PR2101MB091877CF62AD20D07D82F452D7490@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB091877CF62AD20D07D82F452D7490@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 12, 2019 at 09:53:28PM +0000, Michael Kelley wrote:
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>  Sent: Tuesday, March 12, 2019 2:47 PM
> > >
> > > Michael Kelley (2):
> > >   Drivers: hv: Move Hyper-V clockevents code to new clocksource driver
> > >   Drivers: hv: Move Hyper-V clocksource code to new clocksource driver
> > 
> > You have two different patches that do different things, yet have the
> > same identical shortlog text :(
> > 
> > That's not ok, and something that I reject for trivial patches, it
> > should never happen for a "real" patch as you don't do the same thing in
> > both of these patches.
> 
> Hmmm.  Not identical.  The first patch is "clockevents" code, and the second
> patch is "clocksource" code.

Wow, that's not obvious at all, sorry.  You still might want to make it
a bit more different :)

greg k-h
