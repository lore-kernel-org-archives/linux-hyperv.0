Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20B6C10F05
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8472220879
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 18:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfCZSMj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:12:39 -0400
Received: from foss.arm.com ([217.140.101.70]:42046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732064AbfCZSMj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 14:12:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271F51596;
        Tue, 26 Mar 2019 11:12:39 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32E433F575;
        Tue, 26 Mar 2019 11:12:36 -0700 (PDT)
Date:   Tue, 26 Mar 2019 18:12:30 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: hv: Fix a memory leak in hv_eject_device_work()
Message-ID: <20190326181156.GA12093@e107981-ln.cambridge.arm.com>
References: <PU1P153MB0169E9AA13EB51DF5CFC1CE4BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190326170842.GA10666@e107981-ln.cambridge.arm.com>
 <DM5PR2101MB0918F2C06BBFF7684BF179FFD75F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <PU1P153MB0169CA2F484C02A196F9B78DBF5F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169CA2F484C02A196F9B78DBF5F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 26, 2019 at 06:01:32PM +0000, Dexuan Cui wrote:

[...]

> > > Have we reached a conclusion on this ? I would like to merge this series
> > > given that it is fixing bugs and it has hung in the balance for quite
> > > a while but it looks like Michael is not too happy about these patches
> > > and I need a maintainer ACK to merge them.
> > >
> > > Thanks,
> > > Lorenzo
> > 
> > Dexuan and I have discussed the topic extensively offline.  The patch works
> > in its current form, and I'll agree to it.
> > 
> > Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> 
> Thanks, Michael!
> 
> Hi Lorenzo,
> All the 3 patches have got Michael's Reviewed-by.

Good, I asked because I do not want to merge patches with review
questions open, thanks for the clarifications.

> Previously, Stephen Hemminger, one of the Hyper-V driver maintainers, 
> provided his Reviewed-by in the " [PATCH 0/3]" mail:
> https://lkml.org/lkml/2019/3/5/521

I will reformat/rewrite the logs and notify you when queued.

Thanks,
Lorenzo
