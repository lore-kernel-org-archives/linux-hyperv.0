Return-Path: <SRS0=N7CS=R5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57991C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8FD2075D
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfCZOGE (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfCZOGE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Mar 2019 10:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BA74308FED5;
        Tue, 26 Mar 2019 14:06:03 +0000 (UTC)
Received: from ovpn-112-72.ams2.redhat.com (ovpn-112-72.ams2.redhat.com [10.36.112.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 451021001E74;
        Tue, 26 Mar 2019 14:06:00 +0000 (UTC)
Message-ID: <1553609158.5021.15.camel@redhat.com>
Subject: Re: [PATCH] hyper-v: Check for ring buffer in
 hv_get_bytes_to_read/write
From:   Mohammed Gamal <mgamal@redhat.com>
Reply-To: mgamal@redhat.com
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kimbrownkd <kimbrownkd@gmail.com>
Cc:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Date:   Tue, 26 Mar 2019 15:05:58 +0100
In-Reply-To: <DM5PR2101MB0725E0BD19C4D4EBA1F2B9FCCA5E0@DM5PR2101MB0725.namprd21.prod.outlook.com>
References: <20190307163606.25212-1-mgamal@redhat.com>
         <DM5PR2101MB09182EAC78F8EEA57E27C26AD74C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
         <1551983533.5436.8.camel@redhat.com>
         <DM5PR2101MB0725B71EE9A41E1ABE2B266ACA490@DM5PR2101MB0725.namprd21.prod.outlook.com>
         <1552472705.4717.7.camel@redhat.com>
         <SN6PR2101MB0912DF97AC683F8DAD5B59FDCC4A0@SN6PR2101MB0912.namprd21.prod.outlook.com>
        ,<1552567360.4717.11.camel@redhat.com>
         <SN6PR2101MB0912C247FA2B38E10F1824B0CC4B0@SN6PR2101MB0912.namprd21.prod.outlook.com>
         <DM5PR2101MB0725E0BD19C4D4EBA1F2B9FCCA5E0@DM5PR2101MB0725.namprd21.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 26 Mar 2019 14:06:03 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2019-03-25 at 20:13 +0000, Haiyang Zhang wrote:
> Hi Mohammed,
>  
> I found by reading the code and testing – in netvsc_detach(), after
> netif_tx_disable(), the queues may be waken up again when ring buffer
> usage drops below the “low wartermark”. This is expected in normal
> conditions as part of our flow control mechanism.
>  
> But when we stopped all tx queues in netvsc_detach(), and start
> removing the netvsc device, this may cause send path panic on NULL
> pointer on a closed channel.
>  
> I have attached a patch for this issue, could you test it on your
> side?
>  
> Thanks,
> Haiyang

Hi Haiyang,

I've tested the patch and it seems to fix the problem.

Thanks,
Mohammed

>  
> From: Stephen Hemminger <sthemmin@microsoft.com> 
> Sent: Thursday, March 14, 2019 1:09 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; Michael Kelley <mikelley@
> microsoft.com>; linux-hyperv@vger.kernel.org; kimbrownkd <kimbrownkd@
> gmail.com>; mgamal@redhat.com
> Cc: Sasha Levin <Alexander.Levin@microsoft.com>; Dexuan Cui <decui@mi
> crosoft.com>; Long Li <longli@microsoft.com>; KY Srinivasan <kys@micr
> osoft.com>; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH] hyper-v: Check for ring buffer in
> hv_get_bytes_to_read/write
>  
> There were lots of interations of netvsc driver to ensure that state
> was handled properly on queue changes.
> Can you reproduce this with current 5.0 kernel? If it only happens
> with driver backport then maybe something is different there (across
> netvsc and vmbus).
> From: Mohammed Gamal <mgamal@redhat.com>
> Sent: Thursday, March 14, 2019 5:42 AM
> To: Stephen Hemminger; Haiyang Zhang; Michael Kelley; linux-hyperv@vg
> er.kernel.org; kimbrownkd
> Cc: Sasha Levin; Dexuan Cui; Long Li; KY Srinivasan; vkuznets
> Subject: Re: [PATCH] hyper-v: Check for ring buffer in
> hv_get_bytes_to_read/write
>  
> On Wed, 2019-03-13 at 21:12 +0000, Stephen Hemminger wrote:
> > What test are you running?
> 
> I am running iperf3 with the following arguments:
> iperf3 -u -c ${iperf3 server address} -b 0 -P8 -t 3600
> 
> while changing the interface parameters in parallel with the
> following
> script:
> 
> cat ./test.sh
> #!/bin/bash
> device="eth1"
> i=0
> while [ "$i" -lt 1000 ]
> do
>     ethtool -L $device combined 1
>     ethtool -L $device combined 2
>     let "i++"
>     echo $i
> done
> 
> > 
> > -----Original Message-----
> > From: Mohammed Gamal <mgamal@redhat.com> 
> > Sent: Wednesday, March 13, 2019 3:25 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>; Michael Kelley
> <mikelley@
> > microsoft.com>; linux-hyperv@vger.kernel.org; kimbrownkd
> <kimbrownkd@
> > gmail.com>
> > Cc: Sasha Levin <Alexander.Levin@microsoft.com>; Dexuan Cui <decui@
> mi
> > crosoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Long Li
> <lo
> > ngli@microsoft.com>; KY Srinivasan <kys@microsoft.com>; vkuznets
> <vku
> > znets@redhat.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] hyper-v: Check for ring buffer in
> > hv_get_bytes_to_read/write
> > 
> > On Tue, 2019-03-12 at 18:02 +0000, Haiyang Zhang wrote:
> > >  
> > >  
> > > > -----Original Message-----
> > > > From: Mohammed Gamal <mgamal@redhat.com>
> > > > Sent: Thursday, March 7, 2019 1:32 PM
> > > > To: Michael Kelley <mikelley@microsoft.com>; linux-hyperv@vger.
> ke
> > > > rn
> > > 
> > > el.org;
> > > > kimbrownkd <kimbrownkd@gmail.com>
> > > > Cc: Sasha Levin <Alexander.Levin@microsoft.com>; Dexuan Cui
> > > > <decui@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.co
> m>
> > > > ;
> > > > Long Li <longli@microsoft.com>; KY Srinivasan <kys@microsoft.co
> m>
> > > > ;
> > > 
> > > Haiyang
> > > > Zhang <haiyangz@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> > > 
> > > linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] hyper-v: Check for ring buffer in
> > > > hv_get_bytes_to_read/write
> > > > 
> > > > On Thu, 2019-03-07 at 17:33 +0000, Michael Kelley wrote:
> > > > > From: Mohammed Gamal <mgamal@redhat.com> Sent: Thursday,
> March
> > > > > 7,
> > > > > 2019 8:36 AM
> > > > > > 
> > > > > > This patch adds a check for the presence of the ring buffer
> > > > > > in
> > > > > > hv_get_bytes_to_read/write() to avoid possible NULL pointer
> > > > > > dereferences.
> > > > > > If the ring buffer is not yet allocated, return 0 bytes to
> be
> > > > > > read/written.
> > > > > > 
> > > > > > The root cause is that code that accesses the ring buffer
> > > 
> > > including
> > > > > > hv_get_bytes_to_read/write() could be vulnerable to the
> race
> > > > > > condition discussed in
> > > > > > https://nam06.safelinks.protection.outlook.com/?url=https%3
> A%
> > > > > > 2F
> > > 
> > > %2Flk
> > > > > > 
> > > > 
> > > >
> ml.org%2Flkml%2F2018%2F10%2F18%2F779&amp;data=02%7C01%7Chaiyangz
> > > > %40m
> > > > > > 
> > > > 
> > > >
> icrosoft.com%7C73af013c14034bb0b1ad08d6a32b419c%7C72f988bf86f141a
> > > > f9
> > > > 1
> > > > > > 
> > > > 
> > > > ab2d7cd011db47%7C1%7C0%7C636875803518430021&amp;sdata=b51Xc5GUN
> > > > nHX0K
> > > > > > 08LrH3ShTyFcRZ4mYHUATd%2BDpvYDw%3D&amp;reserved=0>;
> > > > > > 
> > > > > > This race is being addressed by the patch series by
> Kimberly
> > > 
> > > Brown
> > > > > > in
> > > > > > https://nam06.safelinks.protection.outlook.com/?url=https%3
> A%
> > > > > > 2F
> > > 
> > > %2Flk
> > > > > > 
> > > > 
> > > >
> ml.org%2Flkml%2F2019%2F2%2F21%2F1236&amp;data=02%7C01%7Chaiyangz
> > > > %40m
> > > > > > 
> > > > 
> > > >
> icrosoft.com%7C73af013c14034bb0b1ad08d6a32b419c%7C72f988bf86f141a
> > > > f9
> > > > 1
> > > > > > 
> > > > 
> > > >
> ab2d7cd011db47%7C1%7C0%7C636875803518430021&amp;sdata=js1ff15Gbk7
> > > > 0MD
> > > > > > A2hkMZExxvAAbDuKDhfBvc5ZrckzM%3D&amp;reserved=0 which is
> not
> > > > 
> > > > final
> > > > > > yet
> > > > > > 
> > > > > > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> > > > > 
> > > > > Could you elaborate on the code paths where
> > > > > hv_get_bytes_to_read/write() could be called when the ring
> > > > > buffer
> > > > > isn't yet allocated?  My sense is that Kim Brown's patch will
> > > 
> > > address
> > > > > all of the code paths that involved sysfs access from outside
> > > > > the
> > > > > driver.  And within a driver, the ring buffer should never be
> > > 
> > > accessed
> > > > > unless it is already allocated.  Is there another code path
> > > > > we're
> > > 
> > > not
> > > > > aware of?  I'm wondering if these changes are really needed
> > > > > once
> > > 
> > > Kim
> > > > > Brown's patch is finished.
> > > > > 
> > > > > Michael
> > > > 
> > > > I've seen one instance of the race in the netvsc driver when
> > > 
> > > running traffic
> > > > through it with iperf3 while continuously changing the channel
> > > 
> > > settings.
> > > > 
> > > > The following code path deallocates the ring buffer:
> > > > netvsc_set_channels() -> netvsc_detach() ->
> > > > rndis_filter_device_remove() -> netvsc_device_remove() ->
> > > 
> > > vmbus_close()
> > > > -> vmbus_free_ring() -> hv_ringbuffer_cleanup().
> > > > 
> > > > netvsc_send_pkt() -> hv_get_bytes_to_write() might get called
> > > 
> > > concurrently
> > > > after vmbus_close() and before vmbus_open() returns and sets up
> > > > the
> > > 
> > > new ring
> > > > buffer.
> > > > 
> > > > The race is fairly hard to reproduce on recent upstream
> kernels,
> > > 
> > > but I still
> > > > managed to reproduce it.
> > > 
> > >  
> > > Looking at the code from netvsc_detach() –
> > >          netif_tx_disable(ndev) is called before
> > > rndis_filter_device_remove(hdev, nvdev).
> > > So there should be no call to netvsc_send_pkt() after detaching.
> > > What’s the crash stack trace?
> > >  
> > > static int netvsc_detach(struct net_device *ndev,
> > >                          struct netvsc_device *nvdev)
> > > {
> > >         struct net_device_context *ndev_ctx = netdev_priv(ndev);
> > >         struct hv_device *hdev = ndev_ctx->device_ctx;
> > >         int ret;
> > >  
> > >         /* Don't try continuing to try and setup sub channels */
> > >         if (cancel_work_sync(&nvdev->subchan_work))
> > >                 nvdev->num_chn = 1;
> > >  
> > >         /* If device was up (receiving) then shutdown */
> > >         if (netif_running(ndev)) {
> > >                 netif_tx_disable(ndev);
> > >  
> > >                 ret = rndis_filter_close(nvdev);
> > >                 if (ret) {
> > >                         netdev_err(ndev,
> > >                                    "unable to close device (ret
> > > %d).\n", ret);
> > >                         return ret;
> > >                 }
> > >  
> > >                 ret = netvsc_wait_until_empty(nvdev);
> > >                 if (ret) {
> > >                         netdev_err(ndev,
> > >                                    "Ring buffer not empty after
> > > closing rndis\n");
> > >                         return ret;
> > >                 }
> > >         }
> > >  
> > >         netif_device_detach(ndev);
> > >  
> > >         rndis_filter_device_remove(hdev, nvdev);
> > >  
> > >         return 0;
> > > }
> > >  
> > > Thanks,
> > > Haiyang
> > 
> > Here is one stack trace on a 4.18 kernel, the most recent kernel I
> > managed to reproduce this bug on. 
> > I haven't managed to reproduce on 5.0.0 yet, but I guess some
> recent
> > changes to the netvsc driver could be masking the problem, as I
> tried
> > backporting those changes to older RHEL 7 kernels and still managed
> > to
> > reproduce the problem there. I could however be wrong, and any
> > pointers
> > are still appreciated:
> > 
> > [  545.308507] BUG: unable to handle kernel NULL pointer
> dereference
> > at
> > 0000000000000004
> > [  545.308656] PGD 0 P4D 0 
> > [  545.308763] Oops: 0000 [#1] SMP PTI
> > [  545.308855] CPU: 2 PID: 1800 Comm: iperf3 Kdump: loaded Not
> > tainted
> > 4.18.0-64.el8.test.x86_64 #1
> > [  545.308990] Hardware name: Microsoft Corporation Virtual
> > Machine/Virtual Machine, BIOS Hyper-V UEFI Release v1.0 11/26/2012
> > [  545.309143] RIP: 0010:netvsc_send+0x2c9/0xce0 [hv_netvsc]
> > [  545.309298] Code: 4c 8b b1 c0 00 00 00 4f 8d 2c 64 49 c1 e5 07
> 4d
> > 03
> > ae c0 03 00 00 48 8b 84 03 30 01 00 00 4c 89 6c 24 18 48 8b 90 20
> 01
> > 00
> > 00 <8b> 72 04 8b 0a 8b 90 38 01 00 00 89 f7 01 f2 29 cf 29 ca 39 ce
> >  0f
> > [  545.309321] RSP: 0018:ffffb8a305d5b6c0 EFLAGS: 00010282
> > [  545.309321] RAX: ffff926928bd7000 RBX: ffff92687dbe0000 RCX:
> > ffff92687d5bec00
> > [  545.309321] RDX: 0000000000000000 RSI: ffff92691b61c654 RDI:
> > 0000000000000000
> > [  545.309321] RBP: ffff926915dcde28 R08: ffff926915dcde00 R09:
> > 0000000000000000
> > [  545.309321] R10: 00000000000db61c R11: 0000000000000f7e R12:
> > 0000000000000001
> > [  545.309321] R13: ffff926931808180 R14: ffff926931801000 R15:
> > 0000000000000000
> > [  545.309321] FS:  00007feca6a4b740(0000)
> GS:ffff926940080000(0000)
> > knlGS:0000000000000000
> > [  545.309321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  545.309321] CR2: 0000000000000004 CR3: 00000000dfccc004 CR4:
> > 00000000003606e0
> > [  545.309321] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [  545.309321] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [  545.309321] Call Trace:
> > [  545.309321]  netvsc_start_xmit+0x3c9/0x800 [hv_netvsc]
> > [  545.309321]  ? __switch_to_asm+0x34/0x70
> > [  545.309321]  ? __switch_to_asm+0x34/0x70
> > [  545.309321]  ? ___slab_alloc+0x269/0x4e0
> > [  545.309321]  ? __alloc_skb+0x82/0x1c0
> > [  545.309321]  ? nft_do_chain+0x3d7/0x3f0 [nf_tables]
> > [  545.309321]  ? nft_do_chain+0x3d7/0x3f0 [nf_tables]
> > [  545.309321]  ? nft_do_chain+0x3d7/0x3f0 [nf_tables]
> > [  545.309321]  ? _cond_resched+0x15/0x30
> > [  545.309321]  ? netif_skb_features+0x118/0x280
> > [  545.309321]  dev_hard_start_xmit+0xa5/0x210
> > [  545.309321]  sch_direct_xmit+0x14f/0x340
> > [  545.309321]  __dev_queue_xmit+0x799/0x8f0
> > [  545.309321]  ip_finish_output2+0x2e0/0x430
> > [  545.309321]  ? ip_finish_output+0x139/0x270
> > [  545.309321]  ip_output+0x6c/0xe0
> > [  545.309321]  ? ip_append_data.part.50+0xc0/0xc0
> > [  545.309321]  ip_send_skb+0x15/0x40
> > [  545.309321]  udp_send_skb.isra.43+0x153/0x340
> > [  545.309321]  udp_sendmsg+0xac2/0xd30
> > [  545.309321]  ? set_fd_set.part.7+0x40/0x40
> > [  545.309321]  ? set_fd_set.part.7+0x40/0x40
> > [  545.309321]  ? __check_object_size+0xa3/0x181
> > [  545.309321]  ? sock_has_perm+0x78/0xa0
> > [  545.309321]  ? core_sys_select+0x242/0x2f0
> > [  545.309321]  ? sock_sendmsg+0x36/0x40
> > [  545.309321]  ? udp_push_pending_frames+0x60/0x60
> > [  545.309321]  sock_sendmsg+0x36/0x40
> > [  545.309321]  sock_write_iter+0x8f/0xf0
> > [  545.309321]  __vfs_write+0x156/0x1a0
> > [  545.309321]  vfs_write+0xa5/0x1a0
> > [  545.309321]  ksys_write+0x4f/0xb0
> > [  545.309321]  do_syscall_64+0x5b/0x1b0
> > [  545.309321]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > [  545.309321] RIP: 0033:0x7feca5fb5348
> > [  545.309321] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00
> 00
> > 00
> > 00 f3 0f 1e fa 48 8d 05 d5 63 2d 00 8b 00 85 c0 75 17 b8 01 00 00
> 00
> > 0f
> > 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4
> > 55
> > [  545.309321] RSP: 002b:00007ffc3ff1f108 EFLAGS: 00000246
> ORIG_RAX:
> > 0000000000000001
> > [  545.309321] RAX: ffffffffffffffda RBX: 00000000000005a8 RCX:
> > 00007feca5fb5348
> > [  545.309321] RDX: 00000000000005a8 RSI: 00007feca6a59000 RDI:
> > 0000000000000009
> > [  545.309321] RBP: 00007feca6a59000 R08: 0000000000000002 R09:
> > 00cd09a3238b4e43
> > [  545.309321] R10: 0002961ecea49016 R11: 0000000000000246 R12:
> > 0000000000000009
> > [  545.309321] R13: 00000000000005a8 R14: 00007ffc3ff1f180 R15:
> > 0000563c1e05b260
> > [  545.309321] Modules linked in: nft_chain_nat_ipv6
> > nf_conntrack_ipv6
> > nf_defrag_ipv6 nf_nat_ipv6 nft_chain_route_ipv6 nft_chain_nat_ipv4
> > nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat
> > nft_chain_route_ipv4 nf_conntrack ip_set nf_tables nfnetlink vfat
> fat
> > sb_edac crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> > intel_rapl_perf sg hv_utils hv_balloon pcspkr joydev xfs libcrc32c
> > sd_mod sr_mod cdrom serio_raw hv_storvsc hv_netvsc
> scsi_transport_fc
> > hyperv_fb hyperv_keyboard hid_hyperv crc32c_intel hv_vmbus
> dm_mirror
> > dm_region_hash dm_log dm_mod [last unloaded: nft_compat]
> > [  545.309321] CR2: 0000000000000004
> > 
> > From the stack trace netvsc_send+0x2c9 points to this line:
> > 
> > static inline u32 hv_get_bytes_to_write(const struct  hv_ring_
> > bu
> > ffer_info *rbi)
> > {
> >         u32 read_loc, write_loc, dsize, write;
> > 
> >         dsize = rbi->ring_datasize;
> >         read_loc = READ_ONCE(rbi->ring_buffer->read_index);  <-----
> --
> > --
> >         write_loc = rbi->ring_buffer->write_index;
> > 
> >         write = write_loc >= read_loc ? dsize - (write_loc -
> > read_loc) 
> >                 read_loc - write_loc;
> >         return write;
> > }
> > 
> > which gets called from netvsc_send_pkt().
> 
