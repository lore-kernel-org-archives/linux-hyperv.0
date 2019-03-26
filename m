Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F59AC43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69442075C
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 19:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfCZTyj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:54:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZTyj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 15:54:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432B180D;
        Tue, 26 Mar 2019 12:54:38 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4E03F575;
        Tue, 26 Mar 2019 12:54:35 -0700 (PDT)
Date:   Tue, 26 Mar 2019 19:54:30 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
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
Subject: Re: [PATCH 3/3] PCI: hv: Add pci_destroy_slot() in
 pci_devices_present_work(), if necessary
Message-ID: <20190326195429.GA15410@e107981-ln.cambridge.arm.com>
References: <20190304213357.16652-1-decui@microsoft.com>
 <20190304213357.16652-4-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304213357.16652-4-decui@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 04, 2019 at 09:34:49PM +0000, Dexuan Cui wrote:
> When we hot-remove a device, usually the host sends us a PCI_EJECT message,
> and a PCI_BUS_RELATIONS message with bus_rel->device_count == 0. But when
> we do the quick hot-add/hot-remove test, the host may not send us the
> PCI_EJECT message, if the guest has not fully finished the initialization
> by sending the PCI_RESOURCES_ASSIGNED* message to the host, so it's
> potentially unsafe to only depend on the pci_destroy_slot() in
> hv_eject_device_work(), though create_root_hv_pci_bus() ->
> hv_pci_assign_slots() is not called in this case. Note: in this case, the
> host still sends the guest a PCI_BUS_RELATIONS message with
> bus_rel->device_count == 0.
> 
> And, in the quick hot-add/hot-remove test, we can have such a race: before
> pci_devices_present_work() -> new_pcichild_device() adds the new device
> into hbus->children, we may have already received the PCI_EJECT message,
> and hence the taklet handler hv_pci_onchannelcallback() may fail to find
> the "hpdev" by get_pcichild_wslot(hbus, dev_message->wslot.slot), so
> hv_pci_eject_device() is NOT called; later create_root_hv_pci_bus() ->
> hv_pci_assign_slots() creates the slot, and the PCI_BUS_RELATIONS message
> with bus_rel->device_count == 0 removes the device from hbus->children, and
> we end up being unable to remove the slot in hv_pci_remove() ->
> hv_pci_remove_slots().
> 
> The patch removes the slot in pci_devices_present_work() when the device
> is removed. This can address the above race. Note 1:
> pci_devices_present_work() and hv_eject_device_work() run in the
> singled-threaded hbus->wq, so there is not a double-remove issue for the
> slot. Note 2: we can't offload hv_pci_eject_device() from
> hv_pci_onchannelcallback() to the workqueue, because we need
> hv_pci_onchannelcallback() synchronously call hv_pci_eject_device() to
> poll the channel's ringbuffer to work around the
> "hangs in hv_compose_msi_msg()" issue: see
> commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")

This commit log is unreadable, sorry. Indentation, punctuation and
formatting are just a mess, try to read it, you will notice by
yourself.

I basically reformatted it completely and pushed the series to
pci/controller-fixes but that's the last time I do it since I am not an
editor, next time I won't merge it.

More importantly, these patches are marked for stable, given the series
of fixes that triggered this series please ensure it was tested
thoroughly because it is honestly complicate to understand and I do not
want to backport further fixes to stable kernels on top of this.

Please have a look and report back.

Thanks,
Lorenzo

> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index b489412e3502..82acd6155adf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1776,6 +1776,10 @@ static void pci_devices_present_work(struct work_struct *work)
>  		hpdev = list_first_entry(&removed, struct hv_pci_dev,
>  					 list_entry);
>  		list_del(&hpdev->list_entry);
> +
> +		if (hpdev->pci_slot)
> +			pci_destroy_slot(hpdev->pci_slot);
> +
>  		put_pcichild(hpdev);
>  	}
>  
> -- 
> 2.19.1
> 
