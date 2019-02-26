Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5626C4360F
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 11:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A12217F5
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 11:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfBZLBI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:01:08 -0500
Received: from 8bytes.org ([81.169.241.247]:41452 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfBZLBI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 06:01:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B8EAA41A; Tue, 26 Feb 2019 12:01:06 +0100 (CET)
Date:   Tue, 26 Feb 2019 12:01:05 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to
 support x2apic mode
Message-ID: <20190226110105.GJ20740@8bytes.org>
References: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
 <DM5PR2101MB0918EF12A3B75142EC54D754D77A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB0918EF12A3B75142EC54D754D77A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 25, 2019 at 08:51:22PM +0000, Michael Kelley wrote:
> Joerg -- What's your take on this patch set now that it has settled down?  If
> you are good with it, from the Microsoft standpoint we're hoping that it
> can get into linux-next this week (given the extra week due to 5.0-rc8).

I can't find v5 of the patch-set in my inbox or my iommu-list folder.
Please re-send to me with all Acks and Reviewed-by's added.

Thanks,

	Joerg
