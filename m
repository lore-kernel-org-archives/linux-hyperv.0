Return-Path: <SRS0=e6q8=RE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D72C43381
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8A62083E
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Mar 2019 11:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfCALzs (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:55:48 -0500
Received: from foss.arm.com ([217.140.101.70]:33732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbfCALzs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Mar 2019 06:55:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 688E9EBD;
        Fri,  1 Mar 2019 03:55:48 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8FA3F5C1;
        Fri,  1 Mar 2019 03:55:45 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:55:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: Re: [PATCH v5 0/3] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset
 and cpumask_to_vpset()
Message-ID: <20190301115542.GC17669@e107981-ln.cambridge.arm.com>
References: <cover.1551421809.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551421809.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 01, 2019 at 06:54:45AM +0000, Maya Nakamura wrote:
> This patchset removes a duplicate definition of VP set (hv_vp_set) and
> uses the common definition (hv_vpset) that is used in other places. It
> changes the order of the members in struct hv_pcibus_device due to
> flexible array in hv_vpset.
> 
> It also removes the duplicate implementation of cpumask_to_vpset(), uses
> the shared implementation, and exports hv_max_vp_index, which is
> required by cpumask_to_vpset().
> 
> It adds __aligned(8) to struct retarget_msi_interrupt because Hyper-V
> requires that hypercall arguments be aligned on an 8 byte boundary. This
> is now a new patch, separate from one of the previous patches.
> 
> Maya Nakamura (3):
>   PCI: hv: Add __aligned(8) to struct retarget_msi_interrupt
>   PCI: hv: Replace hv_vp_set with hv_vpset
>   PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()
> 
>  arch/x86/hyperv/hv_init.c           |  1 +
>  drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++----------------
>  2 files changed, 29 insertions(+), 33 deletions(-)

It looks all good, applied to pci/hv for v5.1, pending kbot checks.

Thanks,
Lorenzo
