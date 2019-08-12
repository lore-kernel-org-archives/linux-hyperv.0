Return-Path: <SRS0=ZuTB=WI=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A368C31E40
	for <linux-hyperv@archiver.kernel.org>; Mon, 12 Aug 2019 13:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF3620684
	for <linux-hyperv@archiver.kernel.org>; Mon, 12 Aug 2019 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHLNGN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:06:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfHLNGM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Aug 2019 09:06:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DC3415AB;
        Mon, 12 Aug 2019 06:06:12 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206B23F706;
        Mon, 12 Aug 2019 06:06:10 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:06:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: Re: [PATCH v2] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Message-ID: <20190812130607.GD20861@e121166-lin.cambridge.arm.com>
References: <PU1P153MB01693F32F6BB02F9655CC84EBFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190806201611.GT151852@google.com>
 <PU1P153MB0169F9EDD707FFE1517F8D56BFD50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169F9EDD707FFE1517F8D56BFD50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 06, 2019 at 08:41:17PM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Bjorn Helgaas
> > Sent: Tuesday, August 6, 2019 1:16 PM
> > To: Dexuan Cui <decui@microsoft.com>
> > 
> > Thanks for updating this.  But you didn't update the subject line,
> > which is really still a little too low-level.  Maybe Lorenzo will fix
> > this.  Something like this, maybe?
> > 
> >   PCI: hv: Avoid use of hv_pci_dev->pci_slot after freeing it
> 
> This is better. Thanks!
> 
> I hope Lorenzo can help to fix this so I could avoid a v3. :-)

You should have fixed it yourself, this time I will.

Thanks,
Lorenzo
