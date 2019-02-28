Return-Path: <SRS0=MLR3=RD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C1C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 10:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B086521850
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 10:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbfB1KOd (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:14:33 -0500
Received: from 8bytes.org ([81.169.241.247]:55866 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732282AbfB1KOd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Feb 2019 05:14:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 37FC74A3; Thu, 28 Feb 2019 11:14:31 +0100 (CET)
Date:   Thu, 28 Feb 2019 11:14:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     lantianyu1986@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH V6 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to
 support x2apic mode
Message-ID: <20190228101429.GA6303@8bytes.org>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 27, 2019 at 10:54:02PM +0800, lantianyu1986@gmail.com wrote:
> Lan Tianyu (3):
>   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is   
>      available
>   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
>   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
>     scope

Okay, replaced the patches in the iommu-tree by these patches. Please
send future fixes on-top of the hyper-v branch in the iommu tree. Also
note that I am going to exclude this branch from my next pull-request in
case more issues are found.

Regards,

	Joerg

