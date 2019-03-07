Return-Path: <SRS0=GrSc=RK=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D26C43381
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DA320851
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 18:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCGSc3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfCGSc3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Mar 2019 13:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E7FC305B238;
        Thu,  7 Mar 2019 18:32:28 +0000 (UTC)
Received: from ovpn-200-17.brq.redhat.com (ovpn-200-17.brq.redhat.com [10.40.200.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB541001DF1;
        Thu,  7 Mar 2019 18:32:15 +0000 (UTC)
Message-ID: <1551983533.5436.8.camel@redhat.com>
Subject: Re: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
From:   Mohammed Gamal <mgamal@redhat.com>
Reply-To: mgamal@redhat.com
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kimbrownkd <kimbrownkd@gmail.com>
Cc:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Mar 2019 20:32:13 +0200
In-Reply-To: <DM5PR2101MB09182EAC78F8EEA57E27C26AD74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190307163606.25212-1-mgamal@redhat.com>
         <DM5PR2101MB09182EAC78F8EEA57E27C26AD74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 07 Mar 2019 18:32:28 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 2019-03-07 at 17:33 +0000, Michael Kelley wrote:
> From: Mohammed Gamal <mgamal@redhat.com> Sent: Thursday, March 7,
> 2019 8:36 AM
> > 
> > This patch adds a check for the presence of the ring buffer in
> > hv_get_bytes_to_read/write() to avoid possible NULL pointer
> > dereferences.
> > If the ring buffer is not yet allocated, return 0 bytes to be
> > read/written.
> > 
> > The root cause is that code that accesses the ring buffer including
> > hv_get_bytes_to_read/write() could be vulnerable to the race
> > condition
> > discussed in https://lkml.org/lkml/2018/10/18/779>;
> > 
> > This race is being addressed by the patch series by Kimberly Brown
> > in
> > https://lkml.org/lkml/2019/2/21/1236 which is not final yet
> > 
> > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> 
> Could you elaborate on the code paths where
> hv_get_bytes_to_read/write() could be called when the ring buffer
> isn't yet allocated?  My sense is that Kim Brown's patch will address
> all of the code paths that involved sysfs access from outside the
> driver.  And within a driver, the ring buffer should never be
> accessed
> unless it is already allocated.  Is there another code path we're not
> aware of?  I'm wondering if these changes are really needed once
> Kim Brown's patch is finished.
> 
> Michael

I've seen one instance of the race in the netvsc driver when running
traffic through it with iperf3 while continuously changing the channel
settings.

The following code path deallocates the ring buffer:
netvsc_set_channels() -> netvsc_detach() ->
rndis_filter_device_remove() -> netvsc_device_remove() -> vmbus_close()
-> vmbus_free_ring() -> hv_ringbuffer_cleanup().

netvsc_send_pkt() -> hv_get_bytes_to_write() might get called
concurrently after vmbus_close() and before vmbus_open() returns and
sets up the new ring buffer. 

The race is fairly hard to reproduce on recent upstream kernels, but I
still managed to reproduce it.
