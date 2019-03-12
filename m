Return-Path: <SRS0=mRNI=RP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC6C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ADF214AE
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552427214;
	bh=NGwHOoZ8E+td8aM/lO8Kcxhl5PbZxEabR767Fi3Mv+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JkkZS3U02QK88dHY256z2COFCkjyiMNVIyQFUDbrEtu/0R3zftfNDP99H28lUWNDC
	 k/bmAoXCGV764YpkKzAHrHiiqIDun/IETOGnr31If7PBFZe4FeCKoPCSx8gN2CXc83
	 dUrO7FQEdaYxJQ0Qv9LvUQYW4kn/b0PLZzDeDUBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCLVqy (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfCLVqy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Mar 2019 17:46:54 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFA52077B;
        Tue, 12 Mar 2019 21:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552427213;
        bh=NGwHOoZ8E+td8aM/lO8Kcxhl5PbZxEabR767Fi3Mv+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEAkzYsep/OotnI3sFBZPetRRa6g4AxVvQfOmNJw1kFgA3bkSzBXh7w284e9GAELY
         jELNMnIJz7uDq/E+faFG3XqcPXxemdtEHV09NameL5c7IMasdwO3L7OTwQOce9yu5V
         NXPtZAcpKZ5Q2h4xGMZudCvl+BD/LYv4zrsZRbqY=
Date:   Tue, 12 Mar 2019 14:46:52 -0700
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
Message-ID: <20190312214652.GA15914@kroah.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 12, 2019 at 09:42:09PM +0000, Michael Kelley wrote:
> This patch series moves Hyper-V clock/timer code to a separate Hyper-V
> clocksource driver. Previously, Hyper-V clock/timer code and data
> structures were mixed in with other Hyper-V code in the ISA independent
> drivers/hv code as well as in arch dependent code. The new Hyper-V
> clocksource driver is ISA independent, with a just few dependencies on
> arch specific functions. The patch series does not change any behavior
> or functionality -- it only reorganizes the existing code and fixes up
> the linkages. A few places outside of Hyper-V code are fixed up to use
> the new #include file structure.
> 
> This restructuring is in response to Marc Zyngier's review comments
> on supporting Hyper-V running on ARM64, and is a good idea in general.
> It increases the amount of code shared between the x86 and ARM64
> architectures, and reduces the size of the new code for supporting
> Hyper-V on ARM64. A new version of the Hyper-V on ARM64 patches will
> follow once this clocksource restructuring is accepted.
> 
> The code is currently diff'ed against Linux 5.0.  I'll rebase
> to linux-next once 5.1-rc1 is available.
> 
> Michael Kelley (2):
>   Drivers: hv: Move Hyper-V clockevents code to new clocksource driver
>   Drivers: hv: Move Hyper-V clocksource code to new clocksource driver

You have two different patches that do different things, yet have the
same identical shortlog text :(

That's not ok, and something that I reject for trivial patches, it
should never happen for a "real" patch as you don't do the same thing in
both of these patches.

thanks,

greg k-h
