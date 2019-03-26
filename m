Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC9C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 17:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC89920693
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 17:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfCZRIw (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:08:52 -0400
Received: from foss.arm.com ([217.140.101.70]:40990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfCZRIw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 13:08:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CE29374;
        Tue, 26 Mar 2019 10:08:51 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 881EF3F614;
        Tue, 26 Mar 2019 10:08:48 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:08:42 +0000
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
Message-ID: <20190326170842.GA10666@e107981-ln.cambridge.arm.com>
References: <PU1P153MB0169E9AA13EB51DF5CFC1CE4BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169E9AA13EB51DF5CFC1CE4BF420@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 21, 2019 at 12:12:03AM +0000, Dexuan Cui wrote:
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Wednesday, March 20, 2019 2:38 PM
> > 
> > From: Dexuan Cui <decui@microsoft.com>
> > >
> > > After a device is just created in new_pcichild_device(), hpdev->refs is set
> > > to 2 (i.e. the initial value of 1 plus the get_pcichild()).
> > >
> > > When we hot remove the device from the host, in Linux VM we first call
> > > hv_pci_eject_device(), which increases hpdev->refs by get_pcichild() and
> > > then schedules a work of hv_eject_device_work(), so hpdev->refs becomes 3
> > > (let's ignore the paired get/put_pcichild() in other places). But in
> > > hv_eject_device_work(), currently we only call put_pcichild() twice,
> > > meaning the 'hpdev' struct can't be freed in put_pcichild(). This patch
> > > adds one put_pcichild() to fix the memory leak.
> > >
> > > BTW, the device can also be removed when we run "rmmod pci-hyperv". On
> > this
> > > path (hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_devices_present()),
> > > hpdev->refs is 2, and we do correctly call put_pcichild() twice in
> > > pci_devices_present_work().
> > 
> > Exiting new_pcichild_device() with hpdev->refs set to 2 seems OK to me.
> > There is the reference in the hbus->children list, and there is the reference that
> > is returned to the caller.  
> So IMO the "normal" reference count should be 2. :-) IMO only when a hv_pci_dev
> device is about to be destroyed, its reference count can drop to less than 2, 
> i.e. first temporarily drop to 1 (meaning the hv_pci_dev device is removed from
> hbus->children), and then drop to zero (meaning kfree(hpdev) is called).
> 
> > But what is strange is that pci_devices_present_work()
> > overwrites the reference returned in local variable hpdev without doing a
> > put_pcichild().
> I suppose you mean:
> 
>         /* First, mark all existing children as reported missing. */
>         spin_lock_irqsave(&hbus->device_list_lock, flags);
>         list_for_each_entry(hpdev, &hbus->children, list_entry) {
>                 hpdev->reported_missing = true;
>         }
>         spin_unlock_irqrestore(&hbus->device_list_lock, flags)
> 
> This is not strange to me, because, in pci_devices_present_work(), at first we
> don't know which devices are about to disappear, so we pre-mark all devices to
> be potentially missing like that; if a device is still on the bus, we'll mark its
> hpdev->reported_missing to false later; only after we know exactly which
> devices are missing, we should call put_pcichild() against them. All these
> seem natural to me.
> 
> > It seems like the "normal" reference count should be 1 when the
> > child device is not being manipulated, not 2.
> What does "not being manipulated" mean?
> 
> > The fix would be to add a call to
> > put_pcichild() when the return value from new_pcichild_device() is
> > overwritten.
> In pci_devices_present_work(), we NEVER "overwrite" the "hpdev" returned
> from new_pcichild_device(): the "reported_missing" field of the new hpdev
> is implicitly initialized to false in new_pcichild_device().
> 
> > Then remove the call to put_pcichild() in pci_device_present_work() when
> > missing
> > children are moved to the local list. The children have been moved from one
> > list
> > to another, so there's no need to decrement the reference count.  Then when
> > everything in the local list is deleted, the reference is correctly decremented,
> > presumably freeing the memory.
> > 
> > With this approach, the code in hv_eject_device_work() is correct.  There's
> > one call to put_pcichild() to reflect removing the child device from the hbus->
> > children list, and one call to put_pcichild() to pair with the get_pcichild() in
> > hv_pci_eject_device().
> Please refer to my replies above. IMO we should fix
> hv_eject_device_work() rather than pci_devices_present_work().

Have we reached a conclusion on this ? I would like to merge this series
given that it is fixing bugs and it has hung in the balance for quite
a while but it looks like Michael is not too happy about these patches
and I need a maintainer ACK to merge them.

Thanks,
Lorenzo

> Thanks
> -- Dexuan
>  
> > Your patch works, but to me it leaves the ref count in an unnatural state
> > most of the time.
> > 
> > Michael
> 
